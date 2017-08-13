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
using AjaxControlToolkit;

namespace GabayManageSite
{
    public partial class PrayerDetails : System.Web.UI.Page
    {
        private GabayDataSet gabayDataSet { get; set; }
        private GabayDataSetTableAdapters.PrayersTableAdapter prayersTableAdapter { get; set; }
        private GabayDataSetTableAdapters.Pray2SynTableAdapter pray2SynTableAdapter { get; set; }
        private TextBox Private_NameToEdit { get; set; }
        private TextBox Family_NameToEdit { get; set; }
        private Label IdToEdit { get; set; }
        private TextBox BirthdayToEdit {get; set;}
        private DropDownList DropDownParashaToEdit { get; set; }
        private DropDownList DropDownListTitleToEdit {get; set;}
        private TextBox Yourtziet_FatherToEdit{get; set;}
        private TextBox Yourtziet_MotherToEdit{get; set;}
        private CheckBox isReadingMaftirToEdit{get; set;}
        private TextBox PhoneToEdit{get; set;}
        private TextBox EmailToEdit { get; set; }
        
        protected void Page_Load(object sender, EventArgs e)
        {
                string sid = (Session["currSynId"] == null) ? String.Empty : Session["currSynId"].ToString();
                string rawId = Request.QueryString["PrayerID"];
                if (!String.IsNullOrEmpty(sid) && !String.IsNullOrEmpty(rawId))
                {
                    gabayDataSet = new GabayDataSet();
                    prayersTableAdapter = new GabayDataSetTableAdapters.PrayersTableAdapter();
                    pray2SynTableAdapter = new GabayDataSetTableAdapters.Pray2SynTableAdapter();

                    SqlDataSource1.SelectParameters.Remove(SqlDataSource1.SelectParameters["sid"]);
                    SqlDataSource1.SelectParameters.Add("sid", (Session["currSynId"] == null) ? String.Empty : Session["currSynId"].ToString());

                    SqlDataSource1.SelectParameters.Remove(SqlDataSource1.SelectParameters["pid"]);
                    SqlDataSource1.SelectParameters.Add("pid", rawId);

                    BirthdayToEdit = (TextBox)PrayersGridView.Rows[0].FindControl("BirthdayToEdit");
                    BirthdayToEdit.Text = DateTime.Now.Date.ToShortDateString();


                    DropDownParashaToEdit = (DropDownList)PrayersGridView.Rows[0].FindControl("DropDownParashaToEdit");
                    DropDownListTitleToEdit = (DropDownList)PrayersGridView.Rows[0].FindControl("DropDownListTitleToEdit");

                    Private_NameToEdit = (TextBox)PrayersGridView.Rows[0].FindControl("Private_NameToEdit");
                    Family_NameToEdit = (TextBox)PrayersGridView.Rows[0].FindControl("Family_NameToEdit");

                    IdToEdit = (Label)PrayersGridView.Rows[0].FindControl("IdToEdit");
                    Yourtziet_FatherToEdit = (TextBox)PrayersGridView.Rows[0].FindControl("Yourtziet_FatherToEdit");
                    Yourtziet_MotherToEdit = (TextBox)PrayersGridView.Rows[0].FindControl("Yourtziet_MotherToEdit");
                    isReadingMaftirToEdit = (CheckBox)PrayersGridView.Rows[0].FindControl("isReadingMaftirToEdit");
                    PhoneToEdit = (TextBox)PrayersGridView.Rows[0].FindControl("PhoneToEdit");
                    EmailToEdit = (TextBox)PrayersGridView.Rows[0].FindControl("EmailToEdit"); ;

                    Family_NameToEditValidator.ControlToValidate = Family_NameToEdit.GetUniqueIDRelativeTo(Family_NameToEditValidator);
                    Private_NameToEditValidator.ControlToValidate = Private_NameToEdit.GetUniqueIDRelativeTo(Private_NameToEditValidator);
                    //FilteredTextBoxExtender FilteredTextBoxExtenderFamilyName = (FilteredTextBoxExtender)PrayersGridView.Rows[0].FindControl("FilteredTextBoxExtenderFamilyName");
                    // FilteredTextBoxExtender FilteredTextBoxExtenderPrivateName = (FilteredTextBoxExtender)PrayersGridView.Rows[0].FindControl("FilteredTextBoxExtenderPrivateName");
                    /*if (!Page.IsPostBack)
                    {
                        DropDownParashaToEdit.SelectedValue = prayersTableAdapter.GetParashatBarMitzvaId(rawId).ToString();
                        DropDownListTitleToEdit.SelectedValue = prayersTableAdapter.GetTitleId(rawId).ToString();
                    }*/
                    //DropDownParashaToEdit.SelectedValue = prayersTableAdapter.GetParashatBarMitzvaId(rawId, int.Parse(sid)).ToString();
                    //DropDownListTitleToEdit.SelectedIndex = (int)prayersTableAdapter.GetTitleId(rawId, int.Parse(sid));
                    Private_NameToEdit.ToolTip = Thread.CurrentThread.CurrentCulture.Name + " characters only";
                    Family_NameToEdit.ToolTip = Thread.CurrentThread.CurrentCulture.Name + " characters only";

                    if (Thread.CurrentThread.CurrentCulture.Name == "he-IL")
                    {
                        FilteredTextBoxExtenderFamilyName.ValidChars = "אבגדהוזחטיכלמנסעפצקרשתםךןץף ";
                        FilteredTextBoxExtenderPrivateName.ValidChars = "אבגדהוזחטיכלמנסעפצקרשתםךןץף ";
                    }
                    else
                    {
                        FilteredTextBoxExtenderFamilyName.ValidChars = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
                        FilteredTextBoxExtenderPrivateName.ValidChars = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
                    }
                    FilteredTextBoxExtenderFamilyName.TargetControlID = Family_NameToEdit.GetUniqueIDRelativeTo(FilteredTextBoxExtenderFamilyName);
                    FilteredTextBoxExtenderPrivateName.TargetControlID = Private_NameToEdit.GetUniqueIDRelativeTo(FilteredTextBoxExtenderPrivateName);

                }
            
        }

        public IQueryable<Prayer> GetPrayers(
                    [QueryString("PrayerID")] int? prayerId,
                    [RouteData] int? prayerSynagogeId)
        {
            var _db = new GabayManageSite.Models.ProductContext();
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

        // Same as in ProductList - TODO: put a one shared method
        protected void UpdateBtn_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["currSynId"] != null && !String.IsNullOrEmpty(Session["currSynId"].ToString()))
                {
                    string id = IdToEdit.Text;
                    string private_name = Private_NameToEdit.Text;
                    string family_name = Family_NameToEdit.Text;
                    string birthday = BirthdayToEdit.Text;
                    string parasha_id = DropDownParashaToEdit.SelectedValue;
                    string yourtziet_father = Yourtziet_FatherToEdit.Text;
                    string yourtziet_mother = Yourtziet_MotherToEdit.Text;
                    string title_id = DropDownListTitleToEdit.SelectedValue;
                    string isReadingMaftir = isReadingMaftirToEdit.Checked ? "1" : "0";
                    string synId = Session["currSynId"].ToString();
                    string phone = PhoneToEdit.Text;
                    string email = EmailToEdit.Text;

                    pray2SynTableAdapter.DeleteQuery(id, synId);
                    prayersTableAdapter.DeleteQueryByPid(id);
                    GabayDataSet.PrayersRow rsDetails = gabayDataSet.Prayers.NewPrayersRow();

                    rsDetails["Id"] = int.Parse(id);
                    rsDetails["PRIVATE_NAME"] = private_name;
                    rsDetails["FAMILY_NAME"] = family_name;
                    rsDetails["BIRTHDAY"] = DateTime.ParseExact(birthday, "dd/M/yyyy",
                                       System.Globalization.CultureInfo.InvariantCulture);//Convert.ToDateTime(birthday);
                    rsDetails["PARASHAT_BAR_MITZVA_ID"] = int.Parse(parasha_id);
                    rsDetails["TITLE_ID"] = int.Parse(title_id);
                    rsDetails["IS_READING_MAFTIR"] = int.Parse(isReadingMaftir);
                    //rsDetails["SYNAGOGE_ID"] = int.Parse(synId);
                    rsDetails["phone"] = phone;
                    rsDetails["email"] = email;

                    if (!String.IsNullOrEmpty(yourtziet_father))
                    {
                        rsDetails["YOURTZIET_FATHER"] = DateTime.ParseExact(yourtziet_father, "dd/M/yyyy",
                                       System.Globalization.CultureInfo.InvariantCulture);
                    }

                    if (!String.IsNullOrEmpty(yourtziet_mother))
                    {
                        rsDetails["YOURTZIET_MOTHER"] = DateTime.ParseExact(yourtziet_mother, "dd/M/yyyy",
                                       System.Globalization.CultureInfo.InvariantCulture);
                    }

                    gabayDataSet.Prayers.Rows.Add(rsDetails.ItemArray);

                    prayersTableAdapter.Update(gabayDataSet.Prayers);

                    pray2SynTableAdapter.InsertQuery(id, int.Parse(synId));

                    DropDownParashaToEdit.SelectedValue = parasha_id;
                    DropDownListTitleToEdit.SelectedValue = title_id;

                    PrayersGridView.DataBind();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }

        protected void FormViewPrayerDetail_DataBound(object sender, EventArgs e)
        {

        }
    }
}