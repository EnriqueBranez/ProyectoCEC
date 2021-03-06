USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val34_CantSuministrosMTdifTablaResumen_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Cantidad de suministros reportados en la tabla SUMINBT diferente a lo reportado en el archivo TABLA RESUMEN.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val34_CantSuministrosMTdifTablaResumen_Semestre]('CEV','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val34_CantSuministrosMTdifTablaResumen_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, Localidad, [Cantidad de Suministros en la Tabla SuminMT], [Cantidad de Suministros MT en la Tabla Resumen]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val34_CantSuministrosMTdifTablaResumen_Semestre]('CEV','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='CEV'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by S.Empresa order by S.Empresa,S.[Localidad]) as Ítem
		, S.[Empresa], S.[Semestre], S.[Localidad], S.[Cantidad de Suministros] as [Cantidad de Suministros en la Tabla SuminMT]
		--, R.[empresa],R.[actividad],R.Semestre,R.[localidad]
		, R.[Cantidad de Suministros] as [Cantidad de Suministros MT en la Tabla Resumen]
	from
	(	--Cantidad de Suministro MT  Pir localidad
		SELECT
			SM.[Empresa], SM.[actividad], SM.[NombreSemestre] as Semestre, SM.[localidad], Count(SM.[suministro]) as [Cantidad de Suministros]
		FROM [dbo].[SUMINMT] as SM
		where SM.[actividad]='D' and SM.[NombreSemestre]=@NombreSemestre and SM.Empresa=@Empresa
		--where SM.[actividad]='D' and SM.[NombreSemestre]='2017S2'
		group by SM.[empresa], SM.[actividad], SM.[NombreSemestre], SM.[localidad]
	) as S 
	left join 
	(
		--Tabla [TABLARESUMEN]
		SELECT
			R.[empresa],R.[NombreSemestre] as Semestre,R.[localidad], R.[suministrosmt] as [Cantidad de Suministros]
		FROM [dbo].[TABLARESUMEN] as R
		where R.NombreSemestre=@NombreSemestre and R.Empresa=@Empresa
		--where R.NombreSemestre='2017S2'
	) as R on S.[Empresa]=R.Empresa and S.[Semestre]=R.Semestre and S.[localidad]=R.localidad
	where S.[Cantidad de Suministros]<>R.[Cantidad de Suministros]

)

GO
