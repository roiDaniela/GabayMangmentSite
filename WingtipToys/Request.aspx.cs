using GabayManageSite.GabayDataSetTableAdapters;
using System;
using System.Collections.Generic;
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

        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSource2.SelectParameters.Remove(SqlDataSource2.SelectParameters["sid"]);
            SqlDataSource2.SelectParameters.Add("sid", (Session["currSynId"] == null) ? String.Empty : Session["currSynId"].ToString());

            SqlDataSourceName.SelectParameters.Remove(SqlDataSourceName.SelectParameters["sid"]);
            SqlDataSourceName.SelectParameters.Add("sid", (Session["currSynId"] == null) ? String.Empty : Session["currSynId"].ToString());

            gabayDataSet = new GabayDataSet();
            prayersTableAdapter = new GabayDataSetTableAdapters.PrayersTableAdapter();
            exceptionalTableAdapter = new GabayDataSetTableAdapters.ExceptionalTableAdapter();
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
                DropDownListName.SelectedItem.Value = IdToAdd.Text;
            }
        }

        protected void rbDateOrParasha_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rbDateOrParasha.SelectedItem.Text == "Date")
            {
                DateToAdd.Visible = true;
                DropDownListParashaToAdd.Visible = false;
            }
            else if (rbDateOrParasha.SelectedItem.Text == "Parasha")
            {
                DateToAdd.Visible = false;
                DropDownListParashaToAdd.Visible = true;
            }
        }

        protected void addButton_Click(object sender, EventArgs e)
        {
            int id = int.Parse(IdToAdd.Text);
            int syn_id = int.Parse(Session["currSynId"].ToString());
            DateTime date;
            int parasha_id;
            bool bIsConst = isConstToAdd.Checked;
            int favorite_aliya = int.Parse(DropDownListSuggestedAliya.SelectedItem.Value);
            string description = DescriptionToAdd.Text;
            int reason_id = int.Parse(DropDownListReason.SelectedItem.Value);

            if (rbDateOrParasha.SelectedItem.Text == "Date")
            {
                date = Convert.ToDateTime(DateToAdd.Text);
                exceptionalTableAdapter.InsertQuery(id.ToString(), syn_id, date, null, bIsConst, favorite_aliya, description, reason_id);
            }
            else if (rbDateOrParasha.SelectedItem.Text == "Parasha")
            {
                parasha_id = int.Parse(DropDownListParashaToAdd.SelectedItem.Value);
                exceptionalTableAdapter.InsertQuery(id.ToString(), syn_id, null, parasha_id, bIsConst, favorite_aliya, description, reason_id);
            }

            PrayersGridView.DataBind();
        }

        protected void DropDownListName_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = DropDownListName.SelectedItem.Value;
            IdToAdd.Text = id;
        }
    }
}