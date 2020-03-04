using Quanlyduoc.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Quanlyduoc.Areas.Admin.Controllers
{
    public class QuanHuyenController : Controller
    {
        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: Admin/QuanHuyen
        [HttpPost]
        public JsonResult QuanHuyenTheoTinhThanh(int maTinhThanh)
        {
            var JQuanHuyen = db.QuanHuyen.Where(m => m.IDTinhThanh == maTinhThanh).ToList()
                .Select(x => new
                {
                    ID = x.ID,
                    x.TenQuanHuyen,
                    x.IDTinhThanh
                }).OrderBy(qh => qh.TenQuanHuyen).ToList();
            return Json(new { JQuanHuyen = JQuanHuyen }, JsonRequestBehavior.AllowGet);
        }
    }
}