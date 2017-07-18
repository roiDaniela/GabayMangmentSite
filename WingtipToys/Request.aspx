
<%@ Page Title="Request" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Request.aspx.cs" Inherits="GabayManageSite.Request" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %> 

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    
    <% if (Session["currSynId"] != null && !String.IsNullOrEmpty(Session["currSynId"].ToString())){ %>            
    <h3>Add Prayers Special Requests for "<%:Session["currSynName"] %>" shool</h3> 
    <% } %>
    <% else{ %>
    <h3>Prayers requests.</h3>
    <% } %>
  

    <section>
        <div class="row">
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

            <div class="form-horizontal">                

                <br />                
                
                <div class="col-md-3">                
                <dl class="dl-horizontal">
                    <dt>Id:</dt>
                    <dd>
                        <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtenderSynName" runat="server" TargetControlID="IdToAdd" FilterType="Numbers"/>
                        <asp:TextBox ID="IdToAdd" MaxLength="9" runat="server" Width="140px" ValidationGroup="addGroup" AutoPostBack="true" CssClass="form-control" Font-Size="X-Small" ToolTip="numbers only" OnTextChanged="IdToAdd_TextChanged"/>
                    </dd>
                         
                    <dd><br /></dd>
                    
                    <dt>Name:</dt>
                    <dd>    
                        <%--<asp:TextBox ToolTip="Click Enter to view" ID="TextBoxFull_name" runat="server" Width="140px" Enabled="false" CssClass="form-control" Font-Size="X-Small"/>                             --%>
                        <asp:DropDownList AutoPostBack="true" ID="DropDownListName" Width="140px" CssClass="form-control" runat="server" DataSourceID="SqlDataSourceName" DataTextField="Name" DataValueField="Id" Font-Size="X-Small" OnSelectedIndexChanged="DropDownListName_SelectedIndexChanged"/>
                        <asp:SqlDataSource ID="SqlDataSourceName" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="select  p.id,    CONCAT ( p.PRIVATE_NAME, '  ', p.FAMILY_NAME ) AS name from prayers p, Pray2Syn ps where p.id = ps.prayer_id and ps.syn_id = @sid order by p.family_name"/>
                    </dd>
                            
                </dl>                              
                </div>

                <div class="col-md-3">
                    <dl class="dl-horizontal">

                        <dt/>
                        <dd>
                            <asp:RadioButtonList AutoPostBack="true" ID="rbDateOrParasha" runat="server" OnSelectedIndexChanged="rbDateOrParasha_SelectedIndexChanged">
                                <asp:ListItem Text="Date" Value="Date" />
                                <asp:ListItem Text="Parasha" Value="Parasha" />
                            </asp:RadioButtonList>
                        </dd>

                        <dd><br /></dd>

                        <dt>Date:</dt>
                        <dd>    
                            <asp:TextBox Visible="false" ID ="DateToAdd" ValidationGroup="addGroup" runat="server" Width="140px" TextMode="Date" CssClass="form-control" Font-Size="X-Small"/>                                                    
                        </dd>

                        <dd><br /></dd>
                        <dt>Parasha:</dt>
                        <dd>
                            <asp:DropDownList Visible="false" ID="DropDownListParashaToAdd" Width="140px" CssClass="form-control" runat="server" DataSourceID="DataSourceParashot" DataTextField="Name" DataValueField="Id" Font-Size="X-Small"/>
                            <asp:SqlDataSource ID="DataSourceParashot" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="select nameHe as name, id from parashot where tora_order is not null order by tora_order"/>
                        </dd>
                        <dd><br /></dd>

                        <dt>Is Regular?</dt>
                        <dd>
                            <asp:CheckBox id="isConstToAdd" runat="server" Enabled="true" Width="80px" Checked="false"/>
                        </dd>
                        <dd><br /></dd>

                        
                    </dl>
                </div>

                <div class="col-md-3">
                    <dl class="dl-horizontal">

                        <dt>Suggested Aliya:</dt>
                        <dd>    
                            <asp:DropDownList ID="DropDownListSuggestedAliya" Width="140px" CssClass="form-control" runat="server" DataSourceID="SqlDataSourceAliya" DataTextField="Name" DataValueField="Id" Font-Size="X-Small"/>
                            <asp:SqlDataSource ID="SqlDataSourceAliya" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="select name, id from Aliyah"/>
                        </dd>

                        <dd><br /></dd>
                        <dt>Description:</dt>
                        <dd>
                            <asp:TextBox ID="DescriptionToAdd" runat="server" Width="140px" CssClass="form-control"  Font-Size="X-Small"/>
                        </dd>
                        <dd><br /></dd>

                        <dt>Reason:</dt>
                        <dd>
                            <asp:DropDownList ID="DropDownListReason" Width="140px" CssClass="form-control" runat="server" DataSourceID="SqlDataSourceReason" DataTextField="Name" DataValueField="Id" Font-Size="X-Small"/>
                            <asp:SqlDataSource ID="SqlDataSourceReason" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="select name, id from Reason order by priority"/>
                        </dd>
                        <dd><br /></dd>
                        
                    </dl>
                </div>

                <div class="col-md-3">                
                    <dl class="dl-horizontal">
                        <dd>
                            <asp:Button runat="server" id="addButton" OnClick="addButton_Click" Text="Add" ValidationGroup="addGroup" CssClass="btn btn-default" />
                        </dd>                         
                            
                        <dd>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="IdToAdd" CssClass="text-danger" ValidationGroup="addGroup" ErrorMessage="Id is required." />                           
                        </dd>

                        <% if (rbDateOrParasha.SelectedItem != null && rbDateOrParasha.SelectedItem.Text == "Date"){ %>      
                            <dd>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="DateToAdd" CssClass="text-danger" ValidationGroup="addGroup" ErrorMessage="Date is required." />
                            </dd>
                        <% } %>      
                    </dl>                              
                </div>

                <br /> 

            </div>

            </div>
        </section>
        <% } %>


            <%--            
              <asp:Table ID="Table1" runat="server" GridLines="Vertical" CellPadding="4" CssClass="table table-striped table-bordered">
                <asp:TableRow>
                    <asp:TableCell Width="80px">
                            <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtenderSynName" runat="server" TargetControlID="IdToAdd" FilterType="Numbers"/>
                            <asp:TextBox ID="IdToAdd" MaxLength="9" runat="server" Width="80px" ValidationGroup="addGroup" CssClass="form-control" Font-Size="X-Small" ToolTip="numbers only"/>                            
                    </asp:TableCell>
                    <asp:TableCell Width="80px">                            
                            <asp:TextBox ID="Name" runat="server" Width="80px" ValidationGroup="addGroup" CssClass="form-control"  Font-Size="X-Small" Enabled="false"/>
                    </asp:TableCell>
                    <asp:TableCell Width="80px">
                        <asp:TextBox ID ="dateToAdd" runat="server" Width="80px" TextMode="Date" CssClass="form-control" Font-Size="X-Small"/>                        
                    </asp:TableCell>
                    <asp:TableCell Width="80px">
                            <asp:DropDownList ID="DropDownListParashaToAdd" Width="80px" CssClass="form-control" runat="server" DataSourceID="DataSourceParashot" DataTextField="Name" DataValueField="Id" Font-Size="X-Small"/>
                            <asp:SqlDataSource ID="DataSourceParashot" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="select nameHe as name, id from parashot where tora_order is not null order by tora_order"/>
                    </asp:TableCell> 
                    <asp:TableCell Width="80px">
                            <asp:CheckBox id="isConstToAdd" runat="server" Enabled="true" Width="80px" Checked="false"/>
                    </asp:TableCell>
                    <asp:TableCell Width="80px">
                            <asp:DropDownList ID="DropDownListSuggestedAliya" Width="80px" CssClass="form-control" runat="server" DataSourceID="SqlDataSourceAliya" DataTextField="Name" DataValueField="Id" Font-Size="X-Small"/>
                            <asp:SqlDataSource ID="SqlDataSourceAliya" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="select name, id from Aliyah"/>
                    </asp:TableCell>
                    <asp:TableCell Width="80px">
                            <asp:TextBox ID="DescriptionToAdd" runat="server" Width="80px" CssClass="form-control"  Font-Size="X-Small"/>
                    </asp:TableCell>
                    <asp:TableCell Width="80px">
                            <asp:DropDownList ID="DropDownListReason" Width="80px" CssClass="form-control" runat="server" DataSourceID="SqlDataSourceReason" DataTextField="Name" DataValueField="Id" Font-Size="X-Small"/>
                            <asp:SqlDataSource ID="SqlDataSourceReason" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="select name, id from Reason order by priority"/>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table> --%>

    <section>
            <% if (Session["currSynId"] != null && !String.IsNullOrEmpty(Session["currSynId"].ToString())){ %>
                <h3>Requests table</h3>  
                
                <asp:GridView showHeader="true" DataSourceID="SqlDataSource2" ID="PrayersGridView" runat="server" AutoGenerateColumns="False" ShowFooter="True" GridLines="Vertical" CellPadding="4"
                CssClass="table table-striped table-bordered">
                    <Columns>
                                                                
                        <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" HeaderText="Id">            
                                <ItemTemplate>
                                <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("prayer_id") %>' Width="80px"/>
                        </ItemTemplate>        
                        </asp:TemplateField>      

                        <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" HeaderText="Name">            
                                <ItemTemplate>
                                <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("name") %>' Width="80px"/>
                        </ItemTemplate>        
                        </asp:TemplateField>   

                        <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" HeaderText="Date">            
                                <ItemTemplate>
                                <asp:Label ID="DateLabel" runat="server" Text='<%# Eval("date") %>' Width="80px"/>
                        </ItemTemplate>        
                        </asp:TemplateField>      

                        <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" HeaderText="Parasha">            
                                <ItemTemplate>
                                <asp:Label ID="ParashaLabel" runat="server" Text='<%# Eval("parasha") %>' Width="80px"/>
                        </ItemTemplate>        
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" HeaderText="Const">            
                                <ItemTemplate>
                                <asp:CheckBox id="isConst" Enabled="false" runat="server" Width="80px" Checked=<%# "true" == Eval("isConst")%>/>
                        </ItemTemplate>     
                        </asp:TemplateField>   

                        <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" HeaderText="Suggested Aliya">            
                                <ItemTemplate>
                                <asp:Label ID="AliyaLabel" runat="server" Text='<%# Eval("favorite_Aliya") %>' Width="80px" />
                        </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" HeaderText="Description">            
                                <ItemTemplate>
                                <asp:Label ID="descriptionLabel" runat="server" Text='<%# Eval("description") %>' Width="80px" />
                        </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" HeaderText="Reason">            
                                <ItemTemplate>
                                <asp:Label ID="reasonLabel" runat="server" Text='<%# Eval("reason") %>' Width="80px"/>
                        </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
            <%} %>
            
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="SELECT e.prayer_id, CONCAT ( pr.private_Name, ' ', pr.family_name) as name, e.syn_id, CAST(CASE WHEN CONVERT(VARCHAR(10),e.date,110) is not null THEN CONVERT(VARCHAR(10),e.date,110) ELSE '' END AS Text) as date, p.nameHe as parasha, Cast(CASE WHEN e.isConst = '1' THEN 'true'  else 'false' end as varchar(50))  as isConst, a.name as favorite_Aliya, e.description, r.name as reason FROM [Exceptional] e, Reason r, Aliyah a ,Parashot p, Prayers pr where r.id = e.reason_id and pr.id = e.prayer_id and a.id = e.favorite_Aliya and p.id = parasha_id and syn_id = @sid">
                <SelectParameters>
                </SelectParameters>
            </asp:SqlDataSource>
    </section>

</asp:Content>