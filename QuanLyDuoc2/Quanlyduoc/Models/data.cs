using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Quanlyduoc.Models
{
    public class data
    {
        public string maNhomQuyen { get; set; }
        public List<JModul> JModul { get; set; }
    }
    public class JModul
    {
        public int iD { get; set; }
        public string tenModul { get; set; }
        public string tenDinhNghia { get; set; }
        public string moTa { get; set; }
        public List<ListAction> ListAction { get; set; }
    }
    public class ListAction
    {
        public int ID { get; set; }
        public string Namespace { get; set; }
        public string Controller { get; set; }
        public string Action { get; set; }
        public string Name { get; set; }
        public string Checked { get; set; }
    }
}


