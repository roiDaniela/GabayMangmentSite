
<%@ Page Title="Products" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" 
         CodeBehind="PrayerDetails.aspx.cs" Inherits="WingtipToys.PrayerDetails" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
<%--    <asp:FormView ID="productDetail" runat="server" ItemType="WingtipToys.Models.Prayer" SelectMethod ="GetPrayer" RenderOuterTable="false">
        <ItemTemplate>
            <div>
                <h1><%#:Item.ProductName %></h1>
            </div>
            <br />
            <table>
                <tr>
                    <td>
                        <img src="/Catalog/Images/boatbig" style="border:solid; height:300px" alt="<%#:Item.PrayerName %>"/>
                    </td>
                    <td>&nbsp;</td>  
                    <td style="vertical-align: top; text-align:left;">
                        <br />
                        <span><b>Private Name:</b>&nbsp;<%#: String.Format("{0:c}", Item.Private) %></span>
                        <br />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:FormView>
    --%>
     <asp:FormView ID="prayerDetail" runat="server" ItemType="WingtipToys.Models.Prayer">
        <ItemTemplate>
            <input id="TextPrayerId" type="number" value=<%#Item.PrayerID %>/>
        </ItemTemplate>
     </asp:FormView>
     <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="SELECT * FROM [Prayers]"></asp:SqlDataSource>
</asp:Content>



