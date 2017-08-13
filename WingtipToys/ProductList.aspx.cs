﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GabayManageSite.Models;
using System.Web.ModelBinding;
using System.Web.Routing;
using System.Threading;
using System.Threading.Tasks;
using System.Globalization;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json.Linq;
using System.Text;

namespace GabayManageSite
{
  public partial class ProductList : System.Web.UI.Page
  {
      private GabayDataSet gabayDataSet { get; set; }
      private GabayDataSetTableAdapters.PrayersTableAdapter prayersTableAdapter { get; set; }
      private GabayDataSetTableAdapters.Pray2SynTableAdapter pray2SynTableAdapter { get; set; }
      private GabayDataSetTableAdapters.ExceptionalTableAdapter exceptionalTableAdapter { get; set; }
      private GabayDataSetTableAdapters.Exceptional2DateTableAdapter exceptional2DateTableAdapter { get; set; }
      private GabayDataSetTableAdapters.fullkriyahTableAdapter fullkriyahTableAdapter { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        gabayDataSet = new GabayDataSet();
        prayersTableAdapter = new GabayDataSetTableAdapters.PrayersTableAdapter();
        pray2SynTableAdapter = new GabayDataSetTableAdapters.Pray2SynTableAdapter();
        exceptionalTableAdapter = new GabayDataSetTableAdapters.ExceptionalTableAdapter();
        exceptional2DateTableAdapter = new GabayDataSetTableAdapters.Exceptional2DateTableAdapter();
        fullkriyahTableAdapter = new GabayDataSetTableAdapters.fullkriyahTableAdapter();

        //birthdayToAdd.Text = DateTime.Now.Date.ToShortDateString();
        Private_NameToAdd.ToolTip = Thread.CurrentThread.CurrentCulture.Name + " characters only";
        Family_NameToAdd.ToolTip = Thread.CurrentThread.CurrentCulture.Name + " characters only";

        if (Thread.CurrentThread.CurrentCulture.Name == "he-IL")
        {
            FilteredTextBoxExtenderFamilyName.ValidChars = "אבגדהוזחטיכלמנסעפצקרשתםךןץף ";
            FilteredTextBoxExtenderPrivateName.ValidChars = "אבגדהוזחטיכלמנסעפצקרשתםךןץף ";
        }
        else
        {
            FilteredTextBoxExtenderFamilyName.ValidChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";
            FilteredTextBoxExtenderPrivateName.ValidChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ";
        }

        SqlDataSource1.SelectParameters.Remove(SqlDataSource1.SelectParameters["sid"]);
        SqlDataSource1.SelectParameters.Add("sid", (Session["currSynId"] == null) ? String.Empty : Session["currSynId"].ToString());
    }
        protected void UpdateBtn_Click(object sender, EventArgs e)
        {
            try 
            { 
                if (Session["currSynId"] != null && !String.IsNullOrEmpty(Session["currSynId"].ToString()))
                {
                    string id = IdToAdd.Text;
                    string private_name = Private_NameToAdd.Text;
                    string family_name = Family_NameToAdd.Text;
                    string birthday = birthdayToAdd.Text;
                    string title_id = DropDownTitleToAdd.SelectedValue;
                    bool isReadingMaftir = isReadingMaftirToAdd.Checked;
                    string synId = Session["currSynId"].ToString();
                    string phone = PhoneToAdd.Text;
                    string email = EmailToAdd.Text;

                    exceptional2DateTableAdapter.DeleteQueryByPrayerId(id);
                    exceptionalTableAdapter.DeleteQueryByPrayerId(id);
                    pray2SynTableAdapter.DeleteQuery(id, synId);
                    prayersTableAdapter.DeleteQueryByPid(id);
                    
                    if(id != null && !string.IsNullOrEmpty(private_name) && 
                        !string.IsNullOrEmpty(family_name) &&
                        !string.IsNullOrEmpty(title_id) &&
                        !string.IsNullOrEmpty(synId))
                    prayersTableAdapter.InsertQuery(id, private_name, family_name, birthday, int.Parse(title_id), isReadingMaftir, phone, email);
                   
                    pray2SynTableAdapter.InsertQuery(id, int.Parse(synId));
                    addBarMitzvaToTable(id, birthday, synId);
                    PrayersGridView.DataBind();
                }     
            }
            catch(Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }

        private string GetParashaByDateQuery2(string strBarMitzva)
        {
            string modified;
            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["gabayConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("select top(1) pr.id from fullkriyah f, parashot pr where pr.id = f.parashah and date >= @date order by date", con))
                {
                    cmd.Parameters.AddWithValue("@date", strBarMitzva);
                    con.Open();

                    modified = cmd.ExecuteScalar().ToString();

                    if (con.State == System.Data.ConnectionState.Open) con.Close();
                }
            }

            return modified;
        }

        private List<string> GetDatesByParashaAndStartYear(int parasha_id, int year)
        {
          List<string> listdate = new List<string>();

          using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["gabayConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("select CONVERT(VARCHAR(10),f.date,110) as date from fullkriyah f where year(date) >= @d_year and f.parashah = @parasha_id group by date order by f.date", con))
                {
                    cmd.Parameters.AddWithValue("@parasha_id", parasha_id);
                    cmd.Parameters.AddWithValue("@d_year", year);
                    con.Open();

                    SqlDataReader dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        string date = (dr["date"]).ToString();
                        listdate.Add(date);
                    }


                    //modified = cmd.ExecuteReader(). .ToString();

                    if (con.State == System.Data.ConnectionState.Open) con.Close();                    
                }
            }

          return listdate;
      }

        private void addBarMitzvaToTable(string id, string birthday, string synId)
        {
            DateTime dtBirthday = Convert.ToDateTime(birthday);
            NewHebCal HebCal = new NewHebCal();
            DateTime dtBarMitzva = HebCal.AddYears(dtBirthday, 13);

            /*try
            {
                // fix c# bug
                string urlG2H = "http://www.hebcal.com/converter/?cfg=json&gy={0}&gm={1}&gd={2}&g2h=1";
                urlG2H = String.Format(urlG2H, dtBirthday.Year.ToString(), dtBirthday.Month.ToString(), dtBirthday.Day.ToString());
                var wc = new System.Net.WebClient { Encoding = Encoding.UTF8 };
                var contents = wc.DownloadString(urlG2H);
                JObject dateObject = JObject.Parse(contents);
                string hebrewYear = dateObject.GetValue("hy").ToString();
                string hebrewMonth = dateObject.GetValue("hm").ToString();
                string hebrewDay = dateObject.GetValue("hd").ToString(); 
                // calc bar mitzva
                hebrewYear = (Int32.Parse(hebrewYear) + 13).ToString();
                string urlH2G = "http://www.hebcal.com/converter/?cfg=json&hy={0}&hm={1}&hd={2}&h2g=1";
                urlH2G = String.Format(urlH2G, hebrewYear, hebrewMonth, hebrewDay);
                wc = new System.Net.WebClient { Encoding = Encoding.UTF8 };
                contents = wc.DownloadString(urlH2G);
                dateObject = JObject.Parse(contents);
                string gYear = dateObject.GetValue("gy").ToString();
                string gMonth = dateObject.GetValue("gm").ToString();
                string gDay = dateObject.GetValue("gd").ToString();
                dtBarMitzva = new DateTime(Int32.Parse(gYear), Int32.Parse(gMonth), Int32.Parse(gDay));
            }
            catch (Exception e)
            {
                System.Diagnostics.Debug.WriteLine(e.Message);
            }*/


            int? favoriteAliya = (isReadingMaftirToAdd.Checked) ? (int?)8 : null;
            string strBarMitzva = dtBarMitzva.ToString("MM/dd/yyyy g", CultureInfo.InvariantCulture).Replace(" A.D.", "");
            int ParashatBarMitzvaId = Convert.ToInt32(GetParashaByDateQuery2(strBarMitzva)); //This falling

            try { 
            // Add BarMitzva
            if (DateTime.Now <= dtBarMitzva)
            {
                // calc saturday date of barmitzva
                DateTime shabatOfBarMitzva = Next(dtBarMitzva, DayOfWeek.Saturday);

                exceptionalTableAdapter.InsertQuery(id, int.Parse(synId), shabatOfBarMitzva.ToShortDateString(), favoriteAliya, "", 10);
            }

            int currYear = DateTime.Now.Year;//HebCal.GetYear(DateTime.Now);
            exceptionalTableAdapter.InsertQuery(id, int.Parse(synId), null, favoriteAliya, "", 12);
            int exptional_id = (int) exceptionalTableAdapter.GetRefScalarQuery(id, int.Parse(synId), 12);
            string nextDt;
            List<string> listdate = new List<string>();
            listdate = GetDatesByParashaAndStartYear(ParashatBarMitzvaId, currYear);
            
            for (int i = 0; i < 3; i++)
            {

                nextDt = listdate[i];

                if (nextDt != null)
                {
                    exceptional2DateTableAdapter.InsertQuery(nextDt, exptional_id);
                }
            }
            }
            catch(Exception e){
                System.Diagnostics.Debug.WriteLine(e.Message);
            }
        }

    public void updatePrayer()
    {

    }

    private DateTime Next(DateTime from, DayOfWeek dayOfWeek)
    {
        int start = (int)from.DayOfWeek;
        int target = (int)dayOfWeek;
        if (target <= start)
            target += 7;
        return from.AddDays(target - start);
    }

    protected void DeleteBtn_Click(object sender, EventArgs e)
    {
        try
        {
            string sid = (Session["currSynId"] != null) ? Session["currSynId"].ToString() : "";
            string id_to_delete;
            if (!String.IsNullOrEmpty(sid))
            {

                for (int i = 0; i < PrayersGridView.Rows.Count; i++)
                {
                    GridViewRow row = PrayersGridView.Rows[i];
                    if (((CheckBox)row.FindControl("Remove")).Checked)
                    {
                        id_to_delete = ((Label)row.FindControl("IdLabel")).Text;

                        exceptional2DateTableAdapter.DeleteQueryByPrayerId(id_to_delete);
                        exceptionalTableAdapter.DeleteQueryByPrayerId(id_to_delete);
                        pray2SynTableAdapter.DeleteQuery(id_to_delete, sid);
                        prayersTableAdapter.DeleteQueryByPid(id_to_delete);
                    }
                }                
            }

            PrayersGridView.DataBind();
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine(ex.Message);
        }
    }

    protected void EndSessionBtn_Click(object sender, EventArgs e)
    {
        Session.Abandon();
    }
  }
}