USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val28_SEDMTBTsinSuministrosEnSuminBT_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Subestaciones de distribución reportadas en la tabla SED MT/BT sin suministros asociados en la tabla SUMINBT.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val28_SEDMTBTsinSuministrosEnSuminBT_Semestre]('CEV','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val28_SEDMTBTsinSuministrosEnSuminBT_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [Sector Típico], Subestación, [Nombre de la Subestación], [Tensión BT], [Tensión MT], [Cantidad de Suministros]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val28_SEDMTBTsinSuministrosEnSuminBT_Semestre]('CEV','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='EOR'
	--set @NombreSemestre='2018S1'
	SELECT
		ROW_NUMBER() over (partition by SE.Empresa order by SE.Empresa,SE.[NombreSemestre], SE.[sectortipico],SE.[subestacion]) as Ítem
		, SE.[Empresa], SE.[NombreSemestre] as Semestre, SE.[sectortipico] as [Sector Típico]
		, SE.[subestacion] as Subestación, SE.[nombresubestacion] as [Nombre de la Subestación]
		--, SE.[localidad], SE.[direccionset], SE.[sucursal], SE.[ubicacion]
		, SE.[tensiobt] as  [Tensión BT], SE.[tensionmt] as [Tensión MT]
		--, SE.[captransformacion], SE.[utmnorte], SE.[utmeste], SE.[seccionlinea]
		--, SE.[semestre], SE.[SEDMTBT_codigo_cabecera]
		--, SE.[nombrelocalidad], SE.[Localidad_MaximaDemanda]
		--, SE.[sistemaelectrico], SE.[nomsistema], SE.[tiposistema], SE.[sectortipico], SE.[Sistemas_MaximaDemandaMW], SE.[actividad]
		--, SB.[empresa], SB.[NombreSemestre], SB.[subestacion]
		, iif(SB.[Cantidad de Suministros] is Null,'Sin Suministros BT',ltrim(rtrim(cast(SB.[Cantidad de Suministros] as Varchar(20))))+' Suministros') as [Cantidad de Suministros]
	FROM [dbo].[SED_MTBT] as SE
	left join (
			--declare @Empresa char(3), @NombreSemestre char(6)
			--set @Empresa='EOR'
			--set @NombreSemestre='2018S1'
			SELECT SB.[empresa], SB.[NombreSemestre], SB.[subestacion], count(*) as [Cantidad de Suministros]
			FROM [dbo].[SUMINBT] as SB
			where SB.[NombreSemestre]=@NombreSemestre and SB.[empresa]=@Empresa
			group by SB.[empresa], SB.[NombreSemestre], SB.[subestacion]
		) as SB
		on SB.[empresa]=SE.[empresa] and SB.[NombreSemestre]=SE.[NombreSemestre] and SB.[subestacion]=SE.[subestacion]
	where SE.[NombreSemestre]=@NombreSemestre and SE.[empresa]=@Empresa
		and SE.[actividad]='D' and SB.[subestacion] is null
)

GO
