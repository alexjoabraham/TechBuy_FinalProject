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
                        <li class="list-group-item">Email: <%= OrderDetails.Email %></li>
                        <li class="list-group-item">Name: <%= OrderDetails.FirstName %> <%= OrderDetails.LastName %></li>
                        <li class="list-group-item">Phone Number: <%= OrderDetails.PhoneNumber %></li>
                        <li class="list-group-item">Address: <%= OrderDetails.Address %>, <%= OrderDetails.City %>, <%= OrderDetails.State %> <%= OrderDetails.ZipCode %></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.js"></script>
</asp:Content>
