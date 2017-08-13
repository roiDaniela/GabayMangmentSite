
<%@ Page Title="Request" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Request.aspx.cs" Inherits="GabayManageSite.Request" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %> 

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    
    <% if (Session["currSynId"] != null && !String.IsNullOrEmpty(Session["currSynId"].ToString())){ %>            
    <h3>Add Prayers Special Requests for "<%:Session["currSynName"] %>" shul</h3> 
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
                    <%--<LoggedInTemplate>
                        <p>Hello <%: Context.User.Identity.GetUserName()  %> <a runat="server" href="~/Account/Manage" title="Manage your account"> please select your synagoge</a> </p>  
                    </LoggedInTemplate>--%>
                    </asp:LoginView>                
            <% } %>
            
            <% if (Session["currSynId"] != null && !String.IsNullOrEmpty(Session["currSynId"].ToString())){ %>            

            <div class="form-horizontal">                

                <br />                
                
                <div class="col-md-3">                
                <dl class="dl-horizontal">
                    <dt/>

                    <dd><br /></dd>

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

                        <dd><br /></dd>

                        <dt>Date:</dt>
                        <dd>    
                            <asp:TextBox Visible="true" ID ="DateToAdd" ValidationGroup="addGroup" runat="server" Width="140px" TextMode="Date" CssClass="form-control" Font-Size="X-Small"/>                                                    
                        </dd>

                        <dd><br /></dd>
                        <%--<dt>Parasha:</dt>
                        <dd>
                            <asp:DropDownList Visible="false" ID="DropDownListParashaToAdd" Width="140px" CssClass="form-control" runat="server" DataSourceID="DataSourceParashot" DataTextField="Name" DataValueField="Id" Font-Size="X-Small"/>
                            <asp:SqlDataSource ID="DataSourceParashot" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="select nameHe as name, id from parashot where tora_order is not null order by tora_order"/>
                        </dd> --%>
                        <dd><br /></dd>

                        <dt>Is Regular?</dt>
                        <dd>
                            <asp:CheckBox id="isRegularToAdd" runat="server" Enabled="true" Width="80px" Checked="false"/>
                        </dd>
                        <dd><br /></dd>

                        
                    </dl>
                </div>

                <div class="col-md-3">
                    <dl class="dl-horizontal">

                        <dt>Suggested Aliya:</dt>
                        <dd>    
                            <asp:DropDownList ID="DropDownListSuggestedAliya" Width="140px" CssClass="form-control" runat="server" DataSourceID="SqlDataSourceAliya" DataTextField="Name" DataValueField="Id" Font-Size="X-Small"/>
                            <asp:SqlDataSource ID="SqlDataSourceAliya" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="select name, id from Aliyah where name != 'הפטרה'"/>
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
                            <asp:SqlDataSource ID="SqlDataSourceReason" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="select * from Reason order by priority desc"/>
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
                    </dl>                              
                </div>

                <br /> 

            </div>

            </div>
        </section>
        <% } %>

    <section>
            <% if (Session["currSynId"] != null && !String.IsNullOrEmpty(Session["currSynId"].ToString())){ %>
          
              <h2>Requests table</h2>  
                
            <div class="form-inline">
            <h3>                
                from <%= DateTime.Now.Year %> to                 
                <asp:DropDownList AutoPostBack="true" CssClass="form-control" ID="DropDownListRangeOfYears" Width="140px" runat="server" DataSourceID="SqlDataSourceRangeOfYears" DataTextField="year" DataValueField="year" Font-Size="X-Small" OnSelectedIndexChanged="DropDownListRangeOfYears_SelectedIndexChanged" />
                <asp:SqlDataSource ID="SqlDataSourceRangeOfYears" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="select c.year, CASE WHEN c.year >= year(getdate()) THEN 1 ELSE 0 END AS orderyear from [Auxiliary].[Calendar] c where c.year >= year(getdate()) group by c.year order by orderyear desc, c.year"/>              

            </h3> 
            </div>
            <asp:Button ID="DeleteBtn" runat="server" Text="Delete" OnClick="DeleteBtn_Click"/>

           

                <asp:GridView showHeader="true" DataSourceID="SqlDataSource2" ID="RequestsGridView" runat="server" AutoGenerateColumns="False" ShowFooter="True" GridLines="Vertical" CellPadding="4"
                CssClass="table table-striped table-bordered">
                    <Columns>
                                                                
                        <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" HeaderText="Id">            
                                <ItemTemplate>
                                <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("prayer_id") %>' Width="80px"/>
                        </ItemTemplate>        
                        </asp:TemplateField>      

                        <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" Visible="false">            
                                <ItemTemplate>
                                <asp:Label ID="RefLabel" runat="server" Text='<%# Eval("ref") %>' Width="80px"/>
                        </ItemTemplate>        
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" Visible="false">            
                                <ItemTemplate>
                                <asp:Label ID="ExceptionalIdLabel" runat="server" Text='<%# Eval("ExceptionalId") %>' Width="80px"/>
                        </ItemTemplate>        
                        </asp:TemplateField>

                        <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" HeaderText="Name">            
                                <ItemTemplate>
                                <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("name") %>' Width="80px"/>
                        </ItemTemplate>        
                        </asp:TemplateField>   

                        <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" HeaderText="Date Aliya">            
                                <ItemTemplate>
                                <asp:Label ID="DateLabel" runat="server" Text='<%# Eval("date") %>' Width="80px"/>
                        </ItemTemplate>        
                        </asp:TemplateField>      

                        <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" HeaderText="Parashat Aliya">            
                                <ItemTemplate>
                                <asp:Label ID="ParashaLabel" runat="server" Text='<%# Eval("parasha") %>' Width="80px"/>
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

                        <asp:TemplateField ItemStyle-Width="35px" ControlStyle-Width="35px" HeaderText="Remove">            
                            <ItemTemplate>
                                <asp:CheckBox id="Remove" runat="server" Width="35px" Checked="false"/>
                            </ItemTemplate>        
                    </asp:TemplateField>    

                    </Columns>
                </asp:GridView>
            <%} %>
            
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="select p.id as prayer_id, e2.exceptional_id as ExceptionalId ,e2.ref as ref, r.name as reason, e1.description as description,a.name as favorite_aliya, CONCAT ( p.private_Name, ' ', p.family_name) as name, CAST(CASE WHEN CONVERT(VARCHAR(10),e2.date,110) is not null THEN CONVERT(VARCHAR(10),e2.date,110) ELSE '' END AS Text) as date, (select top(1) pr.nameHe from fullkriyah f, parashot pr where pr.id = f.parashah and date >= e2.date order by date) as parasha, CASE WHEN e2.date >= getdate() THEN 0 ELSE 1 END AS order_date  from exceptional e1, exceptional2date e2, prayers p, reason r, pray2syn ps, Aliyah a where a.id = e1.favorite_aliya and r.id = e1.reason_id and ps.prayer_id = p.id and ps.syn_id = @sid and e2.exceptional_id = e1.ref and p.id = e1.prayer_id and year(e2.date) between year(getdate()) and @range order by order_date, e2.date">
                <SelectParameters>
                </SelectParameters>
            </asp:SqlDataSource>
    </section>

</asp:Content>