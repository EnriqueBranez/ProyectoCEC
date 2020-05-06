USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val18_ALIMEMTconSeccionAlimentadorObservado_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Sección o alimentador MT que no registró correctamente el código del campo 6 de la tabla ALIME_MT.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val18_ALIMEMTconSeccionAlimentadorObservado_Semestre]('EDN','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val18_ALIMEMTconSeccionAlimentadorObservado_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [Código de SET], [Nombre de SET], [Dirección de la SET], Ubigeo
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val18_ALIMEMTconSeccionAlimentadorObservado_Semestre]('EDN','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='ELC'
	--set @NombreSemestre='2018S2'
	SELECT
		ROW_NUMBER() over (order by ST.[Empresa],ST.[Subestacion]) as Ítem
		, ST.[Empresa], ST.[NombreSemestre] AS Semestre, ST.[Subestacion] as [Código de SET]
		, ST.seccion as [Código de Sección o Alimentador], ST.tipoalimentador as [Tipo de Sección (A o S)]
		, ST.seccionalimentador as [Alimentador al que Pertenece]
		, iif(ST.[tipoalimentador]='S' and (ST.[TipoAlimentadorPadre]<>'A' or ST.[TipoAlimentadorPadre] is null)
			,'Si Tipo Alimentador es S, debe existir el Alimentador al que pertence'
			,'Si Tipo Alimentador es A, no puede declarar Alimentador al que pertence') as [Detalle de Observación]
	FROM
	(
		SELECT
			AMT.[empresa],AMT.[localidad],AMT.[subestacion],AMT.[seccion],AMT.[tensionnominal],AMT.[tipoalimentador],AMT.[seccionalimentador],AMT.[semestre],AMT.[codigo_cabecera]
			,AMT.[NombreSemestre],AMT.[Actividad],AMT.[NombreEmpresa],AMT.[TipoAlimentadorPadre],AMT.[Alimen_SectorTipico],AMT.[Alimen_Sistema],AMT.[Alimen_NombreSistema]
		FROM [CalidadGenerales].[dbo].[ALIME_MT] as AMT
		where 
			(
				AMT.[tipoalimentador]='S' and (AMT.[TipoAlimentadorPadre]<>'A' or AMT.[TipoAlimentadorPadre] is null)
				--or (AMT.[tipoalimentador]='A' and AMT.[seccionalimentador] is not null)
				or (AMT.[tipoalimentador]='A' and len(AMT.[seccionalimentador])>0)
			) 
			and AMT.[NombreSemestre]=@NombreSemestre 
			and AMT.[empresa]=@Empresa
	) AS ST
/*	
declare @IDValidacion int
	set @IDValidacion=1
	use [CalidadReportes]
	select @IDValidacion as IDValidacion
		, * INTO Anexo1_Val_Rep18
	from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val18_ALIMEMTconSeccionAlimentadorObservado_Semestre]('ELC','2018S2')
				--from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val18_ALIMEMTconSeccionAlimentadorObservado_Semestre]('EDN','2018S1')
		-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val18_ALIMEMTconSeccionAlimentadorObservado_Semestre]('EDN','2018S1')
		-- Select * from [CalidadReportes].dbo.Anexo1_Val_Rep18 --truncate table Anexo1_Val_Rep18 --DROP table [CalidadReportes].dbo.Anexo1_Val_Rep18
	*/
)

GO
