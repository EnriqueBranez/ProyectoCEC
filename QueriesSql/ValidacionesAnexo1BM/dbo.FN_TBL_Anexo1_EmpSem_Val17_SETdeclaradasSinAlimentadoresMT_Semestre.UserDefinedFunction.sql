USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val17_SETdeclaradasSinAlimentadoresMT_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Subestaciones de Transmisión reportadas en la tabla SETS pero no fueron reportados en la tabla ALIME_MT.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val17_SETdeclaradasSinAlimentadoresMT_Semestre]('EDN','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val17_SETdeclaradasSinAlimentadoresMT_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [Código de SET], [Nombre de SET], [Dirección de la SET], Ubigeo
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val17_SETdeclaradasSinAlimentadoresMT_Semestre]('EDN','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='EDN'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by ST.[Empresa] order by ST.[Empresa],ST.[Subestacion]) as Ítem
		, ST.[Empresa], ST.[NombreSemestre] AS Semestre, ST.[Subestacion] as [Código de SET], ST.[nomset] as [Nombre de SET]
		, ST.[dirset] as [Dirección de la SET], ST.[Ubicacion] as Ubigeo
	FROM
	(
		SELECT ST.[Subestacion], ST.[NombreSemestre], AMT.[subestacion] as [subestacion de AlimenMT]
		FROM [dbo].[SETS] as ST
		left join
		(
			SELECT distinct AMT.[subestacion] FROM [dbo].[ALIME_MT] as AMT
			where AMT.[NombreSemestre]=@NombreSemestre and AMT.[empresa]=@Empresa
		) as AMT on ST.[Subestacion]=AMT.[subestacion]
		where ST.[NombreSemestre]=@NombreSemestre and ST.[empresa]=@Empresa
			and ST.Actividad='D' and AMT.[subestacion] is null
	) AS STO
	LEFT JOIN [dbo].[SETS] as ST ON STO.[Subestacion]=ST.[Subestacion] AND STO.[NombreSemestre]=ST.[NombreSemestre]
)

GO
