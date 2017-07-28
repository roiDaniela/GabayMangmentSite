using System;
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

                    pray2SynTableAdapter.DeleteQuery(id, synId);
                    prayersTableAdapter.DeleteQueryByPid(id);
                    
                    if(id != null && !string.IsNullOrEmpty(private_name) && 
                        !string.IsNullOrEmpty(family_name) &&
                        !string.IsNullOrEmpty(birthday) &&
                        !string.IsNullOrEmpty(birthday) &&
                        !string.IsNullOrEmpty(synId) &&
                        !string.IsNullOrEmpty(birthday))
                    prayersTableAdapter.InsertQuery(id, private_name, family_name, birthday, int.Parse(title_id), isReadingMaftir, phone, email);
                   
                    pray2SynTableAdapter.InsertQuery(id, int.Parse(synId));
                    addBarMitzvaToTable(id, birthday, synId);
                }     
            }
            catch(Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }

      private string GetDateByParashaAndYear(int parasha_id, int year){
          string modified;
          using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["gabayConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("select top(1) CONVERT(VARCHAR(10),f.date,110) as date from fullkriyah f where year(date) >= @d_year and f.parashah = @parasha_id ", con))
                {
                    cmd.Parameters.AddWithValue("@parasha_id", parasha_id);
                    cmd.Parameters.AddWithValue("@d_year", year);
                    con.Open();

                    modified = cmd.ExecuteScalar().ToString();

                    if (con.State == System.Data.ConnectionState.Open) con.Close();                    
                }
            }

          return modified;
      }

        private void addBarMitzvaToTable(string id, string birthday, string synId)
        {
            DateTime dtBirthday = Convert.ToDateTime(birthday);              
            System.Globalization.Calendar HebCal = new HebrewCalendar();
            DateTime dtBarMitzva = HebCal.AddYears(dtBirthday, 13);
            int? favoriteAliya = (isReadingMaftirToAdd.Checked) ? (int?)8 : null;
            string strBarMitzva = dtBarMitzva.ToString("MM/dd/yyyy g", CultureInfo.InvariantCulture).Replace(" A.D.", "");
            int ParashatBarMitzvaId = Convert.ToInt32(fullkriyahTableAdapter.GetParashaByDateQuery(strBarMitzva)); //This falling


            // Add BarMitzva
            if (DateTime.Now <= dtBarMitzva)
            {
                // calc saturday date of barmitzva
                DateTime shabatOfBarMitzva = Next(dtBarMitzva, DayOfWeek.Saturday);

                exceptionalTableAdapter.InsertQuery(id, int.Parse(synId), shabatOfBarMitzva.ToShortDateString(), favoriteAliya, "", 10);
            }

            int currYear = HebCal.GetYear(DateTime.Now);
            exceptionalTableAdapter.InsertQuery(id, int.Parse(synId), null, favoriteAliya, "", 12);
            int exptional_id = (int) exceptionalTableAdapter.GetRefScalarQuery(id, int.Parse(synId), 12);
            string nextDt;
            for (int i = 0; i < 20; i++)
            {
                nextDt = GetDateByParashaAndYear(ParashatBarMitzvaId, currYear + i);
                exceptional2DateTableAdapter.InsertQuery(nextDt, exptional_id);
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
                        pray2SynTableAdapter.DeleteQuery(id_to_delete, sid);
                    }
                }
                pray2SynTableAdapter.Update(gabayDataSet.Pray2Syn);
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