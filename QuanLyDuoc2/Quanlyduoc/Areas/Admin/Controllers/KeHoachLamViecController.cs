using Quanlyduoc.Areas.Admin.Class;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Models;
using Quanlyduoc.Code;

namespace Quanlyduoc.Areas.Admin.Controllers
{
    [CheckSessionUser]
    public class KeHoachLamViecController : Controller
    {
        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: Admin/KeHoachLamViec
        public ActionResult Index()
        {
            var JNhanVien = db.TrinhDuoc
                            .Select(td => new
                            {
                                td.MaTD,
                                td.HoTen,
                                td.SDT,
                                td.NgaySinh,
                                td.DiaChi,
                                td.KhuVuc,
                                td.TrangThai,
                                td.DanhGia,
                                td.LuongTieuThu,
                            }).ToList();
            var JCongViec = db.KeHoachLamViec
                            .Select(k => new
                            {
                                k.ID,
                                k.CongViec,
                                k.TrangThai1,
                                k.TrangThai2,
                                k.GhiChu,
                                k.MaTD
                            }).ToList();
            return View(Json(new { JNhanVien = JNhanVien, JCongViec = JCongViec }, JsonRequestBehavior.AllowGet));
        }

        [HttpPost]
        public JsonResult themKeHoach(string congViec, string ghiChu, string maTD)
        {
            if (congViec == null || congViec.Trim() == "")
            {
                return Json(new { msg = "Điền tên công việc. Please!", success = "error" });
            }
            else
            {
                KeHoachLamViec keHoach = new KeHoachLamViec();
                keHoach.ID = "KH" + SinhMa.getMa("ID", "KeHoachLamViec");
                keHoach.CongViec = congViec;
                keHoach.TrangThai1 = 1;
                keHoach.TrangThai2 = 1;
                keHoach.GhiChu = ghiChu;
                keHoach.MaTD = maTD;
                db.KeHoachLamViec.Add(keHoach);
                if (db.SaveChanges() == 1)
                {
                    return Json(new { keHoach = keHoach, msg = "Thêm thành công!", success = "success" }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { msg = "Lỗi", success = "error" });
                }
            }
        }

        [HttpPost]
        public JsonResult suaKeHoach(JsonKeHoach jsonKeHoach)
        {
            if (jsonKeHoach != null || jsonKeHoach.ID == null)
            {
                if (jsonKeHoach.CongViec.Trim() == null || jsonKeHoach.CongViec.Trim() == "")
                {
                    return Json(new { msg = "Điền tên công việc. Please!", success = "error" });
                }
                else
                {
                    var keHoach1 = db.KeHoachLamViec.Where(k => k.ID == jsonKeHoach.ID).FirstOrDefault();
                    var keHoach2 = db.KeHoachLamViec.Where(k => k.ID == jsonKeHoach.ID).FirstOrDefault();

                    keHoach2.CongViec = jsonKeHoach.CongViec;
                    keHoach2.GhiChu = jsonKeHoach.GhiChu;
                    db.Entry(keHoach1).CurrentValues.SetValues(keHoach2);
                    if (db.SaveChanges() == 1)
                    {
                        return Json(new { msg = "Thêm thành công!", success = "success" }, JsonRequestBehavior.AllowGet);
                    }
                    else
                    {
                        return Json(new { msg = "Lỗi", success = "error" });
                    }
                }
            }
            else
            {
                return Json(new { msg = "Lỗi", success = "error" });
            }
        }

        [HttpPost]
        public JsonResult xoaKeHoach(string maKeHoach)
        {
            var count = db.KeHoachLamViec.Where(k => k.ID == maKeHoach).FirstOrDefault();
            if (count != null)
            {
                db.KeHoachLamViec.Remove(count);
                db.SaveChanges();
                return Json(new { msg = "Xóa thành công!", success = "success" }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { msg = "Lỗi", success = "error" });
            }
        }

        public ActionResult kehoachcanhan()
        {
            var maTaiKhoan = SessionHelper.GetMa();
            var tk1 = db.TaiKhoan.Where(tk => tk.MaTK == maTaiKhoan).FirstOrDefault();
            var maTrinhDuoc = db.TaiKhoan.Where(tk => tk.MaTK == maTaiKhoan).FirstOrDefault().MaTD;
            var JCongViec = db.KeHoachLamViec.Where(k => k.MaTD == maTrinhDuoc)
                            .Select(k => new
                            {
                                k.ID,
                                k.CongViec,
                                k.TrangThai1,
                                k.TrangThai2,
                                k.GhiChu,
                                k.MaTD
                            }).ToList();
            return View(Json(new { JCongViec = JCongViec }, JsonRequestBehavior.AllowGet));
        }

        [HttpPost]
        public JsonResult hoanThanhCongViec(string maCongViec)
        {
            var keHoach = db.KeHoachLamViec.Where(k => k.ID == maCongViec).FirstOrDefault();
            var keHoach1 = db.KeHoachLamViec.Where(k => k.ID == maCongViec).FirstOrDefault();
            var tt = 0;
            if (keHoach1.TrangThai1 == 1)
            {
                keHoach1.TrangThai1 = 2;
                tt = 2;

            }
            else
            {
                keHoach1.TrangThai1 = 1;
                tt = 1;
            }
            db.Entry(keHoach).CurrentValues.SetValues(keHoach1);
            if(db.SaveChanges() == 1)
            {
                return Json(new { tt = tt }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { tt = 0 }, JsonRequestBehavior.AllowGet);
            }
            
        }

        [HttpPost]
        public JsonResult pheDuyetCongViec(string maCongViec)
        {
            var keHoach = db.KeHoachLamViec.Where(k => k.ID == maCongViec).FirstOrDefault();
            var keHoach1 = db.KeHoachLamViec.Where(k => k.ID == maCongViec).FirstOrDefault();
            var tt = 0;
            if (keHoach1.TrangThai2 == 1)
            {
                keHoach1.TrangThai2 = 2;
                tt = 2;

            }
            else
            {
                keHoach1.TrangThai2 = 1;
                tt = 1;
            }
            db.Entry(keHoach).CurrentValues.SetValues(keHoach1);
            if (db.SaveChanges() == 1)
            {
                return Json(new { tt = tt }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { tt = 0 }, JsonRequestBehavior.AllowGet);
            }
        }

    }

}