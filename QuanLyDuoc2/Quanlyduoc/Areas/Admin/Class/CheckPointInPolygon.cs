using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Quanlyduoc.Areas.Admin.Class
{
    public class CheckPointInPolygon
    {
        public static bool PointInPolygon1(Double X, Double Y, List<string> poly)
        {
            var coef = poly.Skip(1).Select((p, i) =>
                                           (Y - double.Parse(poly[i].Split(',')[1], System.Globalization.CultureInfo.InvariantCulture))
                                         * (double.Parse(p.Split(',')[0], System.Globalization.CultureInfo.InvariantCulture) - double.Parse(poly[i].Split(',')[0], System.Globalization.CultureInfo.InvariantCulture))
                                         - (X - double.Parse(poly[i].Split(',')[0], System.Globalization.CultureInfo.InvariantCulture)) 
                                         * (double.Parse(p.Split(',')[1], System.Globalization.CultureInfo.InvariantCulture) - double.Parse(poly[i].Split(',')[1], System.Globalization.CultureInfo.InvariantCulture)))
                                   .ToList();

            if (coef.Any(p => p == 0))
                return true;

            for (int i = 1; i < coef.Count(); i++)
            {
                if (coef[i] * coef[i - 1] < 0)
                    return false;
            }
            return true;
        }
    }
}