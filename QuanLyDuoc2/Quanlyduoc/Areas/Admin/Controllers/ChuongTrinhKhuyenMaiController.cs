using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Models;
using Quanlyduoc.Code;
using System.IO;
using Quanlyduoc.Areas.Admin.Class;

namespace Quanlyduoc.Areas.Admin.Controllers
{
    [CheckSessionUser]
    public class ChuongTrinhKhuyenMaiController : Controller
    {
        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: Admin/ChuongTrinhKhuyenMai
        public ActionResult Index()
        {
            var JKhuyenMai = db.KhuyenMai
                             .Select(km => new
                             {
                                 km.ID,
                                 km.TenChuongTrinh,
                                 km.ChuDe,
                                 km.NoiDung,
                                 km.Image,
                                 ThoiGianBatDau = km.ThoiGianBatDau + "",
                                 ThoiGianKetThuc = km.ThoiGianKetThuc + ""
                             }).ToList();
            return View(Json(new { JKhuyenMai = JKhuyenMai }, JsonRequestBehavior.AllowGet));
        }

        [HttpPost]
        public ActionResult ThemKhuyenMai(string tenChuongTrinh, string chuDe, string noiDung, string batDau, string ketThuc, HttpPostedFileBase anhChuongTrinh)
        {
            KhuyenMai km = new KhuyenMai();
            if (anhChuongTrinh != null)
            {
                var imagefileName = Path.GetFileName(anhChuongTrinh.FileName);
                var path = Path.Combine(Server.MapPath("~/Content/Images/KhuyenMai"), imagefileName);
                if (System.IO.File.Exists(path) == false)
                {
                    anhChuongTrinh.SaveAs(path);
                }
                km.ID = "KM" + SinhMa.getMa("ID", "KhuyenMai");
                km.TenChuongTrinh = tenChuongTrinh;
                km.ChuDe = chuDe;
                km.NoiDung = noiDung;
                km.Image = imagefileName;
                km.ThoiGianBatDau = DateTime.Parse(batDau);
                km.ThoiGianKetThuc = DateTime.Parse(ketThuc);
            }
            else
            {
                km.ID ="KM" + SinhMa.getMa("ID", "KhuyenMai");
                km.TenChuongTrinh = tenChuongTrinh;
                km.ChuDe = chuDe;
                km.NoiDung = noiDung;
                km.ThoiGianBatDau = DateTime.Parse(batDau);
                km.ThoiGianKetThuc = DateTime.Parse(ketThuc);
            }
            db.KhuyenMai.Add(km);
            if(db.SaveChanges() == 1)
            {
                ViewBag.thanhcong = "Thêm thành công!";
                return RedirectToAction("Index");
                //return Json(new { msg = "Thêm thành công chương trình khuyến mại!", success = "success" }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                //return Json(new { msg = "Lỗi", success = "error" }, JsonRequestBehavior.AllowGet);
                ViewBag.loidulieu = "Lỗi dữ liệu không thêm được!";
                return View("Index");
            }
        }

        [HttpPost]
        public ActionResult SuaKhuyenMai(string maChuongTrinh, string tenChuongTrinh, string chuDe, string noiDung, string batDau, string ketThuc, HttpPostedFileBase anhChuongTrinh)
        {
            KhuyenMai km1 = new KhuyenMai();
            KhuyenMai km2 = db.KhuyenMai.Where(km => km.ID == maChuongTrinh).FirstOrDefault();
            if (anhChuongTrinh != null)
            {
                var imagefileName = Path.GetFileName(anhChuongTrinh.FileName);
                var path = Path.Combine(Server.MapPath("~/Content/Images/KhuyenMai"), imagefileName);
                if (System.IO.File.Exists(path) == false)
                {
                    anhChuongTrinh.SaveAs(path);
                }
                km1.ID = km2.ID;
                km1.TenChuongTrinh = tenChuongTrinh;
                km1.ChuDe = chuDe;
                km1.NoiDung = noiDung;
                km1.Image = imagefileName;
                if(batDau != null && batDau.Trim() != "")
                {
                    km1.ThoiGianBatDau = DateTime.Parse(batDau);
                }
                else
                {
                    km1.ThoiGianBatDau = km2.ThoiGianBatDau;
                }
                if(ketThuc != null && ketThuc.Trim() != "")
                {
                    km1.ThoiGianKetThuc = DateTime.Parse(ketThuc);
                }
                else
                {
                    km1.ThoiGianKetThuc = km2.ThoiGianKetThuc;
                }
            }
            else
            {
                km1.ID = km2.ID;
                km1.TenChuongTrinh = tenChuongTrinh;
                km1.ChuDe = chuDe;
                km1.NoiDung = noiDung;
                km1.Image = km2.Image;
                if (batDau != null && batDau.Trim() != "")
                {
                    km1.ThoiGianBatDau = DateTime.Parse(batDau);
                }
                else
                {
                    km1.ThoiGianBatDau = km2.ThoiGianBatDau;
                }
                if (ketThuc != null && ketThuc.Trim() != "")
                {
                    km1.ThoiGianKetThuc = DateTime.Parse(ketThuc);
                }
                else
                {
                    km1.ThoiGianKetThuc = km2.ThoiGianKetThuc;
                }
            }
            db.Entry(km2).CurrentValues.SetValues(km1);
            if (db.SaveChanges() == 1)
            {
                ViewBag.thanhcong = "Sửa thành công!";
                return RedirectToAction("Index");
                //return Json(new { msg = "Thêm thành công chương trình khuyến mại!", success = "success" }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                //return Json(new { msg = "Lỗi", success = "error" }, JsonRequestBehavior.AllowGet);
                ViewBag.loidulieu = "Lỗi dữ liệu!";
                return RedirectToAction("Index");
            }
        }

        [HttpPost]
        public JsonResult xoaKhuyenMai(string maKhuyenMai)
        {
            var km = db.KhuyenMai.Where(km1 =>km1.ID == maKhuyenMai).FirstOrDefault();
            if (km != null)
            {
                var listKmDt = db.KhuyenMaiDauThuoc.Where(KmDt => KmDt.MaKM == km.ID).ToList();
                if(listKmDt != null)
                {
                    foreach (var KmDt in listKmDt)
                    {
                        db.KhuyenMaiDauThuoc.Remove(KmDt);
                    }
                }
                db.KhuyenMai.Remove(km);
                db.SaveChanges();
            }
            return Json(new { msg = "Xóa thành công", success = "success" }, JsonRequestBehavior.AllowGet);
        }
    }
}