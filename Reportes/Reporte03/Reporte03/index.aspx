<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Reporte03.index" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Crystal Decisions</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <fieldset>
        <div>
        Concepto
        <asp:TextBox ID="TextBox1" runat="server" Text="C000000001" ></asp:TextBox>
        </div>
        <div>
        Preciario
        <asp:TextBox ID="TextBox2" runat="server" Text="PRC0001" ></asp:TextBox>
        </div>
        </fieldset>
         
        <asp:Button ID="btn1" runat="server" Text="Ocultar" OnClick="hideReport" />
        <CR:CrystalReportViewer ID="Productos" runat="server" AutoDataBind="true" />
        <asp:Button ID="btn2" runat="server" Text="Mostrar" OnClick="showReport" />
         
        <asp:Button ID="btn3" runat="server" Text="Vista Previa de Productos"  OnClick="getReportParam"/>

        <asp:Button ID="Button8" runat="server" Text="Vista Previa de Presupuestos"  CommandArgument="Presupuesto" OnCommand="toPreview" />
        <asp:Button ID="btn4" runat="server" Text="Generar Presupuesto XLS" CommandArgument="Presupuesto" OnCommand="toXLS"/>
        <asp:Button ID="btn5" runat="server" Text="Generar Presupuesto PDF" CommandArgument="Presupuesto" OnCommand="toPDF"/>
        
        <asp:Button ID="btn6" runat="server" Text="Vista Previa de Estimaciones" CommandArgument="Estimaciones" OnCommand="toPreview" />
        <asp:Button ID="btn7" runat="server" Text="Estimaciones a PDF" CommandArgument="Estimaciones" OnCommand="toPDF" /> 
        <asp:Button ID="btn8" runat="server" Text="Estimaciones a XLS" CommandArgument="Estimaciones" OnCommand="toXLS"/>

        <asp:Button ID="Button1" runat="server" Text="Vista Previa de ResumenPartidas" CommandArgument="ResumenPartidas" OnCommand="toPreview" />
        <asp:Button ID="Button2" runat="server" Text="ResumenPartidas a PDF" CommandArgument="ResumenPartidas" OnCommand="toPDF" /> 
        <asp:Button ID="Button3" runat="server" Text="ResumenPartidas a XLS" CommandArgument="ResumenPartidas" OnCommand="toXLS"/>

        <asp:Button ID="Button4" runat="server" Text="Vista Previa de AdministracionDeInmuebles" CommandArgument="AdministracionDeInmuebles" OnCommand="toPreview" />
        <asp:Button ID="Button5" runat="server" Text="AdministracionDeInmuebles a PDF" CommandArgument="AdministracionDeInmuebles" OnCommand="toPDF" /> 
        <asp:Button ID="Button6" runat="server" Text="AdministracionDeInmuebles a XLS" CommandArgument="AdministracionDeInmuebles" OnCommand="toXLS"/>
        <br />
        <asp:Button ID="Button7" runat="server" Text="Cambios Preciario a PDF" CommandArgument="CPreciario" OnCommand="toPDF" /> 

        <asp:Button ID="Button9" runat="server" Text="Cambios Preciario a XLS" CommandArgument="CPreciario" OnCommand="toXLS" /> 

        <asp:Button ID="Button10" runat="server" Text="Vista Previa de Cambios Preciario" CommandArgument="CPreciario" OnCommand="toPreviewImg" /> 


        <div style="margin-left: auto;margin-right: auto;width: 50%;">
            <CR:CrystalReportViewer ID="ReportsPreview" runat="server" AutoDataBind="true" /> 
        </div>
    
    </div>
    </form>
</body>
</html>
