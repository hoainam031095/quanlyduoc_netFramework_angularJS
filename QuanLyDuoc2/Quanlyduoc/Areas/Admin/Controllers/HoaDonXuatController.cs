using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Models;
using Quanlyduoc.Code;
using Quanlyduoc.Areas.Admin.Class;
using ClosedXML.Excel;
using System.IO;

namespace Quanlyduoc.Areas.Admin.Controllers
{
    
    public class HoaDonXuatController : ExtendsController
    {

        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: Admin/HoaDonXuat
        [CheckSessionUser]
        public ActionResult Index()
        {
            var Jxuat = db.HoaDonXuat.ToList()
                                  .Select(hd => new
                                  {
                                      hd.MaHD,
                                      hd.MaKho,
                                      TenKho = db.Kho.Where(kh => kh.MaKho == hd.MaKho).FirstOrDefault().TenKho,
                                      hd.MaTK,
                                      NguoiXuat = db.TaiKhoan.Where(tk => tk.MaTK == hd.MaTK).FirstOrDefault().HoTen,
                                      hd.MaKH,
                                      KhachHang = db.KhachHang.Where(kh => kh.MaKH == hd.MaKH).FirstOrDefault().HoTen,
                                      NgayXuat = hd.NgayXuat.Value.ToString("MM/dd/yyyy"),
                                      hd.TrangThai,
                                      hd.MaHoaDonMua,
                                      MaHoaDonVanChuyen = hd.MaHoaDonVanChuyen == null ? "" : hd.MaHoaDonVanChuyen,
                                      NguoiVanChuyen = hd.MaHoaDonVanChuyen == null ? "" :
                                                     db.VanChuyen.Where(vc => vc.MaNguoiVanChuyen == (
                                                                             db.HoaDonVanChuyen
                                                                             .Where(hdvc => hdvc.MaHoaDonVanChuyen == hd.MaHoaDonVanChuyen)
                                                                             .FirstOrDefault()
                                                                             .MaNguoiVanChuyen)
                                                                         ).FirstOrDefault().HoTen,
                                  }).ToList();
            return View(Json(new { Jxuat = Jxuat }, JsonRequestBehavior.AllowGet));
        }

        [CheckSessionUser]
        [HttpPost]
        public JsonResult taoPhieuXuat(string maHoaDon)
        {
            var maKho = db.HoaDonMua.Where(hdm => hdm.MaHD == maHoaDon).FirstOrDefault().MaKho;
            var JCTPhieuXuat = db.ChiTietHoaDonMua.Where(cthd => cthd.MaHD == maHoaDon)
                                    .Select(ctpm => new
                                    {
                                        ctpm.MaHD,
                                        ctpm.MaDT,
                                        DauThuoc = db.DauThuoc.Where(dt => dt.MaDT == ctpm.MaDT).FirstOrDefault().TenDauThuoc,
                                        ctpm.SoLuong,
                                        ctpm.MaDonVi,
                                        TenDonVi = db.DonVi.Where(dv => dv.ID == ctpm.MaDonVi).FirstOrDefault().Ten,
                                        ctpm.DonGia
                                    }).ToList();
            return Json(new { JCTPhieuXuat = JCTPhieuXuat, success = "success" }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult luuPhieuXuat(string maHoaDon)
        {
            if (maHoaDon != null)
            {
                string MaTK = SessionHelper.GetMa();
                var PhieuXuat = db.HoaDonMua.Where(hd => hd.MaHD == maHoaDon)
                                .ToList()
                                 .Select(px => new
                                 {
                                     px.MaHD,
                                     px.MaKho,
                                     MaTK = MaTK,
                                     TenNguoiXuat = db.TaiKhoan.Where(tk => tk.MaTK == MaTK).FirstOrDefault().HoTen,
                                     px.MaKH,
                                     TenKhachHang = db.KhachHang.Where(kh => kh.MaKH == px.MaKH).FirstOrDefault().HoTen,
                                     NgayXuat = DateTime.UtcNow.Date.ToString("yyyy-MM-dd")
                                 }).FirstOrDefault();
                var listCTPhieuMua = db.ChiTietHoaDonMua.Where(cthd => cthd.MaHD == maHoaDon)
                                        .Select(cthdm => new
                                        {
                                            cthdm.MaHD,
                                            cthdm.MaDT,
                                            DauThuoc = db.DauThuoc.Where(dt => dt.MaDT == cthdm.MaDT).FirstOrDefault().TenDauThuoc,
                                            cthdm.SoLuong,
                                            cthdm.MaDonVi,
                                            cthdm.DonGia
                                        }).ToList();
                //Thực hiện tạo phiếu xuất    
                HoaDonXuat hdx = new HoaDonXuat();
                string maHDX = "HX" + SinhMa.getMa("MaHD", "HoaDonXuat");
                hdx.MaHD = maHDX;
                hdx.MaKho = PhieuXuat.MaKho;
                hdx.MaTK = PhieuXuat.MaTK;
                hdx.MaKH = PhieuXuat.MaKH;
                hdx.NgayXuat = DateTime.Parse(PhieuXuat.NgayXuat);
                hdx.MaHoaDonMua = PhieuXuat.MaHD;
                hdx.TrangThai = 1;
                db.HoaDonXuat.Add(hdx);
                //Đọc chi tiết phiếu xuất và tạo chi tiết phiếu xuất
                foreach (var ctx in listCTPhieuMua)
                {
                    if (kiemtraVaTaoChiTietPhieuXuat(hdx.MaKho, ctx.MaDT, ctx.SoLuong, ctx.MaDonVi) == false)
                    {
                        return Json(new { msg = "Đầu thuốc chưa có hoặc số lượng không đủ _ " + ctx.DauThuoc + " !", success = "error" }, JsonRequestBehavior.AllowGet);
                    }
                }
                foreach (var ctx in listCTPhieuMua)
                {
                    var khoDauThuocDonVi = db.KhoDauThuoc.Where(khdt => khdt.MaKho == hdx.MaKho && khdt.MaDT == ctx.MaDT && khdt.MaDonVi == ctx.MaDonVi).FirstOrDefault();
                    khoDauThuocDonVi.SoLuongCon = khoDauThuocDonVi.SoLuongCon - ctx.SoLuong;
                    ChiTietHoaDonXuat ctpx = new ChiTietHoaDonXuat();
                    ctpx.MaHD = hdx.MaHD;
                    ctpx.MaDT = ctx.MaDT;
                    ctpx.MaDonVi = ctx.MaDonVi;
                    ctpx.SoLuong = ctx.SoLuong;
                    ctpx.DonGia = ctx.DonGia;
                    db.ChiTietHoaDonXuat.Add(ctpx);
                    db.SaveChanges();
                }
                var HoaDonMua1 = db.HoaDonMua.Where(hd => hd.MaHD == maHoaDon).FirstOrDefault();
                HoaDonMua1.TrangThai = 3;
                db.SaveChanges();
                return Json(new { msg = "Tạo thành công hóa đơn xuất", success = "success" }, JsonRequestBehavior.AllowGet);
                //.kết thúc phiếu xuất

            }
            else
            {
                return Json(new { msg = "Lỗi", success = "error" }, JsonRequestBehavior.AllowGet);
            }
        }

        [CheckSessionUser]
        [HttpPost]
        public JsonResult xoaHoaDonXuat(string maHoaDon)
        {
            var hoaDon = db.HoaDonXuat.Where(hd => hd.MaHD == maHoaDon).FirstOrDefault();
            if (hoaDon != null)
            {
                var listChiTiet = db.ChiTietHoaDonXuat.Where(cthd => cthd.MaHD == maHoaDon).ToList();
                foreach (var item in listChiTiet)
                {
                    db.ChiTietHoaDonXuat.Remove(item);
                    var KhoThuoc = db.KhoDauThuoc.Where(kt => kt.MaKho == hoaDon.MaKho && kt.MaDT == item.MaDT).FirstOrDefault();
                    var KhoThuoc1 = db.KhoDauThuoc.Where(kt => kt.MaKho == hoaDon.MaKho && kt.MaDT == item.MaDT).FirstOrDefault();
                    KhoThuoc.SoLuongCon = KhoThuoc.SoLuongCon + item.SoLuong;
                    db.Entry(KhoThuoc1).CurrentValues.SetValues(KhoThuoc);
                    db.SaveChanges();
                }
                var HoaDonMua1 = db.HoaDonMua.Where(hd => hd.MaHD == hoaDon.MaHoaDonMua).FirstOrDefault();
                var HoaDonMua2 = db.HoaDonMua.Where(hd => hd.MaHD == hoaDon.MaHoaDonMua).FirstOrDefault();
                HoaDonMua1.TrangThai = 2;
                db.Entry(HoaDonMua2).CurrentValues.SetValues(HoaDonMua1);
                db.HoaDonXuat.Remove(hoaDon);
                db.SaveChanges();
                return Json(new { msg = "Xóa thành công", success = "success" }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { msg = "Lỗi", success = "error" }, JsonRequestBehavior.AllowGet);
        }

        [CheckSessionUser]
        [HttpPost]
        public JsonResult kiemTraTrangThaiVanChuyen(string maHoaDon)
        {
            var trangThai = db.HoaDonXuat.Where(hd => hd.MaHD == maHoaDon).FirstOrDefault().TrangThai;
            if (trangThai == 1)
            {
                var JNguoiVanChuyen = db.VanChuyen.Where(v => v.TrangThai == 1)
                          .Select(v => new
                          {
                              v.MaNguoiVanChuyen,
                              v.HoTen,
                              v.TrangThai
                          }).ToList();
                return Json(new { JNguoiVanChuyen = JNguoiVanChuyen, success = "success" }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                if (trangThai == 2)
                {
                    return Json(new { msg = "Hóa đơn này đang vận chuyển!", success = "error" }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { msg = "Hóa đơn này đã hoàn thành!", success = "error" }, JsonRequestBehavior.AllowGet);

                }
            }

        }

        [CheckSessionUser]
        public void Export(string dateFrom, string dateTo)
        {
            var dateFrom1 = DateTime.Parse(dateFrom.Substring(1, 10));
            var dateTo1 = DateTime.Parse(dateTo.Substring(1, 10));
            //Get list export
            var hoaDonXuatEX = db.HoaDonXuat.ToList().Where(hd => hd.NgayXuat >= dateFrom1 && hd.NgayXuat <= dateTo1)
                                  .Select(hd => new
                                  {
                                      hd.MaHD,
                                      hd.MaKho,
                                      TenKho = db.Kho.Where(kh => kh.MaKho == hd.MaKho).FirstOrDefault().TenKho,
                                      hd.MaTK,
                                      NguoiXuat = db.TaiKhoan.Where(tk => tk.MaTK == hd.MaTK).FirstOrDefault().HoTen,
                                      hd.MaKH,
                                      KhachHang = db.KhachHang.Where(kh => kh.MaKH == hd.MaKH).FirstOrDefault().HoTen,
                                      NgayXuat = hd.NgayXuat.Value.ToString("MM/dd/yyyy"),
                                      hd.TrangThai,
                                      hd.MaHoaDonMua,
                                      MaHoaDonVanChuyen = hd.MaHoaDonVanChuyen == null ? "" : hd.MaHoaDonVanChuyen,
                                      NguoiVanChuyen = hd.MaHoaDonVanChuyen == null ? "" :
                                                     db.VanChuyen.Where(vc => vc.MaNguoiVanChuyen == (
                                                                             db.HoaDonVanChuyen
                                                                             .Where(hdvc => hdvc.MaHoaDonVanChuyen == hd.MaHoaDonVanChuyen)
                                                                             .FirstOrDefault()
                                                                             .MaNguoiVanChuyen)
                                                                         ).FirstOrDefault().HoTen,
                                  }).ToList();
            if (hoaDonXuatEX.Count() == 0)
            {
                hoaDonXuatEX = db.HoaDonXuat.ToList()
                                  .Select(hd => new
                                  {
                                      hd.MaHD,
                                      hd.MaKho,
                                      TenKho = db.Kho.Where(kh => kh.MaKho == hd.MaKho).FirstOrDefault().TenKho,
                                      hd.MaTK,
                                      NguoiXuat = db.TaiKhoan.Where(tk => tk.MaTK == hd.MaTK).FirstOrDefault().HoTen,
                                      hd.MaKH,
                                      KhachHang = db.KhachHang.Where(kh => kh.MaKH == hd.MaKH).FirstOrDefault().HoTen,
                                      NgayXuat = hd.NgayXuat.Value.ToString("MM/dd/yyyy"),
                                      hd.TrangThai,
                                      hd.MaHoaDonMua,
                                      MaHoaDonVanChuyen = hd.MaHoaDonVanChuyen == null ? "" : hd.MaHoaDonVanChuyen,
                                      NguoiVanChuyen = hd.MaHoaDonVanChuyen == null ? "" :
                                                     db.VanChuyen.Where(vc => vc.MaNguoiVanChuyen == (
                                                                             db.HoaDonVanChuyen
                                                                             .Where(hdvc => hdvc.MaHoaDonVanChuyen == hd.MaHoaDonVanChuyen)
                                                                             .FirstOrDefault()
                                                                             .MaNguoiVanChuyen)
                                                                         ).FirstOrDefault().HoTen,
                                  }).ToList();
            }

            ///export///
            var filename = "Danh sách hóa đơn xuất ngày (" + DateTime.Now.ToString("dd-MM-yyyy hh:mm") + ").xlsx";
            var sheetname = "Customer";
            XLWorkbook workbook = new XLWorkbook();
            var workSheet = workbook.Worksheets.Add(sheetname);
            workSheet.SheetView.Freeze(1, 0);

            //Design header
            var obj = hoaDonXuatEX.FirstOrDefault();
            var comumns = obj.GetType().GetProperties();
            int i = 1;
            comumns.All(m =>
            {
                var name = m.Name
                .Replace("MaHD", "Mã hóa đơn")
                .Replace("MaKho", "Mã kho")
                .Replace("TenKho", "Tên kho")
                .Replace("MaTK", "Mã người xuất")
                .Replace("NguoiXuat", "Người xuất")
                .Replace("MaKH", "Mã khách hàng")
                .Replace("KhachHang", "Khách hàng")
                .Replace("NgayXuat", "Ngày xuất")
                .Replace("TrangThai", "Trạng thái")
                .Replace("MaHoaDonMua", "Mã hóa đơn mua")
                .Replace("MaHoaDonVanChuyen", "Mã hóa đơn vận chuyển")
                .Replace("NguoiVanChuyen", "Người vận chuyển");

                var h = workSheet.Cell(1, i).SetValue(name);
                h.Style.Font.Bold = true;
                h.Style.Font.FontColor = XLColor.White;
                h.Style.Fill.BackgroundColor = XLColor.Green;

                i++;
                return true;
            });

            //Bind data
            int rowIndex = 2;
            hoaDonXuatEX.All(b =>
            {
                int j = 1;
                comumns.All(m =>
                {
                    var vl = m.GetValue(b);
                    workSheet.Cell(rowIndex, j).SetValue(vl);
                    j++;
                    return true;
                });
                rowIndex++;
                return true;
            });

            //Response
            var httpResponse = Response; //Response;
            httpResponse.Clear();
            httpResponse.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            httpResponse.AddHeader("content-disposition", "attachment;filename=\"" + filename + "\"");
            using (MemoryStream MyMemoryStream = new MemoryStream())
            {
                workbook.SaveAs(MyMemoryStream);
                MyMemoryStream.WriteTo(Response.OutputStream);
                MyMemoryStream.Close();
            }
            httpResponse.End();
        }
    }
}