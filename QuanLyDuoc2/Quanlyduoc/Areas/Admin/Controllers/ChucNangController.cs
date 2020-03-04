using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Areas.Admin.Class;
using Quanlyduoc.Models;

namespace Quanlyduoc.Areas.Admin.Controllers
{
    
    public class ChucNangController : Controller
    {
        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: Admin/Action
        public ActionResult Index()
        {
            return View();
        }

        [CheckSessionUser]
        public JsonResult danhSachChucNang(string controller)
        {
            var JAction = from a in db.Route
                          join b in db.Page on a.Controller equals b.controller
                          where (a.Controller == controller)
                          select (new
                          {
                              iD = a.ID,
                              tenAction = a.Action,
                              tenDinhNghia = a.Name,
                              moTa = a.Description
                          });
            return Json(new { JAction = JAction }, JsonRequestBehavior.AllowGet);
        }

        [CheckSessionUser]
        [HttpPost]
        public JsonResult suaChucNang(Action1 requestAction)
        {
            if(requestAction != null)
            {
                var route = db.Route.Where(rt => rt.ID == requestAction.iD).FirstOrDefault();
                var route2 = db.Route.Where(rt => rt.ID == requestAction.iD).FirstOrDefault();
                route2.Name = requestAction.tenDinhNghia;
                route2.Description = requestAction.moTa;
                db.Entry(route).CurrentValues.SetValues(route2);
                db.SaveChanges();
                return Json(new { msg = "Chỉnh sửa thành công chức năng", success = "success" }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { msg = "Lỗi", success = "error" }, JsonRequestBehavior.AllowGet);
            }
            
        }
    }
}