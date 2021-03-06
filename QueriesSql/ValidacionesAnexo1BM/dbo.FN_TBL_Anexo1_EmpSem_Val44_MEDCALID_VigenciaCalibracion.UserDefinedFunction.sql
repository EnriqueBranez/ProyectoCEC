USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val44_MEDCALID_VigenciaCalibracion]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Medidores de Calidad con fecha de calibración no vigentes.
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val44_MEDCALID_VigenciaCalibracion]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem , Empresa, Semestre, [Marca y Modelo], [Nro de Serie], [Año de Fabricación], [Tipo de Medición]
	, [Fecha de Calibración], [Fecha de Adquisición], Observación, ValidaCalibracion
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val44_MEDCALID_VigenciaCalibracion]('EMP','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='CEV'
	--set @NombreSemestre='2018S1' --hay duplicados para EMP y SEA
	select
		ROW_NUMBER() over (partition by M.[Empresa] order by M.[empresa], M.[NombreSemestre], M.[marcamodelo]) as Ítem 
		, [Empresa], NombreSemestre  as Semestre, [marcamodelo] AS [Marca y Modelo], [nroserie] as [Nro de Serie], [aniofabricacion] as [Año de Fabricación]
		, [tipomedicion] as [Tipo de Medición]
		, [fechacalibracion] as [Fecha de Calibración], [fechaadquisicion] as [Fecha de Adquisición]
		, iif(DATEADD(YEAR,3,[fechaadquisicion])<SYSDATETIME(),iif(DATEADD(YEAR,2,[fechacalibracion])<SYSDATETIME(),'Calibración fuera de fecha',''),'') as Observación
		, iif(DATEADD(YEAR,3,[fechaadquisicion])<SYSDATETIME(),iif(DATEADD(YEAR,2,[fechacalibracion])<SYSDATETIME(),1,0),0) as ValidaCalibracion
	FROM [CalidadGenerales].[dbo].[MEDCALID] as M
	WHERE M.NombreSemestre=@NombreSemestre AND M.[Empresa]=@Empresa
		AND iif(DATEADD(YEAR,3,[fechaadquisicion])<SYSDATETIME(),iif(DATEADD(YEAR,2,[fechacalibracion])<SYSDATETIME(),1,0),0)=1
)


GO
