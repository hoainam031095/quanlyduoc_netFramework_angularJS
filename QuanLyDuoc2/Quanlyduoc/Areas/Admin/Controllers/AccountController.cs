using Quanlyduoc.Areas.Admin.Class;
using Quanlyduoc.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Code;

namespace Quanlyduoc.Areas.Admin.Controllers
{
    [CheckSessionUser]
    public class AccountController : Controller
    {
        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: Admin/Acount
        
        public ActionResult Index()
        {
            var JAccout = db.TaiKhoan
                .Select(m => new
                {
                    m.MaTK,
                    m.TenTaiKhoan,
                    m.HoTen,
                    m.SDT,
                    m.Email,
                    m.MatKhau,
                    m.MaQuyen,
                    m.MaNhomQuyen,
                    TenNhomQuyen = m.NhomQuyen.TenNhomQuyen
                })
                .ToList();
            var JNhomQuyen = db.NhomQuyen
                .Select(n => new
                {
                    n.MaNhomQuyen,
                    n.TenNhomQuyen,
                    n.MoTa
                }).ToList();
            return View(Json(new { JAccout = JAccout, JNhomQuyen = JNhomQuyen }, JsonRequestBehavior.AllowGet));
        }

        public JsonResult suaTaiKhoan(TaiKhoan taiKhoan)
        {
            //var cout = db.TaiKhoan.Where(tk => tk.TenTaiKhoan == taiKhoan.TenTaiKhoan).FirstOrDefault();
            //if (cout != null)
            //{
            //    return Json(new { msg = "Tên tài khoản đã tồn tại", success = "error" }, JsonRequestBehavior.AllowGet);
            //}
            //else
            //{
            var taiKhoan1 = db.TaiKhoan.Where(tk => tk.MaTK == taiKhoan.MaTK).FirstOrDefault();
            db.Entry(taiKhoan1).CurrentValues.SetValues(taiKhoan);
            db.SaveChanges();
            return Json(new { msg = "Sửa thành công", success = "success" }, JsonRequestBehavior.AllowGet);
            //}
        }

        public JsonResult themTaiKhoan(TaiKhoan taiKhoan)
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
                taiKhoan.MaQuyen = 1;
                db.TaiKhoan.Add(taiKhoan);
                db.SaveChanges();
                return Json(new { MaTK = MaTK, msg = "Thêm thành công", success = "success" }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult xoaTaiKhoan(string MaTK)
        {
            var taiKhoan = db.TaiKhoan.Where(tk => tk.MaTK == MaTK).FirstOrDefault();
            if (taiKhoan != null)
            {
                db.TaiKhoan.Remove(taiKhoan);
                db.SaveChanges();
            }
            return Json(new { msg = "Xóa thành công", success = "success" }, JsonRequestBehavior.AllowGet);
        }


    }
}