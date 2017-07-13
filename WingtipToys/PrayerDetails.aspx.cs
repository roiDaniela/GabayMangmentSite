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
        protected void Page_Load(object sender, EventArgs e)
        {
            string sid = (Session["currSynId"] == null) ? String.Empty : Session["currSynId"].ToString();
            string rawId = Request.QueryString["PrayerID"];
            if (!String.IsNullOrEmpty(sid) && !String.IsNullOrEmpty(rawId))
            {
                gabayDataSet = new GabayDataSet();
                prayersTableAdapter = new GabayDataSetTableAdapters.PrayersTableAdapter();
                //id = Convert.ToInt32(rawId);            
                SqlDataSource1.SelectParameters.Remove(SqlDataSource1.SelectParameters["sid"]);
                SqlDataSource1.SelectParameters.Add("sid", (Session["currSynId"] == null) ? String.Empty : Session["currSynId"].ToString());

                SqlDataSource1.SelectParameters.Remove(SqlDataSource1.SelectParameters["pid"]);
                SqlDataSource1.SelectParameters.Add("pid", rawId);

                //TextBox BirthdayToEdit = (TextBox)PrayersGridView.Rows[0].FindControl("BirthdayToEdit");
                //BirthdayToEdit.Text = DateTime.Now.Date.ToShortDateString();
                

                DropDownList DropDownParashaToEdit = (DropDownList)PrayersGridView.Rows[0].FindControl("DropDownParashaToEdit");
                DropDownList DropDownListTitleToEdit = (DropDownList)PrayersGridView.Rows[0].FindControl("DropDownListTitleToEdit");

                TextBox Private_NameToEdit = (TextBox)PrayersGridView.Rows[0].FindControl("Private_NameToEdit");
                TextBox Family_NameToEdit = (TextBox)PrayersGridView.Rows[0].FindControl("Family_NameToEdit"); 

                FilteredTextBoxExtender FilteredTextBoxExtenderFamilyName = (FilteredTextBoxExtender)PrayersGridView.Rows[0].FindControl("FilteredTextBoxExtenderFamilyName");
                FilteredTextBoxExtender FilteredTextBoxExtenderPrivateName = (FilteredTextBoxExtender)PrayersGridView.Rows[0].FindControl("FilteredTextBoxExtenderPrivateName");

                DropDownParashaToEdit.SelectedValue = prayersTableAdapter.GetParashatBarMitzvaId(rawId, int.Parse(sid)).ToString();
                //DropDownParashaToEdit.SelectedValue = prayersTableAdapter.GetParashatBarMitzvaId(rawId, int.Parse(sid)).ToString();
                //DropDownListTitleToEdit.SelectedIndex = (int)prayersTableAdapter.GetTitleId(rawId, int.Parse(sid));
                Private_NameToEdit.ToolTip = Thread.CurrentThread.CurrentCulture.Name + " characters only";
                Family_NameToEdit.ToolTip = Thread.CurrentThread.CurrentCulture.Name + " characters only";
            
                if (Thread.CurrentThread.CurrentCulture.Name == "he-IL")
                {
                    FilteredTextBoxExtenderFamilyName.ValidChars = "אבגדהוזחטיכלמנסעפצקרשתםך";
                    FilteredTextBoxExtenderPrivateName.ValidChars = "אבגדהוזחטיכלמנסעפצקרשתםך";
                }
                else
                {
                    FilteredTextBoxExtenderFamilyName.ValidChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
                    FilteredTextBoxExtenderPrivateName.ValidChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
                }
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

        protected void FormViewPrayerDetail_DataBound(object sender, EventArgs e)
        {

        }
    }
}