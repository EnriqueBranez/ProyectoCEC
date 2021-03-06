USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val29_SEDMTBTdiferenteSistemaElectricoEnSuminBT_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Subestaciones de distribución reportadas en la tabla SED MT/BT con diferente sistema eléctrico a lo reportado en la tabla SUMINBT.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val29_SEDMTBTdiferenteSistemaElectricoEnSuminBT_Semestre]('CEV','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val29_SEDMTBTdiferenteSistemaElectricoEnSuminBT_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [Código de SubEstación], [Nombre de la Subestación]
	, [Sistema Eléctrico según Tabla SEDMTBT], [Sector Típico según Tabla SEDMTBT]
	, [Sistema Eléctrico según Tabla SuminBT], [Sector Típico según Tabla SuminBT]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val29_SEDMTBTdiferenteSistemaElectricoEnSuminBT_Semestre]('ELS','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='EOR'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by SE.[Empresa] order by SE.[Empresa], SE.[NombreSemestre], SE.[sectortipico], SE.[sistemaelectrico]) as Ítem
		, SE.[Empresa], SE.[NombreSemestre] as Semestre, SE.[subestacion] as [Código de SubEstación]
		, SE.[nombresubestacion] as [Nombre de la SubEstación]
		, SE.[sistemaelectrico] as [Sistema Eléctrico según Tabla SEDMTBT]
		, SE.[sectortipico] as [Sector Típico según Tabla SEDMTBT]
		--, SB.[Empresa], SB.[NombreSemestre], SB.[subestacion]
		, SB.[sistemaelectrico] as [Sistema Eléctrico según Tabla SuminBT]
		, SB.[sectortipico] as [Sector Típico según Tabla SuminBT]
	FROM [dbo].[SED_MTBT] as SE
	left join
	(	SELECT 
			SB.[Empresa], SB.[NombreSemestre], SB.[subestacion], SB.[sistemaelectrico], SB.[sectortipico]
		FROM [dbo].[SUMINBT] as SB
		where SB.[actividad]='D' and SB.[NombreSemestre]=@NombreSemestre and SB.[empresa]=@Empresa
		group by SB.[Empresa], SB.[NombreSemestre], SB.[subestacion], SB.[sistemaelectrico], SB.[sectortipico]
	) as SB on SE.[Empresa]=SB.[Empresa] and SE.[NombreSemestre]=SB.[NombreSemestre] and SE.[subestacion]=SB.[subestacion]
	where SE.[actividad]='D' and SE.[NombreSemestre]=@NombreSemestre and SE.[empresa]=@Empresa
		and SE.[sistemaelectrico]<>SB.[sistemaelectrico]
)

GO
