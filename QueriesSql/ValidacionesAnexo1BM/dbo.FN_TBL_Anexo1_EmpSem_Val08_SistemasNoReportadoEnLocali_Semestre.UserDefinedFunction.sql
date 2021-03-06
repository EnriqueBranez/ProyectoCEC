USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val08_SistemasNoReportadoEnLocali_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Sistemas eléctricos reportados en el archivo SISTEMAS no encontrados en la tabla LOCALI.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val08_SistemasNoReportadoEnLocali_Semestre]('HID','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val08_SistemasNoReportadoEnLocali_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [Sector Típico], Sistema, [Nombre De Sistema Eléctrico], [Código Sistema Tabla Locali]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val08_SistemasNoReportadoEnLocali_Semestre]('HID','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='HID'
	--set @NombreSemestre='2018S1'
	Select 
		ROW_NUMBER() over (partition by S.Empresa order by S.Empresa,S.NombreSemestre, S.sectortipico, S.[Sistema]) as Ítem
		, S.[Empresa], S.NombreSemestre as Semestre, S.sectortipico as [Sector Típico], S.[Sistema], s.nomsistema as [Nombre De Sistema Eléctrico]
		, L.sistemaelectrico AS [Código Sistema Tabla Locali]
	FROM [dbo].[SISTEMAS] as S 
	left join 
	(
		--declare @Empresa char(3), @NombreSemestre char(6)
		--set @Empresa='HID'
		--set @NombreSemestre='2018S1'
		SELECT
			distinct L.[empresa], L.[sistemaelectrico]
		FROM [dbo].[LOCALI] as L where L.NombreSemestre=@NombreSemestre AND L.[empresa]=@Empresa
	) as L on S.empresa=L.empresa and S.sistema=L.sistemaelectrico
	where S.NombreSemestre=@NombreSemestre  AND S.[empresa]=@Empresa
		and S.Actividad='D' and L.sistemaelectrico is null
)

GO
