<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeBehind="DailySalesmanReport.aspx.cs" Inherits="AIO.IDOS2.Web.Reports.DailySalesmanReport" %>

<%@ Register Assembly="DevExpress.XtraReports.v18.1.Web.WebForms, Version=18.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.XtraReports.v18.1.Web.WebForms, Version=18.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web.WebDocumentViewer" TagPrefix="cc1" %>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="server">
    <dx:ASPxWebDocumentViewer ID="documentViewer" runat="server" CssClass="commonDocumentViewer" ClientInstanceName="documentViewer" EnableViewState="false">
        <ClientSideEvents Init="documentViewer_initViewer" />
    </dx:ASPxWebDocumentViewer>
</asp:Content>
