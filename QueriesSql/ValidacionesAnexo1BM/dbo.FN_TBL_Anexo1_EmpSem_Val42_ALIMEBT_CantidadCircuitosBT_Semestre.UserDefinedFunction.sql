USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val42_ALIMEBT_CantidadCircuitosBT_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	SED MT/BT reportadas en la tabla ALIME_BT con más de 10 circuitos de baja tensión.
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val42_ALIMEBT_CantidadCircuitosBT_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6), @CantidadMaxima int
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem , Empresa, Semestre, [Código de Subestación], [Cantidad de Alimentadores BT]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_vAL42_ALIMEBT_CantidadCircuitosBT_Semestre]('EDN','2018S1',10)
*/
	--declare @Empresa char(3), @NombreSemestre char(6), @CantidadMaxima int
	--set @Empresa='ESE'
	--set @NombreSemestre='2018S1'
	--set @CantidadMaxima=10
	select
		ROW_NUMBER() over (partition by ABT.[Empresa] order by ABT.[Empresa], ABT.NombreSemestre, ABT.[subestacion]) as Ítem 
		, ABT.[Empresa], ABT.NombreSemestre as Semestre
		, ABT.[subestacion] as [Código de Subestación]
		, count(*) as [Cantidad de Alimentadores BT]
	FROM [dbo].[ALIME_BT] as ABT
	where ABT.NombreSemestre=@NombreSemestre and ABT.[Actividad]='D' AND ABT.[Empresa]=@Empresa
	group by ABT.[Empresa], ABT.NombreSemestre, ABT.[subestacion]
	having count(*)>@CantidadMaxima
)


GO
