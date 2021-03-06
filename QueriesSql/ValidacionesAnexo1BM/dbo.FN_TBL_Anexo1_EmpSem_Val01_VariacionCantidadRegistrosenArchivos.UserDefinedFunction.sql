USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val01_VariacionCantidadRegistrosenArchivos]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Enrique Bráñez
-- Fecha de Actualizacion: 05/05/2020
-- Description:	select * from [dbo].[FN_TBL_Anexo1_EmpSem_Val01_VariacionCantidadRegistrosenArchivos]('ESE','2018S1')
-- =============================================
CREATE --
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val01_VariacionCantidadRegistrosenArchivos]
(	
	@Empresa char(3),
	@NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
	--declare @NombreSemestre char(6), @Empresa char(3) --Comentar
	--set @Empresa='HID' --Comentar
	--set @NombreSemestre='2018S1'--Comentar
	SELECT 
		A.[Ítem]
		, A.[Empresa]
		, A.[Semestre]
		, A.TipoArchivoSirvan as [Tipo de Archivo]
		, A.NombreArchivo as [Nombre de Archivo]
		, A.[Fecha último archivo recibido Correcto]
		, A.[Cantidad Total de Envíos]
		, A.[Cantidad Total de Envíos Correctos]
		, A.[Código Interno último archivo remitido Correcto]
		, A.[Número registros en el Archivo]
		, B.[Semestre] as [Semestre Anterior]
		, B.[Tipo de Archivo] as [Tipo de Archivo Anterior]
		, B.[Nombre de Archivo] as [Nombre de Archivo Anterior]
		, B.[Fecha último archivo recibido Correcto] as [Fecha último archivo recibido Correcto Anterior]
		, B.[Cantidad Total de Envíos] as [Cantidad Total de Envíos Anterior]
		, B.[Cantidad Total de Envíos Correctos] as [Cantidad Total de Envíos Correctos Anterior]
		, B.[Código Interno último archivo remitido Correcto] as [Código Interno último archivo remitido Correcto Anterior]
		, B.[Número registros en el Archivo] as [Número registros en el Archivo Anterior]
		, Cast(A.[Número registros en el Archivo] as int) - try_Cast(B.[Número registros en el Archivo] as int) as [Diferencia de Registros]
		, iif(Cast(A.[Número registros en el Archivo] as float)>0,100.0*(Cast(A.[Número registros en el Archivo] as float) - try_Cast(B.[Número registros en el Archivo] as float))/Cast(A.[Número registros en el Archivo] as float),0) as [Porcentaje Diferencia]
	FROM [RECEPTORArchivos].[dbo].[FN_Anexo1_SeguimientoArchivosRemitidos_EmpSem] (@Empresa,@NombreSemestre) AS A
	LEFT JOIN 
		(
			SELECT * FROM 
			--[RECEPTORArchivos].[dbo].[FN_Anexo1_SeguimientoArchivosRemitidos_Sem] ([CalidadGenerales].DBO.GetSemestreAnterior(@NombreSemestre))
			[RECEPTORArchivos].[dbo].[FN_Anexo1_SeguimientoArchivosRemitidos_EmpSem] (@Empresa,[CalidadGenerales].DBO.GetSemestreAnterior(@NombreSemestre))
		) AS B ON A.[Empresa]=B.[Empresa] AND A.NombreArchivo=B.[Nombre de Archivo]
		--, A.[Empresa]		, A.[Semestre]		, A.TipoArchivoSirvan as [Tipo de Archivo]		, A.NombreArchivo as [Nombre de Archivo]
)

GO
