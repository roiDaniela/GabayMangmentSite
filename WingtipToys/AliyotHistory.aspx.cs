using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GabayManageSite.GabayDataSetTableAdapters;
using System.Xml;

namespace GabayManageSite
{
    public partial class AliyotHistory : System.Web.UI.Page
    {
        GabayDataSet GabayDataSet { get; set; }
        PrayersTableAdapter PrayersTableAdapter { get; set; }
        ParashaDetailsTableAdapter ParashaTabeleAdapter { get; set;}
        AliyaHistoryTableAdapter AliyaHistoryAdapter { get; set; }
        GabayDataSet gabayDataSet { get; set; }
        ParashotTableAdapter parashaTableAdapter { get; set; }
        GabayDataSet.ParashotDataTable currentParasha { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            dlProducts.ItemStyle.BorderStyle = BorderStyle.Dashed;
            parashaTableAdapter = new GabayDataSetTableAdapters.ParashotTableAdapter();
            currentParasha = parashaTableAdapter.GetLastParashah();

            HyperLinkParasha.Text = currentParasha.Rows[0]["NameHe"].ToString();
            HyperLinkParasha.NavigateUrl = currentParasha.Rows[0]["link"].ToString().TrimEnd(' ');
            DateTime parashaDate = (DateTime)currentParasha.Rows[0]["date"];

            String URLString = "http://www.hebcal.com/converter/?cfg=xml&gy=" + parashaDate.Year + "&gm=" + parashaDate.Month + "&gd=" + parashaDate.Day + "&g2h=1";

            XmlTextReader reader = new XmlTextReader(URLString);
            XmlDocument doc = new XmlDocument();
            doc.Load(reader);
            LabelHebDate.Text = doc.ChildNodes[1].ChildNodes[1].Attributes[3].Value;
        }



        protected void ButtonClear_Click1(object sender, EventArgs e)
        {
            if (Session["currSynId"] != null)
            {
                AliyaHistoryAdapter = new AliyaHistoryTableAdapter();
                AliyaHistoryAdapter.DeleteLastAliyaDateRecords((int)Session["currSynId"]);
                Response.Redirect(Request.RawUrl);
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}