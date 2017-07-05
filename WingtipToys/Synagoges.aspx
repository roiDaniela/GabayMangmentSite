	<%@ Page Title="Synagoges" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" 
         CodeBehind="Synagoges.aspx.cs" Inherits="GabayManageSite.Synagoges" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %> 
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server" >
    <section>
        <div>
            <hgroup>
                <h2><%: Page.Title %></h2>
            </hgroup>               
        
            <br />
            
            <table>
                <tr>
                <td>
                    <asp:Button ID="UpdateBtn" runat="server" Text="Update" OnClick="UpdateBtn_Click" />
                </td>
                </tr>
            </table>

            <asp:Table ID="Table1" runat="server" AutoGenerateColumns="False" ShowFooter="True" GridLines="Vertical" CellPadding="4" CssClass="table table-striped table-bordered">
                <asp:TableHeaderRow>
                    <asp:TableHeaderCell Text="Id" Width="120px"/>
                    <asp:TableHeaderCell Text="Name" Width="120px"/>
                    <asp:TableHeaderCell Text="Password" Width="120px"/>
                </asp:TableHeaderRow>
                <asp:TableRow>
                    <asp:TableCell Width="120px">
                            <asp:TextBox ID="IdToAdd" runat="server" Width="120px" Enabled="false" CssClass="form-control"/>
                    </asp:TableCell>
                    <asp:TableCell Width="120px">                            
                            <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtenderSynName" runat="server" TargetControlID="NameToAdd" FilterType="Custom"/>
                            <asp:TextBox ID="NameToAdd" runat="server" Width="120px" CssClass="form-control"/>
                            <asp:RequiredFieldValidator runat="server" Visible="false" ControlToValidate="NameToAdd" CssClass="text-danger" ErrorMessage="The name field is required." />
                    </asp:TableCell>
                    <asp:TableCell Width="120px">
                            <asp:TextBox runat="server" ID="PasswordToAdd" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" Visible="false" ControlToValidate="PasswordToAdd" CssClass="text-danger" ErrorMessage="The password field is required." />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            
            <asp:GridView ShowHeader="False" DataSourceID="SqlDataSource1" ID="SynagogesList" runat="server" AutoGenerateColumns="False" ShowFooter="True" GridLines="Vertical" CellPadding="4"
                CssClass="table table-striped table-bordered">   
                <Columns>
                <asp:TemplateField ItemStyle-Width="120px">            
                        <ItemTemplate>
                        <asp:Label ID="Id" runat="server" Text='<%# Eval("Id") %>' Width="120px"/>
                        </ItemTemplate>        
                </asp:TemplateField>               
                <asp:TemplateField ItemStyle-Width="120px">            
                        <ItemTemplate>
                        <asp:Label ID="Name" runat="server" Text='<%# Eval("Name") %>' Width="120px"/>
                        </ItemTemplate>        
                </asp:TemplateField>    
                <asp:TemplateField ItemStyle-Width="120px">            
                        <ItemTemplate>
                            <asp:Label ID="password" runat="server" Text='<%# Eval("Password") %>' Width="120px" Visible="false"/>
                        </ItemTemplate>        
                </asp:TemplateField>
                </Columns>    
            </asp:GridView>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="select * from [synagoge]"></asp:SqlDataSource>
            
        </div>
    </section>
</asp:Content>