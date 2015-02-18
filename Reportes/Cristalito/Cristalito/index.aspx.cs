using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using CrystalDecisions.CrystalReports.Engine;

namespace Cristalito
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        { 
        }
        public void getReport(object sender, EventArgs e)
        {
           
                var conn = new SqlConnection("Data Source=GIOVANNI-PC;Initial Catalog=plantas;User Id=sa;Password=");
                try
                {
                    using (var comando = new SqlCommand("SELECT * FROM  [plantas].[dbo].[Usuario]", conn))
                    {
                        using (var adaptador = new SqlDataAdapter(comando))
                        {
                            var ds = new DataSet();
                            adaptador.Fill(ds);

                            var reporte = new ReportDocument();
                            reporte.Load(Server.MapPath("Usuarios.rpt"));
                            reporte.SetDataSource(ds.Tables[0]);
                            reporte.DataSourceConnections[0].SetConnection("GIOVANNI-PC", "plantas", "sa", ""); 
                            CrystalReportViewer1.ReportSource = reporte;
                        } // end using adaptador
                    } // end using comando
                } // end try
                catch (Exception ex)
                {
                    lblMensaje.Text = ex.Message;
                }
                finally
                {
                    if (conn.State != ConnectionState.Closed)
                        conn.Close();
                    conn.Dispose();
                } 
        }

        public void getReportByParam(object sender, EventArgs e)
        {
            string param = TextBox1.Text;
            if (param != "")
            {
                var conn = new SqlConnection("Data Source=GIOVANNI-PC;Initial Catalog=plantas;User Id=sa;Password=");
                try
                {
                    using (var comando = new SqlCommand("SELECT * FROM  [plantas].[dbo].[Usuario] usr WHERE (usr.idUsuario = " + param + ")", conn))
                    {
                        using (var adaptador = new SqlDataAdapter(comando))
                        {
                            var ds = new DataSet();
                            adaptador.Fill(ds);

                            var reporte = new ReportDocument();
                            reporte.Load(Server.MapPath("Usuarios.rpt"));
                            reporte.SetDataSource(ds.Tables[0]);
                            reporte.DataSourceConnections[0].SetConnection("GIOVANNI-PC", "plantas", "sa", "");

                            CrystalReportViewer1.ReportSource = reporte;
                        } // end using adaptador
                    } // end using comando
                } // end try
                catch (Exception ex)
                {
                    lblMensaje.Text = ex.Message;
                }
                finally
                {
                    if (conn.State != ConnectionState.Closed)
                        conn.Close();
                    conn.Dispose();
                }
            }
        }
    }
}