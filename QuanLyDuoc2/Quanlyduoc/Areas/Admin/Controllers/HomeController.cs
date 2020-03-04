using Quanlyduoc.Areas.Admin.Class;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Quanlyduoc.Models;

namespace Quanlyduoc.Areas.Admin.Controllers
{
    
    public class HomeController : Controller
    {
        QL_Duoc1Entities db = new QL_Duoc1Entities();
        // GET: Admin/Home
        [CheckSessionUser]
        public ActionResult Index()
        {
            int nowYear = DateTime.Now.Year;
            int nowMonth = DateTime.Now.Month;

            //get các bảng dữ liệu phục vụ cho việc thống kê
            var CTXuat = db.ChiTietHoaDonXuat.ToList().AsEnumerable();
            var DT = db.DauThuoc.ToList().AsEnumerable();
            var tagsNh = db.TagsDThuocNThuoc.ToList().AsEnumerable();
            var NhomDT = db.NhomDauThuoc.ToList().AsEnumerable();
            var HDxuat = db.HoaDonXuat.ToList().AsEnumerable();
            var listKhachHang = db.KhachHang.ToList().AsEnumerable();
            var listTinhThanh = db.TinhThanhPho.ToList().AsEnumerable();


            //Tinh toán thống kê
            var JdoanhSo = CTXuat.Sum(s => s.DonGia);
            var JcountKhachHang = listKhachHang.Count();
            var JcountDonhang = db.HoaDonMua.Count();
            var JdauThuoc = DT.Count();


            //Tính tổng doanh số vẽ biểu đồ
            var JtongdoanhSo = "";
            for(int i =1; i <= nowMonth; i++)
            {
                var listHD = db.HoaDonXuat.Where(hd => hd.NgayXuat.Value.Year == nowYear && hd.NgayXuat.Value.Month == i).ToList();
                if (listHD.Count() > 0)
                {
                    int? doanhso = 0;
                    foreach (var HD in listHD)
                        doanhso = doanhso + db.ChiTietHoaDonXuat.Where(ct => ct.MaHD == HD.MaHD).Sum(ct => ct.DonGia);
                            JtongdoanhSo = JtongdoanhSo + doanhso + ",";
                }
                else
                    JtongdoanhSo = JtongdoanhSo  + "0,";
            }


            //Khu vực tiêu thụ nhiều
            var joinCTXvaKH = from ct in CTXuat
                              join hd in HDxuat on ct.MaHD equals hd.MaHD
                              join kh in listKhachHang on hd.MaKH equals kh.MaKH
                              join tp in listTinhThanh on kh.MaTinhThanh equals tp.ID
                              group new { tp } by new { tp.ID, tp.TenTinh } into gr
                              select new
                              {
                                  count = gr.Count(),
                                  gr.Key.ID,
                                  gr.Key.TenTinh
                              };
            var JkhuVucTieuThu = "";
            var JnumberKhuVuc = "";
            var tongTop = 0;
            foreach(var x in joinCTXvaKH.Take(5))
            {
                JkhuVucTieuThu = JkhuVucTieuThu + x.TenTinh + ",";
                JnumberKhuVuc = JnumberKhuVuc + x.count + ",";
                tongTop = tongTop + x.count; 
            }
            JkhuVucTieuThu = JkhuVucTieuThu + "Khu vực khác";
            JnumberKhuVuc = JnumberKhuVuc + (joinCTXvaKH.ToList().Sum(x => x.count) - tongTop);


            //Top khách hàng thường xuyên
            var joinCTXvaKH1 = from ct in CTXuat
                              join hd in HDxuat on ct.MaHD equals hd.MaHD
                              join kh in listKhachHang on hd.MaKH equals kh.MaKH
                               group new { kh } by new { kh.MaKH, kh.HoTen } into gr
                               select new
                               {
                                   count = gr.Count(),
                                   gr.Key.MaKH,
                                   gr.Key.HoTen
                               };
            var JkhachHangThuongXuyen = joinCTXvaKH1.OrderByDescending(x=>x.count).Take(8);


            //Top đầu thuốc bán chạy
            var joinCTXvaDT = from ct in CTXuat
                               join dt in DT on ct.MaDT equals dt.MaDT
                               group new { dt } by new { dt.MaDT, dt.TenDauThuoc } into gr
                               select new
                               {
                                   count = gr.Count(),
                                   gr.Key.MaDT,
                                   gr.Key.TenDauThuoc
                               };
            var JdauthuocBanChay = joinCTXvaDT.OrderByDescending(nh => nh.count).Take(8);


            //Top nhóm thuốc tiêu thụ nhiều
            var joinCTXvaNDT = from ct in CTXuat
                              join dt in DT on ct.MaDT equals dt.MaDT
                              join tagNh in tagsNh on dt.MaDT equals tagNh.MaDauThuoc
                              join nh in NhomDT on tagNh.MaNhomThuoc equals nh.MaNhomThuoc
                              group new {nh} by new {nh.MaNhomThuoc, nh.TenNhom} into gr
                              select new
                              {
                                  count = gr.Count(),
                                  gr.Key.MaNhomThuoc,
                                  gr.Key.TenNhom
                              };
            var JnhomBanChay = joinCTXvaNDT.OrderByDescending( nh => nh.count).Take(8);


            //Trả dữ liệu Json cho view
            return View(Json(new {
                JcountKhachHang = JcountKhachHang,
                JcountDonhang = JcountDonhang,
                JdoanhSo = JdoanhSo,
                JdauThuoc = JdauThuoc,
                JkhuVucTieuThu = JkhuVucTieuThu,
                JnumberKhuVuc = JnumberKhuVuc,
                JtongdoanhSo = JtongdoanhSo,
                JnhomBanChay = JnhomBanChay,
                JdauthuocBanChay = JdauthuocBanChay,
                JkhachHangThuongXuyen = JkhachHangThuongXuyen,
            }, JsonRequestBehavior.AllowGet));
        }

        [HttpPost]
        public JsonResult layDoanhSoNam(string year)
        {
            var JtongdoanhSo = "";
            int nowYear = DateTime.Now.Year;
            int nowMonth = DateTime.Now.Month;
            int year1 = Int32.Parse(year);
            if (nowYear == year1)
            {
                for (int i = 1; i <= nowMonth; i++)
                {
                    var listHD = db.HoaDonXuat.Where(hd => hd.NgayXuat.Value.Year == year1 && hd.NgayXuat.Value.Month == i).ToList();
                    if (listHD.Count() > 0)
                    {
                        int? doanhso = 0;
                        foreach (var HD in listHD)
                            doanhso = doanhso + db.ChiTietHoaDonXuat.Where(ct => ct.MaHD == HD.MaHD).Sum(ct => ct.DonGia);
                        JtongdoanhSo = JtongdoanhSo + doanhso + ",";
                    }
                    else
                        JtongdoanhSo = JtongdoanhSo + "0,";
                }
            }
            else
            {
                if (nowYear > year1)
                {
                    for (int i = 1; i <= 12; i++)
                    {
                        var listHD = db.HoaDonXuat.Where(hd => hd.NgayXuat.Value.Year == year1 && hd.NgayXuat.Value.Month == i).ToList();
                        if (listHD.Count() > 0)
                        {
                            int? doanhso = 0;
                            foreach (var HD in listHD)
                                doanhso = doanhso + db.ChiTietHoaDonXuat.Where(ct => ct.MaHD == HD.MaHD).Sum(ct => ct.DonGia);
                            JtongdoanhSo = JtongdoanhSo + doanhso + ",";
                        }
                        else
                            JtongdoanhSo = JtongdoanhSo + "0,";
                    }
                }
            }
            return Json(new { JtongdoanhSo = JtongdoanhSo }, JsonRequestBehavior.AllowGet);
        }
    }
}