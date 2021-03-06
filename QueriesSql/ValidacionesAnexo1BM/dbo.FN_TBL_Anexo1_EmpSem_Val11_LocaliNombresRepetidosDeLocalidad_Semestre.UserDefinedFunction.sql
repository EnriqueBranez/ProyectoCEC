USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val11_LocaliNombresRepetidosDeLocalidad_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Localidades reportados en la tabla LOCALI con nombres iguales.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val11_LocaliNombresRepetidosDeLocalidad_Semestre]('ENO','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val11_LocaliNombresRepetidosDeLocalidad_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [Sector Típico], [Código de Sistema Eléctrico], [Código de Localidad], [Nombre de Localidad]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val11_LocaliNombresRepetidosDeLocalidad_Semestre]('ENO','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='ENO'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by L.Empresa order by L.Empresa,L.[NombreSemestre],L.[nombrelocalidad],L.[sectortipico]) as Ítem
		, L.[Empresa]
		, L.[NombreSemestre] as Semestre, L.[sectortipico] as [Sector Típico], L.[sistemaelectrico] as [Código de Sistema Eléctrico]
		, L.[localidad] as [Código de Localidad]
		, L.[nombrelocalidad] as [Nombre de Localidad]
		--, L.[maximademanda] as [Máxima Demanda]
		--, L.[semestre], L.[codigo_cabecera], L.[sisaurbano], L.[actividad], L.[nomsistema], L.[Norma]
	FROM [dbo].[LOCALI] as L
	right join
		(
			SELECT
				L.[Empresa], L.NombreSemestre, L.[nombrelocalidad]
			FROM [dbo].[LOCALI] as L
			Where L.[actividad]='D' and L.NombreSemestre=@NombreSemestre and L.[Empresa]=@Empresa
			group by L.[Empresa], L.NombreSemestre, L.[nombrelocalidad]
			having count(*) >1
		) as R on L.[Empresa]=R.[Empresa] and L.NombreSemestre=R.NombreSemestre and L.[Empresa]=@Empresa
			and L.[nombrelocalidad]=R.[nombrelocalidad]
)

GO
