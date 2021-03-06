USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val48_SEDMTBT_SubestacionesReportadoEnRINnoenSEDMTBT]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Subestaciones de distribución reportados en el archivo RIN del tercer trimestre 2017 no reportadas en el archivo SED_MTBT.
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val48_SEDMTBT_SubestacionesReportadoEnRINnoenSEDMTBT]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, [Empresa], [Semestre de reporte de RIN], [Subestación en tabla RIN], [Cantidad de Interrupciones], [Subestación en tabla SEDMTBT]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val48_SEDMTBT_SubestacionesReportadoEnRINnoenSEDMTBT]('CEV','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='CEV'
	--set @NombreSemestre='2018S1' --hay duplicados para EMP y SEA
	SELECT
		ROW_NUMBER() over (partition by SB.[empresa] order by SB.[Empresa], SB.[Subestación en tabla RIN]) as Ítem
		, SB.[Empresa], SB.NombreSemestre as [Semestre de reporte de RIN], SB.[Subestación en tabla RIN]
		, SB.[Cantidad de Interrupciones], RS.[Subestación en tabla SEDMTBT]
	FROM 
	(
		--declare @Empresa char(3), @NombreSemestre char(6)
		--set @Empresa='CEV'
		--set @NombreSemestre='2018S1' --hay duplicados para EMP y SEA
		SELECT Empresa, NombreSemestre, subestacion as [Subestación en tabla RIN], count(distinct [interrupcion]) as [Cantidad de Interrupciones]
			from CalidadSuministro.dbo.RIN
			WHERE Empresa=@Empresa AND NombreSemestre= [CalidadGenerales].[dbo].GetSemestreAnterior(@NombreSemestre)
			group by Empresa, NombreSemestre, subestacion
	)
	as SB
	left JOIN
	(
		--declare @Empresa char(3), @NombreSemestre char(6)
		--set @Empresa='CEV'
		--set @NombreSemestre='2018S1' --hay duplicados para EMP y SEA
		select [Empresa], NombreSemestre, [subestacion] as [Subestación en tabla SEDMTBT]
			from [CalidadGenerales].[dbo].[SED_MTBT]
			where Empresa=@Empresa AND NombreSemestre= @NombreSemestre
	) as RS
		ON SB.empresa=RS.empresa AND SB.[Subestación en tabla RIN]=RS.[Subestación en tabla SEDMTBT]
	where  RS.[Subestación en tabla SEDMTBT] is null

)


GO
