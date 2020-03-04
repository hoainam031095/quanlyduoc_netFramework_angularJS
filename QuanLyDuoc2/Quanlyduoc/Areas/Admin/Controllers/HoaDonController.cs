using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Models;
using Quanlyduoc.Code;
using Quanlyduoc.Areas.Admin.Class;

namespace Quanlyduoc.Areas.Admin.Controllers
{
    
    public class HoaDonController : Controller
    {

        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: Admin/HoaDon
        [CheckSessionUser]
        public ActionResult Index()
        {
            //Danh sách hóa đơn đối với người quản lý
            if (SessionHelper.GetRoles() == "1")
            {
                //Danh sách hóa đơn đối với quản lý
                var HoaDonJ = from a in db.HoaDonMua
                                  //join g in db.ChiTietHoaDonMua on a.MaHD equals g.MaHD
                              join b in db.KhachHang on a.MaKH equals b.MaKH
                              join c in db.TaiKhoan on a.MaTK equals c.MaTK into HD_TK
                              from TK in HD_TK.DefaultIfEmpty()
                              join d in db.HoaDonVanChuyen on a.MaHoaDonVanChuyen equals d.MaHoaDonVanChuyen into HD_VC
                              from VC in HD_VC.DefaultIfEmpty()
                              join e in db.VanChuyen on (VC == null ? "" : VC.MaNguoiVanChuyen) equals e.MaNguoiVanChuyen into HD_TONG
                              from HD in HD_TONG.DefaultIfEmpty()
                              select new DonDatHangModels()
                              {
                                  maHoaDon = a.MaHD,
                                  maKhachHang = b.MaKH == null ? "" : b.MaKH,
                                  tenKhachHang = b.MaKH == null ? "" : b.HoTen,
                                  ngayMua = a.NgayMua.Value.ToString(),
                                  maTaiKhoan = TK == null ? "" : a.MaTK,
                                  tenTaiKhoan = TK == null ? "" : TK.HoTen,
                                  trangThai = a.TrangThai == 1 ? "Chưa duyệt" : (a.TrangThai == 2 ? "Đã duyệt" : (a.TrangThai == 3 ? "Đã xuất" : "Hoàn thành")),
                                  maHoaDonVanChuyen = HD == null ? "" : a.MaHoaDonVanChuyen,
                                  nguoiVanChuyen = VC == null ? "" : VC.VanChuyen.HoTen,
                              };

                if (HoaDonJ == null)
                {
                    Response.StatusCode = 404;
                }
                return View(Json(new { hoaDon = HoaDonJ }, JsonRequestBehavior.AllowGet));
            }
            else
            {
                //Danh sách hóa đơn đối với nhân viên
                if (SessionHelper.GetRoles() == "2")
                {
                    var maSession = SessionHelper.GetMa();
                    var maTD = db.TaiKhoan.Where(tk => tk.MaTK == maSession).FirstOrDefault().MaTD;
                    //var listKH = db.TrinhDuocKhachHang.Where(kh => kh.MaTD == maTD).ToList();
                    var HoaDonJ = from a in db.HoaDonMua
                                  join b in db.KhachHang on a.MaKH equals b.MaKH
                                  join f in db.TrinhDuocKhachHang on b.MaKH equals f.MaKH
                                  where f.MaTD == maTD
                                  join c in db.TaiKhoan on a.MaTK equals c.MaTK into HD_TK
                                  from TK in HD_TK.DefaultIfEmpty()
                                  join d in db.HoaDonVanChuyen on a.MaHoaDonVanChuyen equals d.MaHoaDonVanChuyen into HD_VC
                                  from VC in HD_VC.DefaultIfEmpty()
                                  join e in db.VanChuyen on (VC == null ? "" : VC.MaNguoiVanChuyen) equals e.MaNguoiVanChuyen into HD_TONG
                                  from HD in HD_TONG.DefaultIfEmpty()

                                  select new DonDatHangModels()
                                  {
                                      maHoaDon = a.MaHD,
                                      maKhachHang = b.MaKH == null ? "" : b.MaKH,
                                      tenKhachHang = b.MaKH == null ? "" : b.HoTen,
                                      ngayMua = a.NgayMua.Value.ToString(),
                                      maTaiKhoan = TK == null ? "" : a.MaTK,
                                      tenTaiKhoan = TK == null ? "" : TK.HoTen,
                                      trangThai = a.TrangThai == 1 ? "Chưa duyệt" : (a.TrangThai == 2 ? "Đã duyệt" : (a.TrangThai == 3 ? "Đã xuất" : "Hoàn thành")),
                                      maHoaDonVanChuyen = HD == null ? "" : a.MaHoaDonVanChuyen,
                                      nguoiVanChuyen = VC == null ? "" : VC.VanChuyen.HoTen,
                                  };

                    if (HoaDonJ == null)
                    {
                        Response.StatusCode = 404;
                    }
                    return View(Json(new { hoaDon = HoaDonJ }, JsonRequestBehavior.AllowGet));
                }
                //Danh sách hóa đơn đối với khách hàng
                else
                {
                    var HoaDonJ = from a in db.HoaDonMua
                                  join b in db.KhachHang on a.MaKH equals b.MaKH
                                  join f in db.TrinhDuocKhachHang on b.MaKH equals f.MaKH
                                  join c in db.TaiKhoan on a.MaTK equals c.MaTK into HD_TK
                                  from TK in HD_TK.DefaultIfEmpty()
                                  join d in db.HoaDonVanChuyen on a.MaHoaDonVanChuyen equals d.MaHoaDonVanChuyen into HD_VC
                                  from VC in HD_VC.DefaultIfEmpty()
                                  join e in db.VanChuyen on (VC == null ? "" : VC.MaNguoiVanChuyen) equals e.MaNguoiVanChuyen into HD_TONG
                                  from HD in HD_TONG.DefaultIfEmpty()

                                  select new DonDatHangModels()
                                  {
                                      maHoaDon = a.MaHD,
                                      maKhachHang = b.MaKH == null ? "" : b.MaKH,
                                      tenKhachHang = b.MaKH == null ? "" : b.HoTen,
                                      ngayMua = a.NgayMua.Value.ToString(),
                                      maTaiKhoan = TK == null ? "" : a.MaTK,
                                      tenTaiKhoan = TK == null ? "" : TK.HoTen,
                                      trangThai = a.TrangThai == 1 ? "Chưa duyệt" : (a.TrangThai == 2 ? "Đã duyệt" : (a.TrangThai == 3 ? "Đã xuất" : "Hoàn thành")),
                                      maHoaDonVanChuyen = HD == null ? "" : a.MaHoaDonVanChuyen,
                                      nguoiVanChuyen = VC == null ? "" : VC.VanChuyen.HoTen,
                                  };

                    if (HoaDonJ == null)
                    {
                        Response.StatusCode = 404;
                    }
                    return View(Json(new { hoaDon = HoaDonJ }, JsonRequestBehavior.AllowGet));
                }
            }
            
        }

        [CheckSessionUser]
        [HttpGet]
        public ViewResult themHoaDon()
        {
            ViewBag.NhomDauThuoc = db.NhomDauThuoc.Select(m => new
            {
                Value = m.MaNhomThuoc,
                Text = m.TenNhom,
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

            if (SessionHelper.GetRoles() == "1")
            {
                ViewBag.KhachHang = db.KhachHang.Select(kh => new
                {
                    kh.MaKH,
                    kh.HoTen,
                    kh.SDT
                }).ToList();
            }
            else
            {
                if(SessionHelper.GetRoles() == "2")
                {
                    var maTaiKhoan = SessionHelper.GetMa();
                    var maTD = db.TaiKhoan.Where(tk => tk.MaTK == maTaiKhoan).FirstOrDefault().MaTD;
                    ViewBag.KhachHang = db.KhachHang.Join(db.TrinhDuocKhachHang,
                                                          k => k.MaKH,
                                                          t => t.MaKH,
                                                          (k, t) => new { k, t })
                                                        .Where(kt => kt.t.MaTD == maTD)
                                                        .Select(kh => new
                                                        {
                                                            kh.k.MaKH,
                                                            kh.k.HoTen,
                                                            kh.k.SDT

                                                        }).ToList();
                }
                else
                {
                    var maTaiKhoan = SessionHelper.GetMa();
                    var maKH = db.TaiKhoan.Where(tk => tk.MaTK == maTaiKhoan).FirstOrDefault().MaTK;
                    ViewBag.KhachHang = db.KhachHang.Where(kh => kh.MaKH == maKH).Select(kh => new
                    {
                        kh.MaKH,
                        kh.HoTen,
                        kh.SDT

                    }).ToList();
                }
                
            }
            //new SelectList(db.NhomDauThuoc.ToList(), "MaNhomThuoc", "TenNhom");
            ViewBag.maHoaDon = "HD" + SinhMa.getMa("MaHD", "HoaDonMua");

            ViewBag.ngayMua = DateTime.UtcNow.Date.ToString("yyyy-MM-dd");
            return View();
        }

        [HttpPost]
        public JsonResult themHoaDon(HoaDonJS hoaDonJS)
        {
            var maHoaDon = hoaDonJS.maHoaDon;
            var ngayMua = hoaDonJS.ngayMua;
            var maKhachHang = hoaDonJS.maKhachHang;
            if(maHoaDon == null || ngayMua == null || maKhachHang == null)
            {
                return Json(new { msg = "Dữ liệu còn thiếu!", success = "error" }, JsonRequestBehavior.AllowGet);
            }
            else
            {

                if (hoaDonJS.danhsachchon.ToList() != null)
                {
                    var hoaDon = db.HoaDonMua.Where(h => h.MaHD == maHoaDon).FirstOrDefault();
                    if (hoaDon == null)
                    {
                        HoaDonMua hd = new HoaDonMua();
                        hd.MaHD = maHoaDon;
                        //hd.MaKH = SessionHelper.GetMa();
                        hd.MaKH = maKhachHang;
                        hd.NgayMua = DateTime.Now;
                        hd.TrangThai = 1;
                        db.HoaDonMua.Add(hd);
                    }
                    foreach (danhsachchon ct in hoaDonJS.danhsachchon.ToList())
                    {
                        ChiTietHoaDonMua cthd = new ChiTietHoaDonMua();
                        cthd.MaHD = maHoaDon;
                        cthd.MaDT = ct.MaDT;
                        cthd.MaDonVi = ct.Donvi.ID;
                        var cthdCount = db.ChiTietHoaDonMua.Where(c => c.MaHD == maHoaDon && c.MaDT == ct.MaDT && c.MaDonVi == ct.Donvi.ID).FirstOrDefault();
                        if (cthdCount != null)
                        {
                            cthd.SoLuong = Math.Abs(Int32.Parse(ct.soLuong)) + cthdCount.SoLuong;
                            cthd.DonGia = ct.donGia + cthdCount.DonGia;
                            db.Entry(cthdCount).CurrentValues.SetValues(cthd);
                            db.SaveChanges();
                        }
                        else
                        {
                            cthd.SoLuong = Math.Abs(Int32.Parse(ct.soLuong));
                            cthd.DonGia = ct.donGia;
                            db.ChiTietHoaDonMua.Add(cthd);
                            db.SaveChanges();
                        }
                    }
                    var newMaHoaDon = "HD" + SinhMa.getMa("MaHD", "HoaDonMua");
                    return Json(new { mamoi = newMaHoaDon, msg = "Mua thành công", success = "success" }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { msg = "Danh sách mua trống!", success = "error" }, JsonRequestBehavior.AllowGet);
                }
            }
        }


        [HttpPost]
        public JsonResult kiemTraTrangThaiPheDuyet(string maHoaDon)
        {
            var hoadon = db.HoaDonMua.Where(m => m.MaHD == maHoaDon).FirstOrDefault();
            var trangthai = 0;
            if (hoadon.TrangThai == 1)
            {
                trangthai = 1;
                var JKho = db.Kho
                        .Select(kho => new
                        {
                            kho.MaKho,
                            kho.TenKho,
                            kho.DiaChi,
                            kho.SDT
                        }).ToList();

                return Json(new { trangthai = trangthai, JKho = JKho, success = "success" }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                if (hoadon.TrangThai == 2)
                {
                    trangthai = 2;

                    return Json(new { trangthai = trangthai, success = "success" }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    if (hoadon.TrangThai == 3)
                    {
                        return Json(new { msg = "Hóa đơn này đã xuất", success = "error" }, JsonRequestBehavior.AllowGet);
                    }
                    else
                    {
                        return Json(new { msg = "Hóa đơn này đã hoàn thành", success = "error" }, JsonRequestBehavior.AllowGet);
                    }
                }
            }
        }

        [CheckSessionUser]
        [HttpPost]
        public JsonResult pheDuyetHoaDon(string maHoaDon, string maKho)
        {
            var hoadon = db.HoaDonMua.Where(m => m.MaHD == maHoaDon).FirstOrDefault();
            var hoadon1 = db.HoaDonMua.Where(m => m.MaHD == maHoaDon).FirstOrDefault();
            var trangthai = 0;
            var taikhoan = "";
            var tenTaiKhoan = "";
            if (hoadon.TrangThai == 1)
            {
                var maTaiKhoan = SessionHelper.GetMa();
                taikhoan = hoadon1.MaTK = maTaiKhoan;
                hoadon1.MaKho = maKho;
                tenTaiKhoan = db.TaiKhoan.Where(t => t.MaTK == maTaiKhoan).FirstOrDefault().HoTen;
                hoadon1.TrangThai = 2;
                trangthai = 2;
            }
            else
            {
                if (hoadon.TrangThai == 2)
                {
                    taikhoan = hoadon1.MaTK = null;
                    hoadon1.MaKho = null;
                    var hdvc = db.HoaDonVanChuyen.Where(hdvc1 => hdvc1.MaHoaDonVanChuyen == hoadon1.MaHoaDonVanChuyen).FirstOrDefault();
                    if(hdvc != null)
                    {
                        db.HoaDonVanChuyen.Remove(hdvc);
                        db.SaveChanges();
                    }
                    hoadon1.MaHoaDonVanChuyen = null;
                    hoadon1.TrangThai = 1;
                    trangthai = 1;
                }
                else
                {
                    if (hoadon.TrangThai == 3)
                    {
                        trangthai = 3;
                        return Json(new { msg = "Hóa đơn này đã xuất", success = "error" }, JsonRequestBehavior.AllowGet);
                    }
                    else
                    {
                        trangthai = 4;
                        return Json(new { msg = "Hóa đơn này đã hoàn thành", success = "error" }, JsonRequestBehavior.AllowGet);
                    }
                }
            }

            db.Entry(hoadon).CurrentValues.SetValues(hoadon1);
            db.SaveChanges();
            return Json(new { tt = trangthai, tk = taikhoan, tentk = tenTaiKhoan, success = "success" }, JsonRequestBehavior.AllowGet);
        }

        [CheckSessionUser]
        [HttpPost]
        public JsonResult xoaHoaDon(string maHoaDon)
        {
            var hoaDon = db.HoaDonMua.Where(hd => hd.MaHD == maHoaDon).FirstOrDefault();

            var listChiTietHoaDon = db.ChiTietHoaDonMua.Where(cthd => cthd.MaHD == maHoaDon).ToList();
            foreach (ChiTietHoaDonMua ct in listChiTietHoaDon)
                db.ChiTietHoaDonMua.Remove(ct);

            if(hoaDon.MaHoaDonVanChuyen != null)
            {
                var hdvc = db.HoaDonVanChuyen.Where(hdc => hdc.MaHoaDonVanChuyen == hoaDon.MaHoaDonVanChuyen).FirstOrDefault();
                db.HoaDonVanChuyen.Remove(hdvc);
            }

            db.HoaDonMua.Remove(hoaDon);
            db.SaveChanges();
            return Json(new
            {
                msg = "Xóa thành công!",
                success = "success",
                ketqua = true
            }, JsonRequestBehavior.AllowGet);
        }
    }
}