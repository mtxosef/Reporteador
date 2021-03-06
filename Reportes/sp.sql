PROCEDURE [dbo].[web_spS_ObtenerCambiosPreciarios]
	-- Add the parameters for the stored procedure here 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here or any select
SELECT        dbo.Volumetrias.Sucursal, dbo.Sucursales.Nombre, dbo.Sucursales.CR, dbo.Sucursales.Calle, dbo.Sucursales.EntreCalles, dbo.Sucursales.NoExterior, 
                         dbo.Sucursales.NoInterior, dbo.Sucursales.CodigoPostal, dbo.Sucursales.Colonia, dbo.Sucursales.Estado, dbo.Sucursales.Municipio, 
                         dbo.ImagenesVolumetriasD.PreciarioConcepto, dbo.VolumetriasD.ConceptoID, dbo.VolumetriasD.Cantidad, dbo.VolumetriasD.Utilizada, dbo.VolumetriasD.Volumetria, 
                         dbo.ImagenesVolumetriasD.Direccion, dbo.Volumetrias.FechaEmision, dbo.Volumetrias.Observaciones, dbo.Volumetrias.Preciario, dbo.Preciarios.Descripcion, 
                         dbo.ImagenesVolumetriasD.Nombre AS ImgVoluNombre, dbo.PreciarioConceptos.Descripcion AS PreConDescripcion, dbo.PreciarioConceptos.Categoria, 
                         dbo.PreciarioConceptos.SubCategoria, dbo.PreciarioConceptos.SubSubCategoria, dbo.PreciarioConceptos.Unidad, dbo.PreciarioConceptos.Costo, 
                         dbo.PreciarioConceptos.Cantidad AS PreConceptoCantidad, dbo.PreciarioConceptos.Utilizada AS PreConceptoUtilizada, dbo.PreciarioConceptos.Importe, 
                         dbo.PreciarioConceptos.ImporteFinal
FROM            dbo.ImagenesVolumetriasD INNER JOIN
                         dbo.PreciarioConceptos ON dbo.ImagenesVolumetriasD.PreciarioConcepto = dbo.PreciarioConceptos.ID INNER JOIN
                         dbo.Preciarios ON dbo.PreciarioConceptos.Preciario = dbo.Preciarios.ID INNER JOIN
                         dbo.Sucursales ON dbo.Preciarios.Sucursal = dbo.Sucursales.ID INNER JOIN
                         dbo.Volumetrias ON dbo.ImagenesVolumetriasD.Volumetria = dbo.Volumetrias.ID AND dbo.Preciarios.ID = dbo.Volumetrias.Preciario AND 
                         dbo.Sucursales.ID = dbo.Volumetrias.Sucursal INNER JOIN
                         dbo.VolumetriasD ON dbo.PreciarioConceptos.ID = dbo.VolumetriasD.ConceptoID AND dbo.Volumetrias.ID = dbo.VolumetriasD.Volumetria;
END