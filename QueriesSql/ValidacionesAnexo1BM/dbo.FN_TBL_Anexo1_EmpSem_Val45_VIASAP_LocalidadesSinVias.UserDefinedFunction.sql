USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val45_VIASAP_LocalidadesSinVias]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	El archivo VIASAP no reporta vías de sus localidades reportadas.
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val45_VIASAP_LocalidadesSinVias]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [Sector Típico], [Sistema Eléctrico], Localidad, [Nombre Localidad]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val45_VIASAP_LocalidadesSinVias]('ESE','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='CEV'
	--set @NombreSemestre='2018S1' --hay duplicados para EMP y SEA
	select
		ROW_NUMBER() over (partition by L.[empresa] order by Empresa, Semestre, [Sector Típico], [Sistema Eléctrico], Localidad) as Ítem,
		Empresa, Semestre, [Sector Típico], [Sistema Eléctrico], Localidad, [Nombre Localidad]
	from
	(
		Select
			 L.[empresa],L.[NombreSemestre] as Semestre,L.sectortipico as [Sector Típico]
			 , L.sistemaelectrico as [Sistema Eléctrico],L.[localidad], L.nombrelocalidad as [Nombre Localidad], isnull(sum(V.longitud),0) as Longitud
		FROM [dbo].[LOCALI] as L
		LEFT JOIN [dbo].[VIASAP] as V
			on L.[empresa]=V.[empresa] and L.[NombreSemestre]=V.[NombreSemestre] and L.[localidad]=V.[localidad]
		where L.[NombreSemestre]=@NombreSemestre and L.[empresa]=@Empresa
			and  V.empresa is null
		group by L.[empresa],L.[NombreSemestre],L.sectortipico,L.sistemaelectrico,L.[localidad], L.nombrelocalidad
	) as L
)


GO
