using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GabayManageSite.GabayDataSetTableAdapters;

namespace GabayManageSite
{
    public partial class AliyotHistory : System.Web.UI.Page
    {
        GabayDataSet GabayDataSet { get; set; }
        PrayersTableAdapter PrayersTableAdapter { get; set; }
        ParashaDetailsTableAdapter ParashaTabeleAdapter { get; set;}
        AliyaHistoryTableAdapter AliyaHistoryAdapter { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            dlProducts.ItemStyle.BorderStyle = BorderStyle.Dashed;
        }



        protected void ButtonClear_Click1(object sender, EventArgs e)
        {
            AliyaHistoryAdapter = new AliyaHistoryTableAdapter();
            AliyaHistoryAdapter.DeleteLastAliyaDateRecords((int)Session["currSynId"]);
            Response.Redirect(Request.RawUrl);
        }
    }
}