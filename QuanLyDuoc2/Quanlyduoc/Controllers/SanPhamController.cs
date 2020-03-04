using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Models;

namespace Quanlyduoc.Controllers
{
    public class SanPhamController : Controller
    {
        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: SanPham
        public ActionResult Index()
        {
            var JdauThuoc = db.DauThuoc.ToList().OrderByDescending(dt => dt.MaDT)
                .Select(t => new
                {
                    t.MaDT,
                    t.TenDauThuoc,
                    t.CongDung,
                    t.CachDung,
                    t.Image,
                    t.Status,
                    t.GiaBanLe,
                    t.MaNSX
                }).ToList();
            return View(Json(new { JdauThuoc = JdauThuoc }, JsonRequestBehavior.AllowGet));
        }

        [Route("Chi-tiet-dau-thuoc/{madauthuoc}")]
        public ActionResult ChiTietDauThuoc(string madauthuoc)
        {
            var JdauThuoc = db.DauThuoc.Where(t => t.MaDT == madauthuoc)
                .ToList().AsEnumerable()
                .Select(t => new
                {
                    t.MaDT,
                    t.TenDauThuoc,
                    t.CongDung,
                    t.CachDung,
                    t.Image,
                    t.Status,
                    t.GiaBanLe,
                    t.MaNSX,
                    TenNhaSanXuat = db.NhaSanXuat.Where(nsx => nsx.MaNSX == t.MaNSX).FirstOrDefault().TenNSX
                }).FirstOrDefault();
            return View(Json(new { JdauThuoc = JdauThuoc }, JsonRequestBehavior.AllowGet));
        }
    }
}