using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Models;

namespace Quanlyduoc.Controllers
{
    public class TuVanController : Controller
    {
        QL_Duoc1Entities db = new QL_Duoc1Entities();

        // GET: TuVan
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult SendInfo(TuVan tuVan)
        {
            db.TuVan.Add(tuVan);
            if(db.SaveChanges() == 1)
            {
                var msg = "Đã gửi thông tin thành công!";
                return Json(new { msg = msg, success = "success" }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var msg = "Không gửi được, mời nhập lại!";
                return Json(new { msg = msg, success = "error" }, JsonRequestBehavior.AllowGet);
            }


        }
    }
}