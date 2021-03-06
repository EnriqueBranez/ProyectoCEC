USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val12_VariacionDemandaEntreLocaliTablaResumen_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Localidades reportadas en la tabla LOCALI que variaron  su demanda respecto a lo reportado en el archivo TABLA RESUMEN.
-- Select * from [CalidadGenerales].[dbo].[CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val12_VariacionDemandaEntreLocaliTablaResumen_Semestre]('PAN','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val12_VariacionDemandaEntreLocaliTablaResumen_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [Sector Típico], [Sistema Eléctrico], [Código de Localidad], [Nombre de Localidad]
	,[Máxima Demanda en tabla LOCALI],[Código Localidad Tbl Resumen],[Máxima Demanda Declarada en Tabla Resumen]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val12_VariacionDemandaEntreLocaliTablaResumen_Semestre]('PAN','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='PAN'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by L.[Empresa] order by L.[Empresa], L.sectortipico,L.[sistemaelectrico],L.[Localidad]) as Ítem
		,L.[Empresa],L.[NombreSemestre] as Semestre, L.sectortipico as [Sector Típico]
		,L.[sistemaelectrico] as [Sistema Eléctrico],L.[Localidad] as [Código de Localidad]
		,L.[nombrelocalidad] as [Nombre de Localidad],L.[maximademanda] as [Máxima Demanda en tabla LOCALI]
		--, L.[Semestre],L.[codigo_cabecera],L.[sisaurbano],L.[actividad]
		,R.localidad as [Código Localidad Tbl Resumen], R.demanda as [Máxima Demanda Declarada en Tabla Resumen]
	FROM [dbo].[LOCALI] as L
	left join [dbo].[TABLARESUMEN] as R on L.empresa=R.empresa and L.semestre=R.semestre and L.localidad=R.localidad
	where L.NombreSemestre=@NombreSemestre and L.[Empresa]=@Empresa
		and ( L.maximademanda<>R.demanda or R.demanda is null)
)

GO
