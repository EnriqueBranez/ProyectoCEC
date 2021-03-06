USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val32_SuministroMTnoReportado_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Suministros MT no reportados con respecto al semestre anterior.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val32_SuministroMTnoReportado_Semestre]('CEV','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val32_SuministroMTnoReportado_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre,[Sector Típico],[Sistema Eléctrico],Localidad,Suministro,[Opción Tarifaria],[Semestre en que no fue Reportado]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val32_SuministroMTnoReportado_Semestre]('CEV','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='CEV'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by A.Empresa order by A.Empresa,A.sectortipico,A.[sistemaelectrico],A.[Suministro]) as Ítem
		,A.[Empresa]
		,A.[NombreSemestre] as Semestre
		,A.[sectortipico] as [Sector Típico]
		,A.[sistemaelectrico] as [Sistema Eléctrico]
		,A.[Localidad]
		,A.[Suministro]
		,A.OPCION as [Opción Tarifaria]
		,'No se encontró en Semestre'+@NombreSemestre as [Semestre en que no fue Reportado]
	FROM [dbo].[SUMINMT] as A
	left join [dbo].[SUMINMT] as B on A.[EMPRESA]=B.EMPRESA and A.[SUMINISTRO]=B.SUMINISTRO and (A.[SEMESTRE]+1)=(B.SEMESTRE)
	Where A.[actividad]='D' and A.NombreSemestre= dbo.GetSemestreAnterior(@NombreSemestre)  and A.Empresa=@Empresa
		and B.SUMINISTRO is null
)

GO
