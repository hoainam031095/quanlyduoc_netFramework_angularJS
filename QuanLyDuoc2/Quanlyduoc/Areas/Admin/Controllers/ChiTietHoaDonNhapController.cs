using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Models;

namespace Quanlyduoc.Areas.Admin.Controllers
{
    public class ChiTietHoaDonNhapController : Controller
    {
        // GET: Admin/ChiTietHoaDonNhap
        QL_Duoc1Entities db = new QL_Duoc1Entities();
        public ActionResult Index(string mahd)
        {
            var JHoaDonNhap = db.HoaDonNhap.Where(m => m.MaHD == mahd).Select(m => new {
                m.MaHD,
                m.MaKho,
                hoTen=db.TaiKhoan.Where(t=>t.MaTK==m.MaTK).FirstOrDefault().HoTen,
                ngaynhap=m.NgayNhap + "",
            }).FirstOrDefault();
            var JChiTietHoaDonNhap = db.ChiTietHoaDonNhap.Where(n => n.MaHD == mahd).Select(n => new {
                n.MaHD,
                n.MaDT,
                TenDT = db.DauThuoc.Where(d => d.MaDT == n.MaDT).FirstOrDefault().TenDauThuoc,
                n.SoLuong,
                n.DonGia,
            }).ToList();
            return View(Json(new { JHoaDonNhap,ct=JChiTietHoaDonNhap},JsonRequestBehavior.AllowGet));
        }
    }
}