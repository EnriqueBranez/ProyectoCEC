USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val46_SUMINBT_conRINCantSumDiferente_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Subestaciones de Distribución reportadas en el archivo SUMINBT con 
--               menor cantidad de suministros de lo reportado en el archivo RIN del tercer trimestre 2017.
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val46_SUMINBT_conRINCantSumDiferente_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [Código de Subestación en archivo SUMINBT]
	, [Cantidad de Suministros en archivo SUMINBT], [Semestre del RIN], [Cantidad de Suministros reportado en el archivo RIN], [% Diferencia]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val46_SUMINBT_conRINCantSumDiferente_Semestre]('CEV','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='CEV'
	--set @NombreSemestre='2018S1' --hay duplicados para EMP y SEA
	SELECT
		ROW_NUMBER() over (partition by SB.[empresa] order by SB.[Empresa], SB.[NombreSemestre], SB.[subestacion]) as Ítem
		, SB.[Empresa], SB.[NombreSemestre] as Semestre, SB.[subestacion] as [Código de Subestación en archivo SUMINBT]
		, SB.[CantidadSuministros] as [Cantidad de Suministros en archivo SUMINBT]
		--, RS.subestacion as [Código de Subestacion en RIN]
		, RS.[NombreSemestre] AS [Semestre del RIN]
		, RS.[CantidadSuministros] as [Cantidad de Suministros reportado en el archivo RIN]
		, abs(100.0*(SB.CantidadSuministros-RS.CantidadSuministros)/SB.CantidadSuministros) as [% Diferencia]
	FROM
	(
		Select [NombreSemestre], [empresa], [subestacion], count(DISTINCT [suministro]) as CantidadSuministros
		from [CalidadGenerales].[dbo].[SUMINBT]
		where [NombreSemestre]=@NombreSemestre and [empresa]=@Empresa
		--where [NombreSemestre]='2017S2' and [empresa]='EDN' and [subestacion]='10503A'
		group by [empresa], [NombreSemestre], [subestacion]
	) as SB
	left join
	(
		select [NombreSemestre], [empresa], [subestacion], count(DISTINCT [numsuministro]) as CantidadSuministros
		from [CalidadSuministro].[dbo].[RIN]
		where [NombreSemestre]=CalidadGenerales.DBO.GetSemestreAnterior(@NombreSemestre) and [empresa]=@Empresa 
		--SELECT CalidadGenerales.DBO.GetSemestreAnterior('2018S1')
		--select * from [CalidadSuministro].[dbo].[RIN] where [NombreSemestre]=CalidadGenerales.DBO.GetSemestreAnterior('2018S1') AND EMPRESA='ELS'
		--where [NombreSemestre]='2017S2' and [empresa]='EDN' and [subestacion]='10503A'
		group by [empresa], [NombreSemestre], [subestacion]
	) as RS on CalidadGenerales.DBO.GetSemestreAnterior(SB.NombreSemestre)=RS.NombreSemestre and SB.empresa=RS.empresa and SB.subestacion = RS.subestacion
	where RS.empresa is Null or abs(1.0*(SB.CantidadSuministros-RS.CantidadSuministros)/SB.CantidadSuministros)>0.5
	--order by SB.[empresa], SB.[NombreSemestre], SB.[sectortipico], SB.[sistemaelectrico], SB.[subestacion]
)


GO
