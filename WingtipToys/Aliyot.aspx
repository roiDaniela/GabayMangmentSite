<%@ Page Title="Aliyot" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Aliyot.aspx.cs" Inherits="GabayManageSite.Aliyot" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    
    <% if (Session["currSynId"] != null && !String.IsNullOrEmpty(Session["currSynId"].ToString())){ %>            
    <h3>Aliyot for "<%:Session["currSynName"] %>" shool</h3> 
    <% } %>
    <% else{ %>
    <h3>Prayers aliyot.</h3>
     <% } %>

        <% if (Session["currSynId"] != null && !String.IsNullOrEmpty(Session["currSynId"].ToString())){ %>            
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
        <Columns>
            <%--<asp:BoundField DataField="Title_ID" HeaderText="Title_ID" ReadOnly="True" SortExpression="Title_ID" />
            <asp:BoundField DataField="Reason" HeaderText="Reason" ReadOnly="True" SortExpression="Reason" /> --%>
            <asp:BoundField DataField="ת&quot;ז" HeaderText="ת&quot;ז" ReadOnly="True" SortExpression="ת&quot;ז" />
            <asp:BoundField DataField="שם מלא" HeaderText="שם מלא" ReadOnly="True" SortExpression="שם מלא" />
            <asp:BoundField DataField="כהן/לוי/ישראל" HeaderText="כהן/לוי/ישראל" ReadOnly="True" SortExpression="כהן/לוי/ישראל" />
            <asp:BoundField DataField="עליה מומלצת" HeaderText="עליה מומלצת" ReadOnly="True" SortExpression="עליה מומלצת" />
            <asp:BoundField DataField="סיבה" HeaderText="סיבה" ReadOnly="True" SortExpression="סיבה" />
            <asp:BoundField DataField="תיאור" HeaderText="תיאור" ReadOnly="True" SortExpression="תיאור" />
            <asp:BoundField DataField="מס' עליות" HeaderText="מס' עליות" ReadOnly="True" SortExpression="מס' עליות" />
        </Columns>
        </asp:GridView>
    <% } %>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="Select * 
From
(
Select Top (3) *
From
(


SELECT  Title_ID,

     CAST('24' AS INT) AS Reason,
     Prayers.ID AS 'ת&quot;ז',
     CONCAT ( Prayers.PRIVATE_NAME, '  ', Prayers.FAMILY_NAME ) AS &quot;שם מלא&quot;,
     Title.Name AS &quot;כהן/לוי/ישראל&quot;,
	 Null AS &quot;עליה מומלצת&quot;,
     'פרשת בר מצוה, אך הוא לא בן 13' AS &quot;סיבה&quot;,
     Null AS &quot;תיאור&quot;,
     Count( AliyaHistory.prayer_Id) AS &quot;מס' עליות&quot;
  FROM [dbo].[Prayers]
  Left Outer JOIN AliyaHistory ON  AliyaHistory.prayer_id = Prayers.ID
  Inner Join Title ON Title.ID = Prayers.TITLE_ID
  Inner Join (SELECT TOP (1)
       parashah
  	FROM fullkriyah
  Where date &gt;= getdate()) AS TodayParasha ON TodayParasha.parashah = Prayers.PARASHAT_BAR_MITZVA_ID
  Where Prayers.ID IN (
  Select prayer_id
  from Pray2syn 
  where syn_id = @syn_id) And Prayers.Title_ID = 1 AND (DATEDIFF(day,Prayers.BIRTHDAY,getdate())) &gt; 13
  Group By  Title_ID,Prayers.ID,Prayers.PRIVATE_NAME,Prayers.FAMILY_NAME,Title.Name

Union ALL
SELECT  Title_ID,
     CAST('29' AS INT) AS Reason,
     Prayers.ID AS 'ת&quot;ז',
     CONCAT ( Prayers.PRIVATE_NAME, '  ', Prayers.FAMILY_NAME ) AS &quot;שם מלא&quot;,
     Title.Name AS &quot;כהן/לוי/ישראל&quot;,
     Null AS &quot;עליה מומלצת&quot;,
     'בר מצווה' AS &quot;סיבה&quot;,
     Null AS &quot;תיאור&quot;,
     Count( AliyaHistory.prayer_Id) AS &quot;מס' עליות&quot;
  FROM [dbo].[Prayers]
  Left Outer JOIN AliyaHistory ON  AliyaHistory.prayer_id = Prayers.ID
  Inner Join Title ON Title.ID = Prayers.TITLE_ID
  Inner Join (SELECT TOP (1) 
       parashah
  	FROM fullkriyah
  Where date &gt;= getdate()) AS FavorityParasha ON FavorityParasha.parashah = Prayers.PARASHAT_BAR_MITZVA_ID
  Where Prayers.ID IN (
  Select prayer_id
  from Pray2syn 
  where syn_id = @syn_id) And Prayers.Title_ID = 1 AND (DATEDIFF(day,Prayers.BIRTHDAY,getdate())) = 13
  Group By  Title_ID,Prayers.ID,Prayers.PRIVATE_NAME,Prayers.FAMILY_NAME,Title.Name


Union ALL
	Select 
	   Title.ID as TitleID,
	   CAST('25' AS INT) AS Reason,
	   Prayers.ID AS 'ת&quot;ז',
	   CONCAT ( PRIVATE_NAME, '  ', FAMILY_NAME ) AS &quot;שם מלא&quot;,
	   Title.Name AS &quot;כהן/לוי/ישראל&quot;,
	   'מפטיר' AS &quot;עליה מומלצת&quot;,
	   'יארצייט אמא או אבא' AS &quot;סיבה&quot;,
	   Null AS &quot;תיאור&quot;,
	   Count( AliyaHistory.prayer_Id) AS &quot;מס' עליות&quot;
	From Prayers
	Left Outer JOIN AliyaHistory ON  AliyaHistory.prayer_id = Prayers.id
	Inner Join Title ON Title.ID = Prayers.TITLE_ID
	where Prayers.ID IN (
	Select prayer_id
	from Pray2syn 
	where syn_id = @syn_id) And Title_ID = 1 And IS_READING_MAFTIR = 1
	Group By  Title.ID,Prayers.ID,PRIVATE_NAME,FAMILY_NAME,Title.Name
	

Union ALL
  	Select 
  	   Title_ID,
  	   Reason.Priority,
  	   Prayers.ID,
  	   CONCAT ( PRIVATE_NAME, '  ', FAMILY_NAME ) AS &quot;שם מלא&quot;,
  	   Title.Name AS &quot;כהן/לוי/ישראל&quot;,
  	   Aliyah.Name as &quot;עליה מומלצת&quot;,
  	   Reason.name AS &quot;סיבה&quot;,
  	   Exceptional.description as &quot;תיאור&quot;,
  	   Count( AliyaHistory.prayer_Id) AS &quot;מס' עליות&quot;
  	From Prayers
  	Left Outer JOIN AliyaHistory ON  AliyaHistory.prayer_id = Prayers.id
  	Left Outer Join Exceptional ON Exceptional.prayer_id = Prayers.id
  	Left Outer Join Aliyah ON Exceptional.favorite_Aliya = Aliyah.Id
  	Left join Reason ON Reason.id = Exceptional.reason_id
  	Inner Join  Title On Title.id = Prayers.Title_ID
  	where Prayers.ID IN (
  		Select prayer_id
  		from Pray2syn 
  		where syn_id = @syn_id)
  	AND Title_ID =1
	AND (Exceptional.parasha_id is NULL OR Exceptional.isConst = 'True' Or Exceptional.parasha_id in ((SELECT TOP (1) 
       parashah
  	FROM fullkriyah
  Where date &gt;= getdate())))
  	Group By  Title_ID,Reason.Priority,Prayers.ID,PRIVATE_NAME,FAMILY_NAME, Aliyah.Name,Reason.name,Exceptional.description,Title.Name
) C
Union ALL 


Select Top (3) *
From
(


SELECT  Title_ID,
     CAST('24' AS INT) AS Reason,
     Prayers.ID AS 'ת&quot;ז',
     CONCAT ( Prayers.PRIVATE_NAME, '  ', Prayers.FAMILY_NAME ) AS &quot;שם מלא&quot;,
     Title.Name AS &quot;כהן/לוי/ישראל&quot;,
	 Null AS &quot;עליה מומלצת&quot;,
     'פרשת בר מצוה, אך הוא לא בן 13' AS &quot;סיבה&quot;,
     Null AS &quot;תיאור&quot;,
     Count( AliyaHistory.prayer_Id) AS &quot;מס' עליות&quot;
  FROM [dbo].[Prayers]
  Left Outer JOIN AliyaHistory ON  AliyaHistory.prayer_id = Prayers.ID
  Inner Join Title ON Title.ID = Prayers.TITLE_ID
  Inner Join (SELECT TOP (1)
       parashah
  	FROM fullkriyah
  Where date &gt;= getdate()) AS TodayParasha ON TodayParasha.parashah = Prayers.PARASHAT_BAR_MITZVA_ID
  Where Prayers.ID IN (
  Select prayer_id
  from Pray2syn 
  where syn_id = @syn_id) And Prayers.Title_ID = 2 AND (DATEDIFF(day,Prayers.BIRTHDAY,getdate())) &gt; 13
  Group By  Title_ID,Prayers.ID,Prayers.PRIVATE_NAME,Prayers.FAMILY_NAME,Title.Name

Union ALL
SELECT  Title_ID,
     CAST('29' AS INT) AS Reason,
     Prayers.ID AS 'ת&quot;ז',
     CONCAT ( Prayers.PRIVATE_NAME, '  ', Prayers.FAMILY_NAME ) AS &quot;שם מלא&quot;,
     Title.Name AS &quot;כהן/לוי/ישראל&quot;,
     Null AS &quot;עליה מומלצת&quot;,
     'בר מצווה' AS &quot;סיבה&quot;,
     Null AS &quot;תיאור&quot;,
     Count( AliyaHistory.prayer_Id) AS &quot;מס' עליות&quot;
  FROM [dbo].[Prayers]
  Left Outer JOIN AliyaHistory ON  AliyaHistory.prayer_id = Prayers.ID
  Inner Join Title ON Title.ID = Prayers.TITLE_ID
  Inner Join (SELECT TOP (1) 
       parashah
  	FROM fullkriyah
  Where date &gt;= getdate()) AS FavorityParasha ON FavorityParasha.parashah = Prayers.PARASHAT_BAR_MITZVA_ID
  Where Prayers.ID IN (
  Select prayer_id
  from Pray2syn 
  where syn_id = @syn_id) And Prayers.Title_ID = 2 AND (DATEDIFF(day,Prayers.BIRTHDAY,getdate())) = 13
  Group By  Title_ID,Prayers.ID,Prayers.PRIVATE_NAME,Prayers.FAMILY_NAME,Title.Name


Union ALL
	Select 
	   Title.ID as TitleID,
	   CAST('25' AS INT) AS Reason,
	   Prayers.ID AS 'ת&quot;ז',
	   CONCAT ( PRIVATE_NAME, '  ', FAMILY_NAME ) AS &quot;שם מלא&quot;,
	   Title.Name AS &quot;כהן/לוי/ישראל&quot;,
	   'מפטיר' AS &quot;עליה מומלצת&quot;,
	   'יארצייט אמא או אבא' AS &quot;סיבה&quot;,
	   Null AS &quot;תיאור&quot;,
	   Count( AliyaHistory.prayer_Id) AS &quot;מס' עליות&quot;
	From Prayers
	Left Outer JOIN AliyaHistory ON  AliyaHistory.prayer_id = Prayers.id
	Inner Join Title ON Title.ID = Prayers.TITLE_ID
	where Prayers.ID IN (
	Select prayer_id
	from Pray2syn 
	where syn_id = @syn_id) And Title_ID = 2 And IS_READING_MAFTIR = 1
	Group By  Title.ID,Prayers.ID,PRIVATE_NAME,FAMILY_NAME,Title.Name
	

Union ALL
  	Select 
  	   Title_ID,
  	   Reason.Priority,
  	   Prayers.ID,
  	   CONCAT ( PRIVATE_NAME, '  ', FAMILY_NAME ) AS &quot;שם מלא&quot;,
  	   Title.Name AS &quot;כהן/לוי/ישראל&quot;,
  	   Aliyah.Name as &quot;עליה מומלצת&quot;,
  	   Reason.name AS &quot;סיבה&quot;,
  	   Exceptional.description as &quot;תיאור&quot;,
  	   Count( AliyaHistory.prayer_Id) AS &quot;מס' עליות&quot;
  	From Prayers
  	Left Outer JOIN AliyaHistory ON  AliyaHistory.prayer_id = Prayers.id
  	Left Outer Join Exceptional ON Exceptional.prayer_id = Prayers.id
  	Left Outer Join Aliyah ON Exceptional.favorite_Aliya = Aliyah.Id
  	Left join Reason ON Reason.id = Exceptional.reason_id
  	Inner Join  Title On Title.id = Prayers.Title_ID
  	where Prayers.ID IN (
  		Select prayer_id
  		from Pray2syn 
  		where syn_id = @syn_id)
  	AND Title_ID =2
	AND (Exceptional.parasha_id is NULL OR Exceptional.isConst = 'True' Or Exceptional.parasha_id in ((SELECT TOP (1) 
       parashah
  	FROM fullkriyah
  Where date &gt;= getdate())))
  	Group By  Title_ID,Reason.Priority,Prayers.ID,PRIVATE_NAME,FAMILY_NAME, Aliyah.Name,Reason.name,Exceptional.description,Title.Name
) L

UNION ALL


Select Top (3) *
From
(


SELECT  Title_ID,
     CAST('24' AS INT) AS Reason,
     Prayers.ID AS 'ת&quot;ז',
     CONCAT ( Prayers.PRIVATE_NAME, '  ', Prayers.FAMILY_NAME ) AS &quot;שם מלא&quot;,
     Title.Name AS &quot;כהן/לוי/ישראל&quot;,
	 Null AS &quot;עליה מומלצת&quot;,
     'פרשת בר מצוה, אך הוא לא בן 13' AS &quot;סיבה&quot;,
     Null AS &quot;תיאור&quot;,
     Count( AliyaHistory.prayer_Id) AS &quot;מס' עליות&quot;
  FROM [dbo].[Prayers]
  Left Outer JOIN AliyaHistory ON  AliyaHistory.prayer_id = Prayers.ID
  Inner Join Title ON Title.ID = Prayers.TITLE_ID
  Inner Join (SELECT TOP (1)
       parashah
  	FROM fullkriyah
  Where date &gt;= getdate()) AS TodayParasha ON TodayParasha.parashah = Prayers.PARASHAT_BAR_MITZVA_ID
  Where Prayers.ID IN (
  Select prayer_id
  from Pray2syn 
  where syn_id = @syn_id) And Prayers.Title_ID = 3 AND (DATEDIFF(day,Prayers.BIRTHDAY,getdate())) &gt; 13
  Group By  Title_ID,Prayers.ID,Prayers.PRIVATE_NAME,Prayers.FAMILY_NAME,Title.Name

Union ALL
SELECT  Title_ID,
     CAST('29' AS INT) AS Reason,
     Prayers.ID AS 'ת&quot;ז',
     CONCAT ( Prayers.PRIVATE_NAME, '  ', Prayers.FAMILY_NAME ) AS &quot;שם מלא&quot;,
     Title.Name AS &quot;כהן/לוי/ישראל&quot;,
     Null AS &quot;עליה מומלצת&quot;,
     'בר מצווה' AS &quot;סיבה&quot;,
     Null AS &quot;תיאור&quot;,
     Count( AliyaHistory.prayer_Id) AS &quot;מס' עליות&quot;
  FROM [dbo].[Prayers]
  Left Outer JOIN AliyaHistory ON  AliyaHistory.prayer_id = Prayers.ID
  Inner Join Title ON Title.ID = Prayers.TITLE_ID
  Inner Join (SELECT TOP (1) 
       parashah
  	FROM fullkriyah
  Where date &gt;= getdate()) AS FavorityParasha ON FavorityParasha.parashah = Prayers.PARASHAT_BAR_MITZVA_ID
  Where Prayers.ID IN (
  Select prayer_id
  from Pray2syn 
  where syn_id = @syn_id) And Prayers.Title_ID = 3 AND (DATEDIFF(day,Prayers.BIRTHDAY,getdate())) = 13
  Group By  Title_ID,Prayers.ID,Prayers.PRIVATE_NAME,Prayers.FAMILY_NAME,Title.Name

Union ALL
	Select 
	   Title.ID as TitleID,
	   CAST('25' AS INT) AS Reason,
	   Prayers.ID AS 'ת&quot;ז',
	   CONCAT ( PRIVATE_NAME, '  ', FAMILY_NAME ) AS &quot;שם מלא&quot;,
	   Title.Name AS &quot;כהן/לוי/ישראל&quot;,
	   'מפטיר' AS &quot;עליה מומלצת&quot;,
	   'יארצייט אמא או אבא' AS &quot;סיבה&quot;,
	   Null AS &quot;תיאור&quot;,
	   Count( AliyaHistory.prayer_Id) AS &quot;מס' עליות&quot;
	From Prayers
	Left Outer JOIN AliyaHistory ON  AliyaHistory.prayer_id = Prayers.id
	Inner Join Title ON Title.ID = Prayers.TITLE_ID
	where Prayers.ID IN (
	Select prayer_id
	from Pray2syn 
	where syn_id = @syn_id) And Title_ID = 3 And IS_READING_MAFTIR = 1
	Group By  Title.ID,Prayers.ID,PRIVATE_NAME,FAMILY_NAME,Title.Name

Union ALL
  	Select 
  	   Title_ID,
  	   Reason.Priority,
  	   Prayers.ID,
  	   CONCAT ( PRIVATE_NAME, '  ', FAMILY_NAME ) AS &quot;שם מלא&quot;,
  	   Title.Name AS &quot;כהן/לוי/ישראל&quot;,
  	   Aliyah.Name as &quot;עליה מומלצת&quot;,
  	   Reason.name AS &quot;סיבה&quot;,
  	   Exceptional.description as &quot;תיאור&quot;,
  	   Count( AliyaHistory.prayer_Id) AS &quot;מס' עליות&quot;
  	From Prayers
  	Left Outer JOIN AliyaHistory ON  AliyaHistory.prayer_id = Prayers.id
  	Left Outer Join Exceptional ON Exceptional.prayer_id = Prayers.id
  	Left Outer Join Aliyah ON Exceptional.favorite_Aliya = Aliyah.Id
  	Left join Reason ON Reason.id = Exceptional.reason_id
  	Inner Join  Title On Title.id = Prayers.Title_ID
  	where Prayers.ID IN (
  		Select prayer_id
  		from Pray2syn 
  		where syn_id = @syn_id)
  	AND Title_ID =3
	AND (Exceptional.parasha_id is NULL OR Exceptional.isConst = 'True' Or Exceptional.parasha_id in ((SELECT TOP (1) 
       parashah
  	FROM fullkriyah
  Where date &gt;= getdate())))
  	Group By  Title_ID,Reason.Priority,Prayers.ID,PRIVATE_NAME,FAMILY_NAME, Aliyah.Name,Reason.name,Exceptional.description,Title.Name
) Y
) AS g
Order By Title_ID ASC , Reason DESC, &quot;מס' עליות&quot; DESC"></asp:SqlDataSource>


</asp:Content>
