using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Quanlyduoc.Models
{
    public class DauThuocDonVi
    {
        public string MaDT { get; set; }
        public string TenDauThuoc { get; set; }
        public string CongDung { get; set; }
        public string CachDung { get; set; }
        public string Image { get; set; }
        [AllowHtml]
        public string Status { get; set; }
        public int? GiaBanLe { get; set; }
        public string MaNSX { get; set; }
        public string TenDonVi { get; set; }
        public int? HeSoDonVi { get; set; }
        public string TenDonVi1 { get; set; }
        public int? HeSoDonVi1 { get; set; }
        public string TenDonVi2 { get; set; }
        public int? HeSoDonVi2 { get; set; }
        public string TenDonVi3 { get; set; }
        public int? HeSoDonVi3 { get; set; }
    }
}