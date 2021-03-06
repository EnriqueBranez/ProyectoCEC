USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val30_CantidadSEDsdiferentesSuminBT_SEDMTBT_TblResumen_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Cantidad de subestaciones de distribución reportados en la tabla SUMINBT diferente a los reportados la tabla SED MT/BT y/o TABLA RESUMEN.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val30_CantidadSEDsdiferentesSuminBT_SEDMTBT_TblResumen_Semestre]('CEV','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val30_CantidadSEDsdiferentesSuminBT_SEDMTBT_TblResumen_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [Cantidad de SEDs MT/BT declarado en tabla SuminBT]
	, [Cantidad de SEDs MT/BT declarado en tabla SEDMTBT], [Cantidad de SEDs MT/BT declarado en tabla Resumen] 
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val30_CantidadSEDsdiferentesSuminBT_SEDMTBT_TblResumen_Semestre]('CEV','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='CEV'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by E.codigo order by E.codigo) as Ítem
		,E.codigo as [Código Empresa]
		, SB.[empresa]
		, SB.[NombreSemestre] as Semestre, SB.[Cantidad de SEDs MT/BT declarado en tabla SuminBT]
		--, SE.[empresa], SE.[NombreSemestre]
		, SE.[Cantidad de SEDs MT/BT declarado en tabla SEDMTBT]
		--, R.[empresa], R.[NombreSemestre]
		, R.[Cantidad de SEDs MT/BT declarado en tabla Resumen] 
	from Empresa as E
	left join (
			SELECT --top 2
				SB.[empresa], SB.[NombreSemestre], count(distinct(SB.[subestacion])) as [Cantidad de SEDs MT/BT declarado en tabla SuminBT]
			FROM [dbo].[SUMINBT] as SB
			where SB.[NombreSemestre]=@NombreSemestre and SB.Empresa=@Empresa
			group by SB.[empresa], SB.[NombreSemestre]
		) as SB on E.codigo=SB.[empresa]
	left join (
			SELECT
				SE.[empresa], SE.[NombreSemestre], count(SE.[subestacion]) as [Cantidad de SEDs MT/BT declarado en tabla SEDMTBT]
			FROM [dbo].[SED_MTBT] as SE
			where SE.[NombreSemestre]=@NombreSemestre and SE.Empresa=@Empresa
			group by SE.[empresa], SE.[NombreSemestre]
		) as SE on E.codigo=SE.[empresa]
	left join (
			SELECT
				R.[empresa],R.[NombreSemestre],sum(R.[nroseds])  as [Cantidad de SEDs MT/BT declarado en tabla Resumen] 
			FROM [dbo].[TABLARESUMEN] as R where R.NombreSemestre=@NombreSemestre and R.Empresa=@Empresa
			group by R.[empresa], R.[NombreSemestre]
		) as R on E.codigo=R.[empresa]
	Where E.actividad='D' and E.Empresa=@Empresa
		and
			([Cantidad de SEDs MT/BT declarado en tabla SuminBT]<>[Cantidad de SEDs MT/BT declarado en tabla SEDMTBT]
			or [Cantidad de SEDs MT/BT declarado en tabla SuminBT]<>[Cantidad de SEDs MT/BT declarado en tabla Resumen] 
			or [Cantidad de SEDs MT/BT declarado en tabla SEDMTBT]<>[Cantidad de SEDs MT/BT declarado en tabla Resumen] 
			)
)

GO
