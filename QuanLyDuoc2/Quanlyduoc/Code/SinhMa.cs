using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Quanlyduoc.Models;

namespace Quanlyduoc.Code
{
    public class SinhMa
    {
        public static QL_Duoc1Entities db = new QL_Duoc1Entities();

        //Sinh mã theo định dạng kiểu string
        public static string getMa(string tenTruong, string tenBang)
        {
            //Sinh mã với tên cột và tên bảng được truyền vào
            int index = 0;
            var count = db.Database.SqlQuery<string>("Select " + tenTruong + " from " + tenBang).FirstOrDefault();
            if(count != null)
            {
                index = Int32.Parse(db.Database.SqlQuery<string>("Select " + tenTruong + " from " + tenBang)
            .LastOrDefault().Substring(2)) + 1;
            }
            else
            {
                index = 1;
            }
            var ID = String.Format("{0:000000}", index);
            return ID;
        }

        //Sinh mã theo định dạng kiểu int
        public static long getMaInt(string tenTruong, string tenBang)
        {
            //Sinh mã với tên cột và tên bảng được truyền vào
            long index = 0;
            long count = db.Database.SqlQuery<long>("Select " + tenTruong + " from " + tenBang).FirstOrDefault();
            if (count != 0)
            {
                index = db.Database.SqlQuery<long>("Select " + tenTruong + " from " + tenBang).LastOrDefault() + 1;
            }
            else
            {
                index = 1;
            }
            return index;
        }
    }
}