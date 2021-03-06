USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val20_AlimeMTAlimentadoresNoReportadosDelSemestreAnterior_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Alimentadores de Media Tensión reportados en la tabla ALIME_MT con nivel de tensión mayor a 33 Kv.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val20_AlimeMTAlimentadoresNoReportadosDelSemestreAnterior_Semestre]('EDN','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val20_AlimeMTAlimentadoresNoReportadosDelSemestreAnterior_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, [Semestre Anterior], [Código de SET Semestre Anterior]
	, [Tipo de Sección o Alimentador], [Código de Alimentador]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val20_AlimeMTAlimentadoresNoReportadosDelSemestreAnterior_Semestre]('EDN','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='EDN'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by AMT.[Empresa] order by AMT.[Empresa],AMT.[seccion]) as Ítem
		, AMT.[Empresa], AMT.NombreSemestre as [Semestre Anterior], AMT.[subestacion] as [Código de SET Semestre Anterior]
		, AMT.[tipoalimentador] as [Tipo de Sección o Alimentador], AMT.[seccion] as [Código de Alimentador]
		--, AMTactual.NombreSemestre as [Semestre Evaluado], AMTactual.[subestacion] as [SET declarado en Semestre Evaluado]
	FROM [dbo].[ALIME_MT] as AMT
	left join [dbo].[ALIME_MT] as AMTactual 
		on AMT.[empresa]=AMTactual.[empresa] and AMT.[seccion]=AMTactual.[seccion] and (AMT.Semestre+1)=AMTactual.Semestre
	where AMT.Actividad='D' and AMT.[empresa]=@Empresa
		and AMT.NombreSemestre=dbo.GetSemestreAnterior(@NombreSemestre) and AMT.[tipoalimentador]='A' and AMTactual.seccion is null
	/*
	SELECT
		AMT.[Empresa], AMT.NombreSemestre as [Semestre Anterior], AMT.[subestacion] as [Código de SET Semestre Anterior]
		, AMT.[tipoalimentador] as [Tipo de Sección o Alimentador], AMT.[seccion] as [Código de Alimentador]
		, AMTactual.NombreSemestre as [Semestre Evaluado], AMTactual.[subestacion] as [SET declarado en Semestre Evaluado]
	FROM [dbo].[ALIME_MT] as AMT
	left join [dbo].[ALIME_MT] as AMTactual 
		on AMT.[empresa]=AMTactual.[empresa] and AMT.[seccion]=AMTactual.[seccion] and (AMT.Semestre+1)=AMTactual.Semestre
	where AMT.Actividad='D' and AMT.NombreSemestre=dbo.GetSemestreAnterior('2017S2') and AMT.[tipoalimentador]='A' and AMTactual.seccion is null
	GO	
	*/
)

GO
