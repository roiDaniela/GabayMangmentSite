using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using GabayManageSite.GabayDataSetTableAdapters;

namespace GabayManageSite
{
    public partial class Aliyot : System.Web.UI.Page
    {
        GabayDataSet gabayDataSet { get; set; }
        ParashotTableAdapter parashaTableAdapter { get; set; }
        GabayDataSet.ParashotDataTable currentParasha { get; set; }


        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSource1.SelectParameters.Remove(SqlDataSource1.SelectParameters["syn_id"]);
            SqlDataSource1.SelectParameters.Add("syn_id", (Session["currSynId"] == null) ? String.Empty : Session["currSynId"].ToString());
            gabayDataSet = new GabayDataSet();
            parashaTableAdapter = new GabayDataSetTableAdapters.ParashotTableAdapter();
            currentParasha = parashaTableAdapter.GetCurrentParasha();

            HyperLinkParasha.Text = currentParasha.Rows[0]["NameHe"].ToString();
            HyperLinkParasha.NavigateUrl = currentParasha.Rows[0]["link"].ToString().TrimEnd(' ');
            DateTime parashaDate = (DateTime)currentParasha.Rows[0]["date"];

            String URLString = "http://www.hebcal.com/converter/?cfg=xml&gy=" + parashaDate.Year+ "&gm=" + parashaDate.Month + "&gd=" + parashaDate.Day + "&g2h=1";

            XmlTextReader reader = new XmlTextReader(URLString);
            XmlDocument doc = new XmlDocument();
            doc.Load(reader);
            LabelHebDate.Text = doc.ChildNodes[1].ChildNodes[1].Attributes[3].Value;
        }

        private void getZmanim()
        {
            ////Declarations:
            //EngineClient ZmanimAPI = CreateApiInstance();
            //EngineParamDay Params = new EngineParamDay();
            //EngineResultDay Day = new EngineResultDay();

            ////Set parameters:
            //Params.User = APIUSER;
            //Params.Key = APIKEY;
            //Params.Coding = "CS";
            //Params.Language = "en";
            //Params.InputDate = DateTime.Now;
            //Params.LocationID = "US33487";

            ////Call API:
            //Day = ZmanimAPI.GetDay(Params);

            ////Display results:
            //Console.WriteLine(Day.Place.Name);
            //Console.WriteLine(Day.Time.Weekday);
            //Console.WriteLine("Latest Shema at:");
            //Console.WriteLine(Day.Zman.ShemaGra.ToString("t"));

            ////Use results for further calculations:
            //Console.WriteLine("Mincha Minyan 20 min before shekiah at:");
            //Console.WriteLine(Day.Zman.SunsetDefault.AddMinutes(-20).ToString("t"));
        }

    }
}