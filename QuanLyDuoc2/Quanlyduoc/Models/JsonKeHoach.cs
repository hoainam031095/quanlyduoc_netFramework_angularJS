using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Quanlyduoc.Models
{
    public class JsonKeHoach
    {
        public string ID { get; set; }
        public string CongViec { get; set; }
        public Nullable<int> TrangThai1 { get; set; }
        public Nullable<int> TrangThai2 { get; set; }
        public string GhiChu { get; set; }
        public string MaTD { get; set; }
    }
}