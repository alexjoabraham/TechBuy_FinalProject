<%@ Page Title="Home Page - TechBuy" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TechBuy_FinalProject._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="hero-image">
        <div class="hero-text">
            <h1>Welcome to TechBuy</h1>
            <p>Explore our amazing collection of brand new Mobiles.</p>
        </div>
    </div>

    <div class="container mt-5">
        <h2 class="text-center">Featured Mobiles</h2>
        <asp:Repeater ID="MobilesRepeater" runat="server">
            <HeaderTemplate>
                <div class="mobile-grid">
            </HeaderTemplate>
            <ItemTemplate>
                <div class="featured-mobile-card">
                    <img src='<%# Eval("Image") %>' alt='<%# Eval("Title") %>' class="featured-mobile-img" />
                    <h3><%# Eval("Title") %></h3>
                    <p><strong>Price:</strong> <%# Eval("Price", "${0}") %></p>
                </div>
            </ItemTemplate>
            <FooterTemplate>
                </div>
            </FooterTemplate>
        </asp:Repeater>
    </div>

    <div class="explore-more">
        <a class="btn btn-primary" href="Products.aspx">Explore More &raquo;</a>
    </div>

    <div class="container mt-5">
        <div class="row about-us-section">
            <div class="col-md-6">
                <img src="/Image/about-us.jpg" alt="About Us" class="img-fluid rounded">
            </div>
            <div class="col-md-6 d-flex align-items-center">
                <div>
                    <h2>About Us</h2>
                    <p>Welcome to TechBuy, your number one source for all things mobiles. We're dedicated to giving you the very best of our collection, with a focus on quality, customer service, and uniqueness.</p>
                    <p>Founded in 2024, TechBuy has come a long way from its beginnings. When we first started out, our passion for providing the best mobiles drove us to do intense research, and gave us the impetus to turn hard work and inspiration into a booming online store. We now serve customers all over the world and are thrilled to be a part of the tech industry's innovation.</p>
                    <p>We hope you enjoy our products as much as we enjoy offering them to you. If you have any questions or comments, please don't hesitate to contact us.</p>
                    <p>Sincerely,<br>
                        TechBuy Team</p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
