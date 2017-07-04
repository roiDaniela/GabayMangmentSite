using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WingtipToys.Models;
using System.Web.ModelBinding;

namespace WingtipToys
{
    public partial class PrayerDetails : System.Web.UI.Page
    {
        public int id;
        protected void Page_Load(object sender, EventArgs e)
        {
            string rawId = Request.QueryString["PrayerID"];
            //id = Convert.ToInt32(rawId);
            SqlDataSource1.SelectParameters.Add("prayer_id", rawId);
        }

        public IQueryable<Prayer> GetPrayers(
                    [QueryString("PrayerID")] int? prayerId,
                    [RouteData] int? prayerSynagogeId)
        {
            var _db = new WingtipToys.Models.ProductContext();
            IQueryable<Prayer> query = _db.Prayers;

            if (prayerId.HasValue && prayerId > 0)
            {
                query = query.Where(p => p.PrayerID == prayerId);
            }

            if (!(prayerSynagogeId == null))
            {
                query = query.Where(p =>
                                    p.SynagogeId ==
                                    prayerSynagogeId);
            }
            return query;
        }
    }
}