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
    
    public class TrinhDuocController : Controller
    {
        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: Admin/TrinhDuoc
        [CheckSessionUser]
        [HttpGet]
        public ActionResult Index()
        {
            var JtrinhDuoc = db.TrinhDuoc
                             .Select(n => new
                             {
                                 n.MaTD,
                                 n.HoTen,
                                 n.SDT,
                                 n.NgaySinh,
                                 n.DiaChi,
                                 n.KhuVuc,
                                 n.TrangThai,
                                 n.DanhGia,
                                 n.LuongTieuThu
                             }).ToList();

            var JtinhThanh = db.TinhThanhPho
                            .Select(tp => new
                            {
                                tp.ID,
                                tp.TenTinh,
                                JquanHuyen = db.QuanHuyen.Where(qh => qh.IDTinhThanh == tp.ID)
                                             .Select(qh => new
                                             {
                                                 qh.ID,
                                                 qh.TenQuanHuyen
                                             }).ToList()
                            }).ToList();
            var JNhomQuyen = db.NhomQuyen
                .Select(n => new
                {
                    n.MaNhomQuyen,
                    n.TenNhomQuyen,
                    n.MoTa
                }).ToList();
            return View(Json(new { JtrinhDuoc = JtrinhDuoc, JtinhThanh = JtinhThanh, JNhomQuyen = JNhomQuyen }, JsonRequestBehavior.AllowGet));
        }

        [CheckSessionUser]
        [HttpGet]
        public ActionResult Themtrinhduoc()
        {
            ViewBag.MaTinhThanh = new SelectList(db.TinhThanhPho.ToList().OrderBy(c => c.TenTinh), "ID", "TenTinh");
            return View();
        }

        [HttpPost]
        public ActionResult ThemTrinhDuoc(TrinhDuoc trinhDuoc, int MaTinhThanh, int maQuanHuyen)
        {
            if (ModelState.IsValid)
            {
                string maTrinhDuoc = "TD" + SinhMa.getMa("MaTD", "TrinhDuoc");
                TrinhDuoc countTrinhDuoc = db.TrinhDuoc.Where(m => m.MaTD == maTrinhDuoc).FirstOrDefault();
                //if( countTrinhDuoc != null)
                //{
                //    ViewBag.Thongbao = "Mã trình dược này đã có mời nhập lại";
                //    ViewBag.MaTinhThanh = new SelectList(db.TinhThanhPho.ToList().OrderBy(c => c.TenTinh), "ID", "TenTinh");
                //    return View();
                //}
                //else
                //{
                string khuVuc = db.TinhThanhPho.Where(m => m.ID == MaTinhThanh).FirstOrDefault().TenTinh + " - "
                                + db.QuanHuyen.Where(m => m.ID == maQuanHuyen).FirstOrDefault().TenQuanHuyen;
                trinhDuoc.MaTD = maTrinhDuoc;
                trinhDuoc.KhuVuc = khuVuc;
                db.TrinhDuoc.Add(trinhDuoc);
                db.SaveChanges();
                return RedirectToAction("Index");
                //}

            }
            ViewBag.Thongbao = "Dữ liệu nhập vào không hợp lệ";
            ViewBag.MaTinhThanh = new SelectList(db.TinhThanhPho.ToList().OrderBy(c => c.TenTinh), "ID", "TenTinh");
            return View();
        }

        [CheckSessionUser]
        [HttpPost]
        public JsonResult checkTaiKhoanTrinhDuoc(string maTrinhDuoc)
        {
            var cout = db.TaiKhoan.Where(tk => tk.MaTD == maTrinhDuoc).FirstOrDefault();
            if (cout != null)
            {
                return Json(new { msg = "Trình dược này đã có: ", success = "error", maTaiKhoan = cout.MaTK }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { success = "success" }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult themTaiKhoanChoTrinhDuoc(TaiKhoan taiKhoan)
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
                taiKhoan.MaQuyen = 2;
                db.TaiKhoan.Add(taiKhoan);
                db.SaveChanges();

                return Json(new { MaTK = MaTK, msg = "Thêm thành công", success = "success" }, JsonRequestBehavior.AllowGet);
            }
        }

        [CheckSessionUser]
        [HttpGet]
        public ActionResult suaTrinhDuoc(string maTrinhDuoc)
        {
            var trinhDuoc = db.TrinhDuoc.Where(td => td.MaTD == maTrinhDuoc).FirstOrDefault();
            return View(trinhDuoc);
        }

        [CheckSessionUser]
        [HttpPost]
        public JsonResult Xoa(string maTrinhDuoc)
        {
            TrinhDuoc trinhDuoc = db.TrinhDuoc.Where(m => m.MaTD == maTrinhDuoc).FirstOrDefault();
            if (trinhDuoc == null)
            {
                Response.StatusCode = 404;
                return Json(new { msg = "Lỗi", success = "error" }, JsonRequestBehavior.AllowGet); ;
            }
            db.TrinhDuoc.Remove(trinhDuoc);
            db.SaveChanges();
            return Json(new { msg = "Xóa thành công trình dược", success = "success" }, JsonRequestBehavior.AllowGet);
        }

    }
}