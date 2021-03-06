USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val13_LocaliCantidadLocalidadesConTablaResumen_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Localidades reportadas en la tabla LOCALI que variaron  su demanda respecto a lo reportado en el archivo TABLA RESUMEN.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val13_LocaliCantidadLocalidadesConTablaResumen_Semestre]('ESE','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val13_LocaliCantidadLocalidadesConTablaResumen_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [Cantidad de Localidades en Tabla Locali], [Cantidad de Localidades en Tabla Resumen]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val13_LocaliCantidadLocalidadesConTablaResumen_Semestre]('ESE','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='ESE'
	--set @NombreSemestre='2018S1'
	Select 
		ROW_NUMBER() over (partition by L.Empresa order by L.Empresa) as Ítem
		,L.[Empresa], L.Semestre, L.[Cantidad de Localidades en Tabla Locali], R.[Cantidad de Localidades en Tabla Resumen]
	from
	(
		--declare @Empresa char(3), @NombreSemestre char(6)
		--set @Empresa='ESE'
		--set @NombreSemestre='2018S1'
		SELECT
			L.[Empresa], L.NombreSemestre as Semestre, L.Actividad, COUNT(L.[localidad]) AS [Cantidad de Localidades en Tabla Locali]
		FROM [dbo].[LOCALI] as L
		where L.NombreSemestre=@NombreSemestre  and L.[Empresa]=@Empresa
		group by L.[Empresa], L.NombreSemestre, L.Actividad
	) as L
	left join 
	(	
		--declare @Empresa char(3), @NombreSemestre char(6)
		--set @Empresa='ESE'
		--set @NombreSemestre='2018S1'
		SELECT
			R.[Empresa], R.NombreSemestre, count(distinct(R.[localidad])) AS [Cantidad de Localidades en Tabla Resumen]
		FROM [dbo].[TABLARESUMEN] as R
		where R.NombreSemestre=@NombreSemestre  and R.[Empresa]=@Empresa
		group by R.[Empresa], R.NombreSemestre
	) as R
		on L.empresa=R.empresa and L.Semestre=R.NombreSemestre
	where L.Semestre=@NombreSemestre  and L.[Empresa]=@Empresa
		and L.[Cantidad de Localidades en Tabla Locali]<>R.[Cantidad de Localidades en Tabla Resumen]
	--where L.Semestre='2017S2' and L.Actividad='D'
)

GO
