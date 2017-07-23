<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="GabayManageSite.Account.Register" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %> 

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h2><%: Title %>.</h2>
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>

    <div class="row">
        <div class="col-md-8">
            <section id="RegisterForm">
                <div class="form-horizontal">
                    <h4>Create a new account</h4>
                    <hr />
                    <asp:ValidationSummary runat="server" CssClass="text-danger" />
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 control-label">Email</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                                CssClass="text-danger" ErrorMessage="The email field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Password</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                                CssClass="text-danger" ErrorMessage="The password field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 control-label">Confirm password</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                                CssClass="text-danger" Display="Dynamic" ErrorMessage="The confirm password field is required." />
                            <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                                CssClass="text-danger" Display="Dynamic" ErrorMessage="The password and confirmation password do not match." />
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="TextBoxSynCity" CssClass="col-md-2 control-label">Select your synagoge city</asp:Label>
                        <div class="col-md-10">
                            <asp:DropDownList AutoPostBack="true" ID="DropDownListName" runat="server" DataSourceID="SqlDataSourceName" DataTextField="Name" DataValueField="Id" Font-Size="X-Small" OnSelectedIndexChanged="DropDownListName_SelectedIndexChanged"/>
                            <asp:SqlDataSource ID="SqlDataSourceSynCity" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="select city from synagoge"/>
                        
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                                CssClass="text-danger" Display="Dynamic" ErrorMessage="The confirm password field is required." />
                            <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                                CssClass="text-danger" Display="Dynamic" ErrorMessage="The synagoge city field is required." />
                        </div>
                    </div>

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="DropDownListSyn" CssClass="col-md-2 control-label">Select your synagoge name</asp:Label>
                        <div class="col-md-10">
                            <asp:DropDownList AutoPostBack="true" ID="DropDownListSyn" Visible="false" runat="server" DataSourceID="SqlDataSourceName" DataTextField="Name" DataValueField="Id" Font-Size="X-Small"/>
                            <asp:SqlDataSource ID="SqlDataSourceSynName" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="select id, name from synagoge where city = @city">
                                <SelectParameters>
                                </SelectParameters>
                            </asp:SqlDataSource>
                        
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="DropDownListSyn"
                                CssClass="text-danger" Display="Dynamic" ErrorMessage="The synagoge name field is required." />
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <asp:Button runat="server" OnClick="CreateUser_Click" Text="Register" CssClass="btn btn-default" />
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
</asp:Content>
