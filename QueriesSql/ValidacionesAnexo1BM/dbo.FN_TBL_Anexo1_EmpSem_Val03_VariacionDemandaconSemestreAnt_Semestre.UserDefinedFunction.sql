USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val03_VariacionDemandaconSemestreAnt_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Enrique Bráñez
-- Fecha de Actualizacion: 05/05/2020
-- Description:	select * from [dbo].[FN_TBL_Anexo1_EmpSem_Val03_VariacionDemandaconSemestreAnt_Semestre]('HID','2018S1',15.0)
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val03_VariacionDemandaconSemestreAnt_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6), @PorcentajeVariacion float  -- monto en porcentaje, osea p.e. 15%
)
RETURNS TABLE 
AS
RETURN 
(
/*	select
		Ítem, [Código de Empresa], [Sector típico Semestre Actual], [Código de Sistema Eléctrico], [Nombre de Sistema Eléctrico]
		, [Demanda Semestre Actual en MW], [Demanda Semestre Anterior en MW], [Porcentaje de Variación]
	from CalidadGenerales.[dbo].[FN_TBL_Anexo1_EmpSem_Val03_VariacionDemandaconSemestreAnt_Semestre]('HID','2018S1',15.0)
	Select * from dbo.FN_TBL_Anexo1_Val03_VariacionDemandaconSemestreAnt_Semestre('2018S1',15)
*/
	select
		ROW_NUMBER() over (partition by S.[empresa] order by S.[empresa],S.[sectortipico],S.[sistema]) as Ítem
		,S.[empresa] as [Código de Empresa]
		,S.[sectortipico] as [Sector típico Semestre Actual]
		,S.[sistema] as [Código de Sistema Eléctrico]
		,S.[nomsistema] as [Nombre de Sistema Eléctrico]
		,S.[demandamw] as [Demanda Semestre Actual en MW]
		,A.[demandamw] as [Demanda Semestre Anterior en MW]
		,(100.0*abs(s.demandamw - a.demandamw)/a.demandamw) AS [Porcentaje de Variación]
		/*,S.[tiposistema]
		,S.[semestre],S.[codigo_cabecera],S.[Norma],S.[NombreSemestre],S.[Actividad],S.[NombreEmpresa]
		,A.[empresa] as EmpresaSemAnt
		,A.[sistema] as SistemaSemAnt
		,A.[nomsistema] as NomsistemaSemAnt
		,A.[tiposistema] as TiposistemaSemAnt
		,A.[sectortipico] as SectorTipicoSemAnt*/
	from
	(
		SELECT
			S.[empresa],S.[sistema],S.[nomsistema],S.[tiposistema],S.[sectortipico],S.[demandamw]
			,S.[semestre],S.[codigo_cabecera],S.[Norma],S.[NombreSemestre],S.[Actividad],S.[NombreEmpresa]
		FROM [dbo].[SISTEMAS] as S where s.NombreSemestre=@NombreSemestre and S.[empresa]=@Empresa
	) as S
	left join 
		(
		SELECT
			S.[empresa],S.[sistema],S.[nomsistema],S.[tiposistema],S.[sectortipico],S.[demandamw]
			,S.[semestre],S.[codigo_cabecera],S.[Norma],S.[NombreSemestre],S.[Actividad],S.[NombreEmpresa]
		FROM [dbo].[SISTEMAS] as S where s.NombreSemestre=dbo.GetSemestreAnterior(@NombreSemestre) and S.[empresa]=@Empresa
		) as A 
		on S.empresa=A.empresa and S.sistema=A.sistema
	where S.Actividad='D' and ( A.demandamw is null or ( (100.0*abs(s.demandamw - a.demandamw)/a.demandamw) > @PorcentajeVariacion ) )

)

GO
