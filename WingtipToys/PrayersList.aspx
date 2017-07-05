<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrayersList.aspx.cs" Inherits="GabayManageSite.PrayersList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:DataList ID="PrayersDataList" runat="server" DataKeyField="Id" DataSourceID="SqlDataSource1">
            <ItemTemplate>
                Id:
                <asp:Label ID="IdLabel" runat="server" Text='<%# Eval("Id") %>' />
                <br />
                Private_Name:
                <asp:Label ID="Private_NameLabel" runat="server" Text='<%# Eval("Private_Name") %>' />
                <br />
                Family_Name:
                <asp:Label ID="Family_NameLabel" runat="server" Text='<%# Eval("Family_Name") %>' />
                <br />
                Birthday:
                <asp:Label ID="BirthdayLabel" runat="server" Text='<%# Eval("Birthday") %>' />
                <br />
                Parashat_Bar_Mitzva_Id:
                <asp:Label ID="Parashat_Bar_Mitzva_IdLabel" runat="server" Text='<%# Eval("Parashat_Bar_Mitzva_Id") %>' />
                <br />
                Yourtziet_Father:
                <asp:Label ID="Yourtziet_FatherLabel" runat="server" Text='<%# Eval("Yourtziet_Father") %>' />
                <br />
                Yourtziet_Mother:
                <asp:Label ID="Yourtziet_MotherLabel" runat="server" Text='<%# Eval("Yourtziet_Mother") %>' />
                <br />
                Title_id:
                <asp:Label ID="Title_idLabel" runat="server" Text='<%# Eval("Title_id") %>' />
                <br />
                Aliyot_Counter:
                <asp:Label ID="Aliyot_CounterLabel" runat="server" Text='<%# Eval("Aliyot_Counter") %>' />
                <br />
                Is_Reading_Maftir:
                <asp:Label ID="Is_Reading_MaftirLabel" runat="server" Text='<%# Eval("Is_Reading_Maftir") %>' />
                <br />
                Yourtziet_Child:
                <asp:Label ID="Yourtziet_ChildLabel" runat="server" Text='<%# Eval("Yourtziet_Child") %>' />
                <br />
                Synagoge_Id:
                <asp:Label ID="Synagoge_IdLabel" runat="server" Text='<%# Eval("Synagoge_Id") %>' />
                <br />
                <br />
            </ItemTemplate>
        </asp:DataList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="SELECT * FROM [Prayers]"></asp:SqlDataSource>
        <asp:ListView ID="PrayersListView" runat="server" DataSourceID="SqlDataSource1">
        </asp:ListView>
    </form>
</body>
</html>
