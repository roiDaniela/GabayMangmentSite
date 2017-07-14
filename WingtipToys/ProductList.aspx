	<%@ Page Title="Prayers" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" 
         CodeBehind="ProductList.aspx.cs" Inherits="GabayManageSite.ProductList" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %> 
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server" >
    <section>
        <div>
            <hgroup>
                <% if (Session["currSynId"] == null || String.IsNullOrEmpty(Session["currSynId"].ToString())){ %>            
                    <h2><%: Page.Title %></h2>
                <% } else { %>            
                    <h2><%: Page.Title %> of "<%:Session["currSynName"] %>" shool</h2>
                <% } %>
            </hgroup>               
        
            <br />
            
            <% if (Session["currSynId"] == null || String.IsNullOrEmpty(Session["currSynId"].ToString())){ %>            
                    <asp:LoginView runat="server" ViewStateMode="Disabled">
                    <AnonymousTemplate>
                        <p>You have to <a runat="server" href="~/Account/Login">log in</a> first</p>  
                    </AnonymousTemplate>
                    <LoggedInTemplate>
                        <p>Hello <%: Context.User.Identity.GetUserName()  %> <a runat="server" href="~/Account/Manage" title="Manage your account"> please select your synagoge</a></p>  
                    </LoggedInTemplate>
                    </asp:LoginView>                
            <% } %>

            <% if (Session["currSynId"] != null && !String.IsNullOrEmpty(Session["currSynId"].ToString())){ %>
            <table>
                <tr>
                    <td>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="IdToAdd" CssClass="text-danger" ValidationGroup="addGroup" ErrorMessage="Id is required." />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Family_NameToAdd" CssClass="text-danger" ValidationGroup="addGroup" ErrorMessage="Family name is required." />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Private_NameToAdd" CssClass="text-danger" ValidationGroup="addGroup" ErrorMessage="Private name is required." />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="UpdateBtn" runat="server" Text="Add" ValidationGroup="addGroup" OnClick="UpdateBtn_Click" />
                    </td>
                    <td>
                        <asp:Button ID="DeleteBtn" runat="server" Text="Delete" OnClick="DeleteBtn_Click"/>
                    </td>
                    <td>
                        <asp:Button ID="EndSessionBtn" runat="server" Text="EndSession" OnClick="EndSessionBtn_Click"/>
                    </td>
                </tr>
            </table>

            <asp:Table ID="Table1" runat="server" GridLines="Vertical" CellPadding="4" CssClass="table table-striped table-bordered">
                <asp:TableRow>
                    <asp:TableCell Width="80px">
                            <asp:Label ID="Label5" runat="server" Width="80px" Text="Id" Font-Bold="true"/>
                    </asp:TableCell>
                    <asp:TableCell Width="80px">
                            <asp:Label ID="Label4" runat="server" Width="80px" Text="Private Name" Font-Bold="true"/>
                    </asp:TableCell>
                    <asp:TableCell Width="80px">
                            <asp:Label ID="Label3" runat="server" Width="80px" Text="Family Name" Font-Bold="true"/>
                    </asp:TableCell>
                    <asp:TableCell Width="120px">
                            <asp:Label ID="Label2" runat="server" Width="120px" Text="Birthday" Font-Bold="true"/>
                    </asp:TableCell>
                    <asp:TableCell Width="80px">
                            <asp:Label ID="Label1" runat="server" Width="80px" Text="Parasha" Font-Bold="true"/>
                    </asp:TableCell> 
                    <asp:TableCell Width="80px">
                            <asp:Label ID="Label6" runat="server" Width="80px" Text="Title" Font-Bold="true"/>
                    </asp:TableCell> 
                    <asp:TableCell Width="120px">
                            <asp:Label ID="DropDownList2" runat="server" Width="120px" Text="Yourtziet father" Font-Bold="true"/>
                    </asp:TableCell>
                    <asp:TableCell Width="120px">
                            <asp:Label ID="TextBox5" runat="server" Width="120px" Text="Yourtziet mother" Font-Bold="true"/>
                    </asp:TableCell>
                    <asp:TableCell Width="35px">
                            <asp:Label id="CheckBox1" runat="server" Width="35px" Text="Read Maftir?" Font-Bold="true" Font-Size="X-Small"/>
                    </asp:TableCell>
                    <asp:TableCell Width="80px">
                            <asp:Label ID="TextBox7" runat="server" Width="80px" Text="Phone" Font-Bold="true"/>
                    </asp:TableCell>
                    <asp:TableCell Width="80px">
                            <asp:Label ID="TextBox8" runat="server" Width="80px" Text="Email" Font-Bold="true"/>
                    </asp:TableCell>
                    <asp:TableCell Width="35px">
                            <asp:Label id="RemoveHeader" runat="server" Width="35px" Text="Remove Item?" Font-Bold="true" Font-Size="X-Small"/>
                    </asp:TableCell>
                </asp:TableRow>

                <asp:TableRow>
                    <asp:TableCell Width="80px">
                            <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtenderSynName" runat="server" TargetControlID="IdToAdd" FilterType="Numbers"/>
                            <asp:TextBox ID="IdToAdd" MaxLength="9" runat="server" Width="80px" ValidationGroup="addGroup" CssClass="form-control" Font-Size="X-Small" ToolTip="numbers only"/>                            
                    </asp:TableCell>
                    <asp:TableCell Width="80px">                            
                            <asp:TextBox ID="Private_NameToAdd" runat="server" Width="80px" ValidationGroup="addGroup" CssClass="form-control"  Font-Size="X-Small"/>
                            <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtenderPrivateName" runat="server" TargetControlID="Private_NameToAdd" FilterType="Custom"/>
                    </asp:TableCell>
                    <asp:TableCell Width="80px">
                            <asp:TextBox ID="Family_NameToAdd" runat="server" Width="80px" ValidationGroup="addGroup" CssClass="form-control"  Font-Size="X-Small"/>
                            <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtenderFamilyName" runat="server" TargetControlID="Family_NameToAdd" FilterType="Custom"/>                            
                    </asp:TableCell>
                    <asp:TableCell Width="120px">
                        <asp:TextBox ID ="birthdayToAdd" runat="server" Width="120px" TextMode="Date" CssClass="form-control" Font-Size="X-Small"/>                        
                    </asp:TableCell>
                    <asp:TableCell>
                            <asp:DropDownList ID="DropDownListParashaToAdd" Width="80px" CssClass="form-control" runat="server" DataSourceID="DataSourceParashot" DataTextField="Name" DataValueField="Id" Font-Size="X-Small"/>
                            <asp:SqlDataSource ID="DataSourceParashot" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="select nameHe as name, id from parashot where tora_order is not null order by tora_order"/>
                    </asp:TableCell> 
                    <asp:TableCell Width="80px">
                            <asp:DropDownList ID="DropDownTitleToAdd" Width="80px" CssClass="form-control" runat="server" DataSourceID="DataSourceTitle" DataTextField="Name" DataValueField="Id"  Font-Size="X-Small"/>
                            <asp:SqlDataSource ID="DataSourceTitle" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="SELECT * from [title]"/>
                    </asp:TableCell>
                    <asp:TableCell Width="120px">
                            <asp:TextBox ID="Yourtziet_FatherTextToAdd" runat="server" Width="120px" TextMode="Date" CssClass="form-control" Font-Size="X-Small"/>
                    </asp:TableCell>
                    <asp:TableCell Width="120px">
                            <asp:TextBox ID="Yourtziet_MotherTextToAdd" runat="server" Width="120px" TextMode="Date" CssClass="form-control" Font-Size="X-Small"/>
                    </asp:TableCell>
                    <asp:TableCell Width="35px">
                            <asp:CheckBox id="isReadingMaftirToAdd" runat="server" Enabled="true" Width="35px" Checked="true"/>
                    </asp:TableCell>
                    <asp:TableCell Width="80px">
                            <asp:TextBox ID="PhoneToAdd" runat="server" Width="80px" TextMode="Phone" MaxLength="12" CssClass="form-control"  Font-Size="X-Small"/>
                    </asp:TableCell>
                    <asp:TableCell Width="120px">
                            <asp:TextBox ID="EmailToAdd" runat="server" Width="120px" TextMode="Email" CssClass="form-control"  Font-Size="X-Small"/>
                    </asp:TableCell>
                    <asp:TableCell Width="35px">
                            <asp:CheckBox id="DisabledCheckbox" runat="server" Enabled="false" Width="35px"/>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table> 
            
            <asp:GridView ShowHeader="False" DataSourceID="SqlDataSource1" ID="PrayersGridView" runat="server" AutoGenerateColumns="False" ShowFooter="True" GridLines="Vertical" CellPadding="4"
                CssClass="table table-striped table-bordered">   
                <Columns>
                <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px">            
                        <ItemTemplate>
                        <a href="/PrayerDetails.aspx?PrayerID=<%# Eval("Id") %>">               
                        <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' Width="80px"/>
                        </a>
                </ItemTemplate>        
                </asp:TemplateField>               
                <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px">            
                        <ItemTemplate>
                        <asp:Label ID="Private_NameLabel" runat="server" Text='<%# Eval("Private_Name") %>' Width="80px"/>
                        </ItemTemplate>        
                </asp:TemplateField>    
                <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px">            
                        <ItemTemplate>
                            <asp:Label ID="Family_NameLabel" runat="server" Text='<%# Eval("Family_Name") %>' Width="80px"/>
                        </ItemTemplate>        
                </asp:TemplateField>
                <asp:TemplateField ItemStyle-Width="120px" ControlStyle-Width="120px">
                    <ItemTemplate>
                        <asp:Label ID="BirthdayLabel" runat="server" Text='<%# Eval("Birthday") %>' Width="120px"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px">            
                        <ItemTemplate>
                            <asp:Label ID="ParashaLabel" runat="server" Text='<%# Eval("Parasha") %>' Width="80px"/>
                </ItemTemplate>                        
                </asp:TemplateField>
                <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px">
                    <ItemTemplate>
                            <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' Width="80px"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ItemStyle-Width="120px" ControlStyle-Width="120px">
                    <ItemTemplate>
                        <asp:Label ID="Yourtziet_FatherLabel" runat="server" Text='<%# Eval("Yourtziet_Father") %>' Width="120px"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ItemStyle-Width="120px" ControlStyle-Width="120px">
                    <ItemTemplate>
                        <asp:Label ID="Yourtziet_MotherLabel" runat="server" Text='<%# Eval("Yourtziet_Mother") %>' Width="120px"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ItemStyle-Width="35px" ControlStyle-Width="35px">
                    <ItemTemplate>
                        <asp:CheckBox id="CheckBoxIsReadingMaftir" runat="server" Checked=<%# "true" == Eval("is_reading_maftir")%> Enabled="false" Width="35px"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px">
                    <ItemTemplate>
                        <asp:Label ID="PhoneLabel" runat="server" Text='<%# Eval("phone") %>' Width="80px"/>
                    </ItemTemplate>
                </asp:TemplateField>                    
                <asp:TemplateField ItemStyle-Width="120px" ControlStyle-Width="120px">
                    <ItemTemplate>
                        <asp:Label ID="EmailLabel" runat="server" Font-Size="X-Small" Text='<%# Eval("email") %>' Width="120px"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ItemStyle-Width="35px" ControlStyle-Width="35px">            
                        <ItemTemplate>
                            <asp:CheckBox id="Remove" runat="server" Width="35px" Checked="false"/>
                        </ItemTemplate>        
                </asp:TemplateField>    
                </Columns>    
            </asp:GridView>
            <% } %>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="SELECT py.Id, py.Private_Name, py.Family_Name, CAST(CASE WHEN CONVERT(VARCHAR(10),py.Birthday,110) is not null THEN CONVERT(VARCHAR(10),py.Birthday,110) ELSE '' END AS Text) as Birthday, Pr.Name as Parasha, CAST(CASE WHEN CONVERT(VARCHAR(10),py.Yourtziet_Father,110) is not null THEN CONVERT(VARCHAR(10),py.Yourtziet_Father,110) ELSE '' END AS Text) as Yourtziet_Father, CAST(CASE WHEN CONVERT(VARCHAR(10),py.Yourtziet_Mother,110) is not null THEN CONVERT(VARCHAR(10),py.Yourtziet_Mother,110) ELSE '' END AS Text) Yourtziet_Mother, t.Name as title, Cast(CASE WHEN py.Is_Reading_Maftir = '1' THEN 'true'  else 'false' end as varchar(50))  as Is_Reading_Maftir, cast(case when py.email is null then '' else py.email end as text) as email, cast(case when py.phone is null then '' else py.phone end as text) as phone FROM [Prayers] py, [Pray2Syn] ps, (select nameHe as name, id from parashot where tora_order is not null) pr, [Title] t where t.Id = py.Title_id and pr.Id = py.Parashat_Bar_Mitzva_Id and ps.prayer_id = py.id and ps.syn_id = @sid">
                <SelectParameters>
                </SelectParameters>
        </asp:SqlDataSource>
            
            <%--<asp:ListView ID="productList" runat="server" 
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
            </asp:ListView> --%>
        </div>
    </section>
</asp:Content>