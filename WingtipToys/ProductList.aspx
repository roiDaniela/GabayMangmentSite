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
                    <h2><%: Page.Title %> of "<%:Session["currSynName"] %>" shul</h2>
                <% } %>
            </hgroup>               
        
            <br />
            
            <% if (Session["currSynId"] == null || String.IsNullOrEmpty(Session["currSynId"].ToString())){ %>            
                    <asp:LoginView runat="server" ViewStateMode="Disabled">
                    <AnonymousTemplate>
                        <p>You have to <a runat="server" href="~/Account/Login">log in</a> first</p>  
                    </AnonymousTemplate>
                    <LoggedInTemplate>
                        <p>Hello <%: Context.User.Identity.GetUserName()  %> <a runat="server" href="~/Account/Manage" title="Manage your account" > please select your synagoge</a></p>  
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
                        <%-- <asp:Button ID="UpdateBtn" runat="server" Text="Add" ValidationGroup="addGroup" OnClick="UpdateBtn_Click" />--%>
                    </td>
                    <td>
                        <%--<asp:Button ID="DeleteBtn" runat="server" Text="Delete" OnClick="DeleteBtn_Click"/> --%>
                    </td>
                    <td>
                        <asp:Button ID="EndSessionBtn" runat="server" Visible="false" Text="EndSession" OnClick="EndSessionBtn_Click"/>
                    </td>
                </tr>
            </table>

            <section id="AddPrayerForm">
                <div class="form-horizontal">
                    <h4>Add new prayer</h4>
                    <hr />

                    <table border="0">
                        <tr>
                            <td>
                                <dl class="dl-horizontal">
                                    <dt>
                                        <asp:Button ID="UpdateBtn" Font-Bold="false" runat="server" Text="Add" ValidationGroup="addGroup" OnClick="UpdateBtn_Click" />                                    </dt>
                                    <dd></dd>
                                </dl>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dl class="dl-horizontal">
                                    <dt>Id:</dt>
                                    <dd>    
                                        <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtenderSynName" runat="server" TargetControlID="IdToAdd" FilterType="Numbers"/>
                                        <asp:TextBox ID="IdToAdd" MaxLength="9" runat="server" Width="120px" ValidationGroup="addGroup" CssClass="form-control" Font-Size="X-Small" ToolTip="numbers only"/>                            
                                    </dd>
                                </dl>
                            </td>

                            <td>
                                <dl class="dl-horizontal">
                                    <dt>Private Name:</dt>
                                    <dd>    
                                        <asp:TextBox ID="Private_NameToAdd" runat="server" Width="120px" ValidationGroup="addGroup" CssClass="form-control"  Font-Size="X-Small"/>
                                        <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtenderPrivateName" runat="server" TargetControlID="Private_NameToAdd" FilterType="Custom"/>
                                    </dd>
                                </dl>
                            </td>

                            <td >
                                <dl class="dl-horizontal">
                                    <dt>Family Name:</dt>
                                    <dd>    
                                        <asp:TextBox ID="Family_NameToAdd" runat="server" Width="120px" ValidationGroup="addGroup" CssClass="form-control"  Font-Size="X-Small"/>
                                        <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtenderFamilyName" runat="server" TargetControlID="Family_NameToAdd" FilterType="Custom"/>                            
                                    </dd>                            
                                </dl>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <dl class="dl-horizontal">
                                    <dt>Birthday</dt>
                                    <dd>
                                        <asp:TextBox ID ="birthdayToAdd" runat="server" Width="120px" TextMode="Date" CssClass="form-control" Font-Size="X-Small"/>                        
                                    </dd>
                                </dl>
                            </td>

                            <td>
                                <dl class="dl-horizontal">
                                    <dt>Title</dt>
                                    <dd>
                                        <asp:DropDownList ID="DropDownTitleToAdd" Width="120px" CssClass="form-control" runat="server" DataSourceID="DataSourceTitle" DataTextField="Name" DataValueField="Id"  Font-Size="X-Small"/>
                                        <asp:SqlDataSource ID="DataSourceTitle" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="SELECT * from [title]"/>
                                    </dd>
                                </dl>
                            </td>

                            <td>
                                <dl class="dl-horizontal">
                                    <dt>is Reading Maftir?</dt>
                                    <dd>
                                        <asp:CheckBox id="isReadingMaftirToAdd" runat="server" Enabled="true" Width="35px" Checked="true"/>
                                    </dd>
                                </dl>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <dl class="dl-horizontal">
                                    <dt>Phone</dt>
                                    <dd>
                                        <asp:TextBox ID="PhoneToAdd" runat="server" Width="120px" TextMode="Phone" MaxLength="12" CssClass="form-control"  Font-Size="X-Small"/>
                                    </dd>
                                </dl>
                            </td>

                            <td>
                                <dl class="dl-horizontal">
                                    <dt>Email</dt>
                                    <dd>
                                        <asp:TextBox ID="EmailToAdd" runat="server" Width="120px" TextMode="Email" CssClass="form-control"  Font-Size="X-Small"/>
                                    </dd>
                                </dl>
                            </td>

                            <td>
                                <dl class="dl-horizontal">
                                    <dt></dt>
                                    <dd>

                                    </dd>
                                </dl>
                            </td>
                        </tr>
                    </table>
                </div>
            </section>
            

            <section id="ShowAllForm">
                <div class="form-horizontal">
                    <h4>Show all prayers</h4>
                    <hr />

                    <asp:Button ID="DeleteBtn" runat="server" Text="Delete" OnClick="DeleteBtn_Click"/>
                    <br />

                <asp:GridView ShowHeader="true" DataSourceID="SqlDataSource1" ID="PrayersGridView" runat="server" AutoGenerateColumns="False" ShowFooter="True" GridLines="Vertical" CellPadding="4"
                    CssClass="table table-striped table-bordered">   
                    <Columns>
                    <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" HeaderText="Id">            
                            <ItemTemplate>
                            <%--<a href="/PrayerDetails.aspx?PrayerID=<%# Eval("Id") %>">--%>
                            <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' Width="80px"/>
                            <%--</a>--%>
                    </ItemTemplate>        
                    </asp:TemplateField>               
                    <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" HeaderText="Private Name">            
                            <ItemTemplate>
                            <asp:Label ID="Private_NameLabel" runat="server" Text='<%# Eval("Private_Name") %>' Width="80px"/>
                            </ItemTemplate>        
                    </asp:TemplateField>    
                    <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" HeaderText="Family Name">            
                            <ItemTemplate>
                                <asp:Label ID="Family_NameLabel" runat="server" Text='<%# Eval("Family_Name") %>' Width="80px"/>
                            </ItemTemplate>        
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-Width="120px" ControlStyle-Width="120px" HeaderText="Birthday">
                        <ItemTemplate>
                            <asp:Label ID="BirthdayLabel" runat="server" Text='<%# Eval("Birthday") %>' Width="120px"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" HeaderText="Title">
                        <ItemTemplate>
                                <asp:Label ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' Width="80px"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-Width="35px" ControlStyle-Width="35px" HeaderText="Maftir?">
                        <ItemTemplate>
                            <asp:CheckBox id="CheckBoxIsReadingMaftir" runat="server" Checked=<%# "true" == Eval("is_reading_maftir")%> Enabled="false" Width="35px"/>
                        </ItemTemplate>
                    </asp:TemplateField> 
                    <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" HeaderText="Phone">
                        <ItemTemplate>
                            <asp:Label ID="PhoneLabel" runat="server" Text='<%# Eval("phone") %>' Width="80px"/>
                        </ItemTemplate>
                    </asp:TemplateField>                    
                    <asp:TemplateField ItemStyle-Width="120px" ControlStyle-Width="120px" HeaderText="Email">
                        <ItemTemplate>
                            <asp:Label ID="EmailLabel" runat="server" Font-Size="X-Small" Text='<%# Eval("email") %>' Width="120px"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-Width="35px" ControlStyle-Width="35px" HeaderText="Remove">            
                            <ItemTemplate>
                                <asp:CheckBox id="Remove" runat="server" Width="35px" Checked="false"/>
                            </ItemTemplate>        
                    </asp:TemplateField>    
                    </Columns>    
                </asp:GridView>
                <% } %>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="SELECT py.Id, py.Private_Name, py.Family_Name, CAST(CASE WHEN CONVERT(VARCHAR(10),py.Birthday,110) is not null THEN CONVERT(VARCHAR(10),py.Birthday,110) ELSE '' END AS Text) as Birthday, t.Name as title, Cast(CASE WHEN py.Is_Reading_Maftir = '1' THEN 'true'  else 'false' end as varchar(50))  as Is_Reading_Maftir, cast(case when py.email is null then '' else py.email end as text) as email, cast(case when py.phone is null then '' else py.phone end as text) as phone FROM [Prayers] py, [Pray2Syn] ps, [Title] t where t.Id = py.Title_id and ps.prayer_id = py.id and ps.syn_id = @sid">
                    <SelectParameters>
                    </SelectParameters>
            </asp:SqlDataSource>
        </div>
        </section>
           
        </div>
    </section>
</asp:Content>