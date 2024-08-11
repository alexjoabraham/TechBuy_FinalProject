using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TechBuy_FinalProject
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear the session and log out the user
            Session.Clear();
            Session.Abandon();
        }

        protected void LoginAgainButton_Click(object sender, EventArgs e)
        {
            // Redirect to LoginRegister.aspx
            Response.Redirect("~/LoginRegister.aspx");
        }
    }
}