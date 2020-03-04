using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Areas.Admin.Class;
using Quanlyduoc.Models;
using Quanlyduoc.Code;
namespace Quanlyduoc.Areas.Admin.Controllers
{
    [CheckSessionUser]
    public class NhaSanXuatController : Controller
    {
        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: Admin/NhaSanXuat
        public ActionResult Index(int? page)
        {
            if (page == null||page<1)
            {
                page = 1;
            }
            
            var nhaSX = db.NhaSanXuat.Select(m => new
                        {
                            m.MaNSX,
                            m.TenNSX,
                            m.DiaChi,
                            m.SDT,
                            m.Email
                        }).OrderBy(m => m.MaNSX);

            int sizePage = 10;
            var coutPage = System.Convert.ToInt32(System.Math.Ceiling(nhaSX.Count()/System.Convert.ToDouble(sizePage)));
            ViewBag.CountPage = coutPage;
            if (page > coutPage)
            {
                page = coutPage;
            }
            var numberResultPage = nhaSX.Skip(sizePage * (page.Value - 1)).Take(sizePage);
            ViewBag.Page = page;
            var JNhaSanXuat = numberResultPage.ToList();
            
            return View(Json(new { JNhaSanXuat },JsonRequestBehavior.AllowGet));
        }

        public ActionResult ThemNhaSanXuat()
        {
            return View();
        }

        [HttpPost]
        public ActionResult ThemNhaSanXuat(NhaSanXuat nhaSanXuat)
        {
            string MaNSX = "SX" + SinhMa.getMa("MaNSX", "NhaSanXuat");
            nhaSanXuat.MaNSX = MaNSX;
            db.NhaSanXuat.Add(nhaSanXuat);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        [HttpGet]
        public ActionResult SuaNhaSanXuat( string maNSX)
        {
            var Sua = db.NhaSanXuat.Where(m => m.MaNSX == maNSX).FirstOrDefault();
            return View(Sua);
        }

        [HttpPost]
        public JsonResult SuaNhaSanXuat(NhaSanXuat nhaSanXuat)
        {
            NhaSanXuat SX = db.NhaSanXuat.Where(m => m.MaNSX == nhaSanXuat.MaNSX).FirstOrDefault();
            db.Entry(SX).CurrentValues.SetValues(nhaSanXuat);
            db.SaveChanges();
            return Json(new { success="success",msg="Thanh Cong" },JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult XoaNhaSanXuat(string maNSX)
        {
            if (maNSX == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            var MaSX = db.NhaSanXuat.Find(maNSX);
            db.NhaSanXuat.Remove(MaSX);
            db.SaveChanges();
            return Json(new {success="success",msg="Thanh COng"},JsonRequestBehavior.AllowGet);
        }
    }
}