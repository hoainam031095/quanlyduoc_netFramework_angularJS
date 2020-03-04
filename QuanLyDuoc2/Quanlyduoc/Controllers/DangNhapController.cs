using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Models;
using Quanlyduoc.Code;

namespace Quanlyduoc.Controllers
{
    public class DangNhapController : Controller
    {
        QL_Duoc1Entities ctx = new QL_Duoc1Entities();
        // GET: DangNhap
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Index(String userName, String passWord)
        {
            var countTaiKhoan = ctx.TaiKhoan.ToList().Where(m => (m.TenTaiKhoan.ToLower() == userName.ToLower()) && (m.MatKhau.ToLower() == passWord.ToLower())).FirstOrDefault();
            if (countTaiKhoan != null)
            {
                SessionHelper.SetSession(countTaiKhoan);
                var url = Request.QueryString["url"];
                if (url != null)
                    //if (url == "/")
                    //    return RedirectToAction("Index", "Admin/Home");
                    //else
                        return Redirect(url);
                else
                    return RedirectToAction("Index", "Admin/Home");
            }
            else
            {
                ModelState.AddModelError("", "Tên đăng nhập hoặc tài khoản không đúng!");
            }
            return View(SessionHelper.GetSession());

        }
    }
}