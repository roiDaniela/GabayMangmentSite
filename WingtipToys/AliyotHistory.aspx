<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AliyotHistory.aspx.cs" Inherits="GabayManageSite.AliyotHistory" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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

</head>
<body>
    <form id="form1" runat="server">
    <div>
        
        <div>
            <asp:Button ID="ButtonApply" runat="server" OnClick="ButtonApply_Click" style="direction: rtl" Text="Apply" />
            <asp:Button ID="ButtonClear" runat="server" OnClick="ButtonClear_Click1" Text="Clear" />
        </div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2">
            <Columns>
                <asp:BoundField DataField="מס' עליה" HeaderText="מס' עליה" SortExpression="מס' עליה" />
                <asp:BoundField DataField="פסוקים" HeaderText="פסוקים" SortExpression="פסוקים" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:gabayConnectionString %>" ProviderName="<%$ ConnectionStrings:gabayConnectionString.ProviderName %>" SelectCommand="Select  fullkriyah.ID, Aliyah.Name AS &quot;מס' עליה&quot;,
	   Reading.name AS &quot;פסוקים&quot;
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

    <div id="shoppingCart" style="width:277px; overflow:auto; height:521px; background-color:yellow;position:absolute;top:23px; left:688px;">
    <div id="header" style="text-align:center"><h3>Aliyot Order</h3></div>

    <div>
    
    </div>

    </div>

    </div>
    </form>
</body>
</html>

<script language="javascript" type="text/javascript">

    function loadProductsFromUser() {

        var params = new Object();
        params.userName = "azamsharp";

        $.ajax(

        {
            type: "POST",
            data: $.toJSON(params),
            dataType: "json",
            contentType: "application/json",
            url: "AjaxService.asmx/GetProductByUserName",
            success: function (response) {

                var products = $.evalJSON(response.d);

                for (i = 0; i <= products.length; i++) {

                    var list = $("#items");
                    var div = document.createElement("div");
                    div.innerHTML = products[i].ProductCode;


                    // you can store more information about the product in the UserProducts table
                    // and then display it over here! 

                    $(list).append(div);                    
                }

            }

        });

    }


    $(document).ready(function () {


       // loadProductsFromUser();


        $(".block").draggable({ helper: 'clone' });

        // drag zone 

        $("#shoppingCart").droppable(

        {
            accept: ".block",
            drop: function (ev, ui) {

                var droppedItem = $(ui.draggable).clone(); 
                $(this).append(droppedItem);

                var productCode = jQuery.trim($(droppedItem).children("ul").children(".productCode").text());

                // ajax request to persist product for the user 

                var params = new Object();
                params.productCode = productCode;
                params.userName = "azamsharp";

                $.ajax(

                {
                    type: "POST",
                    data: $.toJSON(params),
                    contentType: "application/json",
                    url: "AjaxService.asmx/SaveProduct",
                    success: function (response) {

                    }

                });


            }
        }

        );


    });



</script>