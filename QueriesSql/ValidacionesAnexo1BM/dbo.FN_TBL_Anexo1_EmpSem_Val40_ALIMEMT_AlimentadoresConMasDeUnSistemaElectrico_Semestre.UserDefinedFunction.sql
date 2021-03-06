USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val40_ALIMEMT_AlimentadoresConMasDeUnSistemaElectrico_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Alimentadores reportados en las tablas ALIME_MT y/o SED_MTBT  con más de un Sistema Eléctrico.
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val40_ALIMEMT_AlimentadoresConMasDeUnSistemaElectrico_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem , Empresa, Semestre, [Ítem de Casos Alimen.], [Código Alimentador], [Ítem Sist. Eléctr.]
	, [Sector Típico], [Sistema Eléctrico], [Nombre de Sistema Eléctrico], [Cantidad de SEDs por Sistema Eléctrico en el Alimentador]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val40_ALIMEMT_AlimentadoresConMasDeUnSistemaElectrico_Semestre]('ESE','2018S1')
order by
*/
	--declare @Empresa char(3), @NombreSemestre char(6), @CantidadMinimaPorDistrito int
	--set @Empresa='ESE'
	--set @NombreSemestre='2018S1'
	select
		ROW_NUMBER() over (partition by SE.[empresa]
			order by SE.[empresa], SE.[NombreSemestre], SE.ÍtemSEAlim, B.[sectortipico], B.[sistemaelectrico]) as Ítem 
		, SE.[Empresa], SE.[NombreSemestre] as Semestre, SE.ÍtemSEAlim as [Ítem de Casos Alimen.], SE.[Código Alimentador]
		--, B.[empresa], B.[NombreSemestre]
		, B.Ítem AS [Ítem Sist. Eléctr.]
		, B.[sectortipico] as [Sector Típico]
		, B.[sistemaelectrico] as [Sistema Eléctrico]
		, B.[nomsistema] as [Nombre de Sistema Eléctrico]
		--, B.[Código Alimentador], B.[Tipoalimentador]
		, B.[Cantidad de SEDs por Sistema Eléctrico en el Alimentador]
	from
	(
		select 
			ROW_NUMBER() over (partition by SE.[empresa]
					order by SE.[empresa], SE.[Código Alimentador]) as ÍtemSEAlim
			, SE.[empresa], SE.[NombreSemestre], SE.[Código Alimentador]
			, count(*) as Cantidad, sum([Cantidad de SEDs por Sistema Eléctrico en el Alimentador]) as [Cantidad de SEDs en el Alimentador]
		from
		(
			SELECT
				ROW_NUMBER() over (partition by SE.[empresa], SE.[Código Alimentador]
					order by SE.[empresa], SE.[sectortipico], SE.[sistemaelectrico], SE.[Código Alimentador]) as ÍtemSEAlim
				, SE.[empresa], SE.[NombreSemestre]
				--, SE.[localidad], SE.[subestacion]
				, SE.[sectortipico], SE.[sistemaelectrico], SE.[nomsistema]
				--, SE.[tiposistema]
				--, SE.[TensionNominalAlimentador], SE.[SET]
				, SE.[Código Alimentador]
				, SE.[Tipoalimentador]
				, count(*) as [Cantidad de SEDs por Sistema Eléctrico en el Alimentador]
			FROM 
			(
				SELECT
					SE.[empresa], SE.[NombreSemestre], SE.[localidad], SE.[subestacion]
					, SE.[sistemaelectrico], SE.[nomsistema], SE.[tiposistema], SE.[sectortipico]
					--, SE.[seccionlinea], SE.[tipoalimentador], SE.[seccionalimentador], SE.[TipoAlimentadorPadre]
					, SE.[TensionNominalAlimentador], SE.[SET]
					, IIF(SE.[tipoalimentador]<>'A',SE.[seccionalimentador],SE.[seccionlinea]) AS [Código Alimentador]
					, IIF(SE.[tipoalimentador]<>'A',SE.[TipoAlimentadorPadre],SE.[tipoalimentador]) AS [Tipoalimentador]
				FROM [dbo].[SED_MTBT] as SE
				where  SE.[NombreSemestre]=@NombreSemestre and SE.[actividad]='D'  AND SE.Empresa=@Empresa
				--and IIF(SE.[tipoalimentador]<>'A',SE.[TipoAlimentadorPadre],SE.[tipoalimentador])<>'A' --para consistencia de data
			) as SE
			group by SE.[empresa], SE.[NombreSemestre], SE.[sectortipico], SE.[sistemaelectrico], SE.[nomsistema], SE.[Código Alimentador], SE.[Tipoalimentador]
			--order by SE.[empresa], SE.[NombreSemestre], SE.[sectortipico], SE.[sistemaelectrico], SE.[nomsistema], SE.[Código Alimentador], SE.[Tipoalimentador]
		) as SE
		group by SE.[empresa], SE.[NombreSemestre], SE.[Código Alimentador]
		having count(*)>1
		--order by count(*)
	) as SE
	left join 
	(
		SELECT
			ROW_NUMBER() over (partition by SE.[empresa], SE.[Código Alimentador]
				order by SE.[empresa], SE.[sectortipico], SE.[sistemaelectrico], SE.[Código Alimentador]) as Ítem
			, SE.[empresa], SE.[NombreSemestre]
			--, SE.[localidad], SE.[subestacion]
			, SE.[sectortipico], SE.[sistemaelectrico], SE.[nomsistema]
			--, SE.[tiposistema]
			--, SE.[TensionNominalAlimentador], SE.[SET]
			, SE.[Código Alimentador]
			, SE.[Tipoalimentador]
			, count(*) as [Cantidad de SEDs por Sistema Eléctrico en el Alimentador]
		FROM 
		(
			SELECT
				SE.[empresa], SE.[NombreSemestre], SE.[localidad], SE.[subestacion]
				, SE.[sistemaelectrico], SE.[nomsistema], SE.[tiposistema], SE.[sectortipico]
				--, SE.[seccionlinea], SE.[tipoalimentador], SE.[seccionalimentador], SE.[TipoAlimentadorPadre]
				, SE.[TensionNominalAlimentador], SE.[SET]
				, IIF(SE.[tipoalimentador]<>'A',SE.[seccionalimentador],SE.[seccionlinea]) AS [Código Alimentador]
				, IIF(SE.[tipoalimentador]<>'A',SE.[TipoAlimentadorPadre],SE.[tipoalimentador]) AS [Tipoalimentador]
			FROM [dbo].[SED_MTBT] as SE
			where  SE.[NombreSemestre]=@NombreSemestre and SE.[actividad]='D' AND SE.Empresa=@Empresa
			--and IIF(SE.[tipoalimentador]<>'A',SE.[TipoAlimentadorPadre],SE.[tipoalimentador])<>'A' --para consistencia de data
		) as SE
		group by SE.[empresa], SE.[NombreSemestre], SE.[sectortipico], SE.[sistemaelectrico], SE.[nomsistema], SE.[Código Alimentador], SE.[Tipoalimentador]
		--order by SE.[empresa], SE.[NombreSemestre], SE.[sectortipico], SE.[sistemaelectrico], SE.[nomsistema], SE.[Código Alimentador], SE.[Tipoalimentador]
	) as B
	on SE.empresa=B.empresa and SE.NombreSemestre=B.NombreSemestre and SE.[Código Alimentador]=B.[Código Alimentador]
	--order by SE.[empresa], SE.[NombreSemestre], SE.ÍtemSEAlim

)


GO
