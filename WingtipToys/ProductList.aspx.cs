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

namespace GabayManageSite
{
  public partial class ProductList : System.Web.UI.Page
  {
      private GabayDataSet gabayDataSet { get; set; }
      private GabayDataSetTableAdapters.PrayersTableAdapter prayersTableAdapter { get; set; }
      private GabayDataSetTableAdapters.Pray2SynTableAdapter pray2SynTableAdapter { get; set; }
      private GabayDataSetTableAdapters.ExceptionalTableAdapter exceptionalTableAdapter { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        gabayDataSet = new GabayDataSet();
        prayersTableAdapter = new GabayDataSetTableAdapters.PrayersTableAdapter();
        pray2SynTableAdapter = new GabayDataSetTableAdapters.Pray2SynTableAdapter();
        exceptionalTableAdapter = new GabayDataSetTableAdapters.ExceptionalTableAdapter();

        birthdayToAdd.Text = DateTime.Now.Date.ToShortDateString();
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


                    //PrayersGridView.DataBind();
                }     
            }
            catch(Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }

        private void addBarMitzvaToTable(string id, string birthday, string synId)
        {
            DateTime dtBirthday = Convert.ToDateTime(birthday);  

            System.Globalization.Calendar HebCal = new HebrewCalendar();
            int curYear = HebCal.GetYear(dtBirthday);    //current numeric hebrew year

            for (int i = 0; i < 20; i++)
            {
                DateTime nextDt = HebCal.AddYears(dtBirthday, i);
               
                // Calculate the age.
                var age = nextDt.Year - dtBirthday.Year;
                // Go back to the year the person was born in case of a leap year
                if (dtBirthday > nextDt.AddYears(-age)) age--;

                // Bar mitzva
                int reason = (age == 13)? 10: 12;

                if (isReadingMaftirToAdd.Checked)
                {
                    exceptionalTableAdapter.InsertQuery(id, int.Parse(synId), nextDt.ToShortDateString(), 8, "", reason);
                }
                else
                {
                    exceptionalTableAdapter.InsertQuery(id, int.Parse(synId), nextDt.ToShortDateString(), null, "", reason);
                }
            }
        }

    public void updatePrayer()
    {

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
                        //prayersTableAdapter.Delete(id_to_delete, int.Parse(sid));
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