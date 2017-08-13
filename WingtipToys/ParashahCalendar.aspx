<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ParashahCalendar.aspx.cs" Inherits="GabayManageSite.AliyaHistory" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" charset="utf-8"
 src="https://www.hebcal.com/hebcal/?v=1&amp;cfg=e2&amp;nh=on&amp;nx=on&amp;year=now&amp;month=x&amp;ss=on&amp;mf=on&amp;s=on&amp;i=on&amp;d=on&amp">
</script>
<script type="text/javascript"
 src="https://www.hebcal.com/i/calendar-2.0-min.js">
</script>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<link type="text/css" rel="stylesheet"
href="https://www.hebcal.com/i/jec-grey-min.css">
<style type="text/css">
#myCalendarContainer table { width: 800px }
#myCalendarContainer table td.dayHasEvent { height: 80px }
#myCalendarContainer table td.dayBlank { height: 80px }
</style>
</head>
<body>

    <form id="form1" runat="server">
    <div>
    <div id="myCalendarContainer"></div>
<script type="text/javascript">
var myCalendar = new JEC("myCalendarContainer",
   {tableClass: "greyCalendar", linkNewWindow: false});
myCalendar.defineEvents(HEBCAL.jec2events);
myCalendar.showCalendar();
</script>
    </div>
    </form>
</body>
</html>
