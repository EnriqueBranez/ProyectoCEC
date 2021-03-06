USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val49_SUMINBT_SuministrosBTReportadoEnRINnoenSUMINBT]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Suministros en baja tensión reportados en el archivo RIN del tercer trimestre 2017 con diferente código de suministro al reportado en el archivo SUMINBT.
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val49_SUMINBT_SuministrosBTReportadoEnRINnoenSUMINBT]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, [Empresa], [Semestre de reporte de RIN], [Subestación en tabla RIN], [Código de Suministro en RIN], [Cantidad de Interrupciones]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val49_SUMINBT_SuministrosBTReportadoEnRINnoenSUMINBT]('CEV','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='CEV'
	--set @NombreSemestre='2018S1' --hay duplicados para EMP y SEA
	SELECT
		ROW_NUMBER() over (partition by SB.[empresa] order by SB.[Empresa], SB.[Subestación en tabla RIN], SB.numsuministro) as Ítem
		, SB.[Empresa], SB.NombreSemestre as [Semestre de reporte de RIN], SB.[Subestación en tabla RIN], SB.numsuministro as [Código de Suministro en RIN]
		, SB.[Cantidad de Interrupciones], RS.suministro
	FROM 
	(
		--declare @Empresa char(3), @NombreSemestre char(6)
		--set @Empresa='CEV'
		--set @NombreSemestre='2018S1' --hay duplicados para EMP y SEA
		SELECT Empresa, NombreSemestre, subestacion as [Subestación en tabla RIN], numsuministro, count(distinct [interrupcion]) as [Cantidad de Interrupciones]
			from CalidadSuministro.dbo.RIN
			WHERE Empresa=@Empresa AND NombreSemestre= [CalidadGenerales].[dbo].GetSemestreAnterior(@NombreSemestre) AND tension='BT'
			group by Empresa, NombreSemestre, subestacion,numsuministro
	)
	as SB
	left JOIN
	(
		--declare @Empresa char(3), @NombreSemestre char(6)
		--set @Empresa='CEV'
		--set @NombreSemestre='2018S1' --hay duplicados para EMP y SEA
		select [Empresa], NombreSemestre, [subestacion] as [Subestación en tabla SEDMTBT], suministro
			from [CalidadGenerales].[dbo].[SUMINBT]
			where Empresa=@Empresa AND NombreSemestre= @NombreSemestre
	) as RS
		ON SB.empresa=RS.empresa AND SB.numsuministro=RS.suministro
	where  RS.suministro is null

)


GO
