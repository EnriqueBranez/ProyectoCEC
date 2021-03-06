USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val02_SistemasVariaronEntreSemestreAnt_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Enrique Bráñez
-- Fecha de Actualizacion: 05/05/2020
-- Description:	select * from [dbo].[FN_TBL_Anexo1_EmpSem_Val02_SistemasVariaronEntreSemestreAnt_Semestre]('ESE','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val02_SistemasVariaronEntreSemestreAnt_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='ESE'
	--set @NombreSemestre='2018S1'
	select
		ROW_NUMBER() over (order by S.[empresa],S.[sectortipico],S.[sistema]) as Ítem
		,S.[Empresa] as [Código de Empresa]
		,S.[NombreSemestre] as [Semestre Actual]
		,S.[sistema] as [Código de Sistema Eléctrico]
		,S.[nomsistema] as [Nombre de Sistema Eléctrico]
		,S.[sectortipico] as [Sector Típico Semestre Actual]
		,S.[tiposistema] as [Tipo Sistema Electrico Semestre Actual]
		,S.[demandamw],S.[semestre] as CodigoSemestre,S.[codigo_cabecera],S.[Norma],S.[Actividad],S.[NombreEmpresa]
		,A.[NombreSemestre] as [Semestre Anterior]
		,A.[sectortipico] as [Sector Típico Semestre Anterior]
		,A.[tiposistema] as [Tipo Sistema Electrico Semestre Anterior]
		,A.[sistema] as SistemaSemAnt,A.[nomsistema] as NomsistemaSemAnt,A.[demandamw] as DemandamwSemAnt
	from
	(
		--declare @Empresa char(3), @NombreSemestre char(6)
		--set @Empresa='ESE'
		--set @NombreSemestre='2018S1'
		SELECT
			S.[empresa],S.[sistema],S.[nomsistema],S.[tiposistema],S.[sectortipico],S.[demandamw]
			,S.[semestre],S.[codigo_cabecera],S.[Norma],S.[NombreSemestre],S.[Actividad],S.[NombreEmpresa]
		FROM [dbo].[SISTEMAS] as S where s.NombreSemestre=@NombreSemestre AND S.[empresa]=@Empresa
	) as S
	left join 
		(
		--declare @Empresa char(3), @NombreSemestre char(6)
		--set @Empresa='ESE'
		--set @NombreSemestre='2018S1'
		SELECT
			S.[empresa],S.[sistema],S.[nomsistema],S.[tiposistema],S.[sectortipico],S.[demandamw]
			,S.[semestre],S.[codigo_cabecera],S.[Norma],S.[NombreSemestre],S.[Actividad],S.[NombreEmpresa]
		FROM [dbo].[SISTEMAS] as S where s.NombreSemestre=dbo.GetSemestreAnterior(@NombreSemestre) AND S.[empresa]=@Empresa
		) as A 
		on S.empresa=A.empresa and S.sistema=A.sistema
	where S.Actividad='D' and ( A.empresa is null or S.sectortipico <> A.sectortipico or S.tiposistema <> A.tiposistema)
)

GO
