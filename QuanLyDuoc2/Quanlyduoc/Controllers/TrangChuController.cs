using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Models;

namespace Quanlyduoc.Controllers
{
    public class TrangChuController : Controller
    {
        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: TrangChu
        public ActionResult Index()
        {
            var JdauThuoc = db.DauThuoc.ToList().OrderByDescending(dt => dt.MaDT)
                .Select(t => new {
                    t.MaDT,
                    t.TenDauThuoc,
                    t.CongDung,
                    t.CachDung,
                    t.Image,
                    t.Status,
                    t.GiaBanLe,
                    t.MaNSX
                })
                .Take(16);
            return View(Json(new { JdauThuoc = JdauThuoc }, JsonRequestBehavior.AllowGet));
        }
    }
}