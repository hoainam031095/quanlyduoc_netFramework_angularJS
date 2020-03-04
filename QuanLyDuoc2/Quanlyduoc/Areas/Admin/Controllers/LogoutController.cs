using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Code;
using Quanlyduoc.Areas.Admin.Class;

namespace Quanlyduoc.Areas.Admin.Controllers
{
    public class LogoutController : Controller
    {
        // GET: Admin/LogOut
        public ActionResult Logout(ActionExecutingContext filterContext)
        {
            SessionHelper.HuySession();
            return Redirect("/DangNhap");
        }
    }
}