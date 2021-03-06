USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val22_AlimentMTvariacionDeSETconSemestreAnterior_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Alimentadores de Media Tensión reportados en la tabla ALIME_MT que cambiaron de SET respecto al reporte del semestre anterior.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val22_AlimentMTvariacionDeSETconSemestreAnterior_Semestre]('ELC','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val22_AlimentMTvariacionDeSETconSemestreAnterior_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [Código de Sección o Alimentador], [Tipo de Sección A/S], [Sección al que Pertenece]
	, [SET al que pertenece declarado en Semestre Evaluado], [Tensión Nominal]
	, [Semestre Anterior], [SET declarado en Semestre Anterior], [Tensión Nominal declarado en Semestre Anterior]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val22_AlimentMTvariacionDeSETconSemestreAnterior_Semestre]('ELC','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='ELC'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by AMT.[Empresa] order by AMT.[Empresa],AMT.[seccion]) as Ítem
		, AMT.[Empresa], AMT.NombreSemestre as Semestre
		, AMT.[seccion] as [Código de Sección o Alimentador], AMT.[tipoalimentador] as [Tipo de Sección A/S]
		, AMT.[seccionalimentador] as [Alimentador al que Pertenece]
		, AMT.[subestacion] as [SET al que pertenece declarado en Semestre Evaluado], AMT.[tensionnominal] as [Tensión Nominal]
		, AMTant.NombreSemestre [Semestre Anterior]
		, AMTant.[subestacion] as [SET declarado en Semestre Anterior]
		, AMT.[tensionnominal] as [Tensión Nominal declarado en Semestre Anterior]
	FROM [dbo].[ALIME_MT] as AMT
	left join [dbo].[ALIME_MT] as AMTant on AMT.[empresa]=AMTant.[empresa] and AMT.[seccion]=AMTant.[seccion]
		and dbo.GetSemestreAnterior(AMT.NombreSemestre)=AMTant.NombreSemestre
	where AMT.Actividad='D' and AMT.NombreSemestre=@NombreSemestre and AMT.[empresa]=@Empresa
		and AMT.[subestacion]<>AMTant.[subestacion]

	/*
	SELECT
		AMT.[empresa], AMT.NombreSemestre, AMT.[subestacion] as [SET declarado en Semestre Evaluado], AMT.[tensionnominal], AMT.[seccion], AMT.[tipoalimentador]
		, AMT.[seccionalimentador]
		, AMTant.NombreSemestre
		, AMTant.[subestacion] as [SET declarado en Semestre Anterior]
	FROM [dbo].[ALIME_MT] as AMT
	left join [dbo].[ALIME_MT] as AMTant on AMT.[empresa]=AMTant.[empresa] and AMT.[seccion]=AMTant.[seccion] and dbo.GetSemestreAnterior(AMT.NombreSemestre)=AMTant.NombreSemestre
	where AMT.Actividad='D' and AMT.NombreSemestre='2017S2' and AMT.[subestacion]<>AMTant.[subestacion]
	GO
	*/
)

GO
