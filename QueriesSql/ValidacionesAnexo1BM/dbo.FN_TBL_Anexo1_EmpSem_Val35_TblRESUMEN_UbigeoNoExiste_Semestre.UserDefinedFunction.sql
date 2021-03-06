USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val35_TblRESUMEN_UbigeoNoExiste_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	El nombre de la región registrada en la TABLA RESUMEN no corresponde a la zona geográfica de la empresa.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val35_TblRESUMEN_UbigeoNoExiste_Semestre]('ELS','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val35_TblRESUMEN_UbigeoNoExiste_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Localidad, [Sector Típico], Sistema, Region
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val35_TblRESUMEN_UbigeoNoExiste_Semestre]('ELS','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='ELS'
	--set @NombreSemestre='2018S1'
		SELECT
			ROW_NUMBER() over (partition by R.[empresa] order by R.[empresa],R.[sector],R.[sistema],R.[localidad]) as Ítem
			,R.[empresa],R.[localidad],R.[sistema],R.[sector] as [Sector Típico],R.[demanda],R.[potencia]
			,R.[region],U.Nombre, U.Ubigeo
		FROM [dbo].[TABLARESUMEN] as R
		left join 
		(
			select[Ubigeo],[Nombre],[TipoDivisionGeografica],[DeptUbigeo],[DeptNombre],[PerteneceAUbigeo],[PerteneceNombre],[PerteneceTipoDivisionGeografica]
			from [dbo].[UBIGEO] as U
			where U.TipoDivisionGeografica='DEPARTAMENTO'
		)
		as U on [dbo].[RemoverTildes](R.region)=[dbo].[RemoverTildes](U.Nombre) 
		where R.NombreSemestre=@NombreSemestre and R.Empresa=@Empresa
			and R.[actividad]='D' AND U.Ubigeo is Null
		--order by SB.[empresa], SB.[NombreSemestre], SB.[sectortipico], SB.[sistemaelectrico], SB.[subestacion]
)


GO
