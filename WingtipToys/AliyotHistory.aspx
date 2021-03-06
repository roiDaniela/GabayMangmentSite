﻿

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

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" SelectCommand="SELECT Prayers.* 
 From Prayers
inner JOIN  Pray2Syn on Pray2Syn.prayer_id = Prayers.ID
where Pray2Syn.syn_id =@synId" ProviderName="<%$ ConnectionStrings:gabayConnectionString.ProviderName %>">
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
                            alert(params.prayer_id + " not inserted to table some error with the server");
                            droppedItem.remove();
                        }
                    });


            }
        }

        );


    });



</script>
    </asp:Content>