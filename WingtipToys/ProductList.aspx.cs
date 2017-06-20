using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WingtipToys.Models;
using System.Web.ModelBinding;
using System.Web.Routing;

namespace WingtipToys
{
  public partial class ProductList : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
    }
        protected void UpdateBtn_Click(object sender, EventArgs e)
        {
            PrayersList_DataBound(sender, e);
        }

        protected void PrayersList_DataBound(object sender, EventArgs e)
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
        var _db = new WingtipToys.Models.ProductContext();
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

    public IQueryable<Product> GetProducts(
                    [QueryString("id")] int? categoryId,
                    [RouteData] string categoryName)
    {
      var _db = new WingtipToys.Models.ProductContext();
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
  }
}