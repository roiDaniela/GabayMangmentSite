<%@ Page Title="Aliyot" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Aliyot.aspx.cs" Inherits="GabayManageSite.Aliyot" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
            <br />
            <br />

            <div style="text-align: center;  align-content:center; align-self:center; align-items:center; vertical-align: middle; ">
                <asp:Button ID="btnFromCalOpen" runat="server" 
                 Text="Print"  CssClass = "SElementHide" 
                 OnClientClick="Test()" />
            </div>

 
            <script type="text/javascript">
 
                function Test() {
                    var prtContent = document.getElementById("AliyotDiv");                 
                    var WinPrint = window.open('', '', 'height=400,width=600');
                    WinPrint.document.write("<h3>Printed by GabayManagmentSite</h3>");
                    WinPrint.document.write(prtContent.innerHTML);
                    WinPrint.document.close();
                    WinPrint.focus();
                    WinPrint.print();
                    WinPrint.close();
                }

                function printDiv(id) {

                    var mywindow = window.open('', 'new div', 'height=400,width=600');
                    mywindow.document.write('<html><head><title></title>');
                    mywindow.document.write('<link rel="stylesheet" href="css/midday_receipt.css" type="text/css" />');
                    mywindow.document.write('</head><body >');
                    mywindow.document.write(data);
                    mywindow.document.write('</body></html>');

                    mywindow.print();
                    mywindow.close();

                    return true;

                }
 
            </script>
 
    <div id="printDiv">
        <div id="AliyotDiv">
    <%--<asp:BoundField DataField="Title_ID" HeaderText="Title_ID" ReadOnly="True" SortExpression="Title_ID" />
            <asp:BoundField DataField="Reason" HeaderText="Reason" ReadOnly="True" SortExpression="Reason" /> --%>            
        <% if (Session["currSynId"] != null && !String.IsNullOrEmpty(Session["currSynId"].ToString())){ %>
        <h3 style="text-align: center;">בית הכנסת <%:Session["currSynName"] %></h3> 

        <h3 style="text-align: center;">
            <asp:Label ID="LabelHebDate" runat="server" Text="Label"></asp:Label>
        </h3>
        <h3 style="text-align: center;">
            שבת פרשת <asp:HyperLink ID="HyperLinkParasha" runat="server">HyperLink</asp:HyperLink>
        </h3>
            <asp:GridView ID="GridView2" runat="server" HorizontalAlign="Center" DataSourceID="SqlDataSource2" AutoGenerateColumns="false" CssClass="table table-striped table-bordered" ShowFooter="True" GridLines="Vertical" CellPadding="2" Width="30%">
                <Columns>
                    <asp:BoundField DataField="פסוקים" HeaderText="פסוקים" SortExpression="פסוקים" />
                    <asp:BoundField DataField="מס' עליה" HeaderText="מס' עליה" SortExpression="מס' עליה" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="Select Aliyah.Name AS &quot;מס' עליה&quot;,
	       Reading.name AS &quot;פסוקים&quot;
    From fullkriyah
    Inner Join Reading On Reading.Id = fullkriyah.torah
    Inner Join Aliyah On Aliyah.id = fullkriyah.Aliyah
    Where date in (
	    SELECT TOP (1) date
	    From fullkriyah
	    INNER JOin Parashot ON fullkriyah.parashah = Parashot.id
	    Where getdate() &lt;= date
    )"></asp:SqlDataSource>
            <br />
            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" HorizontalAlign="Center" DataSourceID="SqlDataSource1" CssClass="table table-striped table-bordered" ShowFooter="True" GridLines="Vertical" CellPadding="4">
                <Columns>
                    <%--<asp:BoundField DataField="Title_ID" HeaderText="Title_ID" ReadOnly="True" SortExpression="Title_ID" />
                    <asp:BoundField DataField="Priority" HeaderText="Priority" ReadOnly="True" SortExpression="Priority" /> --%>
                    <asp:BoundField DataField="ID" HeaderText="מס. זהות" ReadOnly="True" SortExpression="ID" />
                    <asp:BoundField DataField="שם מלא" HeaderText="שם מלא" ReadOnly="True" SortExpression="שם מלא" />
                    <asp:BoundField DataField="כהן/לוי/ישראל" HeaderText="כהן/לוי/ישראל" ReadOnly="True" SortExpression="כהן/לוי/ישראל" />
                    <asp:BoundField DataField="עליה מומלצת" HeaderText="עליה מומלצת" ReadOnly="True" SortExpression="עליה מומלצת" />
                    <asp:BoundField DataField="סיבה" HeaderText="סיבה" ReadOnly="True" SortExpression="סיבה" />
                    <asp:BoundField DataField="תיאור" HeaderText="תיאור" ReadOnly="True" SortExpression="תיאור" />
                    <asp:BoundField DataField="מספר העליות" HeaderText="מספר העליות" ReadOnly="True" SortExpression="מספר העליות" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="Select * 
From
(
Select Top (3) *
From
(
  	Select 
  	   Title_ID,
  	   Reason.Priority,
  	   Prayers.ID,
  	   CONCAT ( PRIVATE_NAME, '  ', FAMILY_NAME ) AS &quot;שם מלא&quot;,
  	   Title.Name AS &quot;כהן/לוי/ישראל&quot;,
  	   Aliyah.Name as &quot;עליה מומלצת&quot;,
  	   Reason.name AS &quot;סיבה&quot;,
  	   Exceptional2.description as &quot;תיאור&quot;,
  	   Count( AliyaHistory.prayer_Id) AS &quot;מספר העליות&quot;
  	From Prayers
  	Left Outer JOIN AliyaHistory ON  AliyaHistory.prayer_id = Prayers.id
  	Left Outer Join (
	Select prayer_id,reason_id,description,favorite_Aliya from Exceptional INNER JOIN Exceptional2Date ON Exceptional2Date.exceptional_id = Exceptional.ref  where Exceptional2Date.date in (SELECT TOP (1) 
	date
  	FROM fullkriyah
  Where date &gt;= getdate())) AS Exceptional2 ON Exceptional2.prayer_id = Prayers.id
  	Left Outer Join Aliyah ON Exceptional2.favorite_Aliya = Aliyah.Id
  	Left join Reason ON Reason.id = Exceptional2.reason_id
  	Inner Join  Title On Title.id = Prayers.Title_ID
  	where Prayers.ID IN (
  		Select prayer_id
  		from Pray2syn 
  		where syn_id = @syn_id)
  AND Title_ID =1
  Group By  Title_ID,Reason.Priority,Prayers.ID,PRIVATE_NAME,FAMILY_NAME, Aliyah.Name,Reason.name,Exceptional2.description,Title.Name
 ) C
 Order By Priority DESC,&quot;מספר העליות&quot; DESC
Union ALL 


Select Top (3) *
From
(
-----------------------------------------------------------------------------
--------------Query from Exceptional table (1,3,4,6,8)----------------------
-----------------------------------------------------------------------------
  	Select 
  	   Title_ID,
  	   Reason.Priority,
  	   Prayers.ID,
  	   CONCAT ( PRIVATE_NAME, '  ', FAMILY_NAME ) AS &quot;שם מלא&quot;,
  	   Title.Name AS &quot;כהן/לוי/ישראל&quot;,
  	   Aliyah.Name as &quot;עליה מומלצת&quot;,
  	   Reason.name AS &quot;סיבה&quot;,
  	   Exceptional2.description as &quot;תיאור&quot;,
  	   Count( AliyaHistory.prayer_Id) AS &quot;מס עליות&quot;
  	From Prayers
  	Left Outer JOIN AliyaHistory ON  AliyaHistory.prayer_id = Prayers.id
  	Left Outer Join (
	Select prayer_id,reason_id,description,favorite_Aliya from Exceptional INNER JOIN Exceptional2Date ON Exceptional2Date.exceptional_id = Exceptional.ref  where Exceptional2Date.date in (SELECT TOP (1) 
	date
  	FROM fullkriyah
  Where date &gt;= getdate())) AS Exceptional2 ON Exceptional2.prayer_id = Prayers.id
  	Left Outer Join Aliyah ON Exceptional2.favorite_Aliya = Aliyah.Id
  	Left join Reason ON Reason.id = Exceptional2.reason_id
  	Inner Join  Title On Title.id = Prayers.Title_ID
  	where Prayers.ID IN (
  		Select prayer_id
  		from Pray2syn 
  		where syn_id = @syn_id)
  AND Title_ID =2
  Group By  Title_ID,Reason.Priority,Prayers.ID,PRIVATE_NAME,FAMILY_NAME, Aliyah.Name,Reason.name,Exceptional2.description,Title.Name
 ) L
 Order By Priority DESC,&quot;מס עליות&quot; ASC


UNION ALL


Select Top (12) *
From
(
-----------------------------------------------------------------------------
--------------Query from Exceptional table (1,3,4,6,8)----------------------
-----------------------------------------------------------------------------
  	Select 
  	   Title_ID,
  	   Reason.Priority,
  	   Prayers.ID,
  	   CONCAT ( PRIVATE_NAME, '  ', FAMILY_NAME ) AS &quot;שם מלא&quot;,
  	   Title.Name AS &quot;כהן/לוי/ישראל&quot;,
  	   Aliyah.Name as &quot;עליה מומלצת&quot;,
  	   Reason.name AS &quot;סיבה&quot;,
  	   Exceptional2.description as &quot;תיאור&quot;,
  	   Count( AliyaHistory.prayer_Id) AS &quot;מס עליות&quot;
  	From Prayers
  	Left Outer JOIN AliyaHistory ON  AliyaHistory.prayer_id = Prayers.id
  	Left Outer Join (
	Select prayer_id,reason_id,description,favorite_Aliya from Exceptional INNER JOIN Exceptional2Date ON Exceptional2Date.exceptional_id = Exceptional.ref  where Exceptional2Date.date in (SELECT TOP (1) 
	date
  	FROM fullkriyah
  Where date &gt;= getdate())) AS Exceptional2 ON Exceptional2.prayer_id = Prayers.id
  	Left Outer Join Aliyah ON Exceptional2.favorite_Aliya = Aliyah.Id
  	Left join Reason ON Reason.id = Exceptional2.reason_id
  	Inner Join  Title On Title.id = Prayers.Title_ID
  	where Prayers.ID IN (
  		Select prayer_id
  		from Pray2syn 
  		where syn_id = @syn_id)
  AND Title_ID =3
  Group By  Title_ID,Reason.Priority,Prayers.ID,PRIVATE_NAME,FAMILY_NAME, Aliyah.Name,Reason.name,Exceptional2.description,Title.Name
 )Y
  Order By Priority DESC,&quot;מס עליות&quot; ASC
) AS g
Order By Title_ID ASC , Priority DESC, &quot;מספר העליות&quot; ASC">
                <SelectParameters>
                    <asp:Parameter Name="syn_id" />
                </SelectParameters>
            </asp:SqlDataSource>

        <% } %>

        <% if (Session["currSynId"] != null && !String.IsNullOrEmpty(Session["currSynId"].ToString())){ %>            
        <%} %>

            
        </div>
    </div>

</asp:Content>


