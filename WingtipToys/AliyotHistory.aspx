

<%@ Page Title="Aliyot History" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AliyotHistory.aspx.cs" Inherits="GabayManageSite.AliyotHistory" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
            <br />
    <script src="/scripts/jQuery.min.js" type="text/javascript"></script>
    <script src="/scripts/jQuery.ui.js" type="text/javascript"></script>
    <script src="/scripts/jQuery-json.js" type="text/javascript"></script>
    <style type="text/css">

.block 
{
    z-index:9999;
    cursor:move;
}

.productCode 
{
    
}


li
{
    list-style:none;
}

</style>

    <% if (Session["currSynId"] != null && !String.IsNullOrEmpty(Session["currSynId"].ToString())){ %>            
    
    <div>
        <h3 style="text-align: center;">בית הכנסת <%:Session["currSynName"] %></h3> 

        <h3 style="text-align: center;">
            <asp:Label ID="LabelHebDate" runat="server" Text="Label"></asp:Label>
        </h3>
        <h3 style="text-align: center;">
             פרשת <asp:HyperLink ID="HyperLinkParasha" runat="server">HyperLink</asp:HyperLink>
        </h3>

        <div>
        </div>
        <asp:GridView ID="GridView1" runat="server" HorizontalAlign="Center" DataSourceID="SqlDataSource2" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" CssClass="table table-striped table-bordered" Width="30%" OnRowDataBound="GridView1_RowDataBound">
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" ProviderName="<%$ ConnectionStrings:gabayConnectionString.ProviderName %>" SelectCommand="Select  fullkriyah.ID,  Reading.name AS &quot;פסוקים&quot;,Aliyah.Name AS &quot;מס' עליה&quot;
	  
From fullkriyah
Inner Join Reading On Reading.Id = fullkriyah.torah
Inner Join Aliyah On Aliyah.id = fullkriyah.Aliyah
Where date in (
	SELECT TOP (1) date
	From fullkriyah
	INNER JOin Parashot ON fullkriyah.parashah = Parashot.id
	Where getdate() &gt; date
	Order By date DESC
)"></asp:SqlDataSource>
        
            <div style="text-align: center;  align-content:center; align-self:center; align-items:center; vertical-align: middle; ">
                <asp:Button ID="ButtonClear" runat="server" 
                 CssClass = "SElementHide" OnClick="ButtonClear_Click1" Text="Clear"/>
            </div>
        

    <table style="margin: 0px auto;">

    <tr>
    <td style="padding:0 15px 0 15px;">
    <asp:DataList ID="dlProducts" RepeatDirection="Horizontal" RepeatColumns="3" runat="server" DataSourceID="SqlDataSource1">
    <ItemTemplate>
    
    <div class="block" style="width:150px;background-color:lightgreen;padding:10px;margin:10px">
    
    <ul>
    <li>
    <%# Eval("PRIVATE_NAME") %>
    </li>

    <li>
     <%# Eval("FAMILY_NAME") %>
    </li>

    <li class="productCode">
    <%# Eval("ID") %>
    </li>


    </ul>

 
    </div>

    </ItemTemplate>
    
    </asp:DataList>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="
select ID,PRIVATE_NAME, FAMILY_NAME
From
(
Select Top (3) *
From
(
  	Select 
  	   Title_ID,
  	   Reason.Priority,
  	   Prayers.ID,
  	 --CONCAT ( PRIVATE_NAME, '  ', FAMILY_NAME ) AS &quot;שם מלא&quot;,
	   PRIVATE_NAME,FAMILY_NAME,
  	   Title.Name AS &quot;כהן/לוי/ישראל&quot;,
  	   Aliyah.Name as &quot;עליה מומלצת&quot;,
  	   Reason.name AS &quot;סיבה&quot;,
  	   Exceptional2.description as &quot;תיאור&quot;,
  	   Count( AliyaHistory.prayer_Id) AS &quot;מספר העליות&quot;
  	From Prayers
  	Left Outer JOIN (SELECT [prayer_id]
      ,[syn_id]
      ,[fullkriyah_id]
      ,[ref]
  FROM [dbo].[AliyaHistory]
  Where [fullkriyah_id] IN (SELECT 
	id
  	FROM fullkriyah
    Where date &lt; getdate())) AS AliyaHistory ON  AliyaHistory.prayer_id = Prayers.id
  	Left Outer Join (
	Select prayer_id,reason_id,description,favorite_Aliya from Exceptional INNER JOIN Exceptional2Date ON Exceptional2Date.exceptional_id = Exceptional.ref  where Exceptional2Date.date in (SELECT TOP (1) 
	date
  	FROM fullkriyah
    Where date &lt; getdate() Order By date Desc)) AS Exceptional2 ON Exceptional2.prayer_id = Prayers.id
  	Left Outer Join Aliyah ON Exceptional2.favorite_Aliya = Aliyah.Id
  	Left join Reason ON Reason.id = Exceptional2.reason_id
  	Inner Join  Title On Title.id = Prayers.Title_ID
  	where Prayers.ID IN (
  		Select prayer_id
  		from Pray2syn 
  		where syn_id = @synId)
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
  	-- CONCAT ( PRIVATE_NAME, '  ', FAMILY_NAME ) AS &quot;שם מלא&quot;,
  	   PRIVATE_NAME,FAMILY_NAME,
	   Title.Name AS &quot;כהן/לוי/ישראל&quot;,
  	   Aliyah.Name as &quot;עליה מומלצת&quot;,
  	   Reason.name AS &quot;סיבה&quot;,
  	   Exceptional2.description as &quot;תיאור&quot;,
  	   Count( AliyaHistory.prayer_Id) AS &quot;מס עליות&quot;
  	From Prayers
  	Left Outer JOIN (SELECT [prayer_id]
      ,[syn_id]
      ,[fullkriyah_id]
      ,[ref]
  FROM [dbo].[AliyaHistory]
  Where [fullkriyah_id] IN (SELECT 
	id
  	FROM fullkriyah
    Where date &lt; getdate())) AS AliyaHistory ON  AliyaHistory.prayer_id = Prayers.id
  	Left Outer Join (
	Select prayer_id,reason_id,description,favorite_Aliya from Exceptional INNER JOIN Exceptional2Date ON Exceptional2Date.exceptional_id = Exceptional.ref  where Exceptional2Date.date in (SELECT TOP (1) 
	date
  	FROM fullkriyah
    Where date &lt; getdate() Order By date Desc)) AS Exceptional2 ON Exceptional2.prayer_id = Prayers.id
  	Left Outer Join Aliyah ON Exceptional2.favorite_Aliya = Aliyah.Id
  	Left join Reason ON Reason.id = Exceptional2.reason_id
  	Inner Join  Title On Title.id = Prayers.Title_ID
  	where Prayers.ID IN (
  		Select prayer_id
  		from Pray2syn 
  		where syn_id = @synId)
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
  	-- CONCAT ( PRIVATE_NAME, '  ', FAMILY_NAME ) AS &quot;שם מלא&quot;,
	   PRIVATE_NAME,FAMILY_NAME,
  	   Title.Name AS &quot;כהן/לוי/ישראל&quot;,
  	   Aliyah.Name as &quot;עליה מומלצת&quot;,
  	   Reason.name AS &quot;סיבה&quot;,
  	   Exceptional2.description as &quot;תיאור&quot;,
  	   Count( AliyaHistory.prayer_Id) AS &quot;מס עליות&quot;
  	From Prayers
  	Left Outer JOIN (SELECT [prayer_id]
      ,[syn_id]
      ,[fullkriyah_id]
      ,[ref]
  FROM [dbo].[AliyaHistory]
  Where [fullkriyah_id] IN (SELECT 
	id
  	FROM fullkriyah
    Where date &lt; getdate())) AS AliyaHistory ON  AliyaHistory.prayer_id = Prayers.id
  	Left Outer Join (
	Select prayer_id,reason_id,description,favorite_Aliya from Exceptional INNER JOIN Exceptional2Date ON Exceptional2Date.exceptional_id = Exceptional.ref  where Exceptional2Date.date in (SELECT TOP (1) 
	date
  	FROM fullkriyah
    Where date &lt; getdate() Order By date Desc)) AS Exceptional2 ON Exceptional2.prayer_id = Prayers.id
  	Left Outer Join Aliyah ON Exceptional2.favorite_Aliya = Aliyah.Id
  	Left join Reason ON Reason.id = Exceptional2.reason_id
  	Inner Join  Title On Title.id = Prayers.Title_ID
  	where Prayers.ID IN (
  		Select prayer_id
  		from Pray2syn 
  		where syn_id = @synId)
  AND Title_ID =3
  Group By  Title_ID,Reason.Priority,Prayers.ID,PRIVATE_NAME,FAMILY_NAME, Aliyah.Name,Reason.name,Exceptional2.description,Title.Name
 )Y
  Order By Priority DESC,&quot;מס עליות&quot; ASC
) AS g
--Order By Title_ID ASC , Priority DESC, &quot;מספר העליות&quot; ASC

UNION ALL

SELECT ID,PRIVATE_NAME, FAMILY_NAME
 From Prayers
inner JOIN  Pray2Syn on Pray2Syn.prayer_id = Prayers.ID
where Pray2Syn.syn_id =@synId AND Prayers.ID NOT IN 
(
Select ID
From
(
Select Top (3) *
From
(
  	Select 
  	   Title_ID,
  	   Reason.Priority,
  	   Prayers.ID,
  	 --CONCAT ( PRIVATE_NAME, '  ', FAMILY_NAME ) AS &quot;שם מלא&quot;,
	   PRIVATE_NAME,FAMILY_NAME,
  	   Title.Name AS &quot;כהן/לוי/ישראל&quot;,
  	   Aliyah.Name as &quot;עליה מומלצת&quot;,
  	   Reason.name AS &quot;סיבה&quot;,
  	   Exceptional2.description as &quot;תיאור&quot;,
  	   Count( AliyaHistory.prayer_Id) AS &quot;מספר העליות&quot;
  	From Prayers
  	Left Outer JOIN (SELECT [prayer_id]
      ,[syn_id]
      ,[fullkriyah_id]
      ,[ref]
  FROM [dbo].[AliyaHistory]
  Where [fullkriyah_id] IN (SELECT 
	id
  	FROM fullkriyah
    Where date &lt; getdate())) AS AliyaHistory ON  AliyaHistory.prayer_id = Prayers.id
  	Left Outer Join (
	Select prayer_id,reason_id,description,favorite_Aliya from Exceptional INNER JOIN Exceptional2Date ON Exceptional2Date.exceptional_id = Exceptional.ref  where Exceptional2Date.date in (SELECT TOP (1) 
	date
  	FROM fullkriyah
    Where date &lt; getdate() Order By date Desc)) AS Exceptional2 ON Exceptional2.prayer_id = Prayers.id
  	Left Outer Join Aliyah ON Exceptional2.favorite_Aliya = Aliyah.Id
  	Left join Reason ON Reason.id = Exceptional2.reason_id
  	Inner Join  Title On Title.id = Prayers.Title_ID
  	where Prayers.ID IN (
  		Select prayer_id
  		from Pray2syn 
  		where syn_id = @synId)
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
  	-- CONCAT ( PRIVATE_NAME, '  ', FAMILY_NAME ) AS &quot;שם מלא&quot;,
  	   PRIVATE_NAME,FAMILY_NAME,
	   Title.Name AS &quot;כהן/לוי/ישראל&quot;,
  	   Aliyah.Name as &quot;עליה מומלצת&quot;,
  	   Reason.name AS &quot;סיבה&quot;,
  	   Exceptional2.description as &quot;תיאור&quot;,
  	   Count( AliyaHistory.prayer_Id) AS &quot;מס עליות&quot;
  	From Prayers
  	Left Outer JOIN (SELECT [prayer_id]
      ,[syn_id]
      ,[fullkriyah_id]
      ,[ref]
  FROM [dbo].[AliyaHistory]
  Where [fullkriyah_id] IN (SELECT 
	id
  	FROM fullkriyah
    Where date &lt; getdate())) AS AliyaHistory ON  AliyaHistory.prayer_id = Prayers.id
  	Left Outer Join (
	Select prayer_id,reason_id,description,favorite_Aliya from Exceptional INNER JOIN Exceptional2Date ON Exceptional2Date.exceptional_id = Exceptional.ref  where Exceptional2Date.date in (SELECT TOP (1) 
	date
  	FROM fullkriyah
    Where date &lt; getdate() Order By date Desc)) AS Exceptional2 ON Exceptional2.prayer_id = Prayers.id
  	Left Outer Join Aliyah ON Exceptional2.favorite_Aliya = Aliyah.Id
  	Left join Reason ON Reason.id = Exceptional2.reason_id
  	Inner Join  Title On Title.id = Prayers.Title_ID
  	where Prayers.ID IN (
  		Select prayer_id
  		from Pray2syn 
  		where syn_id = @synId)
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
  	-- CONCAT ( PRIVATE_NAME, '  ', FAMILY_NAME ) AS &quot;שם מלא&quot;,
	   PRIVATE_NAME,FAMILY_NAME,
  	   Title.Name AS &quot;כהן/לוי/ישראל&quot;,
  	   Aliyah.Name as &quot;עליה מומלצת&quot;,
  	   Reason.name AS &quot;סיבה&quot;,
  	   Exceptional2.description as &quot;תיאור&quot;,
  	   Count( AliyaHistory.prayer_Id) AS &quot;מס עליות&quot;
  	From Prayers
  	Left Outer JOIN (SELECT [prayer_id]
      ,[syn_id]
      ,[fullkriyah_id]
      ,[ref]
  FROM [dbo].[AliyaHistory]
  Where [fullkriyah_id] IN (SELECT 
	id
  	FROM fullkriyah
    Where date &lt; getdate())) AS AliyaHistory ON  AliyaHistory.prayer_id = Prayers.id
  	Left Outer Join (
	Select prayer_id,reason_id,description,favorite_Aliya from Exceptional INNER JOIN Exceptional2Date ON Exceptional2Date.exceptional_id = Exceptional.ref  where Exceptional2Date.date in (SELECT TOP (1) 
	date
  	FROM fullkriyah
    Where date &lt; getdate() Order By date Desc)) AS Exceptional2 ON Exceptional2.prayer_id = Prayers.id
  	Left Outer Join Aliyah ON Exceptional2.favorite_Aliya = Aliyah.Id
  	Left join Reason ON Reason.id = Exceptional2.reason_id
  	Inner Join  Title On Title.id = Prayers.Title_ID
  	where Prayers.ID IN (
  		Select prayer_id
  		from Pray2syn 
  		where syn_id = @synId)
  AND Title_ID =3
  Group By  Title_ID,Reason.Priority,Prayers.ID,PRIVATE_NAME,FAMILY_NAME, Aliyah.Name,Reason.name,Exceptional2.description,Title.Name
 )Y
  Order By Priority DESC,&quot;מס עליות&quot; ASC
) AS g
)
" ProviderName="<%$ ConnectionStrings:gabayConnectionString.ProviderName %>">
            <SelectParameters>
                <asp:SessionParameter Name="synId" SessionField="currSynId" />
            </SelectParameters>
        </asp:SqlDataSource>
    </td>
    <td style="padding:0 150px 0 150px;">
    <div id="shoppingCart" style="width:339px; overflow:auto; height:754px; background-color:yellow; margin-left: 16px;">
    <div id="header" style="text-align:center"><h3>Aliyot Order</h3></div>

    <div id="AliyotOrderList">
    
    </div>

    </div>

    </div>
    </td>
    </tr>
    </table>
        <%} %>
<script type="text/javascript">
    function GetCurrSynId()
    {
          return '<%= Session["currSynId"] %>';
    }
    function loadProductsFromUser() {

        var params = new Object();

        params.synid = GetCurrSynId();

        //params.synid = 7;

        $.ajax(

        {
            type: "POST",
            data: $.toJSON(params),
            dataType: "json",
            contentType: "application/json",
            url: "Services/AjaxService.asmx/GetPrayerBySynagoge",
            success: function (response) {

                var prayers = $.evalJSON(response.d);

                for (i = 0; i < prayers.length; i++) {

                    var list = $("#AliyotOrderList");
                    var div = document.createElement("div");
                    //Findding Node
                    var table = document.getElementById("MainContent_dlProducts");
                    for (r = 0; r < table.rows.length; r++) {
                        for (c = 0; c < table.rows[r].cells.length; c++) {
                            if (table.rows.item(r).cells.item(c).innerHTML != "") {
                                var prayerID = table.rows.item(r).cells.item(c).querySelector(".productCode").innerHTML.trim(" ");
                                if (prayerID == prayers[i].PrayerIDString.trim(" ")) {
                                    div.innerHTML = table.rows.item(r).cells.item(c).innerHTML;
                                }
                            }
                        }
                    }

                    // you can store more information about the product in the UserProducts table
                    // and then display it over here! 

                    $(list).append(div);                    
                }

            }

        });

    }


    $(document).ready(function () {


        loadProductsFromUser();


        $(".block").draggable({ helper: 'clone' });

        // drag zone 

        $("#shoppingCart").droppable(

        {
            accept: ".block",
            drop: function (ev, ui) {
                $(".block").draggable({ disabled: true });
                var droppedItem = $(ui.draggable).clone(); 
                $(this).append(droppedItem);

                var productCode = jQuery.trim($(droppedItem).children("ul").children(".productCode").text());
                var shoppingCart = document.getElementById("shoppingCart");
                var rowIndex = shoppingCart.childElementCount - 2;
                var kriyaTable = document.getElementById("MainContent_GridView1");
                var kriyaId = kriyaTable.rows[rowIndex].cells[0].innerHTML;
                //window.alert(productCode + " " + kriyaId);

                // ajax request to persist product for the user 

                var params = new Object();
                params.prayer_id = productCode;
                params.kriyaId = kriyaId;
                params.synId = GetCurrSynId();
                $.ajax(

                    {
                        type: "POST",
                        data: $.toJSON(params),
                        contentType: "application/json",
                        url: "Services/AjaxService.asmx/SaveAliyaHistory",
                        success: function (response) {
                            $(".block").draggable({ disabled: false });
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            alert(params.prayer_id + " not inserted to table some error, may some error with server or disconnected try refreshing the page");
                            droppedItem.remove();
                        }
                    });


            }
        }

        );


    });



</script>
    </asp:Content>