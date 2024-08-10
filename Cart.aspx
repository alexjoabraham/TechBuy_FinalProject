<%@ Page Title="Shopping Cart - TechBuy" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="TechBuy_FinalProject.Cart" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="cart-page-background">
        <div class="container mt-5">
            <h1 class="display-4 text-center mb-4">Your Shopping Cart</h1>

            <div id="EmptyMessageContainer" class="empty-message-container">
                <asp:Literal ID="EmptyMessage" runat="server" Text="" />
            </div>

            <div class="table-responsive">
                <asp:Repeater ID="CartRepeater" runat="server">
                    <HeaderTemplate>
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Image</th>
                                    <th>Title</th>
                                    <th>Description</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                                <img src='<%# Eval("Image") %>' alt='<%# Eval("Title") %>' class="img-thumbnail" style="max-width: 100px; max-height: 100px;" />
                            </td>
                            <td><%# Eval("Title") %></td>
                            <td><%# Eval("Description") %></td>
                            <td><%# Eval("Price", "{0:C}") %></td>
                            <td><%# Eval("Quantity") %></td>
                            <td>
                                <asp:Button ID="RemoveButton" runat="server" Text="Remove" CommandArgument='<%# Eval("MobileId") %>' CssClass="btn btn-danger btn-sm" OnClick="RemoveButton_Click" />
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>

            <div class="d-flex justify-content-between mt-4">
                <asp:Button ID="EmptyCartButton" runat="server" Text="Empty Cart" CssClass="btn btn-secondary" OnClick="EmptyCartButton_Click" />
                <div>
                    <asp:Button ID="ContinueShoppingButton" runat="server" Text="Continue Shopping" CssClass="btn btn-primary mr-2" PostBackUrl="~/Products.aspx" />
                    <asp:Button ID="CheckoutButton" runat="server" Text="Checkout" CssClass="btn btn-success" PostBackUrl="~/Checkout.aspx" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
