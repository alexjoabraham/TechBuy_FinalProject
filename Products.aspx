<%@ Page Title="Products Page - TechBuy" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="TechBuy_FinalProject.Products" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="products-page-background">
        <div class="container mt-5">
            <asp:Literal ID="WelcomeMessage" runat="server"></asp:Literal>

            <h2 class="text-center mb-4">Our Products</h2>

            <asp:Label ID="MessageLabel" runat="server" CssClass="message text-center" />

            <div class="row mb-4">
                <div class="col-md-3 mb-3">
                    <asp:DropDownList ID="BrandDropDown" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="BrandDropDown_SelectedIndexChanged">
                        <asp:ListItem Text="Select Brand" Value="0" />
                    </asp:DropDownList>
                </div>
                <div class="col-md-3 mb-3">
                    <asp:DropDownList ID="MobileDropDown" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="MobileDropDown_SelectedIndexChanged">
                        <asp:ListItem Text="Select Mobile" Value="0" />
                    </asp:DropDownList>
                </div>

                <div class="col-md-6">
                    <div class="center-card-container">
                        <asp:Repeater ID="MobilesRepeater" runat="server" DataSourceID="MobilesByBrandSqlDataSource">
                            <ItemTemplate>
                                <div class="mobile-card card flex-row">
                                    <div class="card-img-left">
                                        <img src='<%# Eval("Image") %>' alt='<%# Eval("Title") %>' />
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title"><%# Eval("Title") %></h5>
                                        <p class="card-text"><strong>Brand:</strong> <%# Eval("BrandName") %></p>
                                        <p class="card-text"><strong>Description:</strong> <%# Eval("Description") %></p>
                                        <p class="card-text"><strong>Price:</strong> <%# Eval("Price", "${0}") %></p>
                                        <div class="form-group mb-3">
                                            <asp:Label ID="QuantityLabel" runat="server" Text="Quantity:" CssClass="form-label" />
                                            <asp:DropDownList ID="QuantityDropDown" runat="server" CssClass="form-select">
                                                <asp:ListItem Text="0" Value="0" />
                                                <asp:ListItem Text="1" Value="1" />
                                                <asp:ListItem Text="2" Value="2" />
                                                <asp:ListItem Text="3" Value="3" />
                                                <asp:ListItem Text="4" Value="4" />
                                                <asp:ListItem Text="5" Value="5" />
                                            </asp:DropDownList>
                                            <asp:CustomValidator ID="QuantityCustomValidator" runat="server"
                                                ControlToValidate="QuantityDropDown"
                                                ErrorMessage="Please select a quantity greater than zero."
                                                CssClass="text-danger"
                                                OnServerValidate="ValidateQuantity"
                                                Display="Dynamic" />
                                        </div>
                                        <asp:Button ID="AddToCartButton" runat="server" Text="Add to Cart" CommandArgument='<%# Eval("MobileId") %>' CssClass="btn btn-dark w-100" OnClick="AddToCartButton_Click" />
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>

            <asp:SqlDataSource ID="MobilesByBrandSqlDataSource" runat="server"
                ConnectionString="<%$ ConnectionStrings:TechBuyConnectionString %>"
                SelectCommand="SELECT m.MobileId, m.Title, m.Description, b.BrandName, m.Price, m.Image 
                               FROM Mobiles m
                               INNER JOIN Brands b ON m.BrandId = b.BrandId
                               WHERE (@MobileId IS NULL OR m.MobileId = @MobileId)">
                <SelectParameters>
                    <asp:Parameter Name="MobileId" Type="String" DefaultValue="" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
