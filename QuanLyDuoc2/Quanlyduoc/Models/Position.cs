//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Quanlyduoc.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Position
    {
        public long ID { get; set; }
        public string MaTK { get; set; }
        public string Lat { get; set; }
        public string Lng { get; set; }
        public Nullable<System.DateTime> Time { get; set; }
    
        public virtual TaiKhoan TaiKhoan { get; set; }
    }
}
