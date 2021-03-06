USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val10_LocaliVariacionSectorTipicoSemAnt_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Localidades reportadas en la tabla LOCALI que variaron de sector típico respecto al semestre anterior.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val10_LocaliVariacionSectorTipicoSemAnt_Semestre]('ENO','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val10_LocaliVariacionSectorTipicoSemAnt_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [Sector Típico], [Código de Sistema Eléctrico], [Código de Localidad], [Nombre de Localidad], [Máxima Demanda]
	, [Sector Típico declarado en Semestre Anterior], [Cód. Sistema Eléctrico Semestre Anterior], [Máx. Dem. Semestre Anterior]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val10_LocaliVariacionSectorTipicoSemAnt_Semestre]('ENO','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='ENO'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by L.Empresa order by L.Empresa,L.[NombreSemestre],L.[sectortipico],L.[Localidad]) as Ítem
		, L.[Empresa], L.[NombreSemestre] as Semestre, L.[sectortipico] as [Sector Típico], L.[sistemaelectrico] as [Código de Sistema Eléctrico]
		, L.[localidad] as [Código de Localidad], L.[nombrelocalidad] as [Nombre de Localidad], L.[maximademanda] as [Máxima Demanda]
		--, L.[semestre], L.[codigo_cabecera], L.[sisaurbano], L.[actividad], L.[nomsistema], L.[Norma]
		--,LA.[empresa], LA.[localidad], LA.[nombrelocalidad], LA.[semestre], LA.[codigo_cabecera], LA.[sisaurbano], LA.[actividad], LA.[NombreSemestre], LA.[nomsistema], LA.[Norma]
		, LA.[sectortipico] as [Sector Típico declarado en Semestre Anterior]
		, LA.[sistemaelectrico] as [Cód. Sistema Eléctrico Semestre Anterior]
		, LA.[maximademanda] as [Máx. Dem. Semestre Anterior]
	FROM [dbo].[LOCALI] as L
	left join [dbo].[LOCALI] as LA 
		on L.[empresa]=LA.empresa and L.[localidad]=LA.localidad and dbo.GetSemestreAnterior(L.[NombreSemestre])=LA.NombreSemestre
	Where L.[actividad]='D' and L.NombreSemestre=@NombreSemestre and L.[Empresa]=@Empresa
		and L.[sectortipico]<>LA.[sectortipico] 
)

GO
