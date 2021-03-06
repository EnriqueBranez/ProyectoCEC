USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val16_LocaliSinSuministrosAsociadosMTBT_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Localidades reportadas en la tabla LOCALI sin suministros asociados en los archivos SUMINBT y SUMINMT.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val16_LocaliSinSuministrosAsociadosMTBT_Semestre]('ESE','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val16_LocaliSinSuministrosAsociadosMTBT_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [Código de Localidad], [Código de Localidad de tablas de Suministros], Observación
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val16_LocaliSinSuministrosAsociadosMTBT_Semestre]('ESE','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='ESE'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by L.Empresa order by L.Empresa,L.[localidad]) as Ítem
		, isnull(S.[Empresa],L.[Empresa]) as Empresa, isnull(S.[Semestre],L.Semestre) as Semestre, isnull(S.[localidad],L.[localidad]) as [Código de Localidad]
		, isnull(S.[localidad],'S/C') as [Código de Localidad de tablas de Suministros]
		,iif(isnull(S.[Cantidad de Suministros],0)=0,'Localidad sin Suministros','Localidad con '+ltrim(cast(S.[Cantidad de Suministros] as varchar(10)))+' suministros') as Observación
	from
	(
		SELECT
			L.[Empresa], L.NombreSemestre as Semestre, L.Actividad, L.[localidad]
		FROM [dbo].[LOCALI] as L
		where L.[actividad]='D' and L.[NombreSemestre]=@NombreSemestre and L.[empresa]=@Empresa
	) as L
	full join 
	(
		select
			S.[Empresa], S.[actividad], S.[Semestre], S.[localidad], sum([Cantidad de Suministros]) as [Cantidad de Suministros]
		from
		(	--Cantidad de Suministro BT  oir localidad
			--declare @Empresa char(3), @NombreSemestre char(6)
			--set @Empresa='ESE'
			--set @NombreSemestre='2018S1'
			SELECT
				SB.[Empresa], SB.[actividad], SB.[NombreSemestre] as Semestre, SB.[localidad], Count(SB.[suministro]) as [Cantidad de Suministros]
			FROM [dbo].[SUMINBT] as SB
			where SB.[actividad]='D' and SB.[NombreSemestre]=@NombreSemestre and SB.[empresa]=@Empresa
			group by SB.[empresa], SB.[actividad], SB.[NombreSemestre], SB.[localidad]
			--order by SB.[empresa], SB.[actividad], SB.[NombreSemestre], SB.[localidad]
			union
			--Cantidad de Suministro MT  oir localidad
			SELECT
				SM.[Empresa], SM.[actividad], SM.[NombreSemestre] as Semestre, SM.[localidad], Count(SM.[suministro]) as [Cantidad de Suministros]
			FROM [dbo].[SUMINMT] as SM
			where SM.[actividad]='D' and SM.[NombreSemestre]=@NombreSemestre and SM.[empresa]=@Empresa
			group by SM.[empresa], SM.[actividad], SM.[NombreSemestre], SM.[localidad]
			--order by SM.[empresa], SM.[actividad], SM.[NombreSemestre], SM.[localidad]
			--order by SB.[empresa], SB.[actividad], SB.[NombreSemestre], SB.[localidad]
		) as S 
		group by S.[Empresa], S.[actividad], S.[Semestre], S.[localidad]
	) as S 
	on L.[Empresa]=S.[Empresa] and L.Semestre=S.[Semestre] and L.[localidad]=S.[localidad]
	where l.empresa is null or S.empresa is null
)

GO
