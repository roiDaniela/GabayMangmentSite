<%@ Page Title="Welcome to Gabay Managment website" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="GabayManageSite._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div style="width: 1400px; margin: 0 10%;">
        <h1><%: Title %>.</h1>
        <h2>The perfect solution for your shul!</h2>
    </div>
        <% if (Session["currSynId"] == null || String.IsNullOrEmpty(Session["currSynId"].ToString())){ %>            
        <asp:LoginView runat="server" ViewStateMode="Disabled">
        <AnonymousTemplate>
            <div style="width: 1400px; margin: 0 10%;">
                <br />
                <p>First steps for new users:</p>
                <br />
                <p>1. Please check your <a runat="server" href="~/Synagoges"> synagoge</a> is exist or add it.</p>
                <br />
                <p>2. <a runat="server" href="~/Account/Register">Register</a>.</p>  
                <br />
                <br />
                <p>Seniors can just <a runat="server" href="~/Account/Login">log in</a>.</p>
            </div>
        </AnonymousTemplate>
        </asp:LoginView>                
        <% } %>
</asp:Content>
