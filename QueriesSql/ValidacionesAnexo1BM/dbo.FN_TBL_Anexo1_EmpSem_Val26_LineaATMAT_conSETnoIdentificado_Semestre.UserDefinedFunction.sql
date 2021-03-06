USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val26_LineaATMAT_conSETnoIdentificado_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Campos 4 y/o  5 "Código de la SET de Salida" y "Llegada" de las tablas LÍNEAS AT y LÍNEAS MAT no reportados en tabla SET.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val26_LineaATMAT_conSETnoIdentificado_Semestre]('ELC','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val26_LineaATMAT_conSETnoIdentificado_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [Código de Línea], [setsalida], [setllegada]
	, [Tensión Nominal], [tipolinea] as [Tipo de Línea], [SET de Salida en Tabla SETs], [SET de Llegada en Tabla SETs]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val26_LineaATMAT_conSETnoIdentificado_Semestre]('ELC','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='ELC'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by L.[empresa] order by L.[empresa], L.[lineaat]) as Ítem
		, L.[Empresa], L.[NombreSemestre] as Semestre, L.[lineaat] as [Código de Línea], L.[setsalida], L.[setllegada]
		, L.[tensionnominal] as [Tensión Nominal], L.[tipolinea]--, L.[semestre], L.[codigo_cabecera]
		, isnull(SS.Subestacion+'              ','SET no Identificada') as [SET de Salida en Tabla SETs]
		, isnull(SL.Subestacion+'              ','SET no Identificada') as [SET de Llegada en Tabla SETs]
	FROM [dbo].[LINEA_AT_MT] as L
	LEFT JOIN [dbo].[SETS] AS SS ON L.[NombreSemestre]=SS.[NombreSemestre] AND L.setsalida=SS.Subestacion
	LEFT JOIN [dbo].[SETS] AS SL ON L.[NombreSemestre]=SL.[NombreSemestre] AND l.setllegada=SL.Subestacion
	WHERE L.[NombreSemestre]=@NombreSemestre and L.[empresa]=@Empresa
		and L.[actividad]='D' and (SS.Subestacion is null or SL.Subestacion is null)
)

GO
