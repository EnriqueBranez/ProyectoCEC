USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val33_CantSuministrosBTdifTablaResumen_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Cantidad de suministros reportados en la tabla SUMINBT diferente a lo reportado en el archivo TABLA RESUMEN.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val33_CantSuministrosBTdifTablaResumen_Semestre]('CEV','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val33_CantSuministrosBTdifTablaResumen_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, Localidad, [Cantidad de Suministros Tabla SuminBT], [Cantidad de Suministros BT en la Tabla Resumen]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val33_CantSuministrosBTdifTablaResumen_Semestre]('CEV','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='CEV'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by S.Empresa order by S.Empresa,S.[localidad]) as Ítem
		, S.[Empresa], S.[Semestre], S.[Localidad], S.[Cantidad de Suministros] as [Cantidad de Suministros Tabla SuminBT]
		--, R.[empresa],R.[actividad],R.Semestre,R.[localidad]
		, R.[Cantidad de Suministros] as [Cantidad de Suministros BT en la Tabla Resumen]
	from
	(	--Cantidad de Suministro BT  por localidad
		SELECT
			SB.[Empresa], SB.[actividad], SB.[NombreSemestre] as Semestre, SB.[localidad], Count(SB.[suministro]) as [Cantidad de Suministros]
		FROM [dbo].[SUMINBT] as SB
		where SB.[actividad]='D' and SB.[NombreSemestre]=@NombreSemestre  and SB.Empresa=@Empresa
		group by SB.[empresa], SB.[actividad], SB.[NombreSemestre], SB.[localidad]
	) as S 
	left join 
	(
		--Tabbla [TABLARESUMEN]
		SELECT
			R.[empresa],R.[NombreSemestre] as Semestre,R.[localidad], R.[suminbtmon]+R.[suminbttri] as [Cantidad de Suministros]
		FROM [dbo].[TABLARESUMEN] as R
		where R.NombreSemestre=@NombreSemestre and R.Empresa=@Empresa
	) as R on S.[Empresa]=R.Empresa and S.[Semestre]=R.Semestre and S.[localidad]=R.localidad
	where S.[Cantidad de Suministros]<>R.[Cantidad de Suministros]
)

GO
