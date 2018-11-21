<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeBehind="Error.aspx.cs" Inherits="AIO.IDOS2.Web.Reports.Error" %>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="server">
    <table style="padding: 20px;">
        <tr>
            <td>
                <img src="Content/images/error_96px.png" />
            </td>
            <td>
                <div style="padding: 10px; font-family: 'Calibri'">
                    <h2>iDOS 2.0 Reports Error</h2>
                    <p>
                        An error has occured. You may try again this operation.<br />
                        If the problems still exists, please contact your administrator.<br /><br />
                        <b>Error ID:&nbsp<span style="color: red"><%= ViewState["ErrorID"] %></span></b><br />
                        <b>Error Message:</b>&nbsp;<%= ViewState["ErrorMessage"] %>
                    </p>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
