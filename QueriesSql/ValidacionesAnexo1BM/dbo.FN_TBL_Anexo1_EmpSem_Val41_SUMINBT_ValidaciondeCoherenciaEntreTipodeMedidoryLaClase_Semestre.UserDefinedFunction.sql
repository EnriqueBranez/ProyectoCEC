USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val41_SUMINBT_ValidaciondeCoherenciaEntreTipodeMedidoryLaClase_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	La información asignada en el campo 26 (tipo de medidor) no guarda relación con el campo 29 
	--(clase de precisión del medidor) de la tabla SUMINBT.
-- Description:	--Validación 76	: Validación tabla SUMINBT, Suministros con tipo de medidor que no concuerda con la clase de medidor,
								--cuando es tipo medidor "M" la clase debe ser "C2" y cuando es la clase no puede ser "C2"
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val41_SUMINBT_ValidaciondeCoherenciaEntreTipodeMedidoryLaClase_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, NombreSemestre, [Código de Suministro], [Opción Tarifaria], [Marca], [Modelo], [Serie]
	, [Año del Medidor], [Tipo de Medidor], [Clase de Medidor]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val41_SUMINBT_ValidaciondeCoherenciaEntreTipodeMedidoryLaClase_Semestre]('ESE','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6), @CantidadMinimaPorDistrito int
	--set @Empresa='ESE'
	--set @NombreSemestre='2018S1'
	select
		ROW_NUMBER() over (partition by SB.[empresa]
			order by SB.[empresa], SB.[NombreSemestre], SB.[suministro]) as Ítem 
		, SB.[Empresa], SB.[NombreSemestre], SB.[suministro] as [Código de Suministro]
		, SB.[opcion] as [Opción Tarifaria], SB.[Marca], SB.[Modelo], SB.[Serie]
		, SB.[anio] as [Año del Medidor]
		, SB.[medidor] as [Tipo de Medidor]
		, SB.[clases] as [Clase de Medidor]
		--, SB.[SuminBT_codigo_cabecera], SB.[NroRegEnArchivoOrigen]
		--, SB.[nombrelocalidad], SB.[Localidad_MaximaDemanda]
		--, SB.[sistemaelectrico], SB.[nomsistema], SB.[tiposistema], SB.[sectortipico], SB.[Sistemas_MaximaDemandaMW]
		--, SB.[Norma], SB.[actividad], SB.[NombreSemestre]
	FROM [dbo].[SUMINBT] as SB
	where SB.[actividad]='D' and SB.NombreSemestre=@NombreSemestre AND SB.[Empresa]=@Empresa
		and ( (SB.[medidor]='M' and SB.[clases]<>'C2') or (SB.[medidor]='E' and SB.[clases]='C2') )
)


GO
