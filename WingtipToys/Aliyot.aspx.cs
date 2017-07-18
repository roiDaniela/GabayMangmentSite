using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GabayManageSite
{
    public partial class Aliyot : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSource1.SelectParameters.Remove(SqlDataSource1.SelectParameters["syn_id"]);
            SqlDataSource1.SelectParameters.Add("syn_id", (Session["currSynId"] == null) ? String.Empty : Session["currSynId"].ToString());
        }
        
    }
}