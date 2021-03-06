USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val18_ALIMEMTconSeccionAlimentadorObservado_Semestre]    Script Date: 15/05/2020 1:55:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Sección o alimentador MT con inconsistencias en la relación con su elemento padre (campo 6 de la tabla ALIME_MT).
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val18_ALIMEMTconSeccionAlimentadorObservado_Semestre]('EDN','2018S1')
-- =============================================
--CREATE -- 
ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val18_ALIMEMTconSeccionAlimentadorObservado_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val18_ALIMEMTconSeccionAlimentadorObservado_Semestre]('ELC','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='PAN'
	--set @NombreSemestre='2020S2'
	SELECT
		ROW_NUMBER() over (order by AMT.[Empresa],AMT.[Subestacion]) as Ítem
		, AMT.[Empresa], AMT.[NombreSemestre] AS Semestre, AMT.[Subestacion] as [Código de SET]
		, AMT.seccion as [Código de Sección o Alimentador], AMT.tipoalimentador as [Tipo de Sección (A o S)]
		, AMT.seccionalimentador as [Alimentador al que Pertenece]
		, AMT.TipoAlimentadorPadre as [Tipo de Alimentador al que Pertenece]
		, case 
			when AMT.[tipoalimentador]='S' and AMT.[seccionalimentador] is null then '1 Debe declarar el Alimentador/Seccionamiento al que pertence'
			when AMT.[tipoalimentador]='S' and AMT.[TipoAlimentadorPadre] is null then '2 El Alimentador/Seccionamiento al que pertence no está declarado en ALIME_MT'
			when AMT.[tipoalimentador]='A' and len(rtrim(ltrim(AMT.[seccionalimentador])))>0 then '3 Si tipo de alimentador es A, no pertence a otro alimentador'
			end
			as [Detalle de Observación]
	FROM
	(
		SELECT
			AMT.[empresa],AMT.[localidad],AMT.[subestacion],AMT.[seccion],AMT.[tensionnominal],AMT.[tipoalimentador],AMT.[seccionalimentador],AMT.[semestre],AMT.[codigo_cabecera]
			,AMT.[NombreSemestre],AMT.[Actividad],AMT.[NombreEmpresa],AMT.[TipoAlimentadorPadre],AMT.[Alimen_SectorTipico],AMT.[Alimen_Sistema],AMT.[Alimen_NombreSistema]
		FROM [CalidadGenerales].[dbo].[ALIME_MT] as AMT
		where 
			(	(AMT.[tipoalimentador]='S' and (AMT.[seccionalimentador] is null or len(rtrim(ltrim(AMT.[seccionalimentador])))=0) )
				or (AMT.[tipoalimentador]='S' and AMT.[TipoAlimentadorPadre] is null)
				or (AMT.[tipoalimentador]='A' and len(rtrim(ltrim(AMT.[seccionalimentador])))>0)
			)
			and AMT.[NombreSemestre]=@NombreSemestre 
			and AMT.[empresa]=@Empresa
	) AS AMT
	--order by NombreSemestre
/*	
declare @IDValidacion int
	set @IDValidacion=1
	use [CalidadReportes]
	select @IDValidacion as IDValidacion
		, * INTO Anexo1_Val_Rep18  -- select * 
	from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val18_ALIMEMTconSeccionAlimentadorObservado_Semestre]('ELC','2018S2')
				--from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val18_ALIMEMTconSeccionAlimentadorObservado_Semestre]('EDN','2018S1')
		-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val18_ALIMEMTconSeccionAlimentadorObservado_Semestre]('EDN','2018S1')
		-- Select * from [CalidadReportes].dbo.Anexo1_Val_Rep18 --truncate table Anexo1_Val_Rep18 --DROP table [CalidadReportes].dbo.Anexo1_Val_Rep18
	*/
)
go