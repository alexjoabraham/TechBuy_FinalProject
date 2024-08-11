<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Logout.aspx.cs" Inherits="TechBuy_FinalProject.Logout" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Logout - TechBuy</title>
    <link href="~/Content/styles.css" rel="stylesheet" />
    <link href="~/Content/Site.css" rel="stylesheet" />
</head>
<body>
    <div class="order-page-background">
        <form id="form1" runat="server">
            <div class="container text-center">
                <h1>You have been logged out.</h1>
                <p>Thank you for visiting TechBuy. You have been successfully logged out.</p>
                <asp:Button ID="LoginAgainButton" runat="server" Text="Login/Register Again" CssClass="btn btn-primary" OnClick="LoginAgainButton_Click" />
            </div>
        </form>
    </div>
</body>
</html>
