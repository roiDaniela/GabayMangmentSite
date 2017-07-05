
<%@ Page Title="Products" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" 
         CodeBehind="PrayerDetails.aspx.cs" Inherits="GabayManageSite.PrayerDetails" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

     <asp:FormView ID="FormViewPrayerDetail" runat="server" DataKeyField="Id" DataSourceID="SqlDataSource1">

         <ItemTemplate>
            <asp:Table ID="Table2" runat="server" AutoGenerateColumns="False" ShowFooter="True" GridLines="Vertical" CellPadding="4" CssClass="table table-striped table-bordered">
                <asp:TableRow>
                    <asp:TableHeaderCell Text="Id" Width="120px"/>
                    <asp:TableCell Width="120px">
                            <asp:Label ID="IdDetail" runat="server" Text='<%# Eval("Id") %>' Width="120px"/>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableHeaderCell Text="Private Name" Width="120px"/>
                    <asp:TableCell Width="120px">
                            <asp:TextBox ID="Private_NameLabel" runat="server" Text='<%# Eval("Private_Name") %>' Width="120px"/>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableHeaderCell Text="Family Name" Width="120px"/>
                    <asp:TableCell Width="120px">
                            <asp:TextBox ID="Family_NameLabel" runat="server" Text='<%# Eval("Family_Name") %>' Width="120px"/>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableHeaderCell Text="Birthday" Width="120px"/>
                    <asp:TableCell Width="120px">
                            <asp:TextBox ID="BirthdayLabel" runat="server" Text='<%# Eval("Birthday") %>' Width="120px"/>
                    </asp:TableCell>                    
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableHeaderCell Text="Parashat BarMitzva" Width="120px"/>
                    <asp:TableCell>
                            <asp:TextBox ID="Parashat_Bar_Mitzva_IdLabel" runat="server" Text='<%# Eval("Parasha") %>' Width="120px"/>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableHeaderCell Text="Cohen\Levi\Israel" Width="120px"/>
                    <asp:TableCell Width="120px">
                            <asp:TextBox ID="Title_idLabel" runat="server" Text='<%# Eval("title") %>' Width="120px"/>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableHeaderCell Text="Yourtzeit Father" Width="120px"/>
                    <asp:TableCell Width="120px">
                            <asp:TextBox ID="Yourtziet_FatherLabel" runat="server" Text='<%# Eval("Yourtziet_Father") %>' Width="120px"/>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableHeaderCell Text="Yourtzeit Mother" Width="120px"/>
                    <asp:TableCell Width="120px">
                            <asp:TextBox ID="Yourtziet_MotherLabel" runat="server" Text='<%# Eval("Yourtziet_Mother") %>' Width="120px"/>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </ItemTemplate> 
        </asp:FormView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="SELECT py.Id, py.Private_Name, py.Family_Name, CAST(CASE WHEN CONVERT(VARCHAR(10),py.Birthday,110) is not null THEN CONVERT(VARCHAR(10),py.Birthday,110) ELSE '' END AS Text) as Birthday, Pr.Name as Parasha, CAST(CASE WHEN CONVERT(VARCHAR(10),py.Yourtziet_Father,110) is not null THEN CONVERT(VARCHAR(10),py.Yourtziet_Father,110) ELSE '' END AS Text) as Yourtziet_Father, CAST(CASE WHEN CONVERT(VARCHAR(10),py.Yourtziet_Mother,110) is not null THEN CONVERT(VARCHAR(10),py.Yourtziet_Mother,110) ELSE '' END AS Text) Yourtziet_Mother, t.Name as title FROM [Prayers] py, [Parashot] pr, [Title] t where t.Id = py.Title_id and pr.Id = py.Parashat_Bar_Mitzva_Id and py.Id = @prayer_id"/>
</asp:Content>



