using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Web;
using CrystalDecisions.Shared;

namespace Reporte03
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void showReport(object sender, EventArgs e)
        {
            ReportsPreview.Visible = true;
        }
        protected void hideReport(object sender, EventArgs e)
        {
            ReportsPreview.Visible = false;
        }

        protected void toPreview(object sender, CommandEventArgs e)
        {
            try
            {
                string namereport = ((Button)sender).CommandArgument.ToString();
                string path = AppDomain.CurrentDomain.BaseDirectory;
                var reporte = new ReportDocument();
                reporte.Load(Server.MapPath(namereport + ".rpt"));
                //reporte.DataSourceConnections[0].SetConnection("GIOVANNI-PC", "CrystalReportDB", "sa", "");
                //reporte.SetParameterValue("pCliente", path);
                ReportsPreview.ToolPanelView = ToolPanelViewType.None;
                ReportsPreview.Visible = true;
                ReportsPreview.ReportSource = reporte;
            } // end try
            catch (Exception ex)
            {
                ex.Message.ToString();
            }
        }

        protected void toPreviewImg(object sender, CommandEventArgs e)
        {
            string namereport = ((Button)sender).CommandArgument.ToString();
            var conn = new SqlConnection("Data Source=GIOVANNI-PC;Initial Catalog=OSEF_ERP;User Id=sa;Password=");
            try
            {
                using (var comando = new SqlCommand("web_spS_ObtenerCambiosPreciario", conn))
                {
                    using (var adaptador = new SqlDataAdapter(comando))
                    {
                        DataTable dt = new DataTable();
                        adaptador.SelectCommand.CommandType = CommandType.StoredProcedure;
                        adaptador.SelectCommand.Parameters.Add(@"idconcepto", SqlDbType.NVarChar).Value = TextBox1.Text;
                        adaptador.SelectCommand.Parameters.Add(@"idpreciario", SqlDbType.NVarChar).Value = TextBox2.Text;
                        adaptador.Fill(dt);
                        string path = AppDomain.CurrentDomain.BaseDirectory;
                        var reporte = new ReportDocument();
                        reporte.Load(Server.MapPath(namereport + ".rpt"));
                        reporte.SetDataSource(dt);
                        dt.Dispose();
                        reporte.DataSourceConnections[0].SetConnection("GIOVANNI-PC", "OSEF_ERP", "sa", "");
                        reporte.SetParameterValue("path", path);
                        //reporte.SetParameterValue(@"idconcepto", TextBox1.Text);
                        //reporte.SetParameterValue(@"idpreciario", TextBox2.Text);
                        ReportsPreview.ToolPanelView = ToolPanelViewType.None;
                        ReportsPreview.Visible = true;
                        ReportsPreview.ReportSource = reporte;
                    } // end using adaptador
                } // end using comando
            } // end try
            catch (Exception ex)
            {
                ex.Message.ToString();
            }
            finally
            {
                if (conn.State != ConnectionState.Closed)
                    conn.Close();
                conn.Dispose();
            }

        }
        public static string datePatt = @"M/d/yyyy hh:mm:ss tt";
        protected void toPDF(object sender, CommandEventArgs e)
        {
            string namereport = ((Button)sender).CommandArgument.ToString();
            var reporte = new ReportDocument();
            try
            {
                string path = AppDomain.CurrentDomain.BaseDirectory;
                reporte.Load(Server.MapPath(namereport + ".rpt"));
                reporte.SetParameterValue("path", path);
                reporte.SetParameterValue("@idconcepto", TextBox1.Text);
                reporte.SetParameterValue("@idpreciario", TextBox2.Text);
                reporte.ExportToDisk(ExportFormatType.PortableDocFormat, path + "//" + namereport + ".pdf");
                ClientScript.RegisterStartupScript(this.Page.GetType(), "popupOpener", "var popup=window.open('" + namereport + ".pdf');popup.focus();", true);
            } // end try
            catch (Exception ex)
            {
                ex.Message.ToString();
            }
            finally
            {
                reporte.Database.Dispose();
                reporte.Close();
                reporte.Dispose();
            }
        }

        protected void toXLS(object sender, CommandEventArgs e)
        {
            string namereport = ((Button)sender).CommandArgument.ToString();
            string path = AppDomain.CurrentDomain.BaseDirectory;
            var reporte = new ReportDocument();
            try
            {
                reporte.Load(Server.MapPath(namereport + ".rpt"));
                reporte.SetParameterValue("path", path);
                reporte.SetParameterValue("@idconcepto", TextBox1.Text);
                reporte.SetParameterValue("@idpreciario", TextBox2.Text);
                ExportOptions CrExportOptions;
                DiskFileDestinationOptions CrDiskFileDestinationOptions = new DiskFileDestinationOptions();
                ExcelFormatOptions CrFormatTypeOptions = new ExcelFormatOptions();
                CrDiskFileDestinationOptions.DiskFileName = Server.MapPath(namereport + ".xls");
                CrExportOptions = reporte.ExportOptions;
                CrExportOptions.ExportDestinationType = ExportDestinationType.DiskFile;
                CrExportOptions.ExportFormatType = ExportFormatType.Excel;
                CrExportOptions.DestinationOptions = CrDiskFileDestinationOptions;
                CrExportOptions.FormatOptions = CrFormatTypeOptions;
                reporte.Export();
                ClientScript.RegisterStartupScript(this.Page.GetType(), "popupOpener", "var popup=window.open('" + namereport + ".xls');popup.focus();", true);
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
            }
            finally
            {
                reporte.Database.Dispose();
                reporte.Close();
                reporte.Dispose();
            }
        }

        //START USING STORED PROCEDURES

        protected void getReportParam(object sender, EventArgs e)
        {

            var conn = new SqlConnection("Data Source=GIOVANNI-PC;Initial Catalog=CrystalReportDB;User Id=sa;Password=");
            try
            {
                using (var comando = new SqlCommand("EXEC [dbo].[SP_GetProductsById];", conn))
                {
                    using (var adaptador = new SqlDataAdapter(comando))
                    {
                        DataTable dt = new DataTable();
                        adaptador.SelectCommand.CommandType = CommandType.StoredProcedure;
                        adaptador.SelectCommand.Parameters.Add("@IdPro", SqlDbType.Int).Value = TextBox1.Text;
                        adaptador.Fill(dt);
                        string path = AppDomain.CurrentDomain.BaseDirectory;

                        var reporte = new ReportDocument();
                        reporte.Load(Server.MapPath("Productos.rpt"));
                        reporte.SetDataSource(dt);
                        reporte.DataSourceConnections[0].SetConnection("GIOVANNI-PC", "CrystalReportDB", "sa", "");
                        reporte.SetParameterValue("path", path);
                        Productos.ToolPanelView = ToolPanelViewType.None;
                        Productos.Visible = true;
                        Productos.ReportSource = reporte;

                        //Start DataList
                        //adaptador.Fill(dt);
                        //End DataList
                    } // end using adaptador
                } // end using comando
            } // end try
            catch (Exception ex)
            {
                ex.Message.ToString();
            }
            finally
            {
                if (conn.State != ConnectionState.Closed)
                    conn.Close();
                conn.Dispose();
            }
        }



        protected void getReportBySP(object sender, CommandEventArgs e)
        {
            string namereport = ((Button)sender).CommandArgument.ToString();
            string param = TextBox1.Text;
            if (param != "")
            {
                var conn = new SqlConnection("Data Source=GIOVANNI-PC;Initial Catalog=CrystalReportDB;User Id=sa;Password=");
                try
                {
                    using (var comando = new SqlCommand("EXEC [dbo].[SP_GetProducts];", conn))
                    {
                        using (var adaptador = new SqlDataAdapter(comando))
                        {
                            //DataTable dt = new DataTable(); 
                            //adaptador.Fill(dt);
                            string path = AppDomain.CurrentDomain.BaseDirectory;
                            var reporte = new ReportDocument();
                            reporte.Load(Server.MapPath(namereport + ".rpt"));
                            //reporte.SetDataSource(dt);
                            reporte.DataSourceConnections[0].SetConnection("GIOVANNI-PC", "CrystalReportDB", "sa", "");
                            reporte.SetParameterValue("path", path);
                            Productos.ToolPanelView = ToolPanelViewType.None;
                            Productos.Visible = true;
                            Productos.ReportSource = reporte;
                        } // end using adaptador
                    } // end using comando
                } // end try
                catch (Exception ex)
                {
                    ex.Message.ToString();
                }
                finally
                {
                    if (conn.State != ConnectionState.Closed)
                        conn.Close();
                    conn.Dispose();
                }
            }

        }

        //END USING STORED PROCEDURES
    }
}