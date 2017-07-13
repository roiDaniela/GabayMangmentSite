
<%@ Page Title="Prayer Detail" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" 
         CodeBehind="PrayerDetails.aspx.cs" Inherits="GabayManageSite.PrayerDetails" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %> 

 <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <br />
     <br />

     <% if (Session["currSynId"] != null && !String.IsNullOrEmpty(Session["currSynId"].ToString())){ %>
    <section>
        <div>
        <table>
            <tr>
                <td>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Family_NameToEdit" CssClass="text-danger" ValidationGroup="updateGroup" ErrorMessage="Family name is required." /> 
                </td>
            </tr>
            <tr>
                <td>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Private_NameToEdit" CssClass="text-danger" ValidationGroup="updateGroup" ErrorMessage="Private name is required." /> 
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="UpdateBtn" runat="server" Text="Add" ValidationGroup="updateGroup" OnClick="UpdateBtn_Click" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Image runat="server" ImageUrl="/Catalog/Images/truckfire.png"/>                    
                </td>
            </tr>
        </table>
        </div>

        <div>
            <asp:GridView ShowHeader="true" DataSourceID="SqlDataSource1" ID="PrayersGridView" runat="server" AutoGenerateColumns="False" ShowFooter="True" GridLines="Horizontal" CellPadding="4"
                CssClass="table table-striped table-bordered">   
                <Columns>
                    <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" HeaderText="Id">
                        <ItemTemplate>
                            <asp:Label Font-Size="X-Small" ID="IdToEdit" runat="server" Text='<%# Eval("Id") %>' Width="80px" Enabled="false"/>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" HeaderText="Private Name">
                        <ItemTemplate>
                            <asp:TextBox CssClass="form-control" Font-Size="X-Small" ID="Private_NameToEdit" ValidationGroup="updateGroup" runat="server" Text='<%# Eval("Private_Name") %>' Width="80px"/>
                            <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtenderPrivateName" runat="server" TargetControlID="Private_NameToEdit" FilterType="Custom"/> 
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" HeaderText="Family Name">
                        <ItemTemplate>
                            <asp:TextBox CssClass="form-control" Font-Size="X-Small" ID="Family_NameToEdit" ValidationGroup="updateGroup" runat="server" Text='<%# Eval("Family_Name") %>' Width="80px"/>
                            <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtenderFamilyName" runat="server" TargetControlID="Family_NameToEdit" FilterType="Custom"/>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-Width="120px" ControlStyle-Width="120px" HeaderText="Birthday">
                        <ItemTemplate>
                            <asp:TextBox CssClass="form-control" Font-Size="X-Small" ID="BirthdayToEdit" runat="server" Text='<%# Eval("Birthday") %>' Width="120px"/>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" HeaderText="Parasha">
                        <ItemTemplate>
                            <asp:DropDownList CssClass="form-control" Font-Size="X-Small" AppendDataBoundItems="true" ID="DropDownParashaToEdit" Width="80px" runat="server" DataSourceID="DataSourceParsha" DataTextField="Name" DataValueField="Id" />
                            <asp:SqlDataSource ID="DataSourceParsha" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="select nameHe as name, id from parashot where tora_order is not null order by tora_order"/>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" HeaderText="Title">
                        <ItemTemplate>
                            <asp:DropDownList CssClass="form-control" Font-Size="X-Small" AppendDataBoundItems="true" ID="DropDownListTitleToEdit" Width="80px" runat="server" DataSourceID="SqlDataSourceTitle" DataTextField="Name" DataValueField="Id" />
                            <asp:SqlDataSource ID="SqlDataSourceTitle" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="SELECT * from [title]"/>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-Width="120px" ControlStyle-Width="120px" HeaderText="Yourtziet Father">
                        <ItemTemplate>
                            <asp:TextBox CssClass="form-control" Font-Size="X-Small" TextMode="Date" ID="Yourtziet_FatherToEdit" runat="server" Text='<%# Eval("Yourtziet_Father") %>' Width="120px"/>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-Width="120px" ControlStyle-Width="120px" HeaderText="Yourtziet Mother">
                        <ItemTemplate>
                            <asp:TextBox CssClass="form-control" Font-Size="X-Small" TextMode="Date" ID="Yourtziet_MotherToEdit" runat="server" Text='<%# Eval("Yourtziet_Mother") %>' Width="120px"/>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-Width="35px" ControlStyle-Width="35px" HeaderText="Read Maftir?">
                        <ItemTemplate>
                            <asp:CheckBox id="isReadingMaftirToEdit" runat="server" Enabled="true" Width="35px" Checked=<%# "true" == Eval("is_reading_maftir")%>/>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px" HeaderText="Phone">
                        <ItemTemplate>
                            <asp:TextBox CssClass="form-control" Font-Size="X-Small" ID="PhoneToEdit" runat="server" Width="80px" TextMode="Phone"  Text='<%# Eval("phone") %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-Width="120px" ControlStyle-Width="120px" HeaderText="Email">
                        <ItemTemplate>
                            <asp:TextBox CssClass="form-control" Font-Size="X-Small" ID="EmailToEdit" runat="server" Width="120px"  TextMode="Email"  Text='<%# Eval("email") %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                </Columns>
            </asp:GridView>
        
            </div>
        </section>
         <% } %>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="SELECT py.Id, py.Private_Name, py.Family_Name, CAST(CASE WHEN CONVERT(VARCHAR(10),py.Birthday,110) is not null THEN CONVERT(VARCHAR(10),py.Birthday,110) ELSE '' END AS Text) as Birthday, Pr.id as Parasha, CAST(CASE WHEN CONVERT(VARCHAR(10),py.Yourtziet_Father,110) is not null THEN CONVERT(VARCHAR(10),py.Yourtziet_Father,110) ELSE '' END AS Text) as Yourtziet_Father, CAST(CASE WHEN CONVERT(VARCHAR(10),py.Yourtziet_Mother,110) is not null THEN CONVERT(VARCHAR(10),py.Yourtziet_Mother,110) ELSE '' END AS Text) Yourtziet_Mother, t.Name as title, Cast(CASE WHEN py.Is_Reading_Maftir = '1' THEN 'true'  else 'false' end as varchar(50))  as Is_Reading_Maftir, cast(case when py.email is null then '' else py.email end as text) as email, cast(case when py.phone is null then '' else py.phone end as text) as phone FROM [Prayers] py, [Pray2Syn] ps, (select nameHe as name, id from parashot where tora_order is not null) pr, [Title] t where t.Id = py.Title_id and pr.Id = py.Parashat_Bar_Mitzva_Id and ps.syn_id = @sid and py.Id = ps.prayer_id and py.Id = @pid">
        <SelectParameters>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>



