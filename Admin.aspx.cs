using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TechBuy_FinalProject
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserRole"] == null || !Session["UserRole"].ToString().Equals("Admin", StringComparison.OrdinalIgnoreCase))
            {
                string script = "alert('You do not have the necessary admin privileges to access this page.'); window.location.href = '" + ResolveUrl("~/LoginRegister.aspx") + "';";
                ClientScript.RegisterStartupScript(this.GetType(), "redirect", script, true);
                return;
            }

            if (!IsPostBack)
            {
                BindBrands();
                BindMobiles();
                BindBrandDropDownLists();
            }
        }

        private void BindBrandDropDownLists()
        {

            var brandDataSource = (SqlDataSource)FindControl("BrandSqlDataSource");

            if (brandDataSource != null)
            {
                var brandDropDownList = (DropDownList)MobileDetailsView.FindControl("BrandDropDownList");
                if (brandDropDownList != null)
                {
                    brandDropDownList.DataSource = brandDataSource;
                    brandDropDownList.DataTextField = "BrandName";
                    brandDropDownList.DataValueField = "BrandId";
                    brandDropDownList.DataBind();
                }

                var newBrandDropDownList = (DropDownList)FindControl("NewBrandDropDownList");
                if (newBrandDropDownList != null)
                {
                    newBrandDropDownList.DataSource = brandDataSource;
                    newBrandDropDownList.DataTextField = "BrandName";
                    newBrandDropDownList.DataValueField = "BrandId";
                    newBrandDropDownList.DataBind();
                }
            }

        }

        private void BindBrands()
        {
            try
            {
                BrandDropDownList.DataSource = BrandSqlDataSource;
                BrandDropDownList.DataTextField = "BrandName";
                BrandDropDownList.DataValueField = "BrandId";
                BrandDropDownList.DataBind();
                BrandDropDownList.Items.Insert(0, new ListItem("Select a Brand", ""));
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error binding brands: " + ex.Message);
            }
        }

        private void BindMobiles()
        {
            try
            {
                MobilesGridView.DataBind();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error binding mobiles: " + ex.Message);
            }
        }

        protected void BrandDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            MobileDataList.DataBind();
        }

        protected void MobileDataList_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                if (e.Item.DataItem == null || DataBinder.Eval(e.Item.DataItem, "Title") == DBNull.Value)
                {
                    e.Item.Visible = false;
                }
            }
        }

        protected void CategoryGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            CategoryGridView.EditIndex = e.NewEditIndex;
            CategoryGridView.DataBind();
        }

        protected void CategoryGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                if (e.RowIndex >= 0 && e.RowIndex < CategoryGridView.Rows.Count)
                {
                    GridViewRow row = CategoryGridView.Rows[e.RowIndex];

                    if (row != null)
                    {
                        TextBox brandNameTextBox = row.FindControl("BrandNameTextBox") as TextBox;

                        if (brandNameTextBox != null)
                        {
                            string brandId = CategoryGridView.DataKeys[e.RowIndex]?.Value?.ToString();
                            string brandName = brandNameTextBox.Text;

                            if (!string.IsNullOrEmpty(brandId) && !string.IsNullOrEmpty(brandName))
                            {
                                CategorySqlDataSource.UpdateParameters["BrandId"].DefaultValue = brandId;
                                CategorySqlDataSource.UpdateParameters["BrandName"].DefaultValue = brandName;
                                CategorySqlDataSource.Update();

                                CategoryGridView.EditIndex = -1;
                                CategoryGridView.DataBind();
                            }
                            else
                            {
                                Response.Write("<script>alert('Brand ID and Brand Name cannot be empty.');</script>");
                            }
                        }
                    }
                    else
                    {
                        Response.Write("<script>alert('GridView row is null.');</script>");
                    }
                }
                else
                {
                    Response.Write("<script>alert('Invalid row index.');</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error updating brand: " + ex.Message + "');</script>");
                Console.WriteLine("Error updating brand: " + ex.Message);
            }
        }

        protected void CategoryGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            CategoryGridView.EditIndex = -1;
            CategoryGridView.DataBind();
        }

        protected void AddBrandButton_Click(object sender, EventArgs e)
        {
            string newBrandId = NewBrandIdTextBox.Text.Trim();
            string newBrandName = NewBrandNameTextBox.Text.Trim();

            if (!string.IsNullOrEmpty(newBrandId) && !string.IsNullOrEmpty(newBrandName))
            {
                try
                {
                    AddBrandSqlDataSource.InsertParameters["BrandId"].DefaultValue = newBrandId;
                    AddBrandSqlDataSource.InsertParameters["BrandName"].DefaultValue = newBrandName;
                    AddBrandSqlDataSource.Insert();

                    NewBrandIdTextBox.Text = string.Empty;
                    NewBrandNameTextBox.Text = string.Empty;

                    CategoryGridView.DataBind();
                    BrandDropDownList.DataBind();
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error adding brand: " + ex.Message + "');</script>");
                    Console.WriteLine("Error adding brand: " + ex.Message);
                }
            }
            else
            {
                Response.Write("<script>alert('Brand ID and Brand Name cannot be empty.');</script>");
            }
        }

        protected void MobilesGridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            MobilesGridView.EditIndex = e.NewEditIndex;
            MobilesGridView.DataBind();
        }

        protected void MobilesGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                if (e.RowIndex >= 0 && e.RowIndex < MobilesGridView.Rows.Count)
                {
                    GridViewRow row = MobilesGridView.Rows[e.RowIndex];

                    if (row != null)
                    {
                        TextBox titleTextBox = row.FindControl("TitleTextBox") as TextBox;
                        TextBox brandIdTextBox = row.FindControl("BrandIdTextBox") as TextBox;

                        if (titleTextBox != null && brandIdTextBox != null)
                        {
                            string mobileId = MobilesGridView.DataKeys[e.RowIndex]?.Value?.ToString();
                            string title = titleTextBox.Text;
                            string brandId = brandIdTextBox.Text;

                            if (!string.IsNullOrEmpty(mobileId) && !string.IsNullOrEmpty(title) && !string.IsNullOrEmpty(brandId))
                            {
                                MobilesSqlDataSource.UpdateParameters["MobileID"].DefaultValue = mobileId;
                                MobilesSqlDataSource.UpdateParameters["Title"].DefaultValue = title;
                                MobilesSqlDataSource.UpdateParameters["BrandId"].DefaultValue = brandId;
                                MobilesSqlDataSource.Update();

                                MobilesGridView.EditIndex = -1;
                                MobilesGridView.DataBind();
                            }
                            else
                            {
                                Response.Write("<script>alert('Mobile ID, Title, and Brand ID cannot be empty.');</script>");
                            }
                        }
                        else
                        {
                            Response.Write("<script>alert('Required controls not found.');</script>");
                        }
                    }
                    else
                    {
                        Response.Write("<script>alert('GridView row is null.');</script>");
                    }
                }
                else
                {
                    Response.Write("<script>alert('Invalid row index.');</script>");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error updating mobile: " + ex.Message);
            }
        }

        protected void MobilesGridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            MobilesGridView.EditIndex = -1;
            MobilesGridView.DataBind();
        }

        protected void MobilesGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedMobileID = MobilesGridView.SelectedDataKey.Value.ToString();
            MobileDetailsSqlDataSource.SelectParameters["MobileID"].DefaultValue = selectedMobileID;
            MobileDetailsView.DataBind();
        }

        protected void MobilesGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            MobilesGridView.PageIndex = e.NewPageIndex;
            MobilesGridView.DataBind();
        }

        protected void MobilesGridView_Sorting(object sender, GridViewSortEventArgs e)
        {
            MobilesSqlDataSource.SelectCommand = "SELECT Mobiles.MobileID, Mobiles.Title, Brands.BrandName FROM Mobiles JOIN Brands ON Mobiles.BrandId = Brands.BrandId ORDER BY " + e.SortExpression;
            MobilesGridView.DataBind();
        }

        protected void MobileDetailsView_ModeChanging(object sender, DetailsViewModeEventArgs e)
        {
            if (e.NewMode == DetailsViewMode.Edit || e.NewMode == DetailsViewMode.Insert)
            {
                MobileDetailsView.ChangeMode(e.NewMode);
            }
        }

        protected void MobileDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            try
            {
                string mobileId = e.Keys["MobileID"].ToString();
                string title = e.NewValues["Title"].ToString();
                string description = e.NewValues["Description"].ToString();
                decimal price = Convert.ToDecimal(e.NewValues["Price"]);
                string brandId = e.NewValues["BrandId"].ToString();
                string image = e.NewValues["Image"].ToString();

                MobilesSqlDataSource.UpdateParameters["MobileID"].DefaultValue = mobileId;
                MobilesSqlDataSource.UpdateParameters["Title"].DefaultValue = title;
                MobilesSqlDataSource.UpdateParameters["Description"].DefaultValue = description;
                MobilesSqlDataSource.UpdateParameters["Price"].DefaultValue = price.ToString();
                MobilesSqlDataSource.UpdateParameters["BrandId"].DefaultValue = brandId;
                MobilesSqlDataSource.UpdateParameters["Image"].DefaultValue = image;
                MobilesSqlDataSource.Update();

                MobilesGridView.DataBind();
                MobileDetailsView.ChangeMode(DetailsViewMode.ReadOnly);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error updating mobile: " + ex.Message);
            }
        }

        protected void MobileDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            try
            {
                string mobileId = e.Values["mobileId"].ToString();
                string title = e.Values["Title"]?.ToString();
                string description = e.Values["Description"]?.ToString();
                string brandId = e.Values["BrandId"]?.ToString();
                string image = e.Values["Image"]?.ToString();
                decimal price;

                DropDownList brandDropDownList = (DropDownList)MobileDetailsView.FindControl("BrandDropDownList");
                if (brandDropDownList != null)
                {
                    brandId = brandDropDownList.SelectedValue;
                }

                if (string.IsNullOrEmpty(title))
                {
                    throw new ArgumentNullException("Title", "Title cannot be null or empty.");
                }
                if (string.IsNullOrEmpty(description))
                {
                    throw new ArgumentNullException("Description", "Description cannot be null or empty.");
                }
                if (string.IsNullOrEmpty(brandId))
                {
                    throw new ArgumentNullException("BrandId", "BrandId cannot be null or empty.");
                }
                if (!decimal.TryParse(e.Values["Price"]?.ToString(), out price))
                {
                    throw new ArgumentException("Price is invalid or cannot be parsed.");
                }

                MobilesSqlDataSource.InsertParameters["MobileId"].DefaultValue = mobileId;
                MobilesSqlDataSource.InsertParameters["Title"].DefaultValue = title;
                MobilesSqlDataSource.InsertParameters["Description"].DefaultValue = description;
                MobilesSqlDataSource.InsertParameters["Price"].DefaultValue = price.ToString();
                MobilesSqlDataSource.InsertParameters["BrandId"].DefaultValue = brandId;
                MobilesSqlDataSource.InsertParameters["Image"].DefaultValue = image;

                MobilesSqlDataSource.Insert();

                MobileDetailsView.ChangeMode(DetailsViewMode.ReadOnly);
                MobilesGridView.DataBind();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error inserting mobile: " + ex.Message);
            }
        }


        protected void MobileDetailsView_ItemDeleting(object sender, DetailsViewDeleteEventArgs e)
        {
            try
            {
                string mobileId = e.Keys["MobileID"].ToString();

                MobilesSqlDataSource.DeleteParameters["MobileID"].DefaultValue = mobileId;
                MobilesSqlDataSource.Delete();

                MobileDetailsView.ChangeMode(DetailsViewMode.ReadOnly);
                MobilesGridView.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error deleting mobile: " + ex.Message + "');</script>");
                Console.WriteLine("Error deleting mobile: " + ex.Message);
            }
        }

    }
}
