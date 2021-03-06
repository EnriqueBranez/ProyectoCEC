USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val19_AlimentMTTensionNominalmayor33kV_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Alimentadores de Media Tensión reportados en la tabla ALIME_MT con nivel de tensión mayor a 33 Kv.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val19_AlimentMTTensionNominalmayor33kV_Semestre]('EMP','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val19_AlimentMTTensionNominalmayor33kV_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [SET], [Tipo de Sección/Alimentador], [Código de Sección o Alimentador], [Tensión Nominal]
	, [Semestre Anterior 1], [Tensión Nominal 1], [Semestre Anterior 2], [Tensión Nominal 2], [Semestre Anterior 3], [Tensión Nominal 3]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val19_AlimentMTTensionNominalmayor33kV_Semestre]('EMP','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='EMP'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by AMT.[Empresa] order by AMT.[Empresa],AMT.[seccion]) as Ítem
		, AMT.[Empresa], AMT.NombreSemestre AS Semestre, AMT.[subestacion] as [SET], AMT.[tipoalimentador] as [Tipo de Sección/Alimentador]
		, AMT.[seccion] as [Código de Sección o Alimentador], AMT.[tensionnominal] as [Tensión Nominal]
		--, AMT.[semestre], AMT.[codigo_cabecera], AMT.Actividad, AMT.NombreEmpresa
		, AMTant.NombreSemestre as [Semestre Anterior 1]
		, AMTant.[tensionnominal] as [Tensión Nominal 1]
		, AMTant2.NombreSemestre as [Semestre Anterior 2]
		, AMTant2.[tensionnominal] as [Tensión Nominal 2]
		, AMTant3.NombreSemestre as [Semestre Anterior 3]
		, AMTant3.[tensionnominal] as [Tensión Nominal 3]
	FROM [dbo].[ALIME_MT] as AMT
	left join [dbo].[ALIME_MT] as AMTant 
		on AMT.[empresa]=AMTant.[empresa] and AMT.[seccion]=AMTant.[seccion] and dbo.GetSemestreAnterior(AMT.NombreSemestre)=AMTant.NombreSemestre
	left join [dbo].[ALIME_MT] as AMTant2 
		on AMT.[empresa]=AMTant2.[empresa] and AMT.[seccion]=AMTant2.[seccion] and dbo.GetSemestreAnterior(dbo.GetSemestreAnterior(AMT.NombreSemestre))=AMTant2.NombreSemestre
	left join [dbo].[ALIME_MT] as AMTant3 
		on AMT.[empresa]=AMTant3.[empresa] and AMT.[seccion]=AMTant3.[seccion] and dbo.GetSemestreAnterior(dbo.GetSemestreAnterior(dbo.GetSemestreAnterior(AMT.NombreSemestre)))=AMTant3.NombreSemestre
	where AMT.Actividad='D' and AMT.NombreSemestre=@NombreSemestre and AMT.[empresa]=@Empresa
		and AMT.[tensionnominal]>33.0
	/*
	SELECT
		AMT.[empresa], AMT.[localidad], AMT.[subestacion], AMT.[seccion], AMT.[tensionnominal]
		, AMT.[tipoalimentador], AMT.[seccionalimentador]
		--, AMT.[semestre], AMT.[codigo_cabecera], AMT.NombreSemestre, AMT.Actividad, AMT.NombreEmpresa
		, AMTant.NombreSemestre
		, AMTant.[tensionnominal]
		, AMTant2.NombreSemestre
		, AMTant2.[tensionnominal]
		, AMTant3.NombreSemestre
		, AMTant3.[tensionnominal]
	FROM [dbo].[ALIME_MT] as AMT
	left join [dbo].[ALIME_MT] as AMTant 
		on AMT.[empresa]=AMTant.[empresa] and AMT.[seccion]=AMTant.[seccion] and dbo.GetSemestreAnterior(AMT.NombreSemestre)=AMTant.NombreSemestre
	left join [dbo].[ALIME_MT] as AMTant2 
		on AMT.[empresa]=AMTant2.[empresa] and AMT.[seccion]=AMTant2.[seccion] and dbo.GetSemestreAnterior(dbo.GetSemestreAnterior(AMT.NombreSemestre))=AMTant2.NombreSemestre
	left join [dbo].[ALIME_MT] as AMTant3 
		on AMT.[empresa]=AMTant3.[empresa] and AMT.[seccion]=AMTant3.[seccion] and dbo.GetSemestreAnterior(dbo.GetSemestreAnterior(dbo.GetSemestreAnterior(AMT.NombreSemestre)))=AMTant3.NombreSemestre
	where AMT.Actividad='D' and AMT.NombreSemestre='2017S2' and AMT.[tensionnominal]>33.0
	*/
)

GO
