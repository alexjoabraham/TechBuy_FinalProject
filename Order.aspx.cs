using System;
using System.Collections.Generic;
using TechBuy_FinalProject.Model;

namespace TechBuy_FinalProject
{
    public partial class Order : System.Web.UI.Page
    {
        protected OrderDetails OrderDetails { get; set; }
        protected decimal TotalAmount { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["OrderDetails"] != null)
                {
                    OrderDetails = (OrderDetails)Session["OrderDetails"];

                    // Retrieve purchased items
                    var purchasedItems = Session["PurchasedItems"] as List<Mobile>;
                    if (purchasedItems != null && purchasedItems.Count > 0)
                    {
                        OrderRepeater.DataSource = purchasedItems;
                        OrderRepeater.DataBind();

                        // Calculate total amount
                        TotalAmount = 0;
                        foreach (var item in purchasedItems)
                        {
                            TotalAmount += item.Price * item.Quantity;
                        }
                        TotalAmountLabel.Text = TotalAmount.ToString("C");
                    }
                    else
                    {
                        // Handle case with no purchased items
                        //PurchasedProductsSection.Visible = false;
                        NoPurchasedProductsMessage.Visible = true;
                    }
                }
            }
        }
        protected void ContinueShoppingButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Products.aspx");
        }
    }
}
