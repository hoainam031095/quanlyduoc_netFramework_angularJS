using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ClosedXML.Excel;
using Quanlyduoc.Areas.Admin.Class;
using Quanlyduoc.Code;
using Quanlyduoc.Models;

namespace Quanlyduoc.Areas.Admin.Controllers
{
    [CheckSessionUser]
    public class HoaDonNhapController : Controller
    {
        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: Admin/HoaDonNhap
        public ActionResult Index()
        {
            var Jnhap = db.HoaDonNhap
                        .ToList()
                        .Select(hd => new
                        {
                            hd.MaHD,
                            hd.MaKho,
                            TenKho = db.Kho.Where(kh => kh.MaKho == hd.MaKho).FirstOrDefault().TenKho,
                            hd.MaTK,
                            NguoiNhap = db.TaiKhoan.Where(tk => tk.MaTK == hd.MaTK).FirstOrDefault().HoTen,
                            hd.MaNSX,
                            NhaSanXuat = db.NhaSanXuat.Where(nsx => nsx.MaNSX == hd.MaNSX).FirstOrDefault().TenNSX,
                            NgayNhap = hd.NgayNhap.Value.ToString("MM/dd/yyyy"),
                            hd.GhiChu
                        }).ToList();
            return View(Json(new { Jnhap = Jnhap }, JsonRequestBehavior.AllowGet));
        }

        [HttpGet]
        public ActionResult themhoadonnhap()
        {
            var maTK = SessionHelper.GetRoles();
            if (maTK == "1")
            {
                ViewBag.Kho = db.Kho.ToList().Select(n => new { n.MaKho, n.TenKho, n.DiaChi }).ToList();
            }
            else
            {
                ViewBag.Kho = db.KhoNhanVien.Where(nv => nv.MaTK == maTK)
                                .ToList()
                                .Select(n => new
                                {
                                    n.MaKho,
                                    TenKho = db.Kho.Where(kh => kh.MaKho == n.MaKho).FirstOrDefault().TenKho
                                }).ToList();
            }
            ViewBag.NhaSanXuat = db.NhaSanXuat.Select(n => new { n.MaNSX, n.TenNSX }).ToList();

            ViewBag.maHoaDon = "HD" + SinhMa.getMa("MaHD", "HoaDonNhap");
            ViewBag.ngayNhap = DateTime.UtcNow.Date.ToString("yyyy-MM-dd");

            ViewBag.NhomDauThuoc = db.NhomDauThuoc.Select(m => new
            {
                m.MaNhomThuoc,
                m.TenNhom,
                _DauThuoc = db.DauThuoc.AsEnumerable()
                .Join(db.TagsDThuocNThuoc.AsEnumerable().Where(tag => tag.MaNhomThuoc == m.MaNhomThuoc), dt => dt.MaDT, tag => tag.MaDauThuoc,
                (dt, tag) => new
                {
                    dt.MaDT,
                    dt.TenDauThuoc,
                    dt.GiaBanLe,
                    JDonVi = db.DonVi.Where(dv => dv.MaDT == dt.MaDT).ToList()
                                     .Select(dv => new
                                     {
                                         dv.ID,
                                         dv.IDParent,
                                         dv.Ten,
                                         dv.Heso,
                                         dv.TenDinhNghia
                                     }).ToList(),
                }).ToList(),
            }).ToList();

            return View();
        }

        [HttpPost]
        public JsonResult themhoadonnhap(HoaDonNhapJS hoadonnhapJS)
        {
            var maTK = SessionHelper.GetMa();

            if (hoadonnhapJS.danhsachnhaps.ToList() != null)
            {
                var hoaDon = db.HoaDonNhap.Where(h => h.MaHD == hoadonnhapJS.MaHD).FirstOrDefault();
                if (hoaDon == null)
                {
                    HoaDonNhap hd = new HoaDonNhap();
                    hd.MaHD = hoadonnhapJS.MaHD;
                    hd.MaTK = maTK;
                    hd.MaKho = hoadonnhapJS.MaKho;
                    hd.MaNSX = hoadonnhapJS.MaNSX;
                    hd.NgayNhap = hoadonnhapJS.NgayNhap;
                    hd.GhiChu = hoadonnhapJS.GhiChu;
                    db.HoaDonNhap.Add(hd);
                    db.SaveChanges();
                }
                foreach (danhsachnhap ctn in hoadonnhapJS.danhsachnhaps.ToList())
                {
                    ChiTietHoaDonNhap cthd = new ChiTietHoaDonNhap();
                    cthd.MaHD = hoadonnhapJS.MaHD;
                    cthd.MaDT = ctn.MaDT;
                    cthd.MaDonVi = ctn.MaDonVi;
                    cthd.SoLuong = ctn.SoLuong;
                    cthd.DonGia = ctn.DonGia;
                    db.ChiTietHoaDonNhap.Add(cthd);
                    db.SaveChanges();

                    var countKho = db.KhoDauThuoc.Where(kdt => kdt.MaKho == hoadonnhapJS.MaKho && kdt.MaDT == ctn.MaDT && kdt.MaDonVi == ctn.MaDonVi).FirstOrDefault();
                    if (countKho != null)
                    {
                        countKho.SoLuongCon += ctn.SoLuong;
                        db.SaveChanges();
                    }
                    else
                    {
                        KhoDauThuoc kho = new KhoDauThuoc();
                        kho.MaKho = hoadonnhapJS.MaKho;
                        kho.MaDT = ctn.MaDT;
                        kho.MaDonVi = ctn.MaDonVi;
                        kho.SoLuongCon = ctn.SoLuong;
                        db.KhoDauThuoc.Add(kho);
                        db.SaveChanges();
                    }
                }
                var newMaHoaDonNhap = "HD" + SinhMa.getMa("MaHD", "HoaDonNhap");
                return Json(new { mamoi = newMaHoaDonNhap, msg = "Mua thành công", success = "success" }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { msg = "Danh sách mua trống!", success = "error" }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult xoahoadonnhap(string mahoadon)
        {
            var countHoaDonNhap = db.HoaDonNhap.Where(hd => hd.MaHD == mahoadon).FirstOrDefault();
            if (countHoaDonNhap == null)
                return Json(new { msg = "Không tồn tại hóa đơn!", success = "error" }, JsonRequestBehavior.AllowGet);
            var countChiTietHoaDon = db.ChiTietHoaDonNhap.Where(cthd => cthd.MaHD == countHoaDonNhap.MaHD).ToList();
            foreach (ChiTietHoaDonNhap ct in countChiTietHoaDon)
            {
                var khoDauThuoc = db.KhoDauThuoc.Where(kdt => kdt.MaKho == countHoaDonNhap.MaKho && kdt.MaDT == ct.MaDT && kdt.MaDonVi == ct.MaDonVi).FirstOrDefault();
                if (khoDauThuoc != null)
                {

                    if (khoDauThuoc.SoLuongCon - ct.SoLuong > 0)
                        khoDauThuoc.SoLuongCon -= ct.SoLuong;
                    else
                    {
                        if (khoDauThuoc.SoLuongCon - ct.SoLuong == 0)
                            db.KhoDauThuoc.Remove(khoDauThuoc);
                        else
                            return Json(new { msg = "Không thể xóa hóa đơn này!", success = "error" }, JsonRequestBehavior.AllowGet);
                    }
                    db.ChiTietHoaDonNhap.Remove(ct);
                }
            }

            db.SaveChanges();
            db.HoaDonNhap.Remove(countHoaDonNhap);
            db.SaveChanges();
            return Json(new { msg = "Xóa thành công hóa đơn!", success = "success" }, JsonRequestBehavior.AllowGet);
        }

        [HttpGet]
        public ActionResult suahoadonnhap(string maHD)
        {
            //Hóa đơn nhập cần sửa đổi
            ViewBag.hoadonnhap = db.HoaDonNhap.Where(hdn => hdn.MaHD == maHD)
                                .Select(hd => new
                                {
                                    hd.MaHD,
                                    hd.MaKho,
                                    hd.MaTK,
                                    hd.MaNSX,
                                    hd.NgayNhap,
                                    hd.GhiChu,
                                    danhsachnhaps = db.ChiTietHoaDonNhap.Where(ct => ct.MaHD == hd.MaHD)
                                                    .Select(ct => new
                                                    {
                                                        ct.MaHD,
                                                        ct.MaDT,
                                                        TenDauThuoc = db.DauThuoc.Where(dt => dt.MaDT == ct.MaDT).FirstOrDefault().TenDauThuoc,
                                                        ct.MaDonVi,
                                                        TenDonVi = db.DonVi.Where(dv => dv.ID == ct.MaDonVi).FirstOrDefault().Ten,
                                                        ct.SoLuong,
                                                        ct.DonGia
                                                    }).ToList()

                                }).FirstOrDefault();
            //Các thông tin khác
            var maTK = SessionHelper.GetRoles();
            if (maTK == "1")
            {
                ViewBag.Kho = db.Kho.ToList().Select(n => new { n.MaKho, n.TenKho, n.DiaChi }).ToList();
            }
            else
            {
                ViewBag.Kho = db.KhoNhanVien.Where(nv => nv.MaTK == maTK)
                                .ToList()
                                .Select(n => new
                                {
                                    n.MaKho,
                                    TenKho = db.Kho.Where(kh => kh.MaKho == n.MaKho).FirstOrDefault().TenKho
                                }).ToList();
            }
            ViewBag.NhaSanXuat = db.NhaSanXuat.Select(n => new { n.MaNSX, n.TenNSX }).ToList();

            ViewBag.NhomDauThuoc = db.NhomDauThuoc.Select(m => new
            {
                m.MaNhomThuoc,
                m.TenNhom,
                _DauThuoc = db.DauThuoc.AsEnumerable()
                .Join(db.TagsDThuocNThuoc.AsEnumerable().Where(tag => tag.MaNhomThuoc == m.MaNhomThuoc), dt => dt.MaDT, tag => tag.MaDauThuoc,
                (dt, tag) => new
                {
                    dt.MaDT,
                    dt.TenDauThuoc,
                    dt.GiaBanLe,
                    JDonVi = db.DonVi.Where(dv => dv.MaDT == dt.MaDT).ToList()
                                     .Select(dv => new
                                     {
                                         dv.ID,
                                         dv.IDParent,
                                         dv.Ten,
                                         dv.Heso,
                                         dv.TenDinhNghia
                                     }).ToList(),
                }).ToList(),
            }).ToList();
            return View();
        }

        [HttpPost]
        public ActionResult SuaHoaDonNhap(HoaDonNhapJS hoadonnhapJS)
        {
            var maTK = SessionHelper.GetMa();

            if (hoadonnhapJS.danhsachnhaps.ToList() != null)
            {
                //Lưu hóa đơn sau khi sửa
                var hoaDon = db.HoaDonNhap.Where(h => h.MaHD == hoadonnhapJS.MaHD).FirstOrDefault();
                if (hoaDon != null)
                {
                    hoaDon.MaHD = hoadonnhapJS.MaHD;
                    hoaDon.MaTK = maTK;
                    hoaDon.MaKho = hoadonnhapJS.MaKho;
                    hoaDon.MaNSX = hoadonnhapJS.MaNSX;
                    hoaDon.NgayNhap = hoadonnhapJS.NgayNhap;
                    hoaDon.GhiChu = hoadonnhapJS.GhiChu;
                }

                //Kiểm tra và trừ tất cả số lượng trong kho đã thêm từ hóa đơn cũ và xóa tất cả các chi tiết hóa đơn
                var listChiTiet = db.ChiTietHoaDonNhap.Where(ct => ct.MaHD == hoadonnhapJS.MaHD).ToList();
                foreach (ChiTietHoaDonNhap ct in listChiTiet)
                {
                    var countKho = db.KhoDauThuoc.Where(kdt => kdt.MaKho == hoadonnhapJS.MaKho && kdt.MaDT == ct.MaDT && kdt.MaDonVi == ct.MaDonVi).FirstOrDefault();
                    //Nếu trong kho không có hoặc số lượng không đủ thì không thể sửa
                    if ((countKho == null) || (countKho.SoLuongCon < ct.SoLuong))
                    {
                        return Json(new { msg = "Hóa đơn này không thể sửa!", success = "error" }, JsonRequestBehavior.AllowGet);
                    }
                }

                foreach (ChiTietHoaDonNhap ct in listChiTiet)
                {
                    var countKho = db.KhoDauThuoc.Where(kdt => kdt.MaKho == hoadonnhapJS.MaKho && kdt.MaDT == ct.MaDT && kdt.MaDonVi == ct.MaDonVi).FirstOrDefault();
                    countKho.SoLuongCon -= ct.SoLuong;
                    db.ChiTietHoaDonNhap.Remove(ct);
                    db.SaveChanges();
                }

                foreach (danhsachnhap ctn in hoadonnhapJS.danhsachnhaps.ToList())
                {
                    ChiTietHoaDonNhap cthd = new ChiTietHoaDonNhap();
                    cthd.MaHD = hoadonnhapJS.MaHD;
                    cthd.MaDT = ctn.MaDT;
                    cthd.MaDonVi = ctn.MaDonVi;
                    cthd.SoLuong = ctn.SoLuong;
                    cthd.DonGia = ctn.DonGia;
                    db.ChiTietHoaDonNhap.Add(cthd);
                    db.SaveChanges();

                    var countKho = db.KhoDauThuoc.Where(kdt => kdt.MaKho == hoadonnhapJS.MaKho && kdt.MaDT == ctn.MaDT && kdt.MaDonVi == ctn.MaDonVi).FirstOrDefault();
                    if (countKho != null)
                    {
                        countKho.SoLuongCon += ctn.SoLuong;
                        db.SaveChanges();
                    }
                    else
                    {
                        KhoDauThuoc kho = new KhoDauThuoc();
                        kho.MaKho = hoadonnhapJS.MaKho;
                        kho.MaDT = ctn.MaDT;
                        kho.MaDonVi = ctn.MaDonVi;
                        kho.SoLuongCon = ctn.SoLuong;
                        db.KhoDauThuoc.Add(kho);
                        db.SaveChanges();
                    }
                }
                return Json(new { msg = "Sửa thành công", success = "success" }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { msg = "Danh sách mua trống!", success = "error" }, JsonRequestBehavior.AllowGet);
            }
        }

        public void Export(string dateFrom, string dateTo)
        {
            var dateFrom1 = DateTime.Parse(dateFrom.Substring(1, 10));
            var dateTo1 = DateTime.Parse(dateTo.Substring(1, 10));
            //Get list export
            var hoaDonNhapEX = db.HoaDonNhap.Where(hd => hd.NgayNhap >= dateFrom1 && hd.NgayNhap <= dateTo1)
                                .ToList()
                                .Select(hd => new
                                {
                                    hd.MaHD,
                                    hd.MaKho,
                                    TenKho = db.Kho.Where(kh => kh.MaKho == hd.MaKho).FirstOrDefault().TenKho,
                                    hd.MaTK,
                                    NguoiNhap = db.TaiKhoan.Where(tk => tk.MaTK == hd.MaTK).FirstOrDefault().HoTen,
                                    hd.MaNSX,
                                    NhaSanXuat = db.NhaSanXuat.Where(nsx => nsx.MaNSX == hd.MaNSX).FirstOrDefault().TenNSX,
                                    NgayNhap = hd.NgayNhap.Value.ToString("MM/dd/yyyy"),
                                    hd.GhiChu
                                }).ToList();
            if (hoaDonNhapEX.Count() == 0)
            {
                hoaDonNhapEX = db.HoaDonNhap
                                .ToList()
                                .Select(hd => new
                                {
                                    hd.MaHD,
                                    hd.MaKho,
                                    TenKho = db.Kho.Where(kh => kh.MaKho == hd.MaKho).FirstOrDefault().TenKho,
                                    hd.MaTK,
                                    NguoiNhap = db.TaiKhoan.Where(tk => tk.MaTK == hd.MaTK).FirstOrDefault().HoTen,
                                    hd.MaNSX,
                                    NhaSanXuat = db.NhaSanXuat.Where(nsx => nsx.MaNSX == hd.MaNSX).FirstOrDefault().TenNSX,
                                    NgayNhap = hd.NgayNhap.Value.ToString("MM/dd/yyyy"),
                                    hd.GhiChu
                                }).ToList();
            }

            ///export///
            var filename = "Danh sách hóa đơn nhập ngày (" + DateTime.Now.ToString("dd-MM-yyyy hh:mm") + ").xlsx";
            var sheetname = "Customer";
            XLWorkbook workbook = new XLWorkbook();
            var workSheet = workbook.Worksheets.Add(sheetname);
            workSheet.SheetView.Freeze(1, 0);

            //Design header
            var obj = hoaDonNhapEX.FirstOrDefault();
            var comumns = obj.GetType().GetProperties();
            int i = 1;
            comumns.All(m =>
            {
                var name = m.Name
                .Replace("MaHD", "Mã hóa đơn")
                .Replace("MaKho", "Mã kho")
                .Replace("TenKho", "Tên kho")
                .Replace("MaTK", "Mã người nhập")
                .Replace("NguoiNhap", "Người nhập")
                .Replace("MaNSX", "Mã nhà sản xuất")
                .Replace("NhaSanXuat", "Nhà sản xuất")
                .Replace("NgayNhap", "Ngày nhập")
                .Replace("GhiChu", "Ghi chú");

                var h = workSheet.Cell(1, i).SetValue(name);
                h.Style.Font.Bold = true;
                h.Style.Font.FontColor = XLColor.White;
                h.Style.Fill.BackgroundColor = XLColor.Green;

                i++;
                return true;
            });

            //Bind data
            int rowIndex = 2;
            hoaDonNhapEX.All(b =>
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