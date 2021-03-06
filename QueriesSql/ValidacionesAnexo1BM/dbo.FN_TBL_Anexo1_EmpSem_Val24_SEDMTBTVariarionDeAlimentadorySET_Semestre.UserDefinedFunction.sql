USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val24_SEDMTBTVariarionDeAlimentadorySET_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Subestaciones de Distribución reportados en la tabla SED_MTBT que cambiaron de Alimentador de Media tensión y/o SET respecto al semestre anterior.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val24_SEDMTBTVariarionDeAlimentadorySET_Semestre]('ELC','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val24_SEDMTBTVariarionDeAlimentadorySET_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [Código de SubEstación MT/BT], [Tensión Nominal del Alimentador]
	, [Código Alimentador], [Código SET], [Semestre Anterior], [Código Alimentador declarado en Semestre Anterior]
	, [Código SET declarado en Semestre Anterior]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val24_SEDMTBTVariarionDeAlimentadorySET_Semestre]('ELC','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='ELC'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by SE.[Empresa] order by SE.[Empresa],SE.[subestacion]) as Ítem
		, SE.[empresa], SE.[NombreSemestre] as Semestre, SE.[subestacion] as [Código de SubEstación MT/BT], SE.[TensionNominalAlimentador] as [Tensión Nominal del Alimentador]
		, iif(SE.[tipoalimentador]='A',SE.[seccionlinea],SE.[seccionalimentador]) as [Código Alimentador]
		, SE.[SET] as [Código SET]
		, SEant.[NombreSemestre] as [Semestre Anterior]
		, iif(SEant.[tipoalimentador]='A',SEant.[seccionlinea],SEant.[seccionalimentador]) as [Código Alimentador declarado en Semestre Anterior]
		, SEant.[SET] as [Código SET declarado en Semestre Anterior]
	FROM [dbo].[SED_MTBT] as SE 
		left join [dbo].[SED_MTBT] as SEant on SE.[empresa]=SEant.[empresa] and SE.[subestacion]=SEant.[subestacion] and dbo.GetSemestreAnterior(SE.[NombreSemestre])=SEant.[NombreSemestre] 
	Where SE.[actividad]='D' and SE.[NombreSemestre]=@NombreSemestre and SE.[empresa]=@Empresa
		and (iif(SE.[tipoalimentador]='A',SE.[seccionlinea],SE.[seccionalimentador])<>iif(SEant.[tipoalimentador]='A',SEant.[seccionlinea],SEant.[seccionalimentador])
			or SE.[SET]<>SEant.[SET])
	/*

	SELECT
		SE.[empresa], SE.[NombreSemestre] as Semestre, SE.[subestacion] as [Código de SubEstación], SE.[TensionNominalAlimentador] as [Tensión Nominal del Alimentador]
		, iif(SE.[tipoalimentador]='A',SE.[seccionlinea],SE.[seccionalimentador]) as [Código Alimentador]
		, SE.[SET] as [Código SET]
		, SEant.[NombreSemestre] as [Semestre Anterior]
		, iif(SEant.[tipoalimentador]='A',SEant.[seccionlinea],SEant.[seccionalimentador]) as [Código Alimentador declarado en Semestre Anterior]
		, SEant.[SET] as [Código SET declarado en Semestre Anterior]
	FROM [dbo].[SED_MTBT] as SE 
		left join [dbo].[SED_MTBT] as SEant on SE.[empresa]=SEant.[empresa] and SE.[subestacion]=SEant.[subestacion] and dbo.GetSemestreAnterior(SE.[NombreSemestre])=SEant.[NombreSemestre] 
	Where SE.[actividad]='D' and SE.[NombreSemestre]='2017S2' 
		and (iif(SE.[tipoalimentador]='A',SE.[seccionlinea],SE.[seccionalimentador])<>iif(SEant.[tipoalimentador]='A',SEant.[seccionlinea],SEant.[seccionalimentador])
			or SE.[SET]<>SEant.[SET])
	*/
)

GO
