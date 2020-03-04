using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Areas.Admin.Class;
using Quanlyduoc.Code;
using Quanlyduoc.Models;

namespace Quanlyduoc.Areas.Admin.Controllers
{
    [CheckSessionUser]
    public class HoaDonVanChuyenController : Controller
    {
        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: Admin/HoaDonVanChuyen
        public ActionResult Index()
        {
            var JHoaDonVanChuyen = db.HoaDonVanChuyen
                                   .Select(hd => new
                                   {
                                       hd.MaHoaDonVanChuyen,
                                       hd.MaNguoiVanChuyen,
                                       NgayGioVanChuyen = hd.NgayGioVanChuyen.ToString(),
                                       hd.SoGioDuTinh,
                                       NguoiVanChuyen = db.VanChuyen.Where(vc => vc.MaNguoiVanChuyen == hd.MaNguoiVanChuyen)
                                       .FirstOrDefault().HoTen == null ? hd.MaNguoiVanChuyen : db.VanChuyen.Where(vc => vc.MaNguoiVanChuyen == hd.MaNguoiVanChuyen)
                                       .FirstOrDefault().HoTen
                                   }).ToList();
            return View(Json(new { JHoaDonVanChuyen = JHoaDonVanChuyen }, JsonRequestBehavior.AllowGet));
        }

        [HttpPost]
        public JsonResult ThemHoaDonVanChuyen(HoaDonVanChuyenAjax Jhdvc)
        {
            
            var hdXuat = db.HoaDonXuat.Where(hd => hd.MaHD == Jhdvc.maHoaDon).FirstOrDefault();
            var hdXuat1 = hdXuat;
            var hdMua = db.HoaDonMua.Where(hd => hd.MaHD == hdXuat.MaHoaDonMua).FirstOrDefault();
            var hdMua1 = hdMua;

            if (hdXuat.MaHoaDonVanChuyen == "" || hdXuat.MaHoaDonVanChuyen == null)
            {
                var maHoaDonVanChuyen = "VC" + SinhMa.getMa("MaHoaDonVanChuyen", "HoaDonVanChuyen");
                HoaDonVanChuyen hdvc = new HoaDonVanChuyen();
                hdvc.MaHoaDonVanChuyen = maHoaDonVanChuyen;
                hdvc.NgayGioVanChuyen = DateTime.Parse(Jhdvc.hoaDonVanChuyen.ngayGioVanChuyen);
                hdvc.MaNguoiVanChuyen = Jhdvc.hoaDonVanChuyen.maNguoiVanChuyen;
                hdvc.SoGioDuTinh = Int32.Parse(Jhdvc.hoaDonVanChuyen.soGio);

                //Update trang thái của hóa đơn mua
                hdMua1.MaHoaDonVanChuyen = maHoaDonVanChuyen;
                hdMua1.TrangThai = 3;
                db.Entry(hdMua).CurrentValues.SetValues(hdMua1);

                //Update trạng thái của hóa đơn xuất
                hdXuat1.MaHoaDonVanChuyen = maHoaDonVanChuyen;
                hdXuat1.TrangThai = 2;
                db.Entry(hdXuat).CurrentValues.SetValues(hdXuat1);

                db.HoaDonVanChuyen.Add(hdvc);
                db.SaveChanges();
                return Json(new { maHoaDonVanChuyen = maHoaDonVanChuyen, msg = "Đã chọn người vận chuyển", success = "add" }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var hdvc1 = db.HoaDonVanChuyen.Where(hd => hd.MaHoaDonVanChuyen == hdXuat.MaHoaDonVanChuyen).FirstOrDefault();
                var hdvc2 = hdvc1;
                hdvc2.NgayGioVanChuyen = DateTime.Parse(Jhdvc.hoaDonVanChuyen.ngayGioVanChuyen);
                hdvc2.MaNguoiVanChuyen = Jhdvc.hoaDonVanChuyen.maNguoiVanChuyen;
                hdvc2.SoGioDuTinh = Int32.Parse(Jhdvc.hoaDonVanChuyen.soGio);
                db.Entry(hdvc1).CurrentValues.SetValues(hdvc2);
                db.SaveChanges();
                return Json(new { msg = "Đã chọn người vận chuyển", success = "edit" }, JsonRequestBehavior.AllowGet);
            }

        }
    }
}