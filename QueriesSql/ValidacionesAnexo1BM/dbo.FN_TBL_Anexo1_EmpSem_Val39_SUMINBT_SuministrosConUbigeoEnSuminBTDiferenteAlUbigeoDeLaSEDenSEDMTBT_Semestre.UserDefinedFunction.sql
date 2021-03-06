USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val39_SUMINBT_SuministrosConUbigeoEnSuminBTDiferenteAlUbigeoDeLaSEDenSEDMTBT_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Suministros reportados en la tabla SUMINBT con ubigeo diferente al reportado en la tabla SED_MTBT.
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val39_SUMINBT_SuministrosConUbigeoEnSuminBTDiferenteAlUbigeoDeLaSEDenSEDMTBT_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [Código de Subestación declarado en Tabla SUMINBT], [Cantidad de Suministros en tabla SUMINBT]
	, [Ubigeo declarado en Tabla SUMINBT], [Ubigeo en tabla SEDMTBT]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val39_SUMINBT_SuministrosConUbigeoEnSuminBTDiferenteAlUbigeoDeLaSEDenSEDMTBT_Semestre]('ESE','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6), @CantidadMinimaPorDistrito int
	--set @Empresa='ESE'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by SB.[empresa] order by SB.[empresa], SB.subestacion) as Ítem
		, SB.[Empresa], SB.NombreSemestre as Semestre
		, SB.[Cantidad de Suministros] as [Cantidad de Suministros en tabla SUMINBT]
		, SB.subestacion as [Código de Subestación declarado en Tabla SUMINBT]
		, SB.[ubicacion] AS [Ubigeo declarado en Tabla SUMINBT]
		, SB.[Nombre] as [Nombre de Distrito], SB.[DeptNombre] as [Departamento]
		, SE.[subestacion] [Subestación en tabla SEDMTBT]
		, SE.[nombresubestacion] as [Nombre de la Subestación en tabla SEDMTBT]
		, SE.[direccionset] as [Dirección de la Subestación en tabla SEDMTBT]
		, SE.[ubicacion] as [Ubigeo en tabla SEDMTBT], SE.[Distrito] as [Distrito en tabla SEDMTBT], SE.[Departamento] as [Departamento en tabla SEDMTBT]
	from
	(
		--declare @Empresa char(3), @NombreSemestre char(6), @CantidadMinimaPorDistrito int
		--set @Empresa='ESE'
		--set @NombreSemestre='2018S1'
		SELECT
			SB.NombreSemestre, SB.[empresa], SB.subestacion, SB.[ubicacion], U.[Nombre], U.[TipoDivisionGeografica], U.[DeptUbigeo], U.[DeptNombre]
			, COUNT(*) as [Cantidad de Suministros]
		FROM [dbo].[SUMINBT] as SB
		left join [dbo].[UBIGEO] as U on cast(SB.ubicacion as int)=cast(U.Ubigeo as int)
		where SB.[actividad]='D' and U.Ubigeo is not null and SB.NombreSemestre=@NombreSemestre AND SB.Empresa=@Empresa
		group by SB.NombreSemestre, SB.[empresa], SB.subestacion, SB.[ubicacion], U.[Nombre], U.[TipoDivisionGeografica], U.[DeptUbigeo], U.[DeptNombre]
	) as SB
	left join [dbo].[SED_MTBT] as SE on SB.empresa=SE.empresa and SB.NombreSemestre=SE.NombreSemestre and SB.subestacion=SE.subestacion
	where SE.NombreSemestre=@NombreSemestre AND SB.Empresa=@Empresa and SB.[ubicacion]<>SE.[ubicacion]
)


GO
