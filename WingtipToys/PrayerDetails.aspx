
<%@ Page Title="Prayer Detail" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" 
         CodeBehind="PrayerDetails.aspx.cs" Inherits="GabayManageSite.PrayerDetails" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %> 

 <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section>
        <div>
            <asp:GridView ShowHeader="false" DataSourceID="SqlDataSource1" ID="PrayersGridView" runat="server" AutoGenerateColumns="False" ShowFooter="True" GridLines="Horizontal" CellPadding="4"
                CssClass="table table-striped table-bordered">   
                <Columns>
                    <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px">
                        <ItemTemplate>
                            <asp:Label Font-Size="X-Small" ID="IdToEdit" runat="server" Text='<%# Eval("Id") %>' Width="80px" Enabled="false"/>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px">
                        <ItemTemplate>
                            <asp:TextBox CssClass="form-control" Font-Size="X-Small" ID="Private_NameToEdit" runat="server" Text='<%# Eval("Private_Name") %>' Width="80px"/>
                            <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtenderPrivateName" runat="server" TargetControlID="Private_NameToEdit" FilterType="Custom"/>                            
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px">
                        <ItemTemplate>
                            <asp:TextBox CssClass="form-control" Font-Size="X-Small" ID="Family_NameToEdit" runat="server" Text='<%# Eval("Family_Name") %>' Width="80px"/>
                            <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtenderFamilyName" runat="server" TargetControlID="Family_NameToEdit" FilterType="Custom"/>                            
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px">
                        <ItemTemplate>
                            <asp:TextBox CssClass="form-control" Font-Size="X-Small" TextMode="Date" ID="BirthdayToEdit" runat="server" Text='<%# Eval("Birthday") %>' Width="80px"/>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px">
                        <ItemTemplate>
                            <asp:DropDownList CssClass="form-control" Font-Size="X-Small" AppendDataBoundItems="true" ID="DropDownParashaToEdit" Width="80px" CssClass="form-control" runat="server" DataSourceID="DataSourceParsha" DataTextField="Name" DataValueField="Id" />
                            <asp:SqlDataSource ID="DataSourceParsha" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="SELECT * from [parashot]"/>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px">
                        <ItemTemplate>
                            <asp:DropDownList CssClass="form-control" Font-Size="X-Small" AppendDataBoundItems="true" ID="DropDownListTitleToEdit" Width="80px" CssClass="form-control" runat="server" DataSourceID="SqlDataSourceTitle" DataTextField="Name" DataValueField="Id" />
                            <asp:SqlDataSource ID="SqlDataSourceTitle" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="SELECT * from [title]"/>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-Width="120px" ControlStyle-Width="120px">
                        <ItemTemplate>
                            <asp:TextBox CssClass="form-control" Font-Size="X-Small" TextMode="Date" ID="Yourtziet_FatherToEdit" runat="server" Text='<%# Eval("Yourtziet_Father") %>' Width="120px"/>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-Width="120px" ControlStyle-Width="120px">
                        <ItemTemplate>
                            <asp:TextBox CssClass="form-control" Font-Size="X-Small" TextMode="Date" ID="Yourtziet_MotherToEdit" runat="server" Text='<%# Eval("Yourtziet_Mother") %>' Width="120px"/>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-Width="35px" ControlStyle-Width="35px">
                        <ItemTemplate>
                            <asp:CheckBox id="isReadingMaftirToEdit" runat="server" Enabled="true" Width="35px" Checked=<%# "true" == Eval("is_reading_maftir")%>/>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px">
                        <ItemTemplate>
                            <asp:TextBox CssClass="form-control" Font-Size="X-Small" ID="PhoneToEdit" runat="server" Width="80px" TextMode="Phone" CssClass="form-control"  Text='<%# Eval("phone") %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-Width="80px" ControlStyle-Width="80px">
                        <ItemTemplate>
                            <asp:TextBox CssClass="form-control" Font-Size="X-Small" ID="EmailToEdit" runat="server" Width="80px" TextMode="Email" CssClass="form-control"  Text='<%# Eval("email") %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                </Columns>
            </asp:GridView>
        
            </div>
        </section>
     <section>
         <asp:ListView runat="server">
        <ItemTemplate>

         <table>
            <tr>
                <td>
                    
                        <image src='/Catalog/Images/truckfire.png'
                            width="100" height="75" border="1" />
                    
                </td>
            </tr>
        </table>
        </ItemTemplate>
        </asp:ListView>
     </section>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="SELECT py.Id, py.Private_Name, py.Family_Name, CAST(CASE WHEN CONVERT(VARCHAR(10),py.Birthday,110) is not null THEN CONVERT(VARCHAR(10),py.Birthday,110) ELSE '' END AS Text) as Birthday, Pr.id as Parasha, CAST(CASE WHEN CONVERT(VARCHAR(10),py.Yourtziet_Father,110) is not null THEN CONVERT(VARCHAR(10),py.Yourtziet_Father,110) ELSE '' END AS Text) as Yourtziet_Father, CAST(CASE WHEN CONVERT(VARCHAR(10),py.Yourtziet_Mother,110) is not null THEN CONVERT(VARCHAR(10),py.Yourtziet_Mother,110) ELSE '' END AS Text) Yourtziet_Mother, t.Name as title, Cast(CASE WHEN py.Is_Reading_Maftir = '1' THEN 'true'  else 'false' end as varchar(50))  as Is_Reading_Maftir, cast(case when py.email is null then '' else py.email end as text) as email, cast(case when py.phone is null then '' else py.phone end as text) as phone FROM [Prayers] py, [Parashot] pr, [Title] t where t.Id = py.Title_id and pr.Id = py.Parashat_Bar_Mitzva_Id and py.Id = @prayer_id and synagoge_id = @sid">
        <SelectParameters>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>



