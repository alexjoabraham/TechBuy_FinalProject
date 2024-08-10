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
            }
            else
            {
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
            }
        }

        private void ShowEmptyMessage()
        {
            if (CartRepeater.Controls.Count > 0 && CartRepeater.Controls[0].Controls.Count > 0)
            {
                var emptyMessage = CartRepeater.Controls[0].FindControl("EmptyMessage") as Literal;
                if (emptyMessage != null)
                {
                    emptyMessage.Text = "<p class='empty-message'>Your cart is empty.</p>";
                }
            }
        }

        protected void RemoveButton_Click(object sender, EventArgs e)
        {
            var button = (Button)sender;
            var mobileId = button.CommandArgument; // Ensure CommandArgument is parsed to an integer
            var cart = Session["Cart"] as List<Mobile>;

            if (cart != null)
            {
                cart.RemoveAll(m => m.MobileId == mobileId); // Compare integers now
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
