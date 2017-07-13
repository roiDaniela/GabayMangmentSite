<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="GabayManageSite.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %>.</h2>
    <address>
        <a href="https://www.mta.ac.il/en-us">Tel Aviv Academic College</a><br />
        Khever ha-Le'umim St 10, Tel Aviv-Yafo.
        <br />
        <abbr title="Phone">Phone:</abbr>
        03-680-3333
    </address>

    <address>
        <strong>Roi:</strong>   <a href="mailto:roifo@mail.mta.ac.il">roifo@mail.mta.ac.il</a><br />
        <strong>Eran:</strong> <a href="mailto:erankatz91@gmail.com">erankatz91@gmail.com</a>
    </address>
</asp:Content>
