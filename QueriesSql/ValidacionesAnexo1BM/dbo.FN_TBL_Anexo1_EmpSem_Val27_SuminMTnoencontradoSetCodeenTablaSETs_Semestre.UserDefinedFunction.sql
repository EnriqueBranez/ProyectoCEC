USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val27_SuminMTnoencontradoSetCodeenTablaSETs_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Campo 14 de la tabla SUMINMT (código SET) no reportado en tabla SET.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val27_SuminMTnoencontradoSetCodeenTablaSETs_Semestre]('EOR','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val27_SuminMTnoencontradoSetCodeenTablaSETs_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, Suministro, [Código de la SET a la que pertenece], [Código de Alimentador], Observación
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val27_SuminMTnoencontradoSetCodeenTablaSETs_Semestre]('EOR','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='EMP'
	--set @NombreSemestre='2019S2'
	SELECT
		ROW_NUMBER() over (partition by SM.[Empresa] order by SM.[Empresa],SM.[SUMINISTRO]) as Ítem
		, SM.[Empresa], SM.[NombreSemestre] as Semestre, SM.[SUMINISTRO]
		, SM.[subestacion] as [Código de la SET a la que pertenece], SM.[ALIMENTADOR] as [Código de Alimentador]
		, SM.[subestacion]+' no encontrado en tabla SETs del Anexo 1' as Observación
	FROM [dbo].[SUMINMT] as SM
	left join [dbo].[SETS] as ST on SM.[EMPRESA]=ST.[Empresa] and SM.[NombreSemestre]=ST.[NombreSemestre] and SM.[subestacion]=ST.[Subestacion]
	--left join [dbo].[ALIME_MT] as AMT on SM.[EMPRESA]=AMT.[Empresa] and SM.[NombreSemestre]=AMT.[NombreSemestre] and SM.[ALIMENTADOR]=AMT.[seccion]
	Where SM.[actividad]='D' and SM.[NombreSemestre]=@NombreSemestre and SM.[empresa]=@Empresa
		and ST.Subestacion is Null
)

GO
