using TechBuy_FinalProject.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TechBuy_FinalProject
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCart();
            }
        }

        private void BindCart()
        {
            var cart = Session["Cart"] as List<Mobile>;

            if (cart == null || cart.Count == 0)
            {
                CartRepeater.DataSource = null;
                CartRepeater.DataBind();
                ShowEmptyMessage();
                CheckoutButton.Enabled = false; 
            }
            else
            {
                EmptyMessage.Visible = false; 
                var groupedCart = cart.GroupBy(m => m.MobileId)
                                      .Select(g => new Mobile
                                      {
                                          MobileId = g.Key,
                                          Title = g.First().Title,
                                          Description = g.First().Description,
                                          Image = g.First().Image,
                                          Price = g.First().Price,
                                          Quantity = g.Sum(m => m.Quantity)
                                      }).ToList();

                CartRepeater.DataSource = groupedCart;
                CartRepeater.DataBind();
                CheckoutButton.Enabled = true; 
            }
        }

        private void ShowEmptyMessage()
        {
            EmptyMessage.Text = "<p class='empty-message'>Your cart is empty.</p>";
            EmptyMessage.Visible = true; 
        }

        protected void RemoveButton_Click(object sender, EventArgs e)
        {
            var button = (Button)sender;
            var mobileId = button.CommandArgument; 
            var cart = Session["Cart"] as List<Mobile>;

            if (cart != null)
            {
                cart.RemoveAll(m => m.MobileId == mobileId); 
                Session["Cart"] = cart;
                BindCart();
            }
        }

        protected void EmptyCartButton_Click(object sender, EventArgs e)
        {
            Session["Cart"] = new List<Mobile>();
            BindCart();
        }
    }
}
