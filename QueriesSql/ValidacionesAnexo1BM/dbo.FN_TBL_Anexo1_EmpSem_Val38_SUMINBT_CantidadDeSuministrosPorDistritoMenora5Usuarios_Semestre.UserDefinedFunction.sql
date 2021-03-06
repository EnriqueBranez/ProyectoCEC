USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val38_SUMINBT_CantidadDeSuministrosPorDistritoMenora5Usuarios_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	La cantidad de suministros reportados por distrito en la tabla SUMINBT es menor a 5.
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val38_SUMINBT_CantidadDeSuministrosPorDistritoMenora5Usuarios_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6), @CantidadMinimaPorDistrito int
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, [Ubigeo en Tabla SUMINBT], [Nombre de Distrito], [Departamento al que pertenece], [Cantidad de Suministros en Tabla SUMINBT]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val38_SUMINBT_CantidadDeSuministrosPorDistritoMenora5Usuarios_Semestre]('ESE','2018S1',5)
*/
	--declare @Empresa char(3), @NombreSemestre char(6), @CantidadMinimaPorDistrito int
	--set @Empresa='ESE'
	--set @NombreSemestre='2018S1'
	--set @CantidadMinimaPorDistrito = 5
	SELECT
		ROW_NUMBER() over (partition by SB.[empresa] order by SB.[empresa], SB.[ubicacion]) as Ítem
		, SB.[Empresa], SB.[ubicacion] as [Ubigeo en Tabla SUMINBT]
		, SB.[Nombre] AS [Nombre de Distrito]
		--, SB.[TipoDivisionGeografica]
		--, SB.[DeptUbigeo] as [Ubigeo]
		, SB.[DeptNombre] as [Departamento al que pertenece]
		, SB.[Cantidad de Suministros] as [Cantidad de Suministros en Tabla SUMINBT]
	from 
	(
		--declare @Empresa char(3), @NombreSemestre char(6), @CantidadMinimaPorDistrito int
		--set @Empresa='ESE'
		--set @NombreSemestre='2018S1'
		--set @CantidadMinimaPorDistrito = 5
		SELECT 
			SB.[empresa], SB.[ubicacion]
			, U.[Nombre], U.[TipoDivisionGeografica], U.[DeptUbigeo], U.[DeptNombre]
			, COUNT(*) as [Cantidad de Suministros]
		FROM [dbo].[SUMINBT] as SB
		left join [dbo].[UBIGEO] as U on cast(SB.ubicacion as int)=cast(U.Ubigeo as int)
		where SB.[actividad]='D' and SB.NombreSemestre=@NombreSemestre AND SB.Empresa=@Empresa --and U.Ubigeo is null 
		group by SB.[empresa], SB.[ubicacion], U.[Nombre], U.[TipoDivisionGeografica], U.[DeptUbigeo], U.[DeptNombre]
	)
	as SB
	where SB.[Cantidad de Suministros]<=@CantidadMinimaPorDistrito
)


GO
