USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val04_SistemasNoReportadoResolucion205_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Cantidad de sistemas eléctricos reportados en el archivo SISTEMAS diferente a la Resolución OSINERGMIN N° 205-2013-OS/CD.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val04_SistemasNoReportadoResolucion205_Semestre]('ESE','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val04_SistemasNoReportadoResolucion205_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [Sector Típico], Sistema, [Nombre se Sistema Eléctrico]
	, [Código de Sistema Electrico de tabla Resolucion 205]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val04_SistemasNoReportadoResolucion205_Semestre]('ESE','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='CEV'
	--set @NombreSemestre='2019S1'
	Select 
		ROW_NUMBER() over (partition by S.Empresa order by S.Empresa,S.NombreSemestre, S.sectortipico, S.[Sistema]) as Ítem
		, S.[Empresa], S.NombreSemestre as Semestre, S.sectortipico as [Sector Típico], S.[Sistema], s.nomsistema as [Nombre se Sistema Eléctrico]
		, P.[codigontcse] as [Código de Sistema Electrico de tabla Resolucion 205]
	FROM [dbo].[SISTEMAS] as S 
	right join (
		SELECT
			M.[empresa],M.[sector],M.[codigontcse],M.[codigogfeit],M.[codigogart],M.[nombresistema],M.[vigenciadesde],M.[vigenciahasta], M.[Dispositivo Legal], M.[Detalle en DL]
			,M.[NombreSemestre],M.[CodigoSemestre],M.[FechaDesde],M.[FechaHasta],M.[CantidadDias],M.[CantidadHoras],M.[FactorAplicacionNTCSER]
		FROM [CalidadGenerales].[dbo].[MaestroSistemas] as M --where [empresa]='ECA'
		where M.NombreSemestre=@NombreSemestre and M.[Empresa]=@Empresa and M.[sector]<>'R'
	) as P 
		on S.empresa=P.empresa and S.sistema=P.[codigontcse]
	--where --S.NombreSemestre='2019S1' and S.Actividad='D' and sectortipico<>'R' and P.[codigontcse] is null
	where S.NombreSemestre=@NombreSemestre and S.[Empresa]=@Empresa
		and S.Actividad='D' and sectortipico<>'R' and P.[codigontcse] is null
		--select * from [CalidadGenerales].dbo.[SE_Res205_2013]
)

GO
