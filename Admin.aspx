<%@ Page Title="Admin - TechBuy" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="TechBuy_FinalProject.Admin" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="admin-page-background">
        <div class="container mt-5">
            <h1 class="text-center mb-4">Admin - Manage Mobiles</h1>

            <div class="row mb-4">
                <div class="col-lg-4 offset-lg-4">
                    <asp:DropDownList ID="BrandDropDownList" runat="server" AutoPostBack="True"
                        CssClass="form-control" OnSelectedIndexChanged="BrandDropDownList_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="BrandSqlDataSource" runat="server"
                        ConnectionString="<%$ ConnectionStrings:TechBuyConnectionString %>"
                        SelectCommand="SELECT BrandId, BrandName FROM Brands"></asp:SqlDataSource>
                </div>
            </div>

            <div class="table-responsive">
                <asp:DataList ID="MobileDataList" runat="server" DataSourceID="MobileSqlDataSource"
                    CssClass="minimalist-table" OnItemDataBound="MobileDataList_ItemDataBound">
                    <HeaderTemplate>
                        <table class="minimalist-table">
                            <thead>
                                <tr>
                                    <th>Mobile ID</th>
                                    <th>Title</th>
                                    <th>Description</th>
                                    <th>Price</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr runat="server">
                            <td><%# Eval("MobileID") %></td>
                            <td><%# Eval("Title") %></td>
                            <td><%# Eval("Description") %></td>
                            <td><%# Eval("Price", "{0:C}") %></td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </tbody>
                </table>
                    </FooterTemplate>
                </asp:DataList>
            </div>

            <asp:SqlDataSource ID="MobileSqlDataSource" runat="server"
                ConnectionString="<%$ ConnectionStrings:TechBuyConnectionString %>"
                SelectCommand="SELECT MobileID, Title, Description, Price FROM Mobiles WHERE BrandId = @BrandId">
                <SelectParameters>
                    <asp:ControlParameter ControlID="BrandDropDownList" Name="BrandId" PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <h2 class="text-center mb-4 mt-5">Manage Brand</h2>
            <asp:GridView ID="CategoryGridView" runat="server" DataSourceID="CategorySqlDataSource"
                AutoGenerateColumns="False" CssClass="table table-bordered table-striped"
                DataKeyNames="BrandId" OnRowEditing="CategoryGridView_RowEditing"
                OnRowUpdating="CategoryGridView_RowUpdating" OnRowCancelingEdit="CategoryGridView_RowCancelingEdit">
                <Columns>
                    <asp:BoundField DataField="BrandId" HeaderText="ID" ReadOnly="True" SortExpression="BrandId" />
                    <asp:TemplateField HeaderText="Brand Name">
                        <ItemTemplate>
                            <%# Eval("BrandName") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="BrandNameTextBox" runat="server" Text='<%# Bind("BrandName") %>' CssClass="form-control" />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Edit">
                        <ItemTemplate>
                            <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit"
                                CssClass="btn btn-outline-secondary btn-sm" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update"
                                CssClass="btn btn-success btn-sm" />
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel"
                                CssClass="btn btn-secondary btn-sm" />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Delete">
                        <ItemTemplate>
                            <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete"
                                CssClass="btn btn-outline-danger btn-sm" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="CategorySqlDataSource" runat="server"
                ConnectionString="<%$ ConnectionStrings:TechBuyConnectionString %>"
                SelectCommand="SELECT BrandId, BrandName FROM Brands"
                UpdateCommand="UPDATE Brands SET BrandName = @BrandName WHERE BrandId = @BrandId"
                DeleteCommand="DELETE FROM Brands WHERE BrandId = @BrandId">
                <UpdateParameters>
                    <asp:Parameter Name="BrandName" Type="String" />
                    <asp:Parameter Name="BrandId" Type="String" />
                </UpdateParameters>
                <DeleteParameters>
                    <asp:Parameter Name="BrandId" Type="String" />
                </DeleteParameters>
            </asp:SqlDataSource>

            <!-- Add New Brand -->
            <h2 class="text-center mb-4 mt-5">Add New Brand</h2>
            <div class="row">
                <div class="col-lg-4 offset-lg-4">
                    <asp:TextBox ID="NewBrandIdTextBox" runat="server" CssClass="form-control" Placeholder="Enter new brand ID"></asp:TextBox>
                    <asp:TextBox ID="NewBrandNameTextBox" runat="server" CssClass="form-control mt-2" Placeholder="Enter new brand name"></asp:TextBox>
                    <asp:Button ID="AddBrandButton" runat="server" Text="Add Brand" CssClass="btn btn-primary btn-block mt-2" OnClick="AddBrandButton_Click" />
                </div>
            </div>

            <asp:SqlDataSource ID="AddBrandSqlDataSource" runat="server"
                ConnectionString="<%$ ConnectionStrings:TechBuyConnectionString %>"
                InsertCommand="INSERT INTO Brands (BrandId, BrandName) VALUES (@BrandId, @BrandName)">
                <InsertParameters>
                    <asp:Parameter Name="BrandId" Type="String" />
                    <asp:Parameter Name="BrandName" Type="String" />
                </InsertParameters>
            </asp:SqlDataSource>

            <div class="mobile-management-container">
                <h2 class="text-center mb-4 mt-5">Manage Mobiles</h2>
                <div class="grid-container">
                    <div class="grid-item">
                        <asp:GridView ID="MobilesGridView" runat="server" DataSourceID="MobilesSqlDataSource"
                            AutoGenerateColumns="False" CssClass="table table-bordered table-striped table-condensed"
                            AllowSorting="True" AllowPaging="True" PageSize="10"
                            DataKeyNames="MobileID" OnSelectedIndexChanged="MobilesGridView_SelectedIndexChanged"
                            OnPageIndexChanging="MobilesGridView_PageIndexChanging" OnSorting="MobilesGridView_Sorting">
                            <Columns>
                                <asp:BoundField DataField="MobileID" HeaderText="Mobile ID" SortExpression="MobileID" ReadOnly="True" />
                                <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                                <asp:BoundField DataField="BrandName" HeaderText="Brand" SortExpression="BrandName" />
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="SelectButton" runat="server" CommandName="Select" Text="Select"
                                            CssClass="btn btn-outline-primary btn-sm" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerSettings Mode="NumericFirstLast" />
                            <PagerStyle CssClass="pagerStyle"
                                BackColor="#e5e5e5" HorizontalAlign="Center" />
                        </asp:GridView>
                    </div>

                    <div class="grid-item">
                        <asp:DetailsView ID="MobileDetailsView" runat="server" AutoGenerateRows="False" DataKeyNames="MobileID"
                            DataSourceID="MobileDetailsSqlDataSource" CssClass="table table-active"
                            OnModeChanging="MobileDetailsView_ModeChanging" OnItemUpdating="MobileDetailsView_ItemUpdating"
                            OnItemInserting="MobileDetailsView_ItemInserting" OnItemDeleting="MobileDetailsView_ItemDeleting">
                            <Fields>
                                <%--<asp:BoundField DataField="MobileID" HeaderText="Mobile ID" ReadOnly="True" />--%>
                                <asp:TemplateField HeaderText="Mobile ID">
                                    <ItemTemplate>
                                        <%# Eval("MobileId") %>
                                    </ItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox ID="NewMobileIdTextBox" runat="server" Text='<%# Bind("MobileId") %>' CssClass="form-control" />
                                    </InsertItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Title">
                                    <ItemTemplate>
                                        <%# Eval("Title") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' CssClass="form-control" />
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox ID="NewTitleTextBox" runat="server" Text='<%# Bind("Title") %>' CssClass="form-control" />
                                    </InsertItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Brand">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="BrandDropDownList" runat="server" DataSourceID="BrandDropDownSqlDataSource"
                                            DataTextField="BrandName" DataValueField="BrandId" SelectedValue='<%# Bind("BrandId") %>'
                                            CssClass="form-control" Enabled="False">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="BrandDropDownList" runat="server" DataSourceID="BrandDropDownSqlDataSource"
                                            DataTextField="BrandName" DataValueField="BrandId" SelectedValue='<%# Bind("BrandId") %>'
                                            CssClass="form-control">
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:DropDownList ID="BrandDropDownList" runat="server" DataSourceID="BrandDropDownSqlDataSource"
                                            DataTextField="BrandName" DataValueField="BrandId" SelectedValue='<%# Bind("BrandId") %>' CssClass="form-control">
                                        </asp:DropDownList>
                                    </InsertItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Description">
                                    <ItemTemplate>
                                        <%# Eval("Description") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' CssClass="form-control" />
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox ID="NewDescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' CssClass="form-control" />
                                    </InsertItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Price">
                                    <ItemTemplate>
                                        <%# Eval("Price", "{0:C}") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="PriceTextBox" runat="server" Text='<%# Bind("Price") %>' CssClass="form-control" />
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox ID="NewPriceTextBox" runat="server" Text='<%# Bind("Price") %>' CssClass="form-control" />
                                    </InsertItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Image">
                                    <ItemTemplate>
                                        <%# Eval("Image") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="ImageTextBox" runat="server" Text='<%# Bind("Image") %>' CssClass="form-control" />
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox ID="NewImageTextBox" runat="server" Text='<%# Bind("Image") %>' CssClass="form-control" />
                                    </InsertItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit"
                                            CssClass="btn btn-outline-secondary btn-sm" />
                                        <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete"
                                            CssClass="btn btn-outline-danger btn-sm" />
                                        <asp:Button ID="UpdateButton" runat="server" CommandName="New" Text="New"
                                            CssClass="btn btn-outline-success btn-sm" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update"
                                            CssClass="btn btn-success btn-sm" />
                                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel"
                                            CssClass="btn btn-secondary btn-sm" />
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert"
                                            CssClass="btn btn-primary btn-sm" />
                                        <asp:Button ID="CancelInsertButton" runat="server" CommandName="Cancel" Text="Cancel"
                                            CssClass="btn btn-secondary btn-sm" />
                                    </InsertItemTemplate>
                                </asp:TemplateField>
                            </Fields>
                        </asp:DetailsView>
                    </div>
                </div>
            </div>

            <asp:SqlDataSource ID="MobilesSqlDataSource" runat="server"
                ConnectionString="<%$ ConnectionStrings:TechBuyConnectionString %>"
                SelectCommand="SELECT b.MobileID, b.Title, g.BrandName FROM Mobiles b JOIN Brands g ON b.BrandId = g.BrandId"
                DeleteCommand="DELETE FROM Mobiles WHERE MobileID = @MobileID">
                <DeleteParameters>
                    <asp:Parameter Name="MobileID" Type="String" />
                </DeleteParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="MobileDetailsSqlDataSource" runat="server"
                ConnectionString="<%$ ConnectionStrings:TechBuyConnectionString %>"
                SelectCommand="SELECT * FROM Mobiles WHERE MobileID = @MobileID"
                UpdateCommand="UPDATE Mobiles SET Title = @Title, BrandId = @BrandId, Description = @Description, Price = @Price, Image = @Image WHERE MobileID = @MobileID"
                InsertCommand="INSERT INTO Mobiles (MobileID, Title, BrandId, Description, Price, Image) VALUES (@MobileID, @Title, @BrandId, @Description, @Price, @Image)"
                DeleteCommand="DELETE FROM Mobiles WHERE MobileID = @MobileID">
                <SelectParameters>
                    <asp:QueryStringParameter Name="MobileID" QueryStringField="MobileID" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Title" Type="String" />
                    <asp:Parameter Name="BrandId" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="Price" Type="Decimal" />
                    <asp:Parameter Name="Image" Type="String" />
                    <asp:Parameter Name="MobileID" Type="String" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="MobileID" Type="String" />
                    <asp:Parameter Name="Title" Type="String" />
                    <asp:Parameter Name="BrandId" Type="String" />
                    <asp:Parameter Name="Description" Type="String" />
                    <asp:Parameter Name="Price" Type="Decimal" />
                    <asp:Parameter Name="Image" Type="String" />
                </InsertParameters>
                <DeleteParameters>
                    <asp:Parameter Name="MobileID" Type="String" />
                </DeleteParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="BrandDropDownSqlDataSource" runat="server"
                ConnectionString="<%$ ConnectionStrings:TechBuyConnectionString %>"
                SelectCommand="SELECT BrandId, BrandName FROM Brands"></asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
