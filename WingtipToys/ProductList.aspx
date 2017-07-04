	<%@ Page Title="Products" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" 
         CodeBehind="ProductList.aspx.cs" Inherits="WingtipToys.ProductList" %>
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
                    <asp:TableHeaderCell Text="Private Name" Width="120px"/>
                    <asp:TableHeaderCell Text="Family Name" Width="120px"/>
                    <asp:TableHeaderCell Text="Birthday" Width="120px"/>
                    <asp:TableHeaderCell Text="Parashat BarMitzva" Width="120px"/>
                    <asp:TableHeaderCell Text="Cohen\Levi\Israel" Width="120px"/>
                    <asp:TableHeaderCell Text="Yourtzeit Father" Width="120px"/>
                    <asp:TableHeaderCell Text="Yourtzeit Mother" Width="120px"/>
                    <asp:TableHeaderCell Text="Remove Item" Width="50px"/>
                </asp:TableHeaderRow>
                <asp:TableRow>
                    <asp:TableCell Width="120px">
                            <asp:TextBox ID="IdToAdd" runat="server" Width="120px"/>
                            <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtenderid1" runat="server" TargetControlID="IdToAdd" FilterType="numbers" />
                    </asp:TableCell>
                    <asp:TableCell Width="120px">
                            <asp:TextBox ID="Private_NameToAdd" runat="server" Width="120px"/>
                            <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtenderfamily1" runat="server" TargetControlID="Private_NameToAdd" FilterType="UppercaseLetters" />
                    </asp:TableCell>
                    <asp:TableCell Width="120px">
                            <asp:TextBox ID="Family_NameToAdd" runat="server" Width="120px"/>
                            <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" runat="server" TargetControlID="Family_NameToAdd" FilterType="UppercaseLetters" />
                    </asp:TableCell>
                    <asp:TableCell Width="120px">
                        <asp:TextBox ID ="birthdayToAdd" runat="server" Width="120px"/>
                    </asp:TableCell>
                    <asp:TableCell>
                            <asp:TextBox ID="Parashat_Bar_Mitzva_IdToAdd" runat="server" Width="120px" />
                    </asp:TableCell>
                    <asp:TableCell Width="120px">
                            <asp:TextBox ID="Title_idToAdd" runat="server" Width="120px" />
                    </asp:TableCell>
                    <asp:TableCell Width="120px">
                            <asp:TextBox ID="Yourtziet_FatherLabelToAdd" runat="server" Width="120px" />
                    </asp:TableCell>
                    <asp:TableCell Width="120px">
                            <asp:TextBox ID="Yourtziet_MotherLabelToAdd" runat="server" Width="120px" />
                    </asp:TableCell>
                    <asp:TableCell Width="50px">
                            <asp:CheckBox id="DisabledCheckbox" runat="server" Enabled="false" Width="50px"/>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            
            <asp:GridView ShowHeader="False" DataSourceID="SqlDataSource1" ID="PrayersList" runat="server" AutoGenerateColumns="False" ShowFooter="True" GridLines="Vertical" CellPadding="4"
                CssClass="table table-striped table-bordered">   
                <Columns>
                <asp:TemplateField ItemStyle-Width="120px">            
                        <ItemTemplate>
                        <a href="/PrayerDetails.aspx?PrayerID=<%# Eval("Id") %>">               
                        <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' Width="120px"/>
                        </a>
                        <%--<asp:TextBox ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                        <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtenderId" runat="server" TargetControlID="IdLabel" FilterType="numbers" /> --%>
                </ItemTemplate>        
                </asp:TemplateField>               
                <asp:TemplateField ItemStyle-Width="120px">            
                        <ItemTemplate>
                        <asp:Label ID="Private_NameLabel" runat="server" Text='<%# Eval("Private_Name") %>' Width="120px"/>
                        <%--<asp:TextBox ID="Private_NameLabel" runat="server" Text='<%# Eval("Private_Name") %>' />
                        <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" TargetControlID="Private_NameLabel" FilterType="UppercaseLetters" /> --%>
                        </ItemTemplate>        
                </asp:TemplateField>    
                <asp:TemplateField ItemStyle-Width="120px">            
                        <ItemTemplate>
                            <asp:Label ID="Family_NameLabel" runat="server" Text='<%# Eval("Family_Name") %>' Width="120px"/>
                            <%-- <asp:TextBox ID="Family_NameLabel" runat="server" Text='<%# Eval("Family_Name") %>' />
                            <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" TargetControlID="Family_NameLabel" FilterType="UppercaseLetters" />--%>
                        </ItemTemplate>        
                </asp:TemplateField>
                <asp:TemplateField ItemStyle-Width="120px">
                    <ItemTemplate>
                        <asp:Label ID="BirthdayLabel" runat="server" Text='<%# Eval("Birthday") %>' Width="120px"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ItemStyle-Width="120px">            
                        <ItemTemplate>
                            <asp:Label ID="ParashaLabel" runat="server" Text='<%# Eval("Parasha") %>' Width="120px"/>
                            <%--<asp:Label ID="Parashat_Bar_Mitzva_IdLabel" runat="server" Text='<%# Eval("Parashat_Bar_Mitzva_Id") %>' Width="120px"/> %>
                            <%--<asp:TextBox ID="BirthdayLabel" runat="server" Text='<%# Eval("Birthday") %>' />
                            <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" TargetControlID="Family_NameLabel" FilterType="UppercaseLetters" /> --%>
                </ItemTemplate>                        
                </asp:TemplateField>
                <asp:TemplateField ItemStyle-Width="120px">
                    <ItemTemplate>
                            <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' Width="120px"/>
                        <%--<asp:Label ID="Title_idLabel" runat="server" Text='<%# Eval("Title_id") %>' Width="120px"/>--%>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ItemStyle-Width="120px">
                    <ItemTemplate>
                        <asp:Label ID="Yourtziet_FatherLabel" runat="server" Text='<%# Eval("Yourtziet_Father") %>' Width="120px"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ItemStyle-Width="120px">
                    <ItemTemplate>
                        <asp:Label ID="Yourtziet_MotherLabel" runat="server" Text='<%# Eval("Yourtziet_Mother") %>' Width="120px"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ItemStyle-Width="50px">            
                        <ItemTemplate>
                            <asp:CheckBox id="Remove" runat="server" Width="50px"/>
                        </ItemTemplate>        
                </asp:TemplateField>    
                </Columns>    
            </asp:GridView>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="SELECT py.Id, py.Private_Name, py.Family_Name, CONVERT(VARCHAR(11),py.Birthday,106) as Birthday, Pr.Name as Parasha, py.Yourtziet_Father, py.Yourtziet_Mother, t.Title_Name as title FROM [Prayers] py, [Parahot] pr, [Title] t where t.Id = py.Title_id and pr.Id = py.Parashat_Bar_Mitzva_Id"></asp:SqlDataSource>
            
            <asp:ListView ID="productList" runat="server" 
                DataKeyNames="ProductID" GroupItemCount="4"
                ItemType="WingtipToys.Models.Product" SelectMethod="GetProducts">
                <EmptyDataTemplate>
                    <table >
                        <tr>
                            <td>No data was returned.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <EmptyItemTemplate>
                    <td/>
                </EmptyItemTemplate>
                <GroupTemplate>
                    <tr id="itemPlaceholderContainer" runat="server">
                        <td id="itemPlaceholder" runat="server"></td>
                    </tr>
                </GroupTemplate>
                <ItemTemplate>
                    <td runat="server">
                        <table>
                            <tr>
                                <td>
                                  <a href="<%#: GetRouteUrl("ProductByNameRoute", new {productName = Item.ProductName}) %>">
                                    <image src='/Catalog/Images/Thumbs/<%#:Item.ImagePath%>'
                                      width="100" height="75" border="1" />
                                  </a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <a href="<%#: GetRouteUrl("ProductByNameRoute", new {productName = Item.ProductName}) %>">
                                      <%#:Item.ProductName%>
                                    </a>
                                    <br />
                                    <span>
                                        <b>Price: </b><%#:String.Format("{0:c}", Item.UnitPrice)%>
                                    </span>
                                    <br />
                                    <a href="/AddToCart.aspx?productID=<%#:Item.ProductID %>">               
                                        <span class="ProductListItem">
                                            <b>Add To Cart<b>
                                        </span>           
                                    </a>
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                        </p>
                    </td>
                </ItemTemplate>
                <LayoutTemplate>
                    <table style="width:100%;">
                        <tbody>
                            <tr>
                                <td>
                                    <table id="groupPlaceholderContainer" runat="server" style="width:100%">
                                        <tr id="groupPlaceholder"></tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                            </tr>
                            <tr></tr>
                        </tbody>
                    </table>
                </LayoutTemplate>
            </asp:ListView>
        </div>
    </section>
</asp:Content>