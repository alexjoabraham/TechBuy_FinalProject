<%@ Page Title="Login/Register Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LoginRegister.aspx.cs" Inherits="TechBuy_FinalProject.LoginRegister" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="login-page-background">
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-3 mb-4">
                    <div class="card shadow-lg border-0 rounded-lg">
                        <div class="card-header bg-dark text-light">
                            <h2 class="card-title text-center">Login</h2>
                        </div>
                        <div class="card-body">
                            <div class="form-group mb-3">
                                <asp:Label ID="UsernameLabel" runat="server" Text="Username" AssociatedControlID="UsernameTextBox" CssClass="form-label"></asp:Label>
                                <asp:TextBox ID="UsernameTextBox" runat="server" CssClass="form-control" placeholder="Enter your username"></asp:TextBox>
                            </div>
                            <div class="form-group mb-3">
                                <asp:Label ID="PasswordLabel" runat="server" Text="Password" AssociatedControlID="PasswordTextBox" CssClass="form-label"></asp:Label>
                                <asp:TextBox ID="PasswordTextBox" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter your password"></asp:TextBox>
                            </div>
                            <div class="d-flex justify-content-center">
                                <asp:Button ID="LoginButton" runat="server" Text="Login" CssClass="btn btn-dark mx-2" OnClick="LoginButton_Click" />
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 mb-4 ms-5">
                    <div class="card shadow-lg border-0 rounded-lg">
                        <div class="card-header bg-success text-light">
                            <h2 class="card-title text-center">Register</h2>
                        </div>
                        <div class="card-body">
                            <div class="form-group mb-3">
                                <asp:Label ID="RegisterUsernameLabel" runat="server" Text="Username" AssociatedControlID="RegisterUsernameTextBox" CssClass="form-label"></asp:Label>
                                <asp:TextBox ID="RegisterUsernameTextBox" runat="server" CssClass="form-control" placeholder="Choose a username"></asp:TextBox>
                            </div>
                            <div class="form-group mb-3">
                                <asp:Label ID="RegisterPasswordLabel" runat="server" Text="Password" AssociatedControlID="RegisterPasswordTextBox" CssClass="form-label"></asp:Label>
                                <asp:TextBox ID="RegisterPasswordTextBox" runat="server" TextMode="Password" CssClass="form-control" placeholder="Choose a password"></asp:TextBox>
                            </div>
                            <div class="form-group mb-3">
                                <asp:Label ID="RoleLabel" runat="server" Text="Role" AssociatedControlID="RoleDropDownList" CssClass="form-label"></asp:Label>
                                <asp:DropDownList ID="RoleDropDownList" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="User" Value="User" />
                                    <asp:ListItem Text="Admin" Value="Admin" />
                                </asp:DropDownList>
                            </div>
                            <div class="d-flex justify-content-center">
                                <asp:Button ID="RegisterButton" runat="server" Text="Register" CssClass="btn btn-success mx-2" OnClick="RegisterButton_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
