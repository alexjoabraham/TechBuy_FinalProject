using System;
using System.Collections.Generic;
using System.Xml;
using TechBuy_FinalProject.Model;

namespace TechBuy_FinalProject
{
    public partial class Order : System.Web.UI.Page
    {
        protected OrderDetails OrderDetails { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["OrderDetails"] != null)
                {
                    OrderDetails = (OrderDetails)Session["OrderDetails"];
                }
                else
                {
                }
            }
        }
    }
}
