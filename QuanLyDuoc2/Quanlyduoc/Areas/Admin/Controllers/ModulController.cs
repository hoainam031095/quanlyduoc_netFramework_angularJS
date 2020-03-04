using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Areas.Admin.Class;
using Quanlyduoc.Models;

namespace Quanlyduoc.Areas.Admin.Controllers
{
    [CheckSessionUser]
    public class ModulController : Controller
    {
        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: Admin/Modul
        public ActionResult Index()
        {
            var JModul = from a in db.Page
                         select (new
                         {
                             iD = a.id,
                             tenModul = a.controller,
                             tenDinhNghia = a.name,
                             moTa = a.description
                         });
            if (JModul == null)
            {
                Response.StatusCode = 404;
            }
            return View(Json(new { JModul = JModul }, JsonRequestBehavior.AllowGet));
        }

        public JsonResult suaModul(Page1 page )
        {
            if(page != null)
            {
                var page1 = db.Page.Where(p => p.id == page.iD).FirstOrDefault();
                var page2 = db.Page.Where(p => p.id == page.iD).FirstOrDefault();
                page2.name = page.tenDinhNghia;
                page2.description = page.moTa;
                db.Entry(page1).CurrentValues.SetValues(page2);
                db.SaveChanges();
                return Json(new { msg = "Chỉnh sửa thành công modul", success = "success" }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { msg = "Lỗi", success = "error" }, JsonRequestBehavior.AllowGet);
            }
            
        }
    }
}