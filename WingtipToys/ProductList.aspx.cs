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

namespace GabayManageSite
{
  public partial class ProductList : System.Web.UI.Page
  {
      private GabayDataSet gabayDataSet { get; set; }
      private GabayDataSetTableAdapters.PrayersTableAdapter prayersTableAdapter { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        gabayDataSet = new GabayDataSet();
        prayersTableAdapter = new GabayDataSetTableAdapters.PrayersTableAdapter();

        birthdayToAdd.Text = DateTime.Now.Date.ToShortDateString();
        Private_NameToAdd.ToolTip = Thread.CurrentThread.CurrentCulture.Name + " characters only";
        Family_NameToAdd.ToolTip = Thread.CurrentThread.CurrentCulture.Name + " characters only";

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
                    string parasha_id = DropDownListParashaToAdd.SelectedValue;
                    string yourtziet_father = Yourtziet_FatherTextToAdd.Text;
                    string yourtziet_mother = Yourtziet_MotherTextToAdd.Text;
                    string title_id = DropDownTitleToAdd.SelectedValue;
                    string isReadingMaftir = isReadingMaftirToAdd.Checked? "1": "0";
                    string synId = Session["currSynId"].ToString();
                    string phone = PhoneToAdd.Text;
                    string email = EmailToAdd.Text;

                    GabayDataSet.PrayersRow rsDetails = gabayDataSet.Prayers.NewPrayersRow();

                    rsDetails["Id"] = int.Parse(id);
                    rsDetails["PRIVATE_NAME"] = private_name;
                    rsDetails["FAMILY_NAME"] = family_name;
                    rsDetails["BIRTHDAY"] = Convert.ToDateTime(birthday);
                    rsDetails["PARASHAT_BAR_MITZVA_ID"] = int.Parse(parasha_id);
                    rsDetails["TITLE_ID"] = int.Parse(title_id);
                    rsDetails["IS_READING_MAFTIR"] = int.Parse(isReadingMaftir);
                    rsDetails["SYNAGOGE_ID"] = int.Parse(synId);
                    rsDetails["phone"] = phone;
                    rsDetails["email"] = email;

                    if (!String.IsNullOrEmpty(yourtziet_father))
                    {
                        rsDetails["YOURTZIET_FATHER"] = Convert.ToDateTime(yourtziet_father);
                    }

                    if (!String.IsNullOrEmpty(yourtziet_mother))
                    {
                        rsDetails["YOURTZIET_MOTHER"] = Convert.ToDateTime(yourtziet_mother);
                    }

                    gabayDataSet.Prayers.Rows.Add(rsDetails.ItemArray);

                    prayersTableAdapter.Update(gabayDataSet.Prayers);
                    PrayersGridView.DataBind();
                }     
            }
            catch(Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }

        /*protected void PrayersList_DataBound(object sender, EventArgs e)
        {
            GridViewRow row = new GridViewRow(
                0,
                0,
                DataControlRowType.DataRow,
                DataControlRowState.Alternate);

            for (int i = 0; i < PrayersList.Columns.Count; i++)
            {
                TableCell cell = new TableCell();

                if( i!= PrayersList.Columns.Count - 1)
                {
                    TextBox textbox = new TextBox();
                    //textbox.Text = "&nbsp;";
                    cell.Controls.Add(textbox);
                }
                else
                {
                    CheckBox checkbox = new CheckBox();
                    cell.Controls.Add(checkbox);
                }
                //cell.Text = "";
                row.Cells.Add(cell);
            }

            PrayersList.Controls[0].Controls.AddAt(1, row);
        }

        public IQueryable<Prayer> GetPrayers(
                [QueryString("id")] int? prayerId,
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
    }*/

    public IQueryable<Product> GetProducts(
                    [QueryString("id")] int? categoryId,
                    [RouteData] string categoryName)
    {
      var _db = new GabayManageSite.Models.ProductContext();
      IQueryable<Product> query = _db.Products;

      if (categoryId.HasValue && categoryId > 0)
      {
        query = query.Where(p => p.CategoryID == categoryId);
      }

      if (!String.IsNullOrEmpty(categoryName))
      {
        query = query.Where(p =>
                            String.Compare(p.Category.CategoryName,
                            categoryName) == 0);
      }
      return query;
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
                        prayersTableAdapter.Delete(id_to_delete, int.Parse(sid));
                    }
                }
                //bool isFirst = true;
                //string id_to_delete = "(";

                /*foreach (GridViewRow row in PrayersGridView.Rows)
                {
                    if (((CheckBox)row.FindControl("Remove")).Checked)
                    {
                        if (!isFirst)
                        {
                            id_to_delete += ", ";
                        }

                        id_to_delete += ((Label)row.FindControl("IdLabel")).Text;
                        if(isFirst){isFirst = false;}
                    }
                }*/

                //id_to_delete += ")";*/

                //prayersTableAdapter.DeleteQuery(id_to_delete, int.Parse(sid));
                prayersTableAdapter.Update(gabayDataSet.Prayers);
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