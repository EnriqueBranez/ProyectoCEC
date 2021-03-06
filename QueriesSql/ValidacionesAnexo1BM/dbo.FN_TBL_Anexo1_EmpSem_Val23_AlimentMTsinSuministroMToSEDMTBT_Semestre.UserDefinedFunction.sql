USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val23_AlimentMTsinSuministroMToSEDMTBT_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Sección o alimentador de Media Tensión reportado en el archivo ALIME_MT no fue reportado en las tablas SED_MTBT y/o SUMINMT.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val23_AlimentMTsinSuministroMToSEDMTBT_Semestre]('ELC','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val23_AlimentMTsinSuministroMToSEDMTBT_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [Código de Alimentador], [Cantidad de Suministros MT del Semestre Evaluado]
	, [Cantidad de SEDMTBT del Semestre Evaluado], [Cantidad de Suministros MT del semestre Anterior]
	, [Cantidad de SEDMTBT del semestre Anterior], [Cantidad de Suministros MT del semestre antes del Anterior]
	, [Cantidad de SEDMTBT del semestre antes del Anterior]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val23_AlimentMTsinSuministroMToSEDMTBT_Semestre]('ELC','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='ELC'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by AMT.[Empresa] order by AMT.[Empresa],AMT.[seccion]) as Ítem
		, AMT.[Empresa], AMT.NombreSemestre as Semestre, AMT.[seccion] as [Código de Alimentador]
		, SM.[Cantidad de Suministros] as [Cantidad de Suministros MT del Semestre Evaluado]
		, SE.[Cantidad de SEDMTBT] as [Cantidad de SEDMTBT del Semestre Evaluado]
		, SM_Ant1.[Cantidad de Suministros] as [Cantidad de Suministros MT del semestre Anterior]
		, SE_Ant1.[Cantidad de SEDMTBT] as [Cantidad de SEDMTBT del semestre Anterior]
		, SM_Ant2.[Cantidad de Suministros] as [Cantidad de Suministros MT del semestre antes del Anterior]
		, SE_Ant2.[Cantidad de SEDMTBT] as [Cantidad de SEDMTBT del semestre antes del Anterior]
	from (
	--Identifico los alimentadores con AMT.[tipoalimentador]='A'
		SELECT 
			AMT.[empresa], AMT.NombreSemestre, AMT.[seccion]
		FROM [dbo].[ALIME_MT] as AMT
		where AMT.Actividad='D' and AMT.[NombreSemestre]=@NombreSemestre and AMT.[tipoalimentador]='A' and AMT.[empresa]=@Empresa
		group by AMT.[empresa], AMT.[seccion], AMT.NombreSemestre
	) as AMT
	-- INFORMACIÓN DEL SEMESTRE EVALUADO SUMINMT Y SEDMTBT
	left join (
		SELECT SM.[EMPRESA], SM.[NombreSemestre], iif(SM.[tipoalimentador]='A',SM.[ALIMENTADOR],SM.[seccionalimentador]) as ALIMENTADOR
			, count(SM.[SUMINISTRO]) as [Cantidad de Suministros]
		FROM [dbo].[SUMINMT] as SM
		where SM.Actividad='D' and SM.[NombreSemestre]=@NombreSemestre and SM.[empresa]=@Empresa
		group by SM.[EMPRESA], SM.[NombreSemestre],iif(SM.[tipoalimentador]='A',SM.[ALIMENTADOR],SM.[seccionalimentador])
	) as SM on AMT.[empresa]=SM.[EMPRESA] and AMT.[seccion]=SM.[ALIMENTADOR] -- and AMT.NombreSemestre=SM.[NombreSemestre]
	left join (
		SELECT
			SE.[empresa], SE.[NombreSemestre], iif(SE.[tipoalimentador]='A',SE.[seccionlinea],SE.[seccionalimentador]) as ALIMENTADOR
			, count(SE.[subestacion]) as [Cantidad de SEDMTBT]
		FROM [dbo].[SED_MTBT] as SE
		where SE.Actividad='D' and SE.[NombreSemestre]=@NombreSemestre and SE.[empresa]=@Empresa
		group by SE.[empresa], SE.[NombreSemestre], iif(SE.[tipoalimentador]='A',SE.[seccionlinea],SE.[seccionalimentador])
	) as SE on AMT.[empresa]=SE.[EMPRESA] and AMT.[seccion]=SE.ALIMENTADOR --and AMT.NombreSemestre=SE.[NombreSemestre] 
	-- INFORMACIÓN DEL SEMESTRE ANTERIOR AL EVALUADO SUMINMT Y SEDMTBT
	left join (
		SELECT SM.[EMPRESA], SM.[NombreSemestre], iif(SM.[tipoalimentador]='A',SM.[ALIMENTADOR],SM.[seccionalimentador]) as ALIMENTADOR
			, count(SM.[SUMINISTRO]) as [Cantidad de Suministros]
		FROM [dbo].[SUMINMT] as SM
		where SM.Actividad='D' and SM.[NombreSemestre]=dbo.GetSemestreAnterior(@NombreSemestre) and SM.[empresa]=@Empresa
		group by SM.[EMPRESA], SM.[NombreSemestre],iif(SM.[tipoalimentador]='A',SM.[ALIMENTADOR],SM.[seccionalimentador])
	) as SM_Ant1 on AMT.[empresa]=SM_Ant1.[EMPRESA] and AMT.[seccion]=SM_Ant1.[ALIMENTADOR] and dbo.GetSemestreAnterior(AMT.NombreSemestre)=SM_Ant1.[NombreSemestre]
	left join (
		SELECT
			SE.[empresa], SE.[NombreSemestre], iif(SE.[tipoalimentador]='A',SE.[seccionlinea],SE.[seccionalimentador]) as ALIMENTADOR
			, count(SE.[subestacion]) as [Cantidad de SEDMTBT]
		FROM [dbo].[SED_MTBT] as SE
		where SE.Actividad='D' and SE.[NombreSemestre]=dbo.GetSemestreAnterior(@NombreSemestre) and SE.[empresa]=@Empresa
		group by SE.[empresa], SE.[NombreSemestre], iif(SE.[tipoalimentador]='A',SE.[seccionlinea],SE.[seccionalimentador])
	) as SE_Ant1 on AMT.[empresa]=SE_Ant1.[EMPRESA] and AMT.[seccion]=SE_Ant1.ALIMENTADOR and dbo.GetSemestreAnterior(AMT.NombreSemestre)=SE_Ant1.[NombreSemestre]
	-- INFORMACIÓN DEL SEMESTRE ANTES DE ANTERIOR AL EVALUADO SUMINMT Y SEDMTBT
	left join (
		SELECT SM.[EMPRESA], SM.[NombreSemestre], iif(SM.[tipoalimentador]='A',SM.[ALIMENTADOR],SM.[seccionalimentador]) as ALIMENTADOR
			, count(SM.[SUMINISTRO]) as [Cantidad de Suministros]
		FROM [dbo].[SUMINMT] as SM
		where SM.Actividad='D' and SM.[NombreSemestre]=dbo.GetSemestreAnterior(dbo.GetSemestreAnterior(@NombreSemestre)) and SM.[empresa]=@Empresa
		group by SM.[EMPRESA], SM.[NombreSemestre],iif(SM.[tipoalimentador]='A',SM.[ALIMENTADOR],SM.[seccionalimentador])
	) as SM_Ant2 on AMT.[empresa]=SM_Ant2.[EMPRESA] and AMT.[seccion]=SM_Ant2.[ALIMENTADOR]
		and dbo.GetSemestreAnterior(dbo.GetSemestreAnterior(AMT.NombreSemestre))=SM_Ant2.[NombreSemestre]
	left join (
		SELECT
			SE.[empresa], SE.[NombreSemestre], iif(SE.[tipoalimentador]='A',SE.[seccionlinea],SE.[seccionalimentador]) as ALIMENTADOR
			, count(SE.[subestacion]) as [Cantidad de SEDMTBT]
		FROM [dbo].[SED_MTBT] as SE
		where SE.Actividad='D' and SE.[NombreSemestre]=dbo.GetSemestreAnterior(dbo.GetSemestreAnterior(@NombreSemestre)) and SE.[empresa]=@Empresa
		group by SE.[empresa], SE.[NombreSemestre], iif(SE.[tipoalimentador]='A',SE.[seccionlinea],SE.[seccionalimentador])
	) as SE_Ant2 on AMT.[empresa]=SE_Ant2.[EMPRESA] and AMT.[seccion]=SE_Ant2.ALIMENTADOR
		and dbo.GetSemestreAnterior(dbo.GetSemestreAnterior(AMT.NombreSemestre))=SE_Ant2.[NombreSemestre]
	where isnull(SM.[Cantidad de Suministros],0)+ isnull(SE.[Cantidad de SEDMTBT],0)=0
	/*
SELECT 
	AMT.[Empresa], AMT.NombreSemestre as Semestre, AMT.[seccion] as [Código de Alimentador]
	, SM.[Cantidad de Suministros MT], SE.[Cantidad de SEDMTBT]
	, SM_Ant1.[Cantidad de Suministros MT semestre Anterior], SE_Ant1.[Cantidad de SEDMTBT semestre Anterior]
	, SM_Ant2.[Cantidad de Suministros MT  semestre antes del Anterior], SE_Ant2.[Cantidad de SEDMTBT semestre antes del Anterior]
from (
--Identifico los alimentadores con AMT.[tipoalimentador]='A'
	SELECT 
		AMT.[empresa], AMT.NombreSemestre, AMT.[seccion]
	FROM [dbo].[ALIME_MT] as AMT
	where AMT.Actividad='D' and AMT.[NombreSemestre]='2017S2' and AMT.[tipoalimentador]='A'
	group by AMT.[empresa], AMT.[seccion], AMT.NombreSemestre
) as AMT
-- INFORMACIÓN DEL SEMESTRE EVALUADO SUMINMT Y SEDMTBT
left join (
	SELECT SM.[EMPRESA], SM.[NombreSemestre], iif(SM.[tipoalimentador]='A',SM.[ALIMENTADOR],SM.[seccionalimentador]) as ALIMENTADOR
		, count(SM.[SUMINISTRO]) as [Cantidad de Suministros]
	FROM [dbo].[SUMINMT] as SM
	where SM.Actividad='D' and SM.[NombreSemestre]='2017S2'
	group by SM.[EMPRESA], SM.[NombreSemestre],iif(SM.[tipoalimentador]='A',SM.[ALIMENTADOR],SM.[seccionalimentador])
) as SM on AMT.[empresa]=SM.[EMPRESA] and AMT.[seccion]=SM.[ALIMENTADOR] -- and AMT.NombreSemestre=SM.[NombreSemestre]
left join (
	SELECT
		SE.[empresa], SE.[NombreSemestre], iif(SE.[tipoalimentador]='A',SE.[seccionlinea],SE.[seccionalimentador]) as ALIMENTADOR
		, count(SE.[subestacion]) as [Cantidad de SEDMTBT]
	FROM [dbo].[SED_MTBT] as SE
	where SE.Actividad='D' and SE.[NombreSemestre]='2017S2'
	group by SE.[empresa], SE.[NombreSemestre], iif(SE.[tipoalimentador]='A',SE.[seccionlinea],SE.[seccionalimentador])
) as SE on AMT.[empresa]=SE.[EMPRESA] and AMT.[seccion]=SE.ALIMENTADOR --and AMT.NombreSemestre=SE.[NombreSemestre] 
-- INFORMACIÓN DEL SEMESTRE ANTERIOR AL EVALUADO SUMINMT Y SEDMTBT
left join (
	SELECT SM.[EMPRESA], SM.[NombreSemestre], iif(SM.[tipoalimentador]='A',SM.[ALIMENTADOR],SM.[seccionalimentador]) as ALIMENTADOR
		, count(SM.[SUMINISTRO]) as [Cantidad de Suministros]
	FROM [dbo].[SUMINMT] as SM
	where SM.Actividad='D' and SM.[NombreSemestre]=dbo.GetSemestreAnterior('2017S2')
	group by SM.[EMPRESA], SM.[NombreSemestre],iif(SM.[tipoalimentador]='A',SM.[ALIMENTADOR],SM.[seccionalimentador])
) as SM_Ant1 on AMT.[empresa]=SM_Ant1.[EMPRESA] and AMT.[seccion]=SM_Ant1.[ALIMENTADOR] and dbo.GetSemestreAnterior(AMT.NombreSemestre)=SM_Ant1.[NombreSemestre]
left join (
	SELECT
		SE.[empresa], SE.[NombreSemestre], iif(SE.[tipoalimentador]='A',SE.[seccionlinea],SE.[seccionalimentador]) as ALIMENTADOR
		, count(SE.[subestacion]) as [Cantidad de SEDMTBT]
	FROM [dbo].[SED_MTBT] as SE
	where SE.Actividad='D' and SE.[NombreSemestre]=dbo.GetSemestreAnterior('2017S2')
	group by SE.[empresa], SE.[NombreSemestre], iif(SE.[tipoalimentador]='A',SE.[seccionlinea],SE.[seccionalimentador])
) as SE_Ant1 on AMT.[empresa]=SE_Ant1.[EMPRESA] and AMT.[seccion]=SE_Ant1.ALIMENTADOR and dbo.GetSemestreAnterior(AMT.NombreSemestre)=SE_Ant1.[NombreSemestre]
-- INFORMACIÓN DEL SEMESTRE ANTES DE ANTERIOR AL EVALUADO SUMINMT Y SEDMTBT
left join (
	SELECT SM.[EMPRESA], SM.[NombreSemestre], iif(SM.[tipoalimentador]='A',SM.[ALIMENTADOR],SM.[seccionalimentador]) as ALIMENTADOR
		, count(SM.[SUMINISTRO]) as [Cantidad de Suministros]
	FROM [dbo].[SUMINMT] as SM
	where SM.Actividad='D' and SM.[NombreSemestre]=dbo.GetSemestreAnterior(dbo.GetSemestreAnterior('2017S2'))
	group by SM.[EMPRESA], SM.[NombreSemestre],iif(SM.[tipoalimentador]='A',SM.[ALIMENTADOR],SM.[seccionalimentador])
) as SM_Ant2 on AMT.[empresa]=SM_Ant2.[EMPRESA] and AMT.[seccion]=SM_Ant2.[ALIMENTADOR]
	and dbo.GetSemestreAnterior(dbo.GetSemestreAnterior(AMT.NombreSemestre))=SM_Ant2.[NombreSemestre]
left join (
	SELECT
		SE.[empresa], SE.[NombreSemestre], iif(SE.[tipoalimentador]='A',SE.[seccionlinea],SE.[seccionalimentador]) as ALIMENTADOR
		, count(SE.[subestacion]) as [Cantidad de SEDMTBT]
	FROM [dbo].[SED_MTBT] as SE
	where SE.Actividad='D' and SE.[NombreSemestre]=dbo.GetSemestreAnterior(dbo.GetSemestreAnterior('2017S2'))
	group by SE.[empresa], SE.[NombreSemestre], iif(SE.[tipoalimentador]='A',SE.[seccionlinea],SE.[seccionalimentador])
) as SE_Ant2 on AMT.[empresa]=SE_Ant2.[EMPRESA] and AMT.[seccion]=SE_Ant2.ALIMENTADOR
	and dbo.GetSemestreAnterior(dbo.GetSemestreAnterior(AMT.NombreSemestre))=SE_Ant2.[NombreSemestre]
where isnull(SM.[Cantidad de Suministros],0)+ isnull(SE.[Cantidad de SEDMTBT],0)=0
	*/
)

GO
