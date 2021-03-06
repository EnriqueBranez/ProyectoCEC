USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val43_SUMINBT_SUMINMT_SuministroRepetido]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	SED MT/BT reportadas en la tabla ALIME_BT con más de 10 circuitos de baja tensión.
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val43_SUMINBT_SUMINMT_SuministroRepetido]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem , Empresa, Semestre, [Código de Suministro BT], [Opción Tarifaria], [Identificación Suministro BT]
	, [Código de Suministro MT], [Opción Tarifaria Suministros MT], [Identificación Suministro MT]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val43_SUMINBT_SUMINMT_SuministroRepetido]('EMP','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='CEV'
	--set @NombreSemestre='2018S1' --hay duplicados para EMP y SEA
	select
		ROW_NUMBER() over (partition by SB.[empresa] order by SB.[empresa], SB.[NombreSemestre], SB.[suministro]) as Ítem 
		, SB.[Empresa], SB.[NombreSemestre] as Semestre, SB.[suministro] as [Código de Suministro BT]
		, SB.[opcion] as [Opción Tarifaria], SB.identificacion as [Identificación Suministro BT]
		--, SB.[Marca], SB.[Modelo], SB.[Serie], SB.[anio] as [Año del Medidor], SB.[medidor] as [Tipo de Medidor], SB.[clases] as [Clase de Medidor]
		--, SB.[SuminBT_codigo_cabecera], SB.[NroRegEnArchivoOrigen], SB.[nombrelocalidad], SB.[Localidad_MaximaDemanda]
		--, SB.[sistemaelectrico], SB.[nomsistema], SB.[tiposistema], SB.[sectortipico], SB.[Sistemas_MaximaDemandaMW]
		--, SB.[Norma], SB.[actividad], SB.[NombreSemestre]
		, SM.[suministro] as [Código de Suministro MT], SM.[OPCION] as [Opción Tarifaria Suministros MT], SB.identificacion as [Identificación Suministro MT]
	FROM [dbo].[SUMINBT] as SB
	left join [dbo].[SUMINMT] as SM on SB.empresa=SM.EMPRESA AND SB.NombreSemestre=SM.NombreSemestre AND SB.suministro=SM.SUMINISTRO
	where SB.NombreSemestre=@NombreSemestre AND SB.[Empresa]=@Empresa
		AND SM.SUMINISTRO IS NOT NULL
)


GO
