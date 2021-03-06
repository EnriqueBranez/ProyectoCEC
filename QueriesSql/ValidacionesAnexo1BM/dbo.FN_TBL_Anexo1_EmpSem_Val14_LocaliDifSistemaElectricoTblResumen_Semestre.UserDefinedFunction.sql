USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val14_LocaliDifSistemaElectricoTblResumen_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Localidades reportadas en la tabla LOCALI que variaron  su demanda respecto a lo reportado en el archivo TABLA RESUMEN.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val14_LocaliDifSistemaElectricoTblResumen_Semestre]('ESE','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val14_LocaliDifSistemaElectricoTblResumen_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [Sector Típico], [Código de Sistema Eléctrico]
	, [Código de Localidad], [Nombre de Localidad], [Máxima Demanda], [Código de Sistema Eléctrico Tabla Resumen]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val14_LocaliDifSistemaElectricoTblResumen_Semestre]('ESE','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='ESE'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by L.Empresa order by L.Empresa,L.[NombreSemestre],L.[sectortipico],L.[Localidad]) as Ítem
		, L.[Empresa], L.[NombreSemestre] as Semestre, L.[sectortipico] as [Sector Típico], L.[sistemaelectrico] as [Código de Sistema Eléctrico]
		, L.[localidad] as [Código de Localidad], L.[nombrelocalidad] as [Nombre de Localidad], L.[maximademanda] as [Máxima Demanda]
		--, L.[semestre], L.[codigo_cabecera], L.[sisaurbano], L.[actividad], L.[nomsistema], L.[Norma]
		--,R.[localidad]
		,R.[sistema] as [Código de Sistema Eléctrico Tabla Resumen]
	FROM [dbo].[LOCALI] as L
	left join [dbo].[TABLARESUMEN] as R
		on L.[empresa]=R.empresa and L.[localidad]=R.localidad and L.[NombreSemestre]=R.NombreSemestre
	Where L.[actividad]='D' and L.NombreSemestre=@NombreSemestre and L.[empresa]=@Empresa
		and L.[sistemaelectrico]<>R.[sistema]
)

GO
