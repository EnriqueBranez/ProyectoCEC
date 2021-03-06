USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val36_SEDMTBT_UbigeoNoIgualACodigoINEI_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	El ubigeo de la tabla SED_MTBT no concuerda con los códigos de Ubigeo establecidos por el INEI.
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val36_SEDMTBT_UbigeoNoIgualACodigoINEI_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, [Código de Localidad], [Código de SEDMTBT], [Nombre de la SEDMTBT], [Dirección de la SEDMTBT]
	, [Código Ubicación declarado en SEDMTBT], [Ubigeo del INEI]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val36_SEDMTBT_UbigeoNoIgualACodigoINEI_Semestre]('ELS','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='ELS'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by SE.[empresa] order by SE.[empresa], SE.[localidad], SE.[subestacion]) as Ítem
		--SELECT --top 10
		, SE.[Empresa], SE.[Localidad] as [Código de Localidad]
		, SE.[subestacion] as [Código de SEDMTBT], SE.[nombresubestacion] as [Nombre de la SEDMTBT]
		, SE.[direccionset] as [Dirección de la SEDMTBT], SE.[ubicacion] as [Código Ubicación declarado en SEDMTBT]
		/*, SE.[tensiobt], SE.[tensionmt], SE.[captransformacion], SE.[utmnorte], SE.[utmeste], SE.[seccionlinea]
		, SE.[semestre], SE.[SEDMTBT_codigo_cabecera]
		, SE.[NombreSemestre], SE.[nombrelocalidad], SE.[Localidad_MaximaDemanda]
		, SE.[sistemaelectrico], SE.[nomsistema], SE.[tiposistema], SE.[sectortipico], SE.[Sistemas_MaximaDemandaMW], SE.[actividad]
		, SE.[tipoalimentador], SE.[seccionalimentador], SE.[TipoAlimentadorPadre], SE.[TensionNominalAlimentador]
		, U.[Ubigeo], U.[Nombre], U.[TipoDivisionGeografica], U.[DeptUbigeo], U.[DeptNombre], U.[PerteneceAUbigeo], U.[PerteneceNombre], U.[PerteneceTipoDivisionGeografica]
		*/
		, U.[Ubigeo] as [Ubigeo del INEI]
	FROM [dbo].[SED_MTBT] as SE
	left join [dbo].[UBIGEO] as U on cast(SE.ubicacion as int)=cast(U.Ubigeo as int)
	where u.Ubigeo is not null and SE.NombreSemestre=@NombreSemestre and SE.Empresa=@Empresa
		and SE.ubicacion<>U.Ubigeo
)


GO
