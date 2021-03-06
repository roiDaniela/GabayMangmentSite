﻿	<%@ Page Title="Synagoges" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" 
         CodeBehind="Synagoges.aspx.cs" Inherits="GabayManageSite.Synagoges" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %> 
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server" >
    <section>
        <div>
            <hgroup>
                <h2><%: Page.Title %></h2>
            </hgroup>               
        
            <br />            

            <section id="AddSynForm">
                <div class="form-horizontal">
                    <h4>Add new synagoge</h4>
                    <hr />

                    <table border="0">
                        <tr>
                            <td>
                                <dl class="dl-horizontal">
                                    <dt>
                                        <asp:Button ID="UpdateBtn" runat="server" Text="Update" OnClick="UpdateBtn_Click" />
                                    </dt>
                                    <dd></dd>
                                </dl>
                            </td>

                            <td>
                                <dl class="dl-horizontal">
                                    <dt>Name:</dt>
                                    <dd>    
                                        <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtenderSynName" runat="server" TargetControlID="NameToAdd" FilterType="Custom"/>
                                        <asp:TextBox ID="NameToAdd" runat="server" Width="120px" CssClass="form-control"/>
                                        <asp:RequiredFieldValidator runat="server" Visible="false" ControlToValidate="NameToAdd" CssClass="text-danger" ErrorMessage="The name field is required." />
                                    </dd>
                                </dl>
                            </td>

                            <td>
                                <dl class="dl-horizontal">
                                    <dt>Password:</dt>
                                    <dd>    
                                        <asp:TextBox runat="server" Width="120px" ID="PasswordToAdd" TextMode="Password" CssClass="form-control" />
                                        <asp:RequiredFieldValidator runat="server" Visible="false" ControlToValidate="PasswordToAdd" CssClass="text-danger" ErrorMessage="The password field is required." />
                                    </dd>
                                </dl>
                            </td>

                            <td >
                                <dl class="dl-horizontal">
                                    <dt>City:</dt>
                                    <dd>    
                                        <asp:DropDownList Width="120px" ID="DropDownListName" CssClass="form-control" runat="server" DataSourceID="SqlDataSourceSynCity" DataTextField="Name" DataValueField="Id" Font-Size="Medium" AppendDataBoundItems="true"/>
                                        <asp:SqlDataSource ID="SqlDataSourceSynCity" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="select id, name from city"/>                            
                                        <asp:RequiredFieldValidator runat="server" Visible="false" ControlToValidate="CityToAdd" CssClass="text-danger" ErrorMessage="The city field is required." />
                                    </dd>                            
                                </dl>
                            </td>
                        </tr>
                    </table>
                </div>
            </section>

            <section id="ShowSynForm">
                <div class="form-horizontal">
                    <h4>Show all synagoges</h4>
                    <hr />
                    <asp:GridView ShowHeader="true" DataSourceID="SqlDataSource1" ID="SynagogesList" runat="server" AutoGenerateColumns="False" ShowFooter="True" GridLines="Vertical" CellPadding="4"
                        CssClass="table table-striped table-bordered">   
                        <Columns>
                        <asp:TemplateField ItemStyle-Width="120px" HeaderText="Id">            
                                <ItemTemplate>
                                <asp:Label ID="Id" runat="server" Text='<%# Eval("Id") %>' Width="120px"/>
                                </ItemTemplate>        
                        </asp:TemplateField>               
                        <asp:TemplateField ItemStyle-Width="120px" HeaderText="Name">            
                                <ItemTemplate>
                                <asp:Label ID="Name" runat="server" Text='<%# Eval("Name") %>' Width="120px"/>
                                </ItemTemplate>        
                        </asp:TemplateField>    
                        <asp:TemplateField ItemStyle-Width="120px" HeaderText="City">            
                                <ItemTemplate>
                                    <asp:Label ID="city" runat="server" Text='<%# Eval("City") %>' Width="120px" Visible="true"/>
                                </ItemTemplate>        
                        </asp:TemplateField>
                        </Columns>    
                    </asp:GridView>

                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="select s.id, s.name, s.password, c.name as city from [synagoge] s, city c where c.id = s.city"></asp:SqlDataSource>
                </div>
            </section>
        </div>
    </section>
</asp:Content>