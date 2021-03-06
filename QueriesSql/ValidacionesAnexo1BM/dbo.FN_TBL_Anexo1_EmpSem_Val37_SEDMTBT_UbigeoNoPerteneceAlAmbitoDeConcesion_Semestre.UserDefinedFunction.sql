USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val37_SEDMTBT_UbigeoNoPerteneceAlAmbitoDeConcesion_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	El ubigeo de la SEDMTBT no corresponde a la zona geográfica de la empresa.
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val37_SEDMTBT_UbigeoNoPerteneceAlAmbitoDeConcesion_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, [Código de Localidad], [Nombre de Localidad], [Código de Subestación], [Nombre de la Subestación]
	, [Dirección de la Subestación], [Ubigeo de la SEDMTBT], [Nombre del Distrito], [Ubigeo del Departamento], [Nombre del Departamento]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val37_SEDMTBT_UbigeoNoPerteneceAlAmbitoDeConcesion_Semestre]('ELC','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='ELS'
	--set @NombreSemestre='2018S1'
		SELECT
			ROW_NUMBER() over (partition by SE.[empresa] order by SE.[empresa], SE.[localidad], SE.[subestacion]) as Ítem
			, SE.[Empresa], SE.localidad as [Código de Localidad], SE.nombrelocalidad as [Nombre de Localidad]
			, SE.subestacion as [Código de Subestación], SE.nombresubestacion as [Nombre de la Subestación], SE.direccionset as [Dirección de la Subestación]
			, SE.ubicacion as [Ubigeo de la SEDMTBT], SE.Distrito as [Nombre del Distrito]
			, SE.[DeptUbigeo] as [Ubigeo del Departamento], SE.[DeptNombre] as [Nombre del Departamento]
		from
		(
			SELECT SE.[empresa], SE.localidad, SE.nombrelocalidad
				, SE.subestacion, SE.nombresubestacion, SE.direccionset, SE.ubicacion, u.Nombre as [Distrito], U.[DeptUbigeo], U.[DeptNombre]
			FROM [dbo].[SED_MTBT] as SE
			left join [dbo].[UBIGEO] as U on cast(SE.ubicacion as int)=cast(U.Ubigeo as int)
			where u.Ubigeo is not null and se.NombreSemestre=@NombreSemestre and SE.Empresa=@Empresa
			--order by SE.[empresa], U.[DeptUbigeo], SE.ubicacion
		) as SE
		left join SRV_MAESTRO_EMPRESA_UBIGEO as U on SE.empresa=U.empresa and SE.DeptUbigeo=U.DeptUbigeo
		where U.DeptUbigeo is null
		--order by SE.[empresa], SE.[DeptUbigeo], SE.ubicacion
		
)


GO
