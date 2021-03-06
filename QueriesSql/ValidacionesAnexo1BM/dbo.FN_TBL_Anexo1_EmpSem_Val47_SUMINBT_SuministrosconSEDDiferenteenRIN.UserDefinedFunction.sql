USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val47_SUMINBT_SuministrosconSEDDiferenteenRIN]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	El código de SED del suministro reportado en el archivo SUMINBT es diferente al reportado en el archivo RIN del tercer trimestre 2017.
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val47_SUMINBT_SuministrosconSEDDiferenteenRIN]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, Suministro, [Subestación en tabla SUMINBT], [Semestre de reporte de RIN], [Subestación en tabla RIN], [Cantidad de Interrupciones]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val47_SUMINBT_SuministrosconSEDDiferenteenRIN]('CEV','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='CEV'
	--set @NombreSemestre='2018S1' --hay duplicados para EMP y SEA
	SELECT
		ROW_NUMBER() over (partition by SB.[empresa] order by SB.[Empresa], SB.[SUMINISTRO]) as Ítem
		, SB.[Empresa], SB.NombreSemestre as Semestre, SB.[Suministro], SB.[Subestación en tabla SUMINBT]
		, RS.NombreSemestre as [Semestre de reporte de RIN], RS.subestacion as [Subestación en tabla RIN]
		, RS.[Cantidad de Interrupciones]
	FROM 
	(
		select SB.[EMPRESA], SB.NombreSemestre, SB.[SUMINISTRO], SB.[SUBESTACION] as [Subestación en tabla SUMINBT]
			from [CalidadGenerales].[dbo].[SUMINBT] as SB
			where Empresa=@Empresa AND NombreSemestre= @NombreSemestre
	)
	as SB
	LEFT JOIN
	(
		--declare @Empresa char(3), @NombreSemestre char(6)
		--set @Empresa='CEV'
		--set @NombreSemestre='2018S1' --hay duplicados para EMP y SEA
		SELECT Empresa, NombreSemestre, subestacion, [numsuministro] as suministro, count(*) as [Cantidad de Interrupciones]
			from CalidadSuministro.dbo.RIN
			WHERE Empresa=@Empresa AND NombreSemestre= [CalidadGenerales].[dbo].GetSemestreAnterior(@NombreSemestre)
			group by Empresa, NombreSemestre, subestacion, [numsuministro]
	) as RS
		ON SB.empresa=RS.empresa AND SB.suministro=RS.suministro
	where SB.NombreSemestre=@NombreSemestre and SB.empresa=@Empresa and SB.[Subestación en tabla SUMINBT]<>RS.subestacion

)


GO
