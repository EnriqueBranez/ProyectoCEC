USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val25_SET_LocalidadNoExisteenLOCALI_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Código del campo 2 de la tabla SET (Localidad) no reportado en tabla LOCALI.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val25_SET_LocalidadNoExisteenLOCALI_Semestre]('ELC','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val25_SET_LocalidadNoExisteenLOCALI_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [Subestación], [Nombre de SET], [Dirección de la SET], Ubigeo, Localidad
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val25_SET_LocalidadNoExisteenLOCALI_Semestre]('ELC','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='ELC'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by ST.[Empresa] order by ST.[Empresa],ST.[Localidad]) as Ítem
		, ST.[Empresa], ST.[NombreSemestre] as Semestre, ST.[Subestacion] as [Subestación]
		, ST.[nomset] as[Nombre de SET], ST.[dirset] as [Dirección de la SET], ST.[Ubicacion] as Ubigeo, ST.[Localidad]
	FROM [dbo].[SETS] as ST
	left join [dbo].[LOCALI] as L on ST.[Empresa]=L.[empresa] and ST.[NombreSemestre]=L.[NombreSemestre] and ST.[Localidad]=L.[localidad]
	where L.[localidad] is Null and ST.[Actividad]='D' and ST.[NombreSemestre]=@NombreSemestre and ST.[empresa]=@Empresa
)

GO
