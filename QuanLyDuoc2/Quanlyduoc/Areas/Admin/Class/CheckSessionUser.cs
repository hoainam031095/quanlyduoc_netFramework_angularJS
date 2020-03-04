using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Models;

namespace Quanlyduoc.Areas.Admin.Class
{
    public class CheckSessionUser: ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            //string ip = HttpContext.Current.Request.UserHostAddress;
            //string Agent = HttpContext.Current.Request.UserAgent;
            //string ComputerName = System.Environment.MachineName;

            string sessionDefault = HttpContext.Current.Session.SessionID;
            TaiKhoan session = (TaiKhoan)filterContext.HttpContext.Session["loginSession"];
            var actionResult = ((ReflectedActionDescriptor)filterContext.ActionDescriptor).MethodInfo.ReturnType;
            string actionName = filterContext.ActionDescriptor.ActionName;
            string controllerName = filterContext.ActionDescriptor.ControllerDescriptor.ControllerName;
            string currentUrl = filterContext.HttpContext.Request.Path;
            if (session == null)
            {
                switch (actionResult.Name)
                {
                    case "JsonResult":
                        var jsonResult = new JsonResult();
                        jsonResult.Data = new { success = false, msg = "Bạn cần đăng nhập!" };
                        jsonResult.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
                        filterContext.Result = jsonResult;
                        break;
                    case "ActionResult":
                        filterContext.Result = new RedirectResult("/DangNhap?url=" + currentUrl);
                        break;
                }
            }
            else
            {
                if (session.TenTaiKhoan != "admin")
                {
                    using (var ctx = new QL_Duoc1Entities())
                    {
                        var route = ctx.Route.Where(m => m.Namespace == "Quanlyduoc.Areas.Admin.Controllers" &&
                        m.Controller == controllerName &&
                        m.Action == actionName).FirstOrDefault();
                        if (route != null)
                        {
                            var idG = session.MaNhomQuyen;
                            var role = ctx.NhomQuyenRoute.Where(m => m.MaNhomQuyen == idG && m.IDRoute == route.ID).FirstOrDefault();
                            if (role == null)
                            {
                                switch (actionResult.Name)
                                {
                                    case "JsonResult":
                                        var jsonResult = new JsonResult();
                                        jsonResult.Data = new { success = "warning", msg = "Tài khoản không đủ quyền thực hiện hành động" };
                                        jsonResult.JsonRequestBehavior = JsonRequestBehavior.AllowGet;
                                        filterContext.Result = jsonResult;
                                        break;
                                    case "ActionResult":
                                        filterContext.Result = new ViewResult
                                        {
                                            MasterName = "~/Areas/Admin/Views/Layout/AdminLayout.cshtml",
                                            ViewName = "~/Areas/Admin/Views/AccessDenied/Index2.cshtml",
                                            //ViewData = filterContext.Controller.ViewData,
                                            //TempData = filterContext.Controller.TempData
                                        };
                                        //var a = new ();
                                        //a.ViewName = "Admin/AccessDenied/Index";
                                        //filterContext.Result = new RedirectResult(
                                        //    new RouteValueDictionary(new { controller = "AccessDenied", action = "Index" })
                                        //);

                                        //filterContext.Result.ExecuteResult(filterContext.Controller.ControllerContext);// = a;
                                        break;
                                    default:
                                        break;
                                }
                            }
                        }
                    }
                }
            }
            base.OnActionExecuting(filterContext);
        }

        public override void OnActionExecuted(ActionExecutedContext filterContext)
        {

        }
        public override void OnResultExecuting(ResultExecutingContext filterContext)
        {

        }
        public override void OnResultExecuted(ResultExecutedContext filterContext)
        {

        }
    }
}