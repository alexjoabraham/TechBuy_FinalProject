<%@ Page Title="Order Details - TechBuy" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Order.aspx.cs" Inherits="TechBuy_FinalProject.Order" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="order-page-background">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="mt-5">Your order has been placed</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h3 class="mt-3">Order Details</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-6 offset-lg-3">
                    <ul class="list-group mt-4">
                        <li class="list-group-item"><strong>Email:</strong> <%= OrderDetails.Email %></li>
                        <li class="list-group-item"><strong>Name:</strong> <%= OrderDetails.FirstName %> <%= OrderDetails.LastName %></li>
                        <li class="list-group-item"><strong>Phone Number:</strong> <%= OrderDetails.PhoneNumber %></li>
                        <li class="list-group-item"><strong>Address:</strong> <%= OrderDetails.Address %>, <%= OrderDetails.City %>, <%= OrderDetails.State %> <%= OrderDetails.ZipCode %></li>
                    </ul>
                </div>
            </div>
            <div class="row mt-5">
                <div class="col-lg-12 text-center">
                    <h3 class="mb-4">Purchased Products</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-10 offset-lg-1">
                    <asp:Repeater ID="OrderRepeater" runat="server">
                        <HeaderTemplate>
                            <table class="table table-striped table-bordered">
                                <thead class="thead-dark">
                                    <tr>
                                        <th scope="col">Image</th>
                                        <th scope="col">Title</th>
                                        <th scope="col">Price</th>
                                        <th scope="col">Quantity</th>
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
                                <td><%# Eval("Price", "{0:C}") %></td>
                                <td><%# Eval("Quantity") %></td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                                </tbody>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 text-center mt-4">
                    <h4>Total Amount: <asp:Label ID="TotalAmountLabel" runat="server" Text=""></asp:Label></h4>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 text-center mt-3">
                    <asp:Button ID="ContinueShoppingButton" runat="server" Text="Continue Shopping" CssClass="btn btn-primary" OnClick="ContinueShoppingButton_Click" />
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12 text-center">
                    <asp:Label ID="NoPurchasedProductsMessage" runat="server" CssClass="text-danger" Visible="false" Text="No products were purchased."></asp:Label>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.js"></script>
</asp:Content>
