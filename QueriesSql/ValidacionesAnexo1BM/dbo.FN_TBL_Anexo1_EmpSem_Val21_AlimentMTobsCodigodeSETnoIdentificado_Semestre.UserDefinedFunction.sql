USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val21_AlimentMTobsCodigodeSETnoIdentificado_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Subestaciones de Transmisión reportados en la tabla ALIME_MT pero no fueron reportadas en la tabla SETS.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val21_AlimentMTobsCodigodeSETnoIdentificado_Semestre]('ESE','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val21_AlimentMTobsCodigodeSETnoIdentificado_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [SET], [Código de Sección o Alimentador], [Tipo Alimentador], [Sección o Alimentador al que Pertenece], Observación
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val21_AlimentMTobsCodigodeSETnoIdentificado_Semestre]('ESE','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='ESE'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by AMT.[Empresa] order by AMT.[Empresa]) as Ítem
		, AMT.[Empresa], AMTO.[NombreSemestre] AS Semestre
		, AMT.[subestacion] as [SET]
		, AMT.[seccion] as [Código de Sección o Alimentador], AMT.[tipoalimentador] as [Tipo Alimentador]
		, AMT.[seccionalimentador] as [Sección o Alimentador al que Pertenece]
		, 'SET '+AMT.[subestacion]+' no reportado en tabla SET del Anexo 1' as Observación
		--, AMT.[tipoalimentador], AMT.[seccionalimentador], AMT.[semestre], AMT.[codigo_cabecera]
		--, AMT.NombreSemestre, AMT.Actividad, AMT.NombreEmpresa, AMT.[localidad], AMT.[tensionnominal]
	FROM
	(
		SELECT	AMT.[subestacion], AMT.[NombreSemestre]
		FROM
		(
			SELECT AMT.[subestacion],AMT.[NombreSemestre] FROM [dbo].[ALIME_MT] as AMT
			where AMT.[NombreSemestre]=@NombreSemestre and AMT.Actividad='D' and AMT.[empresa]=@Empresa
			GROUP BY AMT.[subestacion],AMT.[NombreSemestre]
		) as AMT
		LEFT join [dbo].[SETS] as ST
				on AMT.[subestacion]=ST.[Subestacion] AND AMT.[NombreSemestre]=ST.[NombreSemestre]
		Where AMT.[NombreSemestre]=@NombreSemestre and ST.[Subestacion] is null
	) AS AMTO
	LEFT JOIN [dbo].[ALIME_MT] as AMT
		ON AMTO.[Subestacion]=AMT.[Subestacion] AND AMTO.[NombreSemestre]=AMT.[NombreSemestre]
	where AMT.[NombreSemestre]=@NombreSemestre and AMT.Actividad='D' and AMT.[empresa]=@Empresa

	/*
	--Validación 26	Subestaciones de Transmisión reportados en el archivo ALIME_MT pero no fueron reportadas en el archivo SETS
		SELECT 
			AMT.[Empresa], AMTO.[NombreSemestre] AS Semestre
			, AMT.[seccion] as [Código de Sección o Alimentador], AMT.[tipoalimentador] as [Tipo Alimentador]
			, AMT.[seccionalimentador] as [Seccionador o Alimentador al que Pertenece]
			, AMT.[subestacion] as [SET], 'SET '+AMT.[subestacion]+' no reportado en tabla SET del Anexo 1' as Observación
			--, AMT.[tipoalimentador], AMT.[seccionalimentador], AMT.[semestre], AMT.[codigo_cabecera]
			--, AMT.NombreSemestre, AMT.Actividad, AMT.NombreEmpresa, AMT.[localidad], AMT.[tensionnominal]
		FROM
		(
			SELECT	AMT.[subestacion], AMT.[NombreSemestre]
			FROM
			(
				SELECT AMT.[subestacion],AMT.[NombreSemestre] FROM [dbo].[ALIME_MT] as AMT
				where AMT.[NombreSemestre]='2017S2' and AMT.Actividad='D'
				GROUP BY AMT.[subestacion],AMT.[NombreSemestre]
			) as AMT
			LEFT join [dbo].[SETS] as ST
				 on AMT.[subestacion]=ST.[Subestacion] AND AMT.[NombreSemestre]=ST.[NombreSemestre]
			Where AMT.[NombreSemestre]='2017S2' and ST.[Subestacion] is null
		) AS AMTO
		LEFT JOIN [dbo].[ALIME_MT] as AMT
			ON AMTO.[Subestacion]=AMT.[Subestacion] AND AMTO.[NombreSemestre]=AMT.[NombreSemestre]
		where AMT.[NombreSemestre]='2017S2' and AMT.Actividad='D'

	*/
)

GO
