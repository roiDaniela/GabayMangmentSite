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
                        <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-4 control-label">Email</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                                CssClass="text-danger" ErrorMessage="The email field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-4 control-label">Password</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                                CssClass="text-danger" ErrorMessage="The password field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-4 control-label">Confirm password</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                                CssClass="text-danger" Display="Dynamic" ErrorMessage="The confirm password field is required." />
                            <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                                CssClass="text-danger" Display="Dynamic" ErrorMessage="The password and confirmation password do not match." />
                        </div>
                    </div>

                    <div class="form-group" runat="server">
                        <asp:Label runat="server" AssociatedControlID="DropDownListName" CssClass="col-md-4 control-label">Select your synagoge city</asp:Label>
                        <div class="col-md-10">
                            <asp:DropDownList Width="280px" AutoPostBack="true" ID="DropDownListName" CssClass="form-control" runat="server" DataSourceID="SqlDataSourceSynCity" DataTextField="Name" DataValueField="Id" Font-Size="Medium" OnSelectedIndexChanged="DropDownListName_SelectedIndexChanged" OnDataBound="DropDownListName_SelectedIndexChanged" OnTextChanged="DropDownListName_SelectedIndexChanged" OnLoad="DropDownListName_SelectedIndexChanged" OnDataBinding="DropDownListName_SelectedIndexChanged" AppendDataBoundItems="true"/>
                            <asp:SqlDataSource ID="SqlDataSourceSynCity" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="select distinct city.id, city.name from synagoge s, city where city.id = s.city"/>
                        
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="DropDownListName"
                                CssClass="text-danger" Display="Dynamic" ErrorMessage="The city field is required." />
                        </div>
                    </div>

                    
                    <div class="form-group" runat="server">
                        <asp:Label runat="server" id="synNameLabel" Visible="false" AssociatedControlID="DropDownListSyn" CssClass="col-md-4 control-label">Select your synagoge name</asp:Label>
                        <div class="col-md-10">
                            <asp:DropDownList Width="280px" Visible="false" AutoPostBack="true" ID="DropDownListSyn" CssClass="form-control" runat="server" DataSourceID="SqlDataSourceSynName" DataTextField="Name" DataValueField="Id" Font-Size="Medium"/>
                            <asp:SqlDataSource ID="SqlDataSourceSynName" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="select id, name from synagoge where city = @city">
                                <SelectParameters>
                                </SelectParameters>
                            </asp:SqlDataSource>
                        
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="DropDownListSyn"
                                CssClass="text-danger" Display="Dynamic" ErrorMessage="The synagoge name field is required." />
                        </div>
                    </div> 

                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="SynPassword" CssClass="col-md-4 control-label">Synagoge Password</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="SynPassword" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                                CssClass="text-danger" ErrorMessage="The synagoge password field is required." />
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
