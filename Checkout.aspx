<%@ Page Title="Check Out - TechBuy" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="TechBuy_FinalProject.Checkout" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .error-message{
            color:red;
        }
    </style>
    <div class="checkout-page-background">
        <div class="container mt-5">
            <h1 class="display-4 text-center mb-4">Check Out</h1>

            <div class="row">
                <div class="col-lg-6">
                    <h3>Contact Information</h3>
                    <div class="form-group">
                        <label for="Email">Email Address:</label>
                        <asp:TextBox ID="Email" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="EmailRequiredValidator" runat="server"
                            ControlToValidate="Email"
                            ErrorMessage="Email is required."
                            Display="Dynamic"
                            ValidationGroup="PlaceOrderValidation"
                            CssClass="error-message" />
                        <asp:RegularExpressionValidator ID="EmailValidator" runat="server"
                            ControlToValidate="Email"
                            ErrorMessage="Must be a valid email address."
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                            Display="Dynamic"
                            ValidationGroup="PlaceOrderValidation"
                            CssClass="error-message" />
                    </div>
                    <div class="form-group">
                        <label for="ReEmail">Email Re-entry:</label>
                        <asp:TextBox ID="ReEmail" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="ReEmailRequiredValidator" runat="server"
                            ControlToValidate="ReEmail"
                            ErrorMessage="Please re-enter your email."
                            Display="Dynamic"
                            ValidationGroup="PlaceOrderValidation"
                            CssClass="error-message" />
                        <asp:CompareValidator ID="CompareValidator" runat="server"
                            ControlToValidate="ReEmail"
                            ControlToCompare="Email"
                            ErrorMessage="Emails do not match."
                            Display="Dynamic"
                            ValidationGroup="PlaceOrderValidation"
                            CssClass="error-message" />
                    </div>
                    <div class="form-group">
                        <label for="FirstName">First Name:</label>
                        <asp:TextBox ID="FirstName" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="FirstNameRequiredValidator" runat="server"
                            ControlToValidate="FirstName"
                            ErrorMessage="First Name is required."
                            Display="Dynamic"
                            ValidationGroup="PlaceOrderValidation"
                            CssClass="error-message" />
                    </div>
                    <div class="form-group">
                        <label for="LastName">Last Name:</label>
                        <asp:TextBox ID="LastName" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="LastNameRequiredValidator" runat="server"
                            ControlToValidate="LastName"
                            ErrorMessage="Last Name is required."
                            Display="Dynamic"
                            ValidationGroup="PlaceOrderValidation"
                            CssClass="error-message" />
                    </div>
                    <div class="form-group">
                        <label for="PhoneNumber">Phone Number:</label>
                        <asp:TextBox ID="PhoneNumber" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="PhoneRequiredValidator" runat="server"
                            ControlToValidate="PhoneNumber"
                            ErrorMessage="Phone Number is required."
                            Display="Dynamic"
                            ValidationGroup="PlaceOrderValidation"
                            CssClass="error-message" />
                        <asp:RegularExpressionValidator ID="PhoneValidator" runat="server"
                            ControlToValidate="PhoneNumber"
                            ErrorMessage="Use this format: 123-456-7890"
                            ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"
                            Display="Dynamic"
                            ValidationGroup="PlaceOrderValidation"
                            CssClass="error-message" />
                    </div>
                </div>
                <div class="col-lg-6">
                    <h3>Billing Address</h3>
                    <div class="form-group">
                        <label for="Address">Address:</label>
                        <asp:TextBox ID="Address" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="AddressRequiredValidator" runat="server"
                            ControlToValidate="Address"
                            ErrorMessage="Address is required."
                            Display="Dynamic"
                            ValidationGroup="PlaceOrderValidation"
                            CssClass="error-message" />
                    </div>
                    <div class="form-group">
                        <label for="City">City:</label>
                        <asp:TextBox ID="City" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="CityRequiredValidator" runat="server"
                            ControlToValidate="City"
                            ErrorMessage="City is required."
                            Display="Dynamic"
                            ValidationGroup="PlaceOrderValidation"
                            CssClass="error-message" />
                    </div>
                    <div class="form-group">
                        <label for="State">State:</label>
                        <asp:DropDownList ID="State" runat="server" CssClass="form-control">
                            <asp:ListItem Text="" Value=""></asp:ListItem>
                            <asp:ListItem Text="Alberta" Value="AB"></asp:ListItem>
                            <asp:ListItem Text="British Columbia" Value="BC"></asp:ListItem>
                            <asp:ListItem Text="Manitoba" Value="MB"></asp:ListItem>
                            <asp:ListItem Text="New Brunswick" Value="NB"></asp:ListItem>
                            <asp:ListItem Text="Newfoundland and Labrador" Value="NL"></asp:ListItem>
                            <asp:ListItem Text="Northwest Territories" Value="NT"></asp:ListItem>
                            <asp:ListItem Text="Nova Scotia" Value="NS"></asp:ListItem>
                            <asp:ListItem Text="Nunavut" Value="NU"></asp:ListItem>
                            <asp:ListItem Text="Ontario" Value="ON"></asp:ListItem>
                            <asp:ListItem Text="Prince Edward Island" Value="PE"></asp:ListItem>
                            <asp:ListItem Text="Quebec" Value="QC"></asp:ListItem>
                            <asp:ListItem Text="Saskatchewan" Value="SK"></asp:ListItem>
                            <asp:ListItem Text="Yukon" Value="YT"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="StateRequiredValidator" runat="server"
                            ControlToValidate="State"
                            ErrorMessage="State is required."
                            InitialValue=""
                            Display="Dynamic"
                            ValidationGroup="PlaceOrderValidation"
                            CssClass="error-message" />
                    </div>
                    <div class="form-group">
                        <label for="ZipCode">Zip Code:</label>
                        <asp:TextBox ID="ZipCode" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="ZipRequiredValidator" runat="server"
                            ControlToValidate="ZipCode"
                            ErrorMessage="Zip Code is required."
                            Display="Dynamic"
                            ValidationGroup="PlaceOrderValidation"
                            CssClass="error-message" />
                        <asp:RegularExpressionValidator ID="ZipValidator" runat="server"
                            ControlToValidate="ZipCode"
                            ErrorMessage="Invalid postal code format. Use A1A 1A1."
                            ValidationExpression="[ABCEGHJKLMNPRSTVXY]\d[ABCEGHJKLMNPRSTVWXYZ] ?\d[ABCEGHJKLMNPRSTVWXYZ]\d"
                            Display="Dynamic"
                            ValidationGroup="PlaceOrderValidation"
                            CssClass="error-message" />
                    </div>
                    <div class="form-group mt-4">
                        <asp:Button ID="PlaceOrderButton" runat="server" Text="Place Order" CssClass="btn btn-primary" OnClick="PlaceOrderButton_Click" ValidationGroup="PlaceOrderValidation" />
                        <asp:Button ID="GoBackToCartButton" runat="server" Text="Go back to Cart" CssClass="btn btn-secondary ml-2" PostBackUrl="~/Cart.aspx" />
                    </div>
                </div>
            </div>

            <!-- Optional Data Section -->
            <asp:DropDownList ID="OptionalData" runat="server" CssClass="form-control" Visible="false"></asp:DropDownList>
            <asp:RadioButtonList ID="ContactMethod" runat="server" CssClass="form-control" Visible="false"></asp:RadioButtonList>
        </div>
    </div>
</asp:Content>
