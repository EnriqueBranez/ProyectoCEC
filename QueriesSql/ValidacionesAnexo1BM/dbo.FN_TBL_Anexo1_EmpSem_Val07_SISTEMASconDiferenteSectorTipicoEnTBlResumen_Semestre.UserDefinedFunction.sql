USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val07_SISTEMASconDiferenteSectorTipicoEnTBlResumen_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Sistemas eléctricos reportadas en la tabla SISTEMAS con diferente sector típico a lo reportado en la TABLA RESUMEN.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val07_SISTEMASconDiferenteSectorTipicoEnTBlResumen_Semestre]('HID','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val07_SISTEMASconDiferenteSectorTipicoEnTBlResumen_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [Código Sistema Eléctrico], [Nombre Sistema Eléctrico]
	, [Sector Típico tabla SISTEMAS], [Sector Típico tabla RESUMEN]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val07_SISTEMASconDiferenteSectorTipicoEnTBlResumen_Semestre]('HID','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='ESE'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by S.[Empresa] order by S.[Empresa]) as Ítem
		, S.[Empresa], S.[NombreSemestre] as Semestre
		, S.[sistema] as [Código Sistema Eléctrico]
		, S.[nomsistema] as [Nombre Sistema Eléctrico]
		, S.[sectortipico] as [Sector Típico tabla SISTEMAS]
		, R.[sector] as [Sector Típico tabla RESUMEN]
	FROM [dbo].[SISTEMAS] as S
	left join 
	(
		--declare @Empresa char(3), @NombreSemestre char(6)
		--set @Empresa='HID'
		--set @NombreSemestre='2018S1'
		SELECT
			distinct
			R.[empresa],R.[NombreSemestre],R.[sistema],R.[sector]
		FROM [dbo].[TABLARESUMEN] as R where R.NombreSemestre=@NombreSemestre AND R.[empresa]=@Empresa
		group by R.[empresa],R.[NombreSemestre],R.[sistema],R.[sector]
	) as R on S.[empresa]=R.[empresa] and S.[NombreSemestre]=R.[NombreSemestre] and S.[sistema]=R.[sistema]
	where S.[Actividad]='D' and S.NombreSemestre=@NombreSemestre AND S.[empresa]=@Empresa
		and (S.[sectortipico]<>R.[sector] or R.[sector] is null)
)

GO
