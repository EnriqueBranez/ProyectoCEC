USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val06_CantidadSistemasTblResumen_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Cantidad de sistemas eléctricos reportados en la tabla SISTEMAS diferente a lo reportado en la TABLA RESUMEN.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val06_CantidadSistemasTblResumen_Semestre]('HID','2018S1')
-- =============================================
CREATE -- 
--ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val06_CantidadSistemasTblResumen_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select
	Ítem, Empresa, Semestre, [Cantidad de Sistemas Eléctricos Tabla Sistemas], [Cantidad de Sistemas Eléctricos en Tabla Resumen]
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val06_CantidadSistemasTblResumen_Semestre]('HID','2018S1')
*/
	--declare @NombreSemestre char(6)
	--set @NombreSemestre='2018S1'
	Select 
		ROW_NUMBER() over (partition by S.Empresa order by S.Empresa) as Ítem
		, S.Empresa, S.NombreSemestre as Semestre, S.[Cantidad de Sistemas Eléctricos Tabla Sistemas]
		, R.[Cantidad de Sistemas Eléctricos en Tabla Resumen]
	from
	(	
		--declare @NombreSemestre char(6)
		--set @NombreSemestre='2018S1'
		SELECT
			S.[empresa], S.NombreSemestre, count(distinct(S.[sistema])) as [Cantidad de Sistemas Eléctricos Tabla Sistemas]
		FROM [dbo].[SISTEMAS] as S where S.NombreSemestre=@NombreSemestre and Actividad='D' AND S.[empresa]=@Empresa
		group by S.NombreSemestre, S.[empresa]
	) as S
	left join 
	--Tabbla [TABLARESUMEN]
	(	
		--declare @NombreSemestre char(6)
		--set @NombreSemestre='2018S1'
		SELECT
			R.[empresa],count(distinct(R.[sistema])) as [Cantidad de Sistemas Eléctricos en Tabla Resumen]
		FROM [dbo].[TABLARESUMEN] as R where R.NombreSemestre=@NombreSemestre and Actividad='D' AND R.[empresa]=@Empresa
		group by R.[empresa]
	) as R on S.empresa=R.empresa
	--order by R.[empresa]
	where S.[Cantidad de Sistemas Eléctricos Tabla Sistemas]<>R.[Cantidad de Sistemas Eléctricos en Tabla Resumen] OR R.[Cantidad de Sistemas Eléctricos en Tabla Resumen] IS NULL
)

GO
