<%@ Page Title="Welcome to Gabay Managment website" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GabayManageSite._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <h1><%: Title %>.</h1>
        <h2>The perfect solution for your shul</h2>
        <% if (Session["currSynId"] == null || String.IsNullOrEmpty(Session["currSynId"].ToString())){ %>            
        <asp:LoginView runat="server" ViewStateMode="Disabled">
        <AnonymousTemplate>
            <p>Please <a runat="server" href="~/Account/Login">log in</a> or <a runat="server" href="~/Account/Register">register</a></p>  
        </AnonymousTemplate>
        </asp:LoginView>                
        <% } %>
</asp:Content>
