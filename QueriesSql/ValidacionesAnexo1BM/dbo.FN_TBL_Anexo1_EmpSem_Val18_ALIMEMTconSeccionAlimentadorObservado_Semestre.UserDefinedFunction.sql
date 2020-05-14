USE [CalidadGenerales]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_TBL_Anexo1_EmpSem_Val18_ALIMEMTconSeccionAlimentadorObservado_Semestre]    Script Date: 06/05/2020 2:03:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	Raúl Enrique Bráñez Tamayo
-- Modificacion: JAVA
-- Fecha de Actualizacion: 05/05/2020
-- Description:	Sección o alimentador MT que no registró correctamente el código del campo 6 de la tabla ALIME_MT.
-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val18_ALIMEMTconSeccionAlimentadorObservado_Semestre]('EDN','2018S1')
-- =============================================
--CREATE -- 
ALTER
FUNCTION [dbo].[FN_TBL_Anexo1_EmpSem_Val18_ALIMEMTconSeccionAlimentadorObservado_Semestre]
(	
	@Empresa char(3), @NombreSemestre char(6)
)
RETURNS TABLE 
AS
RETURN 
(
/*
Select 
	Ítem, Empresa, Semestre, [Código de SET], [Nombre de SET], [Dirección de la SET], Ubigeo
from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val18_ALIMEMTconSeccionAlimentadorObservado_Semestre]('EDN','2018S1')
*/
	--declare @Empresa char(3), @NombreSemestre char(6)
	--set @Empresa='ELC'
	--set @NombreSemestre='2018S2'
'observacion: desarrollo no funciona como function, puede ser procedimiento, se requiere que sea una funcion que retorne una tabla'
	declare @auxiliar table (Id int, seccion nvarchar(255));
declare @observacion table ([empresa] [nvarchar](255) NULL, [localidad] [nvarchar](255) NULL,
	[subestacion] [nvarchar](255) NULL, [seccion] [nvarchar](255) NULL, [tensionnominal] [float] NULL,
	[tipoalimentador] [nvarchar](255) NULL, [seccionalimentador] [nvarchar](255) NULL, [semestre] [float] NULL,
	[codigo_cabecera] [float] NULL, [nombresemestre] [varchar](6) NULL,	[actividad] [varchar](1) NULL,
	[NombreEmpresa] [varchar](30) NULL,	[tipoalimentadorpadre] [varchar](1) NULL, [alimen_sectortipico] [varchar](1) NULL,
	[alimen_sistema] [varchar](4) NULL,	[alimen_nombresistema] [varchar](20) NULL)

declare @i int, @lim int, @alimentador nvarchar(255), @conteoalimentador int;

insert into @auxiliar select distinct row_number() over (order by seccion), seccion from ALIME_MT where tipoalimentador='A'
select*from @auxiliar

set @i=0;
set @lim = (select max(Id) from @auxiliar);

while @i<@lim
begin
	set @alimentador= (select seccion from @auxiliar where id=@i)
	set @conteoalimentador = (select count(*) from ALIME_MT where seccionalimentador=@alimentador)
	if @conteoalimentador=0
		insert into @observacion SELECT * from alime_MT WHERE SECCION=@alimentador
	set @i=@i+1
end	

select*from @observacion


		INSERT INTO @OBSERVACION
		SELECT
			AMT.[empresa],AMT.[localidad],AMT.[subestacion],AMT.[seccion],AMT.[tensionnominal],AMT.[tipoalimentador],AMT.[seccionalimentador]
			,AMT.[semestre],AMT.[codigo_cabecera],AMT.[NombreSemestre],AMT.[Actividad],AMT.[NombreEmpresa],AMT.[TipoAlimentadorPadre]
			,AMT.[Alimen_SectorTipico],AMT.[Alimen_Sistema],AMT.[Alimen_NombreSistema]
		FROM [ALIME_MT] as AMT
		where 
			(
				AMT.[tipoalimentador]='S' and (AMT.[TipoAlimentadorPadre]<>'A' or AMT.[TipoAlimentadorPadre] is null)
				--or (AMT.[tipoalimentador]='A' and AMT.[seccionalimentador] is not null)
				or (AMT.[tipoalimentador]='A' and len(AMT.[seccionalimentador])>0)
			) 
			and AMT.[NombreSemestre]=@NombreSemestre 
			and AMT.[empresa]=@Empresa

   SELECT
		ROW_NUMBER() over (order by ST.[Empresa],ST.[Subestacion]) as Ítem
		, ST.[Empresa], ST.[NombreSemestre] AS Semestre, ST.[Subestacion] as [Código de SET]
		, ST.seccion as [Código de Sección o Alimentador], ST.tipoalimentador as [Tipo de Sección (A o S)]
		, ST.seccionalimentador as [Alimentador al que Pertenece]
		, iif(ST.[tipoalimentador]='S' and (ST.[TipoAlimentadorPadre]<>'A' or ST.[TipoAlimentadorPadre] is null)
			,'Si Tipo Alimentador es S, debe existir el Alimentador al que pertenece'
			,iif (st.[tipoalimentador]='A' and len(st.[seccionalimentador])>0
				,'Si Tipo Alimentador es A, no puede declarar Alimentador al que pertenece'
				,'Alimentador no tiene secciones asociadas')) as [Detalle de Observación]
	FROM
	@observacion AS ST

/*	
declare @IDValidacion int
	set @IDValidacion=1
	use [CalidadReportes]
	select @IDValidacion as IDValidacion
		, * INTO Anexo1_Val_Rep18
	from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val18_ALIMEMTconSeccionAlimentadorObservado_Semestre]('ELC','2018S2')
				--from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val18_ALIMEMTconSeccionAlimentadorObservado_Semestre]('EDN','2018S1')
		-- Select * from [CalidadGenerales].[dbo].[FN_TBL_Anexo1_EmpSem_Val18_ALIMEMTconSeccionAlimentadorObservado_Semestre]('EDN','2018S1')
		-- Select * from [CalidadReportes].dbo.Anexo1_Val_Rep18 --truncate table Anexo1_Val_Rep18 --DROP table [CalidadReportes].dbo.Anexo1_Val_Rep18
	*/
)

GO
