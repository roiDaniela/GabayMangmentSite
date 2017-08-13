using GabayManageSite.GabayDataSetTableAdapters;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GabayManageSite
{
    public partial class Request : System.Web.UI.Page
    {
        GabayDataSet gabayDataSet { get; set; }
        PrayersTableAdapter prayersTableAdapter { get; set; }
        ExceptionalTableAdapter exceptionalTableAdapter { get; set; }
        private GabayDataSetTableAdapters.Exceptional2DateTableAdapter exceptional2DateTableAdapter { get; set; }


        protected void Page_Load(object sender, EventArgs e)
        {
            string to_year;

            SqlDataSource2.SelectParameters.Remove(SqlDataSource2.SelectParameters["sid"]);
            SqlDataSource2.SelectParameters.Add("sid", (Session["currSynId"] == null) ? String.Empty : Session["currSynId"].ToString());

            if (DropDownListRangeOfYears.SelectedValue != null && !string.IsNullOrEmpty(DropDownListRangeOfYears.SelectedValue))
            {
                to_year = DropDownListRangeOfYears.SelectedValue;
            }
            else
            {
                to_year = DateTime.Now.Year.ToString();
            }

            SqlDataSource2.SelectParameters.Remove(SqlDataSource2.SelectParameters["range"]);
            SqlDataSource2.SelectParameters.Add("range", to_year);

            if (!this.IsPostBack && DropDownListName.SelectedValue != null && !string.IsNullOrEmpty(DropDownListName.SelectedValue))
            {
                string id = DropDownListName.SelectedValue;
                IdToAdd.Text = id;
            }

            SqlDataSourceName.SelectParameters.Remove(SqlDataSourceName.SelectParameters["sid"]);
            SqlDataSourceName.SelectParameters.Add("sid", (Session["currSynId"] == null) ? String.Empty : Session["currSynId"].ToString());

            gabayDataSet = new GabayDataSet();
            prayersTableAdapter = new GabayDataSetTableAdapters.PrayersTableAdapter();
            exceptionalTableAdapter = new GabayDataSetTableAdapters.ExceptionalTableAdapter();
            exceptional2DateTableAdapter = new GabayDataSetTableAdapters.Exceptional2DateTableAdapter();

        }

        protected void IdToAdd_TextChanged(object sender, EventArgs e)
        {
            if(IdToAdd.Text.Length == 9)
            {                
                GabayDataSet.PrayersDataTable prayersDataTable = prayersTableAdapter.GetDataById1(IdToAdd.Text);
                string private_name = prayersDataTable.Rows[0]["Private_name"].ToString();
                string family_name = prayersDataTable.Rows[0]["Private_name"].ToString();
                string full_name = private_name + ' ' + family_name;
                //TextBoxFull_name.Text = full_name;
                DropDownListName.SelectedValue = IdToAdd.Text;
            }
        }

        protected void addButton_Click(object sender, EventArgs e)
        {
            int id = int.Parse(IdToAdd.Text);
            string syn_id = Session["currSynId"].ToString();
            bool isRegular = isRegularToAdd.Checked;
            int favorite_aliya = int.Parse(DropDownListSuggestedAliya.SelectedItem.Value);
            string description = DescriptionToAdd.Text;
            string reason_id = DropDownListReason.SelectedValue;

            addDateToTable(IdToAdd.Text, DateToAdd.Text, syn_id, reason_id, isRegular, description);

            RequestsGridView.DataBind();
        }

        // same as in productlist
        private DateTime Next(DateTime from, DayOfWeek dayOfWeek)
        {
            int start = (int)from.DayOfWeek;
            int target = (int)dayOfWeek;
            if (target <= start)
                target += 7;
            return from.AddDays(target - start);
        }

        private void addDateToTable(string id, string date, string synId, string reason_id, bool isRegular, string description)
        {
            DateTime dtDate = Convert.ToDateTime(date);
            DateTime startDate;
            NewHebCal HebCal = new NewHebCal();
            int? favoriteAliya = Int32.Parse(DropDownListSuggestedAliya.SelectedValue);

            try
            {
                DateTime shabatOfDate = Next(dtDate, DayOfWeek.Saturday);
                int reason = Int32.Parse(reason_id);
                exceptionalTableAdapter.InsertQuery(id, int.Parse(synId), shabatOfDate.ToShortDateString(), favoriteAliya, description, reason);
                int exptional_id = (int)exceptionalTableAdapter.GetExRefForRequest(id, int.Parse(synId), reason, shabatOfDate.ToShortDateString());
                string strshabatOfDate = shabatOfDate.ToString("yyyy-MM-dd");

                exceptional2DateTableAdapter.InsertQuery(strshabatOfDate, exptional_id);

                if (isRegular)
                {
                    if (dtDate < DateTime.Now)
                    {
                        int diff = DateTime.Now.Year - dtDate.Year;
                        startDate = HebCal.AddYears(dtDate, diff);
                    }
                    else
                    {
                        startDate = dtDate;
                    }
                    DateTime nextDt;
                    for (int i = 1; i < 4; i++)
                    {
                        nextDt = HebCal.AddYears(startDate, i);

                        if (nextDt != null)
                        {
                            exceptional2DateTableAdapter.InsertQuery(nextDt.ToShortDateString(), exptional_id);
                        }
                    }
                }
            }
            catch (Exception e)
            {
                System.Diagnostics.Debug.WriteLine(e.Message);
            }
                             
        }

        protected void DropDownListName_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = DropDownListName.SelectedValue;
            IdToAdd.Text = id;
        }

        protected void DropDownListRangeOfYears_SelectedIndexChanged(object sender, EventArgs e)
        {
            RequestsGridView.DataBind();
        }

        protected void DeleteBtn_Click(object sender, EventArgs e)
        {
            try
            {
                string sid = (Session["currSynId"] != null) ? Session["currSynId"].ToString() : "";
                int ref_to_delete;
                int expId_to_delete;

                if (!String.IsNullOrEmpty(sid))
                {

                    for (int i = 0; i < RequestsGridView.Rows.Count; i++)
                    {
                        GridViewRow row = RequestsGridView.Rows[i];
                        if (((CheckBox)row.FindControl("Remove")).Checked)
                        {
                            ref_to_delete = Int32.Parse(((Label)row.FindControl("RefLabel")).Text);
                            expId_to_delete = Int32.Parse(((Label)row.FindControl("ExceptionalIdLabel")).Text);


                            //exceptional2DateTableAdapter.DeleteQueryByDateAndRef(ref_to_delete, date_to_delete);
                            exceptional2DateTableAdapter.Delete(ref_to_delete);
                            if (Int32.Parse(exceptional2DateTableAdapter.ScalarQueryGetCountRef(expId_to_delete).ToString()) == 0)
                            {
                                exceptionalTableAdapter.DeleteQueryByRef(expId_to_delete);
                            }
                        }
                    }
                }

                RequestsGridView.DataBind();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }
    }
}