<%@ Page Title="Manage Account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="WingtipToys.Account.Manage" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    
    <h2><%: Title %>.</h2>

    <div>
        <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
            <p class="text-success"><%: SuccessMessage %></p>
        </asp:PlaceHolder>
    </div>

    <div class="row">
        <div class="col-md-12">
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
            <%--
            <section id="synahoges">
                <div class="form-horizontal">
                    <asp:SqlDataSource ID="SqlDataSourceSynNotInMyAcount" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="select s1.Id as Id, s1.Name as Name from [synagoge] s1 where s1.id not in (select s.Id from [synagoge] s, [Mail2Syn] m where m.Email = @email and m.Synagoge_Id = s.Id)">
                        <SelectParameters>
                            <asp:Parameter Name="email" Type="Int32" DefaultValue="<%= Email %>" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <h4>Add Synagoge to your acount</h4>
                    <asp:Table ID="Table1" runat="server" AutoGenerateColumns="False" ShowFooter="True" GridLines="Vertical" CellPadding="4" CssClass="table table-striped table-bordered">
                        <asp:TableHeaderRow>
                            <asp:TableHeaderCell Text="Synagoge Name" Width="120px"/>
                            <asp:TableHeaderCell Text="Synagoge Password" Width="120px"/>
                        </asp:TableHeaderRow>
                        <asp:TableRow>
                            <asp:TableCell Width="120px">
                                <div class="col-md-10">
                                    <asp:DropDownList ID="Synagoge" Width="280px" CssClass="form-control" runat="server" DataSourceID="SqlDataSourceSynNotInMyAcount" DataTextField="Name" DataValueField="Id"/>
                                </div>
                            </asp:TableCell>
                            <asp:TableCell Width="120px">
                                    <asp:TextBox runat="server" ID="synPassword" TextMode="Password" CssClass="form-control" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="synPassword"
                                        CssClass="text-danger" ErrorMessage="The Synagoge password field is required." />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </div>
            </section>
         --%>
        </div>
    </div>

</asp:Content>
