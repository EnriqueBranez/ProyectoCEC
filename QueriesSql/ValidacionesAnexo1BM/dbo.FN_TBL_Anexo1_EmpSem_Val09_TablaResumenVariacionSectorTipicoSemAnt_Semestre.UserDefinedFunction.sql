USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val09_TablaResumenVariacionSectorTipicoSemAnt_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Sistemas eléctricos reportados en el archivo SISTEMAS no encontrados en la tabla LOCALI.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val09_TablaResumenVariacionSectorTipicoSemAnt_Semestre]('ENO','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val09_TablaResumenVariacionSectorTipicoSemAnt_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem,Empresa,Semestre,[Código de Localidad],[Código de Sistema Eléctrico],[Sector Típico]
	,[Semestre Anterior],[Código de Sistema Eléctrico en Semestre Anterior],[Sector Típico en Semestre Anterior]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val09_TablaResumenVariacionSectorTipicoSemAnt_Semestre]('ENO','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='ENO'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by R.Empresa order by R.Empresa,R.[NombreSemestre],R.[sector],R.[Localidad]) as Ítem
		,R.[empresa],R.[NombreSemestre] as Semestre,R.[localidad] AS [Código de Localidad]
		,R.[sistema] as [Código de Sistema Eléctrico],R.[sector] as [Sector Típico]
		--,R.[demanda],R.[potencia]
		--,R.[suminbtmon],R.[suminbttri],R.[suministrosmt],R.[suministrosat],R.[nroseds],R.[puntoentrega],R.[tensionpto]
		--,R.[region],R.[puntoscaso1],R.[puntoscaso2],R.[puntoscaso3],R.[puntoscaso4]
		--,R.[semestre],R.[codigo_cabecera],R.[actividad]
		--,RA.[localidad]
		,RA.[NombreSemestre] as [Semestre Anterior]
		,RA.[sistema] as [Código de Sistema Eléctrico en Semestre Anterior]
		,RA.[sector] as [Sector Típico en Semestre Anterior]
		--,RA.[NombreSemestre]
	FROM [dbo].[TABLARESUMEN] as R
	LEFT JOIN [dbo].[TABLARESUMEN] as RA
		on R.[empresa]=RA.[empresa] and R.[localidad]=RA.[localidad] and dbo.GetSemestreAnterior(R.[NombreSemestre])=RA.[NombreSemestre]
	where R.[actividad]='D' and R.NombreSemestre=@NombreSemestre AND R.[empresa]=@Empresa
		and R.[sector]<>RA.[sector]
	--Total de registros en la tabla [TABLARESUMEN]
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='ENO'
	--set @NombreSemestre='2018S1'
	--SELECT COUNT(*) FROM [dbo].[TABLARESUMEN] as R where R.NombreSemestre=@NombreSemestre AND R.[empresa]=@Empresa
)


GO
