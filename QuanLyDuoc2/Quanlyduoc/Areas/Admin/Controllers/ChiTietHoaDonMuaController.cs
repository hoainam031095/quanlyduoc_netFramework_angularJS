using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Areas.Admin.Class;
using Quanlyduoc.Models;

namespace Quanlyduoc.Areas.Admin.Controllers
{
    public class ChiTietHoaDonMuaController : Controller
    {
        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: Admin/ChiTietHoaDon

        public ActionResult Index(string mhd)
        {
            var JHoaDon = db.HoaDonMua.Where(hd => hd.MaHD == mhd)
                          .Select(hd => new
                          {
                              hd.MaHD,
                              hd.MaKH,
                              TenKH = db.KhachHang.Where(kh => kh.MaKH == hd.MaKH).FirstOrDefault().HoTen,
                              NgayMua = hd.NgayMua + "",
                          }).FirstOrDefault();

            var JChiTietHoaDon = db.ChiTietHoaDonMua.Where(ct => ct.MaHD == mhd)
                                 .Select(ct => new
                                 {
                                     ct.MaHD,
                                     ct.MaDT,
                                     TenDT = db.DauThuoc.Where(dt => dt.MaDT == ct.MaDT).FirstOrDefault().TenDauThuoc,
                                     ct.DonGia,
                                     TenDonvi = ct.DonVi.Ten,
                                     ct.SoLuong
                                 }).ToList();
            return View(Json(new { JHoaDon = JHoaDon, JChiTietHoaDon = JChiTietHoaDon }, JsonRequestBehavior.AllowGet));
        }
    }
}