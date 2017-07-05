<%@ Page Title="Manage Account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="GabayManageSite.Account.Manage" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    
    <h2><%: Title %>.</h2>

    <div>
        <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
            <p class="text-success"><%: SuccessMessage %></p>
        </asp:PlaceHolder>
    </div>

    <div class="row">
        <div class="col-md-6">
            <section id="ManageForm">
                <div class="form-horizontal">
                    <h4>Change your account settings</h4>
                    <hr />
                   
                    <dl class="dl-horizontal">
                        <dt>Password:</dt>
                        <dd>
                            <asp:HyperLink NavigateUrl="/Account/ManagePassword" Text="[Change]" Visible="false" ID="ChangePassword" runat="server" />
                            <asp:HyperLink NavigateUrl="/Account/ManagePassword" Text="[Create]" Visible="false" ID="CreatePassword" runat="server" />
                        </dd>
                         
                        <dt>Current Synagoge:</dt>
                        <dd>    
                            <asp:DropDownList ID="DropDownListCurrSyn" AutoPostBack="True" Width="280px" CssClass="form-control" runat="server" DataSourceID="DataSourceAvailbleSyn" DataTextField="Name" DataValueField="Id" OnSelectedIndexChanged="DropDownListCurrSyn_SelectedIndexChanged" OnLoad="DropDownListCurrSyn_SelectedIndexChanged" OnDataBinding="DropDownListCurrSyn_SelectedIndexChanged" AppendDataBoundItems="true" OnDataBound="DropDownListCurrSyn_SelectedIndexChanged"/>
                            <asp:SqlDataSource ID="DataSourceAvailbleSyn" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="SELECT s.Id, s.Name FROM Synagoge AS s INNER JOIN Mail2Syn AS m ON s.Id = m.Synagoge_Id WHERE (m.Email = @email)">
                                <SelectParameters>
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </dd>
                            
                    </dl>                              
                </div>
            </section>
        </div>
        
        <div class="col-md-4">
            <section id="AddSynToAcountForm">
                <div class="form-horizontal">
                    <h4>Add synagoge To your acount</h4>
                    <hr />
                   
                    <dl class="dl-horizontal">
                         
                        <dt>Choose Synagoge:</dt>
                        <dd>    
                            <asp:DropDownList ID="DropDownListNotAvailbleSyn" AutoPostBack="True" Width="280px" CssClass="form-control" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="Id"/>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="SELECT s.Id, s.Name FROM Synagoge AS s Left outer JOIN Mail2Syn AS m ON (s.Id = m.Synagoge_Id) where (@email !=  m.email or m.email is null)">
                                <SelectParameters>
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </dd>

                        <dt>Enter Synagoge Password:</dt>
                        <dd>    
                            <asp:TextBox runat="server" ID="SynPassword" TextMode="Password" CssClass="form-control" Width="280px"/>
                            <asp:RequiredFieldValidator Visible="false" runat="server" ControlToValidate="SynPassword" CssClass="text-danger" ErrorMessage="The password field is required." />
                        </dd>
                            
                        <dd>
                            <asp:Button runat="server" OnClick="AddSynagogeToUser" Text="Add" CssClass="btn btn-default" />
                        </dd>
                    </dl>                              
                </div>
            </section>
        </div>
    </div>

</asp:Content>
