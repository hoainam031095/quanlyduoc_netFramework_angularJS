using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Areas.Admin.Class;
using Quanlyduoc.Models;

namespace Quanlyduoc.Areas.Admin.Controllers
{
    public class NguoiVanChuyenController : Controller
    {
        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: Admin/NguoiVanChuyen
        [CheckSessionUser]
        public ActionResult Index()
        {
            var JNguoiVanChuyen = db.VanChuyen.Where(v => v.TrangThai == 1)
                      .Select(v => new
                      {
                          v.MaNguoiVanChuyen,
                          v.HoTen,
                          v.DiaChi,
                          v.SDT,
                          v.Email,
                          v.TrangThai
                      }).ToList();
            return View(Json(new { JNguoiVanChuyen = JNguoiVanChuyen }, JsonRequestBehavior.AllowGet));
        }
        
    }
}