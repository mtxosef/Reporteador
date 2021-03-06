SET NOCOUNT ON
GO
set nocount    on
set dateformat mdy
USE master;
declare @dttm varchar(55)
select  @dttm=convert(varchar,getdate(),113)
raiserror('Beginning CrystalReportDB.sql at %s ....',1,1,@dttm) with nowait
GO
if exists (select * from sysdatabases where name='CrystalReportDB')
begin
  raiserror('Dropping existing plantas database ....',0,1)
  ALTER DATABASE CrystalReportDB
  SET SINGLE_USER
  WITH ROLLBACK IMMEDIATE
  DROP database CrystalReportDB
end
GO
CHECKPOINT
go
/****** Object:  Database [CrystalReportDB]    Script Date: 25/02/2015 13:34:33 ******/
raiserror('Creating CrystalReportDB database....',0,1)
go
CREATE DATABASE CrystalReportDB
GO 
raiserror('Plantas database created successfully....',0,1)
go
USE [master]
GO
ALTER DATABASE [CrystalReportDB] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CrystalReportDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CrystalReportDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CrystalReportDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CrystalReportDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CrystalReportDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CrystalReportDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [CrystalReportDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CrystalReportDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [CrystalReportDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CrystalReportDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CrystalReportDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CrystalReportDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CrystalReportDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CrystalReportDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CrystalReportDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CrystalReportDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CrystalReportDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CrystalReportDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CrystalReportDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CrystalReportDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CrystalReportDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CrystalReportDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CrystalReportDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CrystalReportDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CrystalReportDB] SET RECOVERY FULL 
GO
ALTER DATABASE [CrystalReportDB] SET  MULTI_USER 
GO
ALTER DATABASE [CrystalReportDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CrystalReportDB] SET DB_CHAINING OFF 
GO
USE [CrystalReportDB]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetProducts]    Script Date: 25/02/2015 13:34:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetProducts]
	-- Add the parameters for the stored procedure here 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT p.Id, p.Producto Nombre, p.Precio, p.Imagen FROM Producto p;
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetProductsById]    Script Date: 25/02/2015 13:34:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetProductsById] 
	-- Add the parameters for the stored procedure here
	@IdPro INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT p.Id, p.Producto Nombre, p.Precio, p.Imagen FROM Producto p WHERE p.Id = @IdPro;
END

GO
/****** Object:  Table [dbo].[Producto]    Script Date: 25/02/2015 13:34:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producto](
	[Id] [int] NULL,
	[Producto] [nvarchar](50) NULL,
	[Precio] [decimal](18, 2) NULL,
	[Imagen] [nvarchar](50) NULL
) ON [PRIMARY]

GO
INSERT [dbo].[Producto] ([Id], [Producto], [Precio], [Imagen]) VALUES (1, N'PC', CAST(12500.00 AS Decimal(18, 2)), N'images/pc.png')
INSERT [dbo].[Producto] ([Id], [Producto], [Precio], [Imagen]) VALUES (2, N'Mouse', CAST(350.70 AS Decimal(18, 2)), N'images/mouse.png')
INSERT [dbo].[Producto] ([Id], [Producto], [Precio], [Imagen]) VALUES (3, N'Teclado', CAST(200.30 AS Decimal(18, 2)), N'images/teclado.png')
INSERT [dbo].[Producto] ([Id], [Producto], [Precio], [Imagen]) VALUES (4, N'DD', CAST(1650.00 AS Decimal(18, 2)), N'images/dd.png')
INSERT [dbo].[Producto] ([Id], [Producto], [Precio], [Imagen]) VALUES (5, N'Monitor', CAST(3758.90 AS Decimal(18, 2)), N'images/monitor.png')
USE [master]
GO
ALTER DATABASE [CrystalReportDB] SET  READ_WRITE 
GO
