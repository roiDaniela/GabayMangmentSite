using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Serialization;
using GabayManageSite.GabayDataSetTableAdapters;

namespace GabayManageSite.Services
{
    /// <summary>
    /// Summary description for GabayService
    /// </summary>
    [WebService(Namespace = "https://gabaymanagmentsite.azurewebsites.net/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class GabayService : System.Web.Services.WebService
    {
        PrayersTableAdapter PrayersTableAdapter { get; set; }
        ParashaDetailsTableAdapter ParashaTabeleAdapter { get; set; }

        GabayDataSet gabayDataSet { get; set; }
        PrayersTableAdapter prayersTableAdapter { get; set; }

        [WebMethod]
        public string GetPrayerBySynagoge(int synid)
        {
            gabayDataSet = new GabayDataSet();
            prayersTableAdapter = new PrayersTableAdapter();

            var prayers = prayersTableAdapter.GetData();
            List<Models.Prayer> prayersInfo = new List<Models.Prayer>();
            foreach (var prayer in prayers.ToList())
            {
                prayersInfo.Add(new Models.Prayer { PrayerFirstName = prayer.PRIVATE_NAME, PrayerLastName = prayer.FAMILY_NAME, PrayerIDString = prayer.ID });
            }
                return new JavaScriptSerializer().Serialize(prayersInfo);   
        }

        [WebMethod]
        public void SaveAliyaHistory(string prayer_id, int kriyaId)
        {
            //productCode = productCode.Replace(" ", String.Empty);

            //using (var db = new MyShopDataContext())
            //{
            //    var userProduct = new UserProduct();
            //    userProduct.ProductCode = productCode;
            //    userProduct.UserName = userName;
            //
            //    db.UserProducts.InsertOnSubmit(userProduct);
            //    db.SubmitChanges();
            //}
            AliyaHistoryTableAdapter AliyotAdapter = new AliyaHistoryTableAdapter();
            AliyotAdapter.InsertQuery(prayer_id, 7, kriyaId);
        }
    }
}
