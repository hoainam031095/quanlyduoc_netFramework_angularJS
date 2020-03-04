using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Areas.Admin.Class;
using Quanlyduoc.Code;
using Quanlyduoc.Models;

namespace Quanlyduoc.Areas.Admin.Controllers
{
    [CheckSessionUser]
    public class NhomDauThuocController : Controller
    {
        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: Admin/NhomDauThuoc
        public ActionResult Index()
        {
            var JNhomDauThuoc = from a in db.NhomDauThuoc
                                select (new
                                {
                                    maNhomThuoc = a.MaNhomThuoc,
                                    tenNhomThuoc = a.TenNhom,
                                    image = a.Image,
                                    status = a.Status
                                });
            if (JNhomDauThuoc == null)
            {
                Response.StatusCode = 404;
            }
            return View(Json(new { JListNDT = JNhomDauThuoc }, JsonRequestBehavior.AllowGet));
        }

        [HttpPost]
        public ActionResult ThemNhomDauThuoc(string tenNhomThuoc, string status, HttpPostedFileBase anhNhomDauThuoc)
        {
            NhomDauThuoc nhomDauThuoc = new NhomDauThuoc();
            if (anhNhomDauThuoc != null)
            {
                //Lấy tên file ghép vào thời gian update để tạo tên ảnh mới
                string nowDate = DateTime.Now.ToString("MM_dd_yyyy_hh_mm_ss");
                var imagefileName = Path.GetFileName(anhNhomDauThuoc.FileName).Split('.')[0] + "_" + nowDate + "."
                    + Path.GetFileName(anhNhomDauThuoc.FileName).Split('.')[1];

                //Lấy đường dẫn lưu file
                var path = Path.Combine(Server.MapPath("~/Content/Images/NhomDauThuoc"), imagefileName);
                string maNDT = "NT" + SinhMa.getMa("MaNhomThuoc", "NhomDauThuoc");
                if (System.IO.File.Exists(path) == false)
                {
                    anhNhomDauThuoc.SaveAs(path);
                }
                nhomDauThuoc.MaNhomThuoc = maNDT;
                nhomDauThuoc.TenNhom = tenNhomThuoc;
                nhomDauThuoc.Image = imagefileName;
                nhomDauThuoc.Status = status;
                db.NhomDauThuoc.Add(nhomDauThuoc);
                db.SaveChanges();
            }
            else
            {
                string maNDT = "NT" + SinhMa.getMa("MaNhomThuoc", "NhomDauThuoc");
                nhomDauThuoc.MaNhomThuoc = maNDT;
                nhomDauThuoc.TenNhom = tenNhomThuoc;
                nhomDauThuoc.Status = status;
                db.NhomDauThuoc.Add(nhomDauThuoc);
                db.SaveChanges();
            }
            return RedirectToAction("Index");
        }

        public ActionResult SuaNhomDauThuoc(string maNhomThuoc, string tenNhomDauThuoc, string status, HttpPostedFileBase anhNhomDauThuoc)
        {
            var nhomThuoc2 = db.NhomDauThuoc.Where(ndt => ndt.MaNhomThuoc == maNhomThuoc).FirstOrDefault();
            var imagefileName = "";
            if (anhNhomDauThuoc == null)
            {
                imagefileName = nhomThuoc2.Image;

            }
            else
            {
                //Lấy tên file ghép vào thời gian update để tạo tên ảnh mới
                string nowDate = DateTime.Now.ToString("MM_dd_yyyy_hh_mm_ss");
                imagefileName = Path.GetFileName(anhNhomDauThuoc.FileName).Split('.')[0] + "_" + nowDate + "."
                    + Path.GetFileName(anhNhomDauThuoc.FileName).Split('.')[1];

                //Lưu đường dẫn ảnh
                var path = Path.Combine(Server.MapPath("~/Content/Images/NhomDauThuoc"), imagefileName);
                if (System.IO.File.Exists(path) == false)
                {
                    anhNhomDauThuoc.SaveAs(path);
                }
               
            }
            var nhomThuoc1 = new NhomDauThuoc();
            nhomThuoc1.MaNhomThuoc = maNhomThuoc;
            nhomThuoc1.TenNhom = tenNhomDauThuoc;
            nhomThuoc1.Image = imagefileName;
            nhomThuoc1.Status = status;
            db.Entry(nhomThuoc2).CurrentValues.SetValues(nhomThuoc1);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public JsonResult XoaNhomDau(string maNhomThuoc)
        {
            var nhomDauThuoc = db.NhomDauThuoc.Where(ndt => ndt.MaNhomThuoc == maNhomThuoc).FirstOrDefault();
            var listNhomThuoc = db.DauThuoc.AsEnumerable()
                .Join(db.TagsDThuocNThuoc.Where(tag => tag.MaNhomThuoc == maNhomThuoc).AsEnumerable(), dt => dt.MaDT, tag => tag.MaDauThuoc,
                (dt, tag) => new
                {
                    dt.MaDT,
                    dt.TenDauThuoc,
                    dt.CongDung,
                    dt.CachDung,
                    dt.Image,
                    dt.Status,
                    dt.GiaBanLe,
                    dt.MaNSX
                }).ToList();

            foreach(var dt in listNhomThuoc)
            {
                DauThuoc dauThuoc = db.DauThuoc.Where(m => m.MaDT == dt.MaDT).FirstOrDefault();
                if (dauThuoc == null)
                {
                    Response.StatusCode = 404;
                    return null;
                }
                var anhDauThuoc = dauThuoc.Image;
                if (anhDauThuoc != null)
                {
                    var path = Path.Combine(Server.MapPath("~/Content/Images/NhomDauThuoc"), anhDauThuoc);
                    if (System.IO.File.Exists(path))
                    {
                        System.IO.File.Delete(path);
                    }
                }
                db.DauThuoc.Remove(dauThuoc);
                db.SaveChanges();
            }
            var anhNhomDauThuoc = nhomDauThuoc.Image;
            if (anhNhomDauThuoc != null)
            {
                var path1 = Path.Combine(Server.MapPath("~/Content/Images/DauThuoc"), anhNhomDauThuoc);
                if (System.IO.File.Exists(path1))
                {
                    System.IO.File.Delete(path1);
                }
            }
            db.NhomDauThuoc.Remove(nhomDauThuoc);
            db.TagsDThuocNThuoc.RemoveRange(db.TagsDThuocNThuoc.Where(tag => tag.MaNhomThuoc == maNhomThuoc));
            db.SaveChanges();
            return Json(new
            {
                msg = "Xóa thành công!",
                success="success",
                ketqua = true
            }, JsonRequestBehavior.AllowGet);
        }
    }
}