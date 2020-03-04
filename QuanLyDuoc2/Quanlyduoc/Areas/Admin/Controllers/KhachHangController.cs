using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Areas.Admin.Class;
using Quanlyduoc.Code;
using Quanlyduoc.Models;

namespace Quanlyduoc.Areas.Admin.Controllers
{
    
    public class KhachHangController : Controller
    {
        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: Admin/KhachHang
        [CheckSessionUser]
        public ActionResult Index()
        {
            var JKhachHang = db.KhachHang
                             .Select(kh => new
                             {
                                 kh.MaKH,
                                 kh.HoTen,
                                 kh.MaQuanHuyen,
                                 TenQuanHuyen = db.QuanHuyen.Where(qh => qh.ID == kh.MaQuanHuyen).FirstOrDefault().TenQuanHuyen,
                                 kh.MaTinhThanh,
                                 TenTinhThanh = db.TinhThanhPho.Where(tp => tp.ID == kh.MaTinhThanh).FirstOrDefault().TenTinh,
                                 kh.DiaChi,
                                 kh.SDT,
                                 kh.Email
                             }).ToList();
            var JtinhThanh = db.TinhThanhPho
                .ToList()
                .Select(tp => new
                {
                    tp.ID,
                    tp.TenTinh
                }).OrderBy(tp => tp.TenTinh).ToList();
            if (SessionHelper.GetRoles() == "1")
            {
                var JNhomQuyen = db.NhomQuyen
                .Select(n => new
                {
                    n.MaNhomQuyen,
                    n.TenNhomQuyen,
                    n.MoTa
                }).ToList();
                return View(Json(new { JKhachHang = JKhachHang, JNhomQuyen = JNhomQuyen, JtinhThanh = JtinhThanh }));
            }
            else
            {
                var JNhomQuyen = db.NhomQuyen.Where(nq => nq.TenNhomQuyen.ToLower() == "khách hàng".ToLower())
                .Select(n => new
                {
                    n.MaNhomQuyen,
                    n.TenNhomQuyen,
                    n.MoTa
                }).ToList();
                return View(Json(new { JKhachHang = JKhachHang, JNhomQuyen = JNhomQuyen, JtinhThanh = JtinhThanh }));
            }
        }

        [CheckSessionUser]
        public JsonResult themKhachHang(KhachHang khachHang)
        {
            if (khachHang.HoTen == null || khachHang.DiaChi == null || khachHang.SDT == null)
            {
                return Json(new { msg = "Dữ liệu không hợp lệ!", success = "error" }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var cout = db.KhachHang.Where(kh => kh.SDT == khachHang.SDT).FirstOrDefault();
                if (cout != null)
                {
                    return Json(new { msg = "Số điện thoại này đã dùng cho khách hàng khác!", success = "error" }, JsonRequestBehavior.AllowGet);
                }
                else
                {

                    var MaKH = "KH" + SinhMa.getMa("MaKH", "KhachHang");
                    var TenTinhThanh = db.TinhThanhPho.Where(tp => tp.ID == khachHang.MaTinhThanh).FirstOrDefault().TenTinh;
                    var TenQuanHuyen = db.QuanHuyen.Where(qh => qh.ID == khachHang.MaQuanHuyen).FirstOrDefault().TenQuanHuyen;
                    if (SessionHelper.GetRoles() == "2")
                    {
                        var MaTD = db.TaiKhoan.Where(tk => tk.MaTK == SessionHelper.GetMa()).FirstOrDefault().MaTD;
                        var NgayBatDau = DateTime.UtcNow.Date;
                        TrinhDuocKhachHang tdkh = new TrinhDuocKhachHang();
                        tdkh.MaTD = MaTD;
                        tdkh.MaKH = MaKH;
                        tdkh.NgayBatDau = NgayBatDau;
                        db.TrinhDuocKhachHang.Add(tdkh);
                    }
                    khachHang.MaKH = MaKH;
                    db.KhachHang.Add(khachHang);
                    db.SaveChanges();
                    return Json(new { MaKH = MaKH, TenTinhThanh = TenTinhThanh, TenQuanHuyen = TenQuanHuyen, msg = "Thêm thành công", success = "success" }, JsonRequestBehavior.AllowGet);
                }
            }
        }

        [CheckSessionUser]
        public JsonResult suaKhachHang(KhachHang khachHang)
        {
            if (khachHang.HoTen == null || khachHang.DiaChi == null || khachHang.SDT == null)
            {
                return Json(new { msg = "Dữ liệu không hợp lệ!", success = "error" }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var cout = db.KhachHang.Where(kh => kh.SDT == khachHang.SDT).FirstOrDefault();
                if (cout != null && cout.MaKH != khachHang.MaKH)
                {
                    return Json(new { msg = "Số điện thoại này đã dùng cho khách hàng khác!", success = "error" }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    var TenTinhThanh = db.TinhThanhPho.Where(tp => tp.ID == khachHang.MaTinhThanh).FirstOrDefault().TenTinh;
                    var TenQuanHuyen = db.QuanHuyen.Where(qh => qh.ID == khachHang.MaQuanHuyen).FirstOrDefault().TenQuanHuyen;

                    var khachHang1 = db.KhachHang.Where(kh => kh.MaKH == khachHang.MaKH).FirstOrDefault();
                    db.Entry(khachHang1).CurrentValues.SetValues(khachHang);
                    db.SaveChanges();
                    return Json(new {TenTinhThanh = TenTinhThanh, TenQuanHuyen = TenQuanHuyen, msg = "Sửa thành công", success = "success" }, JsonRequestBehavior.AllowGet);
                }
            }
        }

        [CheckSessionUser]
        [HttpPost]
        public JsonResult checkTaiKhoanKhachHang(string maKhachHang)
        {
            var cout = db.TaiKhoan.Where(tk => tk.MaKH == maKhachHang).FirstOrDefault();
            if (cout != null)
            {
                return Json(new { msg = "khách hàng này đã có: ", success = "error", maTaiKhoan = cout.MaTK }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { success = "success" }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult themTaiKhoanChoKhachHang(TaiKhoan taiKhoan)
        {
            var cout = db.TaiKhoan.Where(tk => tk.TenTaiKhoan == taiKhoan.TenTaiKhoan).FirstOrDefault();
            if (cout != null)
            {
                return Json(new { msg = "Tên tài khoản đã tồn tại", success = "error" }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var MaTK = "TK" + SinhMa.getMa("MaTK", "TaiKhoan");
                taiKhoan.MaTK = MaTK;
                taiKhoan.MaQuyen = 3;
                db.TaiKhoan.Add(taiKhoan);
                db.SaveChanges();

                return Json(new { MaTK = MaTK, msg = "Thêm thành công", success = "success" }, JsonRequestBehavior.AllowGet);
            }
        }

        [CheckSessionUser]
        [HttpPost]
        public JsonResult Xoa(string maKhachHang)
        {
            KhachHang khachHang = db.KhachHang.Where(m => m.MaKH == maKhachHang).FirstOrDefault();
            if (khachHang == null)
            {
                Response.StatusCode = 404;
                return Json(new { msg = "Lỗi", success = "error" }, JsonRequestBehavior.AllowGet); ;
            }
            db.KhachHang.Remove(khachHang);
            db.SaveChanges();
            return Json(new { msg = "Xóa thành công khách hàng", success = "success" }, JsonRequestBehavior.AllowGet);
        }
    }
}