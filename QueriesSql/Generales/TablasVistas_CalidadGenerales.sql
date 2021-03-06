--Queries para crear las estructuras de tablas
USE [CalidadGenerales]
GO
/****** Object:  Table [dbo].[SRV_MEDBRAND_MM]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_MEDBRAND_MM](
	[MM_MARCA] [varchar](3) NOT NULL,
	[MM_NOMBRE] [varchar](200) NOT NULL,
 CONSTRAINT [pk_medidormarc] PRIMARY KEY CLUSTERED 
(
	[MM_MARCA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Marcamedidor]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Marcamedidor] AS SELECT
MM_MARCA AS marca
, MM_NOMBRE AS nombremarca
FROM SRV_MEDBRAND_MM

GO
/****** Object:  Table [dbo].[SRV_RELEVAD]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_RELEVAD](
	[EMPRESA] [varchar](3) NULL,
	[PUNTORED] [varchar](10) NULL,
	[SUBESTACION] [varchar](7) NULL,
	[LINEAALIM] [varchar](7) NULL,
	[SETDIRECCION] [varchar](30) NULL,
	[SEMESTRE] [int] NULL,
	[ID_CABECERA] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[RELEVAD]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE VIEW [dbo].[RELEVAD] AS SELECT
		EMPRESA AS empresa
		, PUNTORED AS puntored
		, SUBESTACION AS subestacion
		, LINEAALIM AS lineaalim
		, SETDIRECCION AS setdireccion
		, SEMESTRE AS semestre
		, ID_CABECERA AS codigo_cabecera
	FROM SRV_RELEVAD

GO
/****** Object:  Table [dbo].[SRV_SUC_CEAT]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_SUC_CEAT](
	[EMPRESA] [varchar](3) NOT NULL,
	[LOCALIDAD] [varchar](4) NOT NULL,
	[CODIGOOFICINA] [varchar](4) NOT NULL,
	[SUCURSAL] [varchar](20) NOT NULL,
	[SEMESTRE] [int] NOT NULL,
	[ID_CABECERA] [int] NULL,
	[NroRegEnArchivoOrigen] [int] NULL,
 CONSTRAINT [pk_succeat] PRIMARY KEY CLUSTERED 
(
	[CODIGOOFICINA] ASC,
	[EMPRESA] ASC,
	[SEMESTRE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[SUC_CEAT]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SUC_CEAT] AS SELECT
EMPRESA AS empresa
, LOCALIDAD AS localidad
, CODIGOOFICINA AS codigooficina
, SUCURSAL AS sucursal
, SEMESTRE AS semestre
, ID_CABECERA AS codigo_cabecera
FROM SRV_SUC_CEAT

GO
/****** Object:  Table [dbo].[SRV_EMPR_EMP]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_EMPR_EMP](
	[EMP_CODE] [varchar](3) NOT NULL,
	[EMP_NOMBRE] [varchar](60) NOT NULL,
	[EMP_ACTIVIDAD] [varchar](2) NULL,
	[EMP_VIGENTE] [varchar](1) NULL,
	[Norma] [char](1) NULL,
	[CodEmpGRT] [char](4) NULL,
	[NombreOriginal] [varchar](200) NULL,
	[CantidadSuministros] [int] NULL,
	[CodigoSemestreReferencia] [int] NULL,
	[SuminBTTot] [int] NULL,
	[SuminMTTot] [int] NULL,
 CONSTRAINT [PK_EMPRESA] PRIMARY KEY CLUSTERED 
(
	[EMP_CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Empresa]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[Empresa] AS SELECT
		EMP_CODE AS codigo
		, EMP_NOMBRE AS nombre
		, EMP_ACTIVIDAD AS actividad
		, EMP_CODE AS Empresa
		, EMP_NOMBRE AS NombreEmpresa
		, EMP_VIGENTE AS Vigente
		, Norma
		, CodEmpGRT
		, NombreOriginal
		, [CantidadSuministros]
		, SuminBTTot
		, SuminMTTot
		FROM SRV_EMPR_EMP

GO
/****** Object:  Table [dbo].[SRV_SEMESTRE_SEM]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_SEMESTRE_SEM](
	[CODIGO] [int] NOT NULL,
	[NOMBRE] [varchar](6) NOT NULL,
	[DESDE] [datetime] NOT NULL,
	[HASTA] [datetime] NOT NULL,
	[FactorAplicacionNTCSER] [float] NULL,
 CONSTRAINT [PK_SEMESTRE] PRIMARY KEY CLUSTERED 
(
	[CODIGO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Semestre]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[Semestre] AS SELECT
	CODIGO AS CodigoSemestre
	, NOMBRE AS NombreSemestre
	, DESDE AS FechaDesde
	, HASTA AS FechaHasta
	, cast(HASTA-desde as int) As CantidadDias 
	, cast(HASTA-desde as int)*24 As CantidadHoras
	, FactorAplicacionNTCSER
FROM [CalidadGenerales].[dbo].SRV_SEMESTRE_SEM


GO
/****** Object:  Table [dbo].[SRV_MAESTRO_SISTEMAS]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_MAESTRO_SISTEMAS](
	[NOMBRE_SISTEMA] [varchar](20) NULL,
	[CODIGO_GART] [varchar](10) NULL,
	[EMPRESA] [varchar](3) NOT NULL,
	[VIGENCIA_HASTA] [datetime] NOT NULL,
	[CODIGO_NORMA] [varchar](10) NOT NULL,
	[SECTOR_TIPICO] [varchar](1) NULL,
	[CODIGO_GFEIT] [varchar](10) NULL,
	[VIGENCIA_DESDE] [datetime] NOT NULL,
	[DispositivoLegal] [nvarchar](100) NULL,
	[DL_Detalle] [nvarchar](100) NULL,
	[Norma] [varchar](1) NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [SRV_MSISTEMA_PK] PRIMARY KEY CLUSTERED 
(
	[EMPRESA] ASC,
	[CODIGO_NORMA] ASC,
	[VIGENCIA_DESDE] ASC,
	[VIGENCIA_HASTA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[MaestroSistemas]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MaestroSistemas]
AS SELECT
	M.EMPRESA AS empresa
	, M.SECTOR_TIPICO AS sector
	, M.CODIGO_NORMA AS codigontcse
	, M.CODIGO_GFEIT AS codigogfeit
	, M.CODIGO_GART AS codigogart
	, M.NOMBRE_SISTEMA AS nombresistema
	, M.VIGENCIA_DESDE AS vigenciadesde
	, M.VIGENCIA_HASTA AS vigenciahasta
	, M.[DispositivoLegal] AS [Dispositivo Legal]
	, M.[DL_Detalle] AS [Detalle en DL]
	, M.Norma
	, S.NombreSemestre, S.CodigoSemestre, S.[FechaDesde], S.[FechaHasta]
	, S.[CantidadDias], S.[CantidadHoras], S.[FactorAplicacionNTCSER]
	, E.actividad
	-- select * 
FROM [CalidadGenerales].[dbo].SRV_MAESTRO_SISTEMAS AS M
cross join [CalidadGenerales].[dbo].[Semestre] as S
left join CalidadGenerales.dbo.Empresa as E on M.EMPRESA=E.Empresa
where M.VIGENCIA_DESDE<=S.[FechaDesde] and S.[FechaDesde]<=M.VIGENCIA_HASTA
GO
/****** Object:  Table [dbo].[SRV_SISTEMAS]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_SISTEMAS](
	[EMPRESA] [varchar](3) NOT NULL,
	[SISTEMA] [varchar](4) NOT NULL,
	[NOMSISTEMA] [varchar](20) NOT NULL,
	[TIPOSISTEMA] [varchar](4) NOT NULL,
	[SECTORTIPICO] [varchar](1) NOT NULL,
	[DEMANDAMW] [decimal](7, 2) NULL,
	[SEMESTRE] [int] NOT NULL,
	[ID_CABECERA] [int] NULL,
	[NroRegEnArchivoOrigen] [int] NULL,
 CONSTRAINT [pk_sistema] PRIMARY KEY CLUSTERED 
(
	[SISTEMA] ASC,
	[EMPRESA] ASC,
	[SEMESTRE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[SISTEMAS]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[SISTEMAS]
AS
SELECT
SE.EMPRESA AS empresa
, SE.SISTEMA AS sistema
, SE.NOMSISTEMA AS nomsistema
, SE.TIPOSISTEMA AS tiposistema
, SE.SECTORTIPICO AS sectortipico
, SE.DEMANDAMW AS demandamw
, SE.SEMESTRE AS semestre
, SE.ID_CABECERA AS codigo_cabecera
--, iif(SE.SECTORTIPICO in ('1','2','3'),'U','R') AS Norma
, M.Norma as Norma
, S.NombreSemestre
, E.Actividad
, E.nombre AS NombreEmpresa
, E.CodEmpGRT
, M.codigogart, M.codigogfeit
, case SE.SECTORTIPICO
	when 'R' then 7
	when 'E' then 8
	else SE.SECTORTIPICO
	end
	as SDT_eqvVNR
FROM dbo.SRV_SISTEMAS as SE
	left join [dbo].[Semestre] as S on SE.SEMESTRE=S.CodigoSemestre
	left join [dbo].[Empresa]as E on SE.EMPRESA=E.codigo
	left join [dbo].[MaestroSistemas] as M on SE.EMPRESA=M.empresa and SE.SISTEMA=M.codigontcse and SE.SEMESTRE=M.CodigoSemestre
--where se.semestre=453 --and iif(SE.SECTORTIPICO in ('1','2','3'),'U','R')<>M.Norma
--order by SE.EMPRESA, SE.SECTORTIPICO, SE.SISTEMA
/*where Se.SEMESTRE=449
order by E.Actividad,se.EMPRESA, se.SISTEMA
SELECT
	[empresa],[sector],[codigontcse],[codigogfeit],[codigogart],[nombresistema],[vigenciadesde],[vigenciahasta],[NombreSemestre],[CodigoSemestre]
	,[FechaDesde],[FechaHasta],[CantidadDias],[CantidadHoras],[FactorAplicacionNTCSER]
FROM [dbo].[MaestroSistemas]
GO
*/

GO
/****** Object:  Table [dbo].[SRV_RESUMEN_SUMIN]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_RESUMEN_SUMIN](
	[LOCALIDAD] [varchar](4) NULL,
	[SISTEMA] [varchar](4) NULL,
	[SECTOR] [varchar](1) NULL,
	[MAXIMA_DEMANDA] [decimal](16, 6) NULL,
	[POTENCIA_INSTALADA] [decimal](16, 6) NULL,
	[SUMINISTROS_BT_MONOFASICOS] [int] NULL,
	[SUMINISTROS_BT_TRIFASICO] [int] NULL,
	[SUMINISTROS_MT] [int] NULL,
	[SUMINISTROS_AT] [int] NULL,
	[SEDS_MT_BT] [int] NULL,
	[PUNTO_ENTREGA] [varchar](600) NULL,
	[TENSION_PUNTO_ENTREGA] [decimal](16, 6) NULL,
	[REGION] [varchar](2000) NULL,
	[CANTIDAD_PUNTOS_CASO_1] [int] NULL,
	[CANTIDAD_PUNTOS_CASO_2] [int] NULL,
	[CANTIDAD_PUNTOS_CASO_3] [int] NULL,
	[CANTIDAD_PUNTOS_CASO_4] [int] NULL,
	[EMPRESA] [varchar](3) NULL,
	[SEMESTRE] [int] NULL,
	[USUARIO_CREACION] [varchar](38) NULL,
	[FECHA_CREACION] [datetime] NULL,
	[TERMINAL_CREACION] [varchar](38) NULL,
	[USUARIO_ACTUALIZACION] [varchar](38) NULL,
	[FECHA_ACTUALIZACION] [datetime] NULL,
	[TERMINAL_ACTUALIZACION] [varchar](38) NULL,
	[ID_CABECERA] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[TABLARESUMEN]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[TABLARESUMEN] AS SELECT
	A.LOCALIDAD AS localidad
	, A.SISTEMA AS sistema
	, A.SECTOR AS sector
	, A.MAXIMA_DEMANDA AS demanda
	, A.POTENCIA_INSTALADA AS potencia
	, A.SUMINISTROS_BT_MONOFASICOS AS suminbtmon
	, A.SUMINISTROS_BT_TRIFASICO AS suminbttri
	, A.SUMINISTROS_MT AS suministrosmt
	, A.SUMINISTROS_AT AS suministrosat
	, A.SEDS_MT_BT AS nroseds
	, A.PUNTO_ENTREGA AS puntoentrega
	, A.TENSION_PUNTO_ENTREGA AS tensionpto
	, A.REGION AS region
	, A.CANTIDAD_PUNTOS_CASO_1 AS puntoscaso1
	, A.CANTIDAD_PUNTOS_CASO_2 AS puntoscaso2
	, A.CANTIDAD_PUNTOS_CASO_3 AS puntoscaso3
	, A.CANTIDAD_PUNTOS_CASO_4 AS puntoscaso4
	, A.EMPRESA AS empresa
	, A.SEMESTRE AS semestre
	, A.USUARIO_CREACION AS audit_usercreacion
	, A.FECHA_CREACION AS audit_creado
	, A.TERMINAL_CREACION AS audit_terminalcrea
	, A.USUARIO_ACTUALIZACION AS audit_usuariomodif
	, A.FECHA_ACTUALIZACION AS audit_modificado
	, A.TERMINAL_ACTUALIZACION AS audit_terminalmodif
	, A.ID_CABECERA AS codigo_cabecera
	, E.actividad
	, C.NombreSemestre
	, S.Norma, S.sectortipico, S.tiposistema, s.nomsistema
	, A.SUMINISTROS_BT_MONOFASICOS+A.SUMINISTROS_BT_TRIFASICO as suminbttot
	, A.SUMINISTROS_MT+A.SUMINISTROS_AT as suminmttot
	, A.SUMINISTROS_BT_MONOFASICOS+A.SUMINISTROS_BT_TRIFASICO + A.SUMINISTROS_MT+A.SUMINISTROS_AT as CantSuminTotal
FROM SRV_RESUMEN_SUMIN as A
LEFT JOIN dbo.Empresa as E
	ON A.EMPRESA = E.codigo
left join [dbo].[Semestre] as C
	on A.SEMESTRE=C.CodigoSemestre
left join [dbo].SISTEMAS as S
	on A.SEMESTRE=S.semestre and A.EMPRESA=S.empresa and A.SISTEMA=S.sistema

GO
/****** Object:  Table [dbo].[SRV_LOCALI]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_LOCALI](
	[EMPRESA] [varchar](3) NOT NULL,
	[SISTEMAELECTRICO] [varchar](4) NOT NULL,
	[LOCALIDAD] [varchar](4) NOT NULL,
	[NOMBRELOCALIDAD] [varchar](20) NOT NULL,
	[MAXIMADEMANDA] [int] NULL,
	[SEMESTRE] [int] NOT NULL,
	[ID_CABECERA] [int] NULL,
	[SISAU] [varchar](1) NULL,
	[NroRegEnArchivoOrigen] [int] NULL,
 CONSTRAINT [pk_localidad] PRIMARY KEY CLUSTERED 
(
	[LOCALIDAD] ASC,
	[EMPRESA] ASC,
	[SEMESTRE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[LOCALI]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[LOCALI] AS SELECT
	A.EMPRESA AS empresa
	, A.SISTEMAELECTRICO AS sistemaelectrico
	, A.LOCALIDAD AS localidad
	, A.NOMBRELOCALIDAD AS nombrelocalidad
	, A.MAXIMADEMANDA AS maximademanda
	, A.SEMESTRE AS semestre
	, A.ID_CABECERA AS codigo_cabecera
	, A.SISAU AS sisaurbano
	, dbo.Empresa.actividad
	, dbo.Semestre.NombreSemestre
	, S.nomsistema
	, S.sectortipico
	, S.Norma
FROM SRV_LOCALI as A
LEFT JOIN dbo.Empresa
	ON A.EMPRESA = dbo.Empresa.codigo
left join dbo.Semestre
	on A.SEMESTRE=[dbo].[Semestre].CodigoSemestre
left join dbo.SISTEMAS as S
	on A.EMPRESA=S.empresa and A.SISTEMAELECTRICO=S.sistema and A.SEMESTRE=S.semestre

GO
/****** Object:  Table [dbo].[SRV_UBIGEO]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_UBIGEO](
	[Ubigeo] [nvarchar](6) NULL,
	[Nombre] [nvarchar](100) NULL,
	[TipoDivisionGeografica] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[UBIGEO]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*left join dbo.SRV_UBIGEO As B on A.Ubigeo= (left(B.Ubigeo,2)+"0000")*/
CREATE VIEW [dbo].[UBIGEO]
AS
SELECT
	A.Ubigeo, A.Nombre, A.TipoDivisionGeografica, B.Ubigeo AS DeptUbigeo, B.Nombre AS DeptNombre, C.Ubigeo AS PerteneceAUbigeo, C.Nombre AS PerteneceNombre
	, C.TipoDivisionGeografica AS PerteneceTipoDivisionGeografica
FROM dbo.SRV_UBIGEO AS A
	LEFT OUTER JOIN dbo.SRV_UBIGEO AS B ON LEFT(A.Ubigeo, 2) + '0000' = B.Ubigeo
	LEFT OUTER JOIN dbo.SRV_UBIGEO AS C ON LEFT(A.Ubigeo, 4) + '00' = C.Ubigeo

GO
/****** Object:  Table [dbo].[SRV_SUMINAT_MAT]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_SUMINAT_MAT](
	[EMPRESA] [varchar](3) NOT NULL,
	[LOCALIDAD] [varchar](4) NOT NULL,
	[IDENTIFICACION] [varchar](35) NOT NULL,
	[DIRECCION] [varchar](30) NOT NULL,
	[UBICACION] [varchar](6) NOT NULL,
	[TELEFONO] [varchar](9) NOT NULL,
	[SUMINISTRO] [varchar](10) NOT NULL,
	[MODELOMED] [varchar](17) NOT NULL,
	[MARCA] [varchar](3) NOT NULL,
	[SERIE] [varchar](10) NOT NULL,
	[ANIO] [varchar](4) NOT NULL,
	[POTENCIA] [decimal](12, 2) NOT NULL,
	[TENSION] [decimal](5, 2) NOT NULL,
	[SETCODE] [varchar](7) NOT NULL,
	[CODIGOLINEALIMMT] [varchar](2000) NOT NULL,
	[TIPOSUMIN] [varchar](200) NOT NULL,
	[SEMESTRE] [int] NOT NULL,
	[ID_CABECERA] [int] NULL,
	[NroRegEnArchivoOrigen] [int] NULL,
 CONSTRAINT [pk_suminatmat] PRIMARY KEY CLUSTERED 
(
	[SUMINISTRO] ASC,
	[EMPRESA] ASC,
	[SEMESTRE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[SUMINAT_MAT]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[SUMINAT_MAT] AS SELECT
	MAT.EMPRESA AS empresa
	, MAT.LOCALIDAD AS localidad
	, cast(null as varchar(4)) as oficina
	, MAT.IDENTIFICACION AS identificacion
	, MAT.DIRECCION AS direccion
	, MAT.UBICACION AS ubicacion
	, MAT.TELEFONO AS telefono
	, MAT.SUMINISTRO AS suministro
	, cast(null as varchar(5)) as opcion		--	[opcion] [varchar](5),
	, MAT.MARCA AS marca
	, MAT.MODELOMED AS modelo
	, MAT.SERIE AS serie
	, MAT.ANIO AS anio
	, MAT.POTENCIA AS potencia
	, MAT.TENSION AS tension
	, MAT.SETCODE AS setcode
	, MAT.CODIGOLINEALIMMT AS codigolinealimmt
	, MAT.TIPOSUMIN AS tiposuministro
	, MAT.SEMESTRE AS semestre
	, MAT.ID_CABECERA AS codigo_cabecera
	, L.nombrelocalidad, L.maximademanda AS Localidad_MaximaDemanda, L.sistemaelectrico
	, S.nomsistema, S.tiposistema, S.sectortipico, S.demandamw AS Sistemas_MaximaDemandaMW, S.Norma
	, E.actividad
	, C.NombreSemestre
	, U.DeptNombre
	--, SED.tipoalimentador, SED.seccionalimentador, SED.TipoAlimentadorPadre, SED.TensionNominalAlimentador
	, 'AT' AS TipoClienteTension
	--, [dbo].[ALIME_MT].tipoalimentador, [dbo].[ALIME_MT].seccionalimentador, [dbo].[ALIME_MT].TipoAlimentadorPadre, [dbo].[ALIME_MT].tensionnominal as TensionNominalAlimentador
FROM SRV_SUMINAT_MAT AS MAT
LEFT OUTER JOIN dbo.LOCALI AS L
	ON MAT.SEMESTRE = L.semestre AND MAT.EMPRESA = L.empresa AND MAT.LOCALIDAD = L.localidad
LEFT OUTER JOIN dbo.SISTEMAS AS S
	ON L.empresa = S.empresa AND L.sistemaelectrico = S.sistema AND L.semestre = S.semestre
LEFT OUTER JOIN dbo.Empresa AS E
	ON MAT.EMPRESA = E.codigo
left join [dbo].[Semestre] AS C
	on MAT.SEMESTRE=C.CodigoSemestre
left join [dbo].[UBIGEO] AS U
	on MAT.UBICACION= U.Ubigeo
--left join [dbo].SED_MTBT AS SED
--	on MAT.EMPRESA=SED.empresa and MAT.SEMESTRE=SED.semestre and MAT.SUBESTACION=SED.subestacion
--left join dbo.ControlCargaArchivos
--	on MAT.ID_CABECERA=dbo.ControlCargaArchivos.CodigoArchivoOrigen
--where dbo.ControlCargaArchivos.UltimoValido='S'


GO
/****** Object:  Table [dbo].[SRV_VIASAP]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_VIASAP](
	[EMPRESA] [varchar](3) NOT NULL,
	[LOCALIDAD] [varchar](4) NOT NULL,
	[CODIGOVIA] [varchar](7) NOT NULL,
	[NUMCARRILES] [int] NULL,
	[DENOMVIA] [varchar](2) NULL,
	[NOMVIA] [varchar](35) NULL,
	[LOCALIDADINICIAVIA] [varchar](20) NULL,
	[UBICACIOGEO] [varchar](6) NULL,
	[LONGITUD] [decimal](5, 3) NULL,
	[CANTPUNTOSLUMINOSOS] [int] NULL,
	[CLASEDEZONA] [varchar](3) NULL,
	[CODIGOTIPOVIA] [varchar](2) NULL,
	[CODIGOTIPOALUMB] [varchar](3) NULL,
	[SEMESTRE] [int] NOT NULL,
	[ID_CABECERA] [int] NULL,
	[NroRegEnArchivoOrigen] [int] NULL,
 CONSTRAINT [pk_viasap] PRIMARY KEY CLUSTERED 
(
	[CODIGOVIA] ASC,
	[EMPRESA] ASC,
	[SEMESTRE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VIASAP]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[VIASAP]
AS
SELECT
V.EMPRESA AS empresa
, V.LOCALIDAD AS localidad
, V.CODIGOVIA AS codigovia
, V.NUMCARRILES AS numcarriles
, V.DENOMVIA AS denomvia
, V.NOMVIA AS nomvia
, V.LOCALIDADINICIAVIA AS localidadiniciavia
, V.UBICACIOGEO AS ubicaciogeo
, V.LONGITUD AS longitud
, V.CANTPUNTOSLUMINOSOS AS cantpuntosluminosos
, V.CLASEDEZONA AS clasedezona
, V.CODIGOTIPOVIA AS codigotipovia
, V.CODIGOTIPOALUMB AS codigotipoalumb
, V.SEMESTRE AS semestre
, V.ID_CABECERA AS codigo_cabecera
, S.NombreSemestre
, E.actividad
, L.nombrelocalidad
, I.sistema, I.nomsistema, I.sectortipico, I.Norma
FROM SRV_VIASAP as V
left join [dbo].[Semestre] as S
	on V.SEMESTRE=S.CodigoSemestre
left join [dbo].Empresa as E
	on V.EMPRESA=E.codigo
left join [dbo].[LOCALI] as L
	on V.SEMESTRE=L.semestre and v.EMPRESA=L.empresa and v.LOCALIDAD=L.localidad
left join [dbo].[SISTEMAS] as I
	on L.semestre=I.semestre and L.empresa=I.empresa and L.sistemaelectrico=I.sistema

GO
/****** Object:  Table [dbo].[SRV_MAESTROS_SETS]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_MAESTROS_SETS](
	[SEMESTRE] [int] NOT NULL,
	[EMPRESA] [varchar](3) NOT NULL,
	[TENSION_NOMINAL] [varchar](2000) NULL,
	[CODIGO_NORMA] [varchar](12) NOT NULL,
	[NOMBRE] [varchar](35) NULL,
 CONSTRAINT [SRV_MSET_PK] PRIMARY KEY CLUSTERED 
(
	[EMPRESA] ASC,
	[CODIGO_NORMA] ASC,
	[SEMESTRE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[MaestroSETS]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MaestroSETS] AS SELECT
SEMESTRE AS semestre
, EMPRESA AS empresa
, TENSION_NOMINAL AS tensionnomina
, CODIGO_NORMA AS codigontcse
, NOMBRE AS nombreset
FROM SRV_MAESTROS_SETS

GO
/****** Object:  Table [dbo].[SRV_ALIME_MT]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_ALIME_MT](
	[EMPRESA] [varchar](3) NOT NULL,
	[LOCALIDAD] [varchar](4) NOT NULL,
	[SUBESTACION] [varchar](7) NOT NULL,
	[SECCION] [varchar](7) NOT NULL,
	[TENSIONNOMINAL] [decimal](5, 2) NULL,
	[TIPOALIMENTADOR] [varchar](1) NULL,
	[SECCIONALIMENTADOR] [varchar](7) NULL,
	[SEMESTRE] [int] NOT NULL,
	[ID_CABECERA] [int] NULL,
	[NroRegEnArchivoOrigen] [int] NULL,
 CONSTRAINT [pk_alimemt] PRIMARY KEY CLUSTERED 
(
	[SECCION] ASC,
	[EMPRESA] ASC,
	[SEMESTRE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ALIME_MT]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[ALIME_MT] AS SELECT
	AMT.EMPRESA AS empresa
	, AMT.LOCALIDAD AS localidad
	, AMT.SUBESTACION AS subestacion
	, AMT.SECCION AS seccion
	, AMT.TENSIONNOMINAL AS tensionnominal
	, AMT.TIPOALIMENTADOR AS tipoalimentador
	, AMT.SECCIONALIMENTADOR AS seccionalimentador
	, AMT.SEMESTRE AS semestre
	, AMT.ID_CABECERA AS codigo_cabecera
	, SE.NombreSemestre
	, E.Actividad
	, E.nombre AS NombreEmpresa
	, E.CodEmpGRT
	, AMTP.TIPOALIMENTADOR as TipoAlimentadorPadre
	, S.sectortipico AS Alimen_SectorTipico
	, S.sistema AS Alimen_Sistema
	, S.nomsistema AS Alimen_NombreSistema
	, M.nombreset
	, M.tensionnomina
FROM dbo.SRV_ALIME_MT as AMT
	left join dbo.Semestre AS SE on AMT.SEMESTRE=SE.CodigoSemestre
	left join dbo.Empresa AS E on AMT.EMPRESA=E.codigo
	left join dbo.SRV_ALIME_MT as AMTP on AMT.EMPRESA=AMTP.EMPRESA and AMT.SEMESTRE=AMTP.SEMESTRE and AMT.seccionalimentador=AMTP.seccion
	LEFT OUTER JOIN dbo.LOCALI AS L ON AMT.SEMESTRE = L.semestre AND AMT.EMPRESA = L.empresa AND AMT.LOCALIDAD = L.localidad
	LEFT OUTER JOIN dbo.SISTEMAS AS S ON L.empresa = S.empresa AND L.sistemaelectrico = S.sistema AND L.semestre = S.semestre
	LEFT OUTER JOIN dbo.MaestroSETS AS M ON AMT.SEMESTRE=M.SEMESTRE and AMT.SUBESTACION=M.codigontcse

GO
/****** Object:  Table [dbo].[SRV_SETS]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_SETS](
	[EMPRESA] [varchar](3) NOT NULL,
	[LOCALIDAD] [varchar](4) NOT NULL,
	[SUBESTACION] [varchar](7) NOT NULL,
	[NOMSET] [varchar](35) NULL,
	[DIRSET] [varchar](30) NULL,
	[UBICACIÓN] [varchar](6) NOT NULL,
	[TELEFONO] [varchar](9) NULL,
	[CAPTRANSFORMACION] [decimal](6, 2) NULL,
	[UTMNORTE] [decimal](11, 3) NULL,
	[UTMESTE] [decimal](11, 3) NULL,
	[TENSIONNOMINALN] [varchar](2000) NULL,
	[SEMESTRE] [int] NOT NULL,
	[ID_CABECERA] [int] NULL,
	[NroRegEnArchivoOrigen] [int] NULL,
 CONSTRAINT [pk_set] PRIMARY KEY CLUSTERED 
(
	[SUBESTACION] ASC,
	[SEMESTRE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[SETS]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SETS] AS SELECT
ST.EMPRESA AS Empresa
, ST.LOCALIDAD AS Localidad
, ST.SUBESTACION AS Subestacion
, ST.NOMSET AS nomset
, ST.DIRSET AS dirset
, ST.UBICACIÓN AS Ubicacion
, ST.TELEFONO AS telefono
, ST.CAPTRANSFORMACION AS captransformacion
, ST.UTMNORTE AS utmnorte
, ST.UTMESTE AS utmeste
, ST.TENSIONNOMINALN AS tensionnominal1
, ST.SEMESTRE AS semestre
, ST.ID_CABECERA AS codigo_cabecera
, ST.[NroRegEnArchivoOrigen]
, S.NombreSemestre
, [dbo].[Empresa].Actividad
, [dbo].[Empresa].nombre AS NombreEmpresa
FROM SRV_SETS as ST
	left join [dbo].[Semestre] as S on ST.SEMESTRE=S.CodigoSemestre
	left join [dbo].[Empresa] on ST.EMPRESA=[dbo].[Empresa].codigo

GO
/****** Object:  Table [dbo].[SRV_SED_MTBT]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_SED_MTBT](
	[EMPRESA] [varchar](3) NOT NULL,
	[LOCALIDAD] [varchar](4) NOT NULL,
	[SUCURSAL] [varchar](4) NOT NULL,
	[SUBESTACION] [varchar](7) NOT NULL,
	[NOMBRESUBESTACION] [varchar](35) NULL,
	[DIRECCIONSET] [varchar](30) NULL,
	[UBICACION] [varchar](6) NOT NULL,
	[TENSIOBT] [decimal](5, 2) NOT NULL,
	[TENSIONMT] [decimal](5, 2) NOT NULL,
	[CAPTRANSFORMACION] [decimal](6, 2) NULL,
	[UTMNORTE] [decimal](11, 3) NULL,
	[UTMESTE] [decimal](11, 3) NULL,
	[SECCIONLINEA] [varchar](7) NOT NULL,
	[SEMESTRE] [int] NOT NULL,
	[ID_CABECERA] [int] NULL,
	[NroRegEnArchivoOrigen] [int] NULL,
 CONSTRAINT [pk_sedmtbt] PRIMARY KEY CLUSTERED 
(
	[SUBESTACION] ASC,
	[EMPRESA] ASC,
	[SEMESTRE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[SED_MTBT]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[SED_MTBT] AS SELECT
	SED.EMPRESA AS empresa, SED.LOCALIDAD AS localidad, SED.SUCURSAL AS sucursal, SED.SUBESTACION AS subestacion
	, SED.NOMBRESUBESTACION AS nombresubestacion, SED.DIRECCIONSET AS direccionset
	, SED.UBICACION AS ubicacion, SED.TENSIOBT AS tensiobt, SED.TENSIONMT AS tensionmt
	, SED.CAPTRANSFORMACION AS captransformacion, SED.UTMNORTE AS utmnorte, SED.UTMESTE AS utmeste
	, SED.SECCIONLINEA AS seccionlinea, SED.SEMESTRE AS semestre, SED.ID_CABECERA AS SEDMTBT_codigo_cabecera
	, S.NombreSemestre
	, L.nombrelocalidad, L.maximademanda AS Localidad_MaximaDemanda, L.sistemaelectrico
	, SI.nomsistema, SI.tiposistema, SI.sectortipico, SI.demandamw AS Sistemas_MaximaDemandaMW, SI.Norma
	, E.actividad, E.CodEmpGRT
	, A.tipoalimentador, A.seccionalimentador, A.TipoAlimentadorPadre
	, A.tensionnominal as TensionNominalAlimentador, A.subestacion as [SET]
	, U.Nombre as [Distrito], U.DeptNombre as [Departamento]
FROM dbo.SRV_SED_MTBT as SED
LEFT OUTER JOIN dbo.Semestre as S ON SED.SEMESTRE = S.CodigoSemestre
LEFT OUTER JOIN dbo.LOCALI as L ON SED.SEMESTRE = L.semestre AND SED.EMPRESA = L.empresa AND SED.LOCALIDAD = L.localidad
LEFT OUTER JOIN dbo.SISTEMAS as SI ON L.empresa = SI.empresa AND L.sistemaelectrico = SI.sistema AND L.semestre = SI.semestre
LEFT OUTER JOIN dbo.Empresa as E ON SED.EMPRESA = E.codigo
LEFT OUTER JOIN [dbo].[ALIME_MT] as A on SED.EMPRESA=A.empresa and SED.SEMESTRE=A.semestre and SED.seccionlinea=A.seccion
LEFT OUTER JOIN [dbo].[UBIGEO] as U ON SED.UBICACION = U.Ubigeo
GO
/****** Object:  Table [dbo].[SRV_SUMINMT]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_SUMINMT](
	[EMPRESA] [varchar](3) NOT NULL,
	[LOCALIDAD] [varchar](4) NOT NULL,
	[IDENTIFICACION] [varchar](35) NOT NULL,
	[DIRECCION] [varchar](30) NOT NULL,
	[UBICACION] [varchar](6) NOT NULL,
	[TELEFONO] [varchar](9) NOT NULL,
	[SUMINISTRO] [varchar](10) NOT NULL,
	[OPCION] [varchar](5) NOT NULL,
	[MARCA] [varchar](3) NOT NULL,
	[MODELOMED] [varchar](17) NOT NULL,
	[SERIE] [varchar](10) NOT NULL,
	[ANIO] [varchar](4) NOT NULL,
	[POTENCIA] [decimal](12, 2) NOT NULL,
	[TENSION] [decimal](5, 2) NOT NULL,
	[SETCODE] [varchar](7) NOT NULL,
	[ALIMENTADOR] [varchar](7) NOT NULL,
	[PUNTOCONEXION] [varchar](16) NOT NULL,
	[CODSUBESTACION] [varchar](16) NOT NULL,
	[CODSUMINISTRO] [varchar](16) NOT NULL,
	[ETIQUETA] [varchar](16) NULL,
	[TIPOSUMINISTRO] [varchar](1) NULL,
	[MEDIDOR] [varchar](1) NULL,
	[NOMINAL] [varchar](6) NULL,
	[MAXIMA] [varchar](6) NULL,
	[CLASES] [varchar](4) NULL,
	[FECHAAFER] [datetime] NULL,
	[CONTRASTACION] [datetime] NULL,
	[SEMESTRE] [int] NOT NULL,
	[ID_CABECERA] [int] NULL,
	[NroRegEnArchivoOrigen] [int] NULL,
 CONSTRAINT [pk_suminmt] PRIMARY KEY CLUSTERED 
(
	[SUMINISTRO] ASC,
	[EMPRESA] ASC,
	[SEMESTRE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[SUMINMT]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[SUMINMT]
AS
SELECT
	SM.EMPRESA, SM.LOCALIDAD
	, cast(null as varchar(4)) as oficina
	, SM.IDENTIFICACION, SM.DIRECCION, SM.UBICACION, SM.TELEFONO
	, SM.SUMINISTRO, SM.OPCION, SM.MARCA, SM.MODELOMED AS modelo, SM.SERIE, SM.ANIO
	, SM.POTENCIA
	, SM.TENSION as tensionnominal
	, SM.SETCODE as subestacion
	, SM.ALIMENTADOR
	, cast(null as varchar(2)) as tipo
	, cast(null as varchar(3)) as fases
	, cast(null as varchar(10)) as nrosuministro
	, cast(null as varchar(1)) as letranumero
	, SM.PUNTOCONEXION, SM.CODSUBESTACION
	, SM.CODSUMINISTRO, SM.ETIQUETA, SM.TIPOSUMINISTRO, SM.MEDIDOR, SM.NOMINAL, SM.MAXIMA
	, SM.CLASES, SM.FECHAAFER AS fecha, SM.CONTRASTACION, SM.SEMESTRE, SM.ID_CABECERA AS SuminBT_codigo_cabecera, SM.NroRegEnArchivoOrigen
	, L.nombrelocalidad, L.maximademanda AS Localidad_MaximaDemanda, L.sistemaelectrico
	, S.nomsistema, S.tiposistema, S.sectortipico, S.demandamw AS Sistemas_MaximaDemandaMW, S.Norma
	, E.actividad
	, SE.NombreSemestre, SE.FechaDesde, SE.FechaHasta
	, U.DeptNombre, U.Nombre as DistritoNombre
	, SM.ALIMENTADOR as seccionlinea, A.tipoalimentador, A.seccionalimentador, A.TipoAlimentadorPadre, A.tensionnominal as TensionNominalAlimentador
	, left(SM.OPCION,2) AS TipoClienteTension
	, P.UBICACIÓN as UbigeoSED
	, P.UTMESTE as UTMSedEste
	, P.UTMNORTE as UTMSedNorte
	/*, cast(null as varchar(6)) as UbigeoSED
	, cast(null as [decimal](11, 3)) as UTMSedEste
	, cast(null as [decimal](11, 3)) as UTMSedNorte*/
FROM dbo.SRV_SUMINMT AS SM
LEFT OUTER JOIN dbo.LOCALI AS L
	ON SM.SEMESTRE = L.semestre AND SM.EMPRESA = L.empresa AND SM.LOCALIDAD = L.localidad
LEFT OUTER JOIN dbo.SISTEMAS AS S
	ON L.empresa = S.empresa AND L.sistemaelectrico = S.sistema AND L.semestre = S.semestre
LEFT OUTER JOIN dbo.Empresa AS E
	ON SM.EMPRESA = E.codigo
LEFT OUTER JOIN [dbo].[Semestre] AS SE
	on SM.SEMESTRE=SE.CodigoSemestre
left join [dbo].[UBIGEO] AS U
	on SM.UBICACION= U.Ubigeo
LEFT OUTER JOIN [dbo].[ALIME_MT] AS A
	on SM.EMPRESA=A.empresa and SM.SEMESTRE=A.semestre and SM.ALIMENTADOR=A.seccion
LEFT OUTER JOIN [dbo].[SRV_SETS] AS P
	on SM.EMPRESA=P.empresa and SM.SEMESTRE=P.semestre and SM.SETCODE=P.subestacion

GO
/****** Object:  View [dbo].[ALIME_MT_2018S1]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[ALIME_MT_2018S1] AS SELECT
	AMT.EMPRESA AS empresa
	, AMT.LOCALIDAD AS localidad
	, AMT.SUBESTACION AS subestacion
	, AMT.SECCION AS seccion
	, AMT.TENSIONNOMINAL AS tensionnominal
	, AMT.TIPOALIMENTADOR AS tipoalimentador
	, AMT.SECCIONALIMENTADOR AS seccionalimentador
	, AMT.SEMESTRE AS semestre
	, AMT.ID_CABECERA AS codigo_cabecera
	, SE.NombreSemestre
	, E.Actividad
	, E.nombre AS NombreEmpresa
	, E.CodEmpGRT
	, AMTP.TIPOALIMENTADOR as TipoAlimentadorPadre
	, S.sectortipico AS Alimen_SectorTipico
	, S.sistema AS Alimen_Sistema
	, S.nomsistema AS Alimen_NombreSistema
	, E.CodEmpGRT+AMT.SECCION AS CodEmpAlim
FROM dbo.SRV_ALIME_MT as AMT
	left join dbo.Semestre AS SE on AMT.SEMESTRE=SE.CodigoSemestre
	left join dbo.Empresa AS E on AMT.EMPRESA=E.codigo
	left join dbo.SRV_ALIME_MT as AMTP on AMT.EMPRESA=AMTP.EMPRESA and AMT.SEMESTRE=AMTP.SEMESTRE and AMT.seccionalimentador=AMTP.seccion
	LEFT OUTER JOIN dbo.LOCALI AS L ON AMT.SEMESTRE = L.semestre AND AMT.EMPRESA = L.empresa AND AMT.LOCALIDAD = L.localidad
	LEFT OUTER JOIN dbo.SISTEMAS AS S ON L.empresa = S.empresa AND L.sistemaelectrico = S.sistema AND L.semestre = S.semestre
WHERE AMT.SEMESTRE=449 and AMT.EMPRESA='EDN'

GO
/****** Object:  Table [dbo].[SRV_LINEA_AT_MT]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_LINEA_AT_MT](
	[EMPRESA] [varchar](3) NOT NULL,
	[LINEAAT] [varchar](7) NOT NULL,
	[NOMBRELINEAAT] [varchar](35) NOT NULL,
	[SETSALIDA] [varchar](7) NOT NULL,
	[SETLLEGADA] [varchar](7) NOT NULL,
	[TENSIONNOMINAL] [decimal](5, 2) NOT NULL,
	[TIPOLINEA] [varchar](200) NOT NULL,
	[SEMESTRE] [int] NOT NULL,
	[ID_CABECERA] [int] NOT NULL,
	[NroRegEnArchivoOrigen] [int] NULL,
 CONSTRAINT [pk_lineaatmat] PRIMARY KEY CLUSTERED 
(
	[LINEAAT] ASC,
	[EMPRESA] ASC,
	[SEMESTRE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[LINEA_AT_MT]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[LINEA_AT_MT] AS SELECT
	L.EMPRESA AS empresa
	, L.LINEAAT AS lineaat
	, L.NOMBRELINEAAT AS nombrelineaat
	, L.SETSALIDA AS setsalida
	, L.SETLLEGADA AS setllegada
	, L.TENSIONNOMINAL AS tensionnominal
	, L.TIPOLINEA AS tipolinea
	, L.SEMESTRE AS semestre
	, L.ID_CABECERA AS codigo_cabecera
	, dbo.Semestre.NombreSemestre
	, dbo.Empresa.actividad
FROM SRV_LINEA_AT_MT AS L
LEFT OUTER JOIN dbo.Empresa
	ON L.EMPRESA = dbo.Empresa.codigo
LEFT OUTER JOIN dbo.Semestre
	ON L.SEMESTRE = dbo.Semestre.CodigoSemestre


GO
/****** Object:  Table [dbo].[SRV_ALIME_BT]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_ALIME_BT](
	[EMPRESA] [varchar](3) NOT NULL,
	[LOCALIDAD] [varchar](4) NOT NULL,
	[SUBESTACION] [varchar](7) NOT NULL,
	[ALIMENTADOR] [varchar](7) NOT NULL,
	[TENSIONOMINAL] [decimal](5, 2) NULL,
	[SEMESTRE] [int] NOT NULL,
	[ID_CABECERA] [int] NULL,
	[NroRegEnArchivoOrigen] [int] NULL,
 CONSTRAINT [pk_alimebt] PRIMARY KEY CLUSTERED 
(
	[ALIMENTADOR] ASC,
	[SUBESTACION] ASC,
	[EMPRESA] ASC,
	[SEMESTRE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ALIME_BT]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ALIME_BT] AS SELECT
ABT.EMPRESA AS Empresa
, ABT.LOCALIDAD AS Localidad
, ABT.SUBESTACION AS Subestacion
, ABT.ALIMENTADOR AS Alimentador
, ABT.TENSIONOMINAL AS tensionominal
, ABT.SEMESTRE AS semestre
, ABT.ID_CABECERA AS codigo_cabecera
, ABT.[NroRegEnArchivoOrigen]
, [dbo].[Semestre].NombreSemestre
, [dbo].[Empresa].Actividad
, [dbo].[Empresa].nombre AS NombreEmpresa
FROM SRV_ALIME_BT as ABT
	left join [dbo].[Semestre] on ABT.SEMESTRE=[dbo].[Semestre].CodigoSemestre
	left join [dbo].[Empresa] on ABT.EMPRESA=[dbo].[Empresa].codigo

GO
/****** Object:  Table [dbo].[SRV_SUMINBT]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_SUMINBT](
	[EMPRESA] [varchar](3) NOT NULL,
	[LOCALIDAD] [varchar](4) NOT NULL,
	[OFICINA] [varchar](4) NOT NULL,
	[IDENTIFICACION] [varchar](35) NULL,
	[DIRECCION] [varchar](30) NULL,
	[UBICACION] [varchar](6) NOT NULL,
	[TELEFONO] [varchar](9) NULL,
	[SUMINISTRO] [varchar](10) NOT NULL,
	[OPCION] [varchar](5) NULL,
	[MARCAMED] [varchar](3) NOT NULL,
	[MODELMED] [varchar](17) NULL,
	[SERIE] [varchar](10) NULL,
	[ANIO] [varchar](4) NULL,
	[POTENCIA] [decimal](12, 2) NULL,
	[TENSION] [decimal](5, 2) NULL,
	[SUBESTACION] [varchar](7) NOT NULL,
	[ALIMENTADOR] [varchar](7) NOT NULL,
	[TIPO] [varchar](2) NULL,
	[FASES] [varchar](3) NULL,
	[NROSUMINISTRO] [varchar](10) NULL,
	[LETRANUMERO] [varchar](1) NULL,
	[PUNTOCONEXION] [varchar](16) NULL,
	[CODSUBESTACION] [varchar](16) NULL,
	[CODSUMINISTRO] [varchar](16) NULL,
	[ETIQUETA] [varchar](16) NULL,
	[TIPOSUMINISTRO] [varchar](1) NULL,
	[MEDIDOR] [varchar](1) NULL,
	[NOMINAL] [varchar](6) NULL,
	[MAXIMA] [varchar](6) NULL,
	[CLASES] [varchar](4) NULL,
	[FECHA] [datetime] NULL,
	[CONTRASTACION] [datetime] NULL,
	[SEMESTRE] [int] NOT NULL,
	[ID_CABECERA] [int] NULL,
	[NroRegEnArchivoOrigen] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[SUMINBT]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[SUMINBT] AS SELECT
	BT.EMPRESA AS empresa, BT.LOCALIDAD AS localidad, BT.OFICINA AS oficina, BT.IDENTIFICACION AS identificacion
	, BT.DIRECCION AS direccion, BT.UBICACION AS ubicacion, BT.TELEFONO AS telefono, BT.SUMINISTRO AS suministro
	, BT.OPCION AS opcion, BT.MARCAMED AS marca, BT.MODELMED AS modelo, BT.SERIE AS serie
	, BT.ANIO AS anio, BT.POTENCIA AS potencia, BT.TENSION AS tensionnominal
	, BT.SUBESTACION AS subestacion, BT.ALIMENTADOR AS alimentador, BT.TIPO AS tipo, BT.FASES AS fases
	, BT.NROSUMINISTRO AS nrosuministro, BT.LETRANUMERO AS letranumero, BT.PUNTOCONEXION AS puntoconexion
	, BT.CODSUBESTACION AS codsubestacion, BT.CODSUMINISTRO AS codsuministro, BT.ETIQUETA AS etiqueta
	, BT.TIPOSUMINISTRO AS tiposuministro, BT.MEDIDOR AS medidor, BT.NOMINAL AS nominal, BT.MAXIMA AS maxima
	, BT.CLASES AS clases, BT.FECHA AS fecha, BT.CONTRASTACION AS contrastacion
	, BT.SEMESTRE AS semestre, BT.ID_CABECERA AS SuminBT_codigo_cabecera, BT.NroRegEnArchivoOrigen
	, L.nombrelocalidad, L.maximademanda AS Localidad_MaximaDemanda, L.sistemaelectrico
	, S.nomsistema, S.tiposistema, S.sectortipico, S.demandamw AS Sistemas_MaximaDemandaMW, S.Norma
	, E.actividad
	, C.NombreSemestre, C.FechaDesde, C.FechaHasta
	, U.DeptNombre, U.Nombre as DistritoNombre
	, SED.seccionlinea, SED.tipoalimentador, SED.seccionalimentador, SED.TipoAlimentadorPadre, SED.TensionNominalAlimentador
	, left(BT.OPCION,2) AS TipoClienteTension, SED.ubicacion as UbigeoSED, SED.utmeste AS UTMSedEste, SED.utmnorte AS UTMSedNorte 
	--, [dbo].[ALIME_MT].tipoalimentador, [dbo].[ALIME_MT].seccionalimentador, [dbo].[ALIME_MT].TipoAlimentadorPadre, [dbo].[ALIME_MT].tensionnominal as TensionNominalAlimentador
FROM dbo.SRV_SUMINBT AS BT
LEFT OUTER JOIN dbo.LOCALI AS L
	ON BT.SEMESTRE = L.semestre AND BT.EMPRESA = L.empresa AND BT.LOCALIDAD = L.localidad
LEFT OUTER JOIN dbo.SISTEMAS AS S
	ON L.empresa = S.empresa AND L.sistemaelectrico = S.sistema AND L.semestre = S.semestre
LEFT OUTER JOIN dbo.Empresa AS E
	ON BT.EMPRESA = E.codigo
left join [dbo].[Semestre] AS C
	on BT.SEMESTRE=C.CodigoSemestre
left join [dbo].[UBIGEO] AS U
	on BT.UBICACION= U.Ubigeo
left join [dbo].SED_MTBT AS SED
	on BT.EMPRESA=SED.empresa and BT.SEMESTRE=SED.semestre and BT.SUBESTACION=SED.subestacion
left join dbo.ControlCargaArchivos
	on BT.ID_CABECERA=dbo.ControlCargaArchivos.CodigoArchivoOrigen
where dbo.ControlCargaArchivos.UltimoValido='S'
/*LEFT OUTER JOIN [dbo].[ALIME_MT]
	on BT.EMPRESA=[dbo].[ALIME_MT].empresa 
	and BT.SEMESTRE=[dbo].[ALIME_MT].semestre 
	and BT.ALIMENTADOR=[dbo].[ALIME_MT].seccion*/
	--execute sp_helpconstraint SRV_SUMINBT --PRIMARY KEY (clustered)


GO
/****** Object:  Table [dbo].[SRV_MEDCALID]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_MEDCALID](
	[EMPRESA] [varchar](3) NULL,
	[MARCAMODELO] [varchar](25) NULL,
	[NROSERIE] [varchar](15) NULL,
	[ANIOFABRICACION] [varchar](4) NULL,
	[TIPOMEDICION] [varchar](1) NULL,
	[FECHACALIBRACION] [datetime] NULL,
	[FECHAADQUISICION] [datetime] NULL,
	[SEMESTRE] [int] NULL,
	[ID_CABECERA] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[MEDCALID]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[MEDCALID] AS
SELECT
	M.EMPRESA AS empresa
	, M.MARCAMODELO AS marcamodelo
	, M.NROSERIE AS nroserie
	, M.ANIOFABRICACION AS aniofabricacion
	, M.TIPOMEDICION AS tipomedicion
	, M.FECHACALIBRACION AS fechacalibracion
	, M.FECHAADQUISICION AS fechaadquisicion
	, M.SEMESTRE AS semestre
	, M.ID_CABECERA AS codigo_cabecera
	, S.NombreSemestre
	, E.actividad
FROM SRV_MEDCALID AS M
LEFT OUTER JOIN dbo.Empresa AS E
ON M.EMPRESA = E.codigo
LEFT OUTER JOIN dbo.Semestre AS S
ON M.SEMESTRE = S.CodigoSemestre

GO
/****** Object:  Table [dbo].[SRV_CLILIBRE]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_CLILIBRE](
	[EMPRESA] [varchar](3) NULL,
	[CODIGOLOCALIDAD] [varchar](4) NULL,
	[EMPRESASUMINISTRO] [varchar](3) NULL,
	[CLIENTE] [varchar](35) NULL,
	[DIRECCIONSUMIN] [varchar](30) NULL,
	[LOCALIDAD] [varchar](20) NULL,
	[UBIGEO] [varchar](6) NULL,
	[SUMINISTRO] [varchar](10) NULL,
	[SEMESTRE] [int] NULL,
	[ID_CABECERA] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CLILIBRE]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


	CREATE VIEW [dbo].[CLILIBRE] AS SELECT
		A.EMPRESA AS empresa
		, A.CODIGOLOCALIDAD AS codigolocalidad
		, A.EMPRESASUMINISTRO AS empresasuministro
		, A.CLIENTE AS cliente
		, A.DIRECCIONSUMIN AS direccionsumin
		, A.LOCALIDAD AS localidad
		, A.UBIGEO AS ubigeo
		, A.SUMINISTRO AS suministro
		, A.SEMESTRE AS semestre
		, A.ID_CABECERA AS codigo_cabecera
		, C.NombreSemestre
		, 'Cliente Libre' as Identificador
	FROM SRV_CLILIBRE A
	Left join [dbo].[Semestre] AS C
	on A.SEMESTRE=C.CodigoSemestre

GO
/****** Object:  Table [dbo].[SRV_MAESTRO_EMPRESA_UBIGEO]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SRV_MAESTRO_EMPRESA_UBIGEO](
	[empresa] [varchar](3) NOT NULL,
	[DeptUbigeo] [nvarchar](6) NULL,
	[DeptNombre] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suministros]    Script Date: 11/05/2020 19:20:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suministros](
	[empresa] [varchar](3) NOT NULL,
	[localidad] [varchar](4) NOT NULL,
	[oficina] [varchar](4) NULL,
	[identificacion] [varchar](35) NULL,
	[direccion] [varchar](30) NULL,
	[ubicacion] [varchar](6) NOT NULL,
	[telefono] [varchar](9) NULL,
	[suministro] [varchar](10) NOT NULL,
	[opcion] [varchar](5) NULL,
	[marca] [varchar](3) NOT NULL,
	[modelo] [varchar](17) NULL,
	[serie] [varchar](10) NULL,
	[anio] [varchar](4) NULL,
	[potencia] [decimal](12, 2) NULL,
	[tensionnominal] [decimal](5, 2) NULL,
	[subestacion] [varchar](7) NOT NULL,
	[alimentador] [varchar](7) NOT NULL,
	[tipo] [varchar](2) NULL,
	[fases] [varchar](3) NULL,
	[nrosuministro] [varchar](10) NULL,
	[letranumero] [varchar](1) NULL,
	[puntoconexion] [varchar](16) NULL,
	[codsubestacion] [varchar](16) NULL,
	[codsuministro] [varchar](16) NULL,
	[etiqueta] [varchar](16) NULL,
	[tiposuministro] [varchar](1) NULL,
	[medidor] [varchar](1) NULL,
	[nominal] [varchar](6) NULL,
	[maxima] [varchar](6) NULL,
	[clases] [varchar](4) NULL,
	[fecha] [datetime] NULL,
	[contrastacion] [datetime] NULL,
	[semestre] [int] NOT NULL,
	[SuminBT_codigo_cabecera] [int] NULL,
	[NroRegEnArchivoOrigen] [int] NULL,
	[nombrelocalidad] [varchar](20) NULL,
	[Localidad_MaximaDemanda] [int] NULL,
	[sistemaelectrico] [varchar](4) NULL,
	[nomsistema] [varchar](20) NULL,
	[tiposistema] [varchar](4) NULL,
	[sectortipico] [varchar](1) NULL,
	[Sistemas_MaximaDemandaMW] [decimal](7, 2) NULL,
	[Norma] [varchar](1) NULL,
	[actividad] [varchar](2) NULL,
	[NombreSemestre] [varchar](6) NULL,
	[FechaDesde] [datetime] NULL,
	[FechaHasta] [datetime] NULL,
	[DeptNombre] [nvarchar](100) NULL,
	[DistritoNombre] [nvarchar](100) NULL,
	[seccionlinea] [varchar](7) NULL,
	[tipoalimentador] [varchar](1) NULL,
	[seccionalimentador] [varchar](7) NULL,
	[TipoAlimentadorPadre] [varchar](1) NULL,
	[TensionNominalAlimentador] [decimal](5, 2) NULL,
	[TipoClienteTension] [varchar](2) NULL,
	[UbigeoSED] [varchar](6) NULL,
	[UTMSedEste] [decimal](11, 3) NULL,
	[UTMSedNorte] [decimal](11, 3) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SRV_ALIME_BT]  WITH CHECK ADD  CONSTRAINT [fk_alimebt_empresa] FOREIGN KEY([EMPRESA])
REFERENCES [dbo].[SRV_EMPR_EMP] ([EMP_CODE])
GO
ALTER TABLE [dbo].[SRV_ALIME_BT] CHECK CONSTRAINT [fk_alimebt_empresa]
GO
ALTER TABLE [dbo].[SRV_ALIME_BT]  WITH NOCHECK ADD  CONSTRAINT [fk_alimebt_localidad] FOREIGN KEY([LOCALIDAD], [EMPRESA], [SEMESTRE])
REFERENCES [dbo].[SRV_LOCALI] ([LOCALIDAD], [EMPRESA], [SEMESTRE])
GO
ALTER TABLE [dbo].[SRV_ALIME_BT] NOCHECK CONSTRAINT [fk_alimebt_localidad]
GO
ALTER TABLE [dbo].[SRV_ALIME_BT]  WITH NOCHECK ADD  CONSTRAINT [fk_alimebt_SED] FOREIGN KEY([SUBESTACION], [EMPRESA], [SEMESTRE])
REFERENCES [dbo].[SRV_SED_MTBT] ([SUBESTACION], [EMPRESA], [SEMESTRE])
GO
ALTER TABLE [dbo].[SRV_ALIME_BT] NOCHECK CONSTRAINT [fk_alimebt_SED]
GO
ALTER TABLE [dbo].[SRV_ALIME_BT]  WITH CHECK ADD  CONSTRAINT [fk_alimebt_semestre] FOREIGN KEY([SEMESTRE])
REFERENCES [dbo].[SRV_SEMESTRE_SEM] ([CODIGO])
GO
ALTER TABLE [dbo].[SRV_ALIME_BT] CHECK CONSTRAINT [fk_alimebt_semestre]
GO
ALTER TABLE [dbo].[SRV_ALIME_MT]  WITH CHECK ADD  CONSTRAINT [fk_alimemt_empresa] FOREIGN KEY([EMPRESA])
REFERENCES [dbo].[SRV_EMPR_EMP] ([EMP_CODE])
GO
ALTER TABLE [dbo].[SRV_ALIME_MT] CHECK CONSTRAINT [fk_alimemt_empresa]
GO
ALTER TABLE [dbo].[SRV_ALIME_MT]  WITH NOCHECK ADD  CONSTRAINT [fk_alimemt_locali] FOREIGN KEY([LOCALIDAD], [EMPRESA], [SEMESTRE])
REFERENCES [dbo].[SRV_LOCALI] ([LOCALIDAD], [EMPRESA], [SEMESTRE])
GO
ALTER TABLE [dbo].[SRV_ALIME_MT] NOCHECK CONSTRAINT [fk_alimemt_locali]
GO
ALTER TABLE [dbo].[SRV_ALIME_MT]  WITH CHECK ADD  CONSTRAINT [fk_alimemt_semestre] FOREIGN KEY([SEMESTRE])
REFERENCES [dbo].[SRV_SEMESTRE_SEM] ([CODIGO])
GO
ALTER TABLE [dbo].[SRV_ALIME_MT] CHECK CONSTRAINT [fk_alimemt_semestre]
GO
ALTER TABLE [dbo].[SRV_ALIME_MT]  WITH NOCHECK ADD  CONSTRAINT [fk_alimemt_sets] FOREIGN KEY([SUBESTACION], [SEMESTRE])
REFERENCES [dbo].[SRV_SETS] ([SUBESTACION], [SEMESTRE])
GO
ALTER TABLE [dbo].[SRV_ALIME_MT] NOCHECK CONSTRAINT [fk_alimemt_sets]
GO
ALTER TABLE [dbo].[SRV_LINEA_AT_MT]  WITH CHECK ADD  CONSTRAINT [fk_lineaat_empresa] FOREIGN KEY([EMPRESA])
REFERENCES [dbo].[SRV_EMPR_EMP] ([EMP_CODE])
GO
ALTER TABLE [dbo].[SRV_LINEA_AT_MT] CHECK CONSTRAINT [fk_lineaat_empresa]
GO
ALTER TABLE [dbo].[SRV_LINEA_AT_MT]  WITH NOCHECK ADD  CONSTRAINT [fk_lineaat_mtsetllegada] FOREIGN KEY([SETLLEGADA], [SEMESTRE])
REFERENCES [dbo].[SRV_SETS] ([SUBESTACION], [SEMESTRE])
GO
ALTER TABLE [dbo].[SRV_LINEA_AT_MT] NOCHECK CONSTRAINT [fk_lineaat_mtsetllegada]
GO
ALTER TABLE [dbo].[SRV_LINEA_AT_MT]  WITH NOCHECK ADD  CONSTRAINT [fk_lineaat_mtsetsalida] FOREIGN KEY([SETSALIDA], [SEMESTRE])
REFERENCES [dbo].[SRV_SETS] ([SUBESTACION], [SEMESTRE])
GO
ALTER TABLE [dbo].[SRV_LINEA_AT_MT] NOCHECK CONSTRAINT [fk_lineaat_mtsetsalida]
GO
ALTER TABLE [dbo].[SRV_LINEA_AT_MT]  WITH CHECK ADD  CONSTRAINT [fk_lineaat_semestre] FOREIGN KEY([SEMESTRE])
REFERENCES [dbo].[SRV_SEMESTRE_SEM] ([CODIGO])
GO
ALTER TABLE [dbo].[SRV_LINEA_AT_MT] CHECK CONSTRAINT [fk_lineaat_semestre]
GO
ALTER TABLE [dbo].[SRV_LOCALI]  WITH CHECK ADD  CONSTRAINT [fk_localiempresa] FOREIGN KEY([EMPRESA])
REFERENCES [dbo].[SRV_EMPR_EMP] ([EMP_CODE])
GO
ALTER TABLE [dbo].[SRV_LOCALI] CHECK CONSTRAINT [fk_localiempresa]
GO
ALTER TABLE [dbo].[SRV_LOCALI]  WITH CHECK ADD  CONSTRAINT [fk_localisemestre] FOREIGN KEY([SEMESTRE])
REFERENCES [dbo].[SRV_SEMESTRE_SEM] ([CODIGO])
GO
ALTER TABLE [dbo].[SRV_LOCALI] CHECK CONSTRAINT [fk_localisemestre]
GO
ALTER TABLE [dbo].[SRV_LOCALI]  WITH NOCHECK ADD  CONSTRAINT [fk_localisistemas] FOREIGN KEY([SISTEMAELECTRICO], [EMPRESA], [SEMESTRE])
REFERENCES [dbo].[SRV_SISTEMAS] ([SISTEMA], [EMPRESA], [SEMESTRE])
GO
ALTER TABLE [dbo].[SRV_LOCALI] NOCHECK CONSTRAINT [fk_localisistemas]
GO
ALTER TABLE [dbo].[SRV_SED_MTBT]  WITH NOCHECK ADD  CONSTRAINT [fk_sedmtbt_alimentador] FOREIGN KEY([SECCIONLINEA], [EMPRESA], [SEMESTRE])
REFERENCES [dbo].[SRV_ALIME_MT] ([SECCION], [EMPRESA], [SEMESTRE])
GO
ALTER TABLE [dbo].[SRV_SED_MTBT] NOCHECK CONSTRAINT [fk_sedmtbt_alimentador]
GO
ALTER TABLE [dbo].[SRV_SED_MTBT]  WITH CHECK ADD  CONSTRAINT [fk_sedmtbt_empresas] FOREIGN KEY([EMPRESA])
REFERENCES [dbo].[SRV_EMPR_EMP] ([EMP_CODE])
GO
ALTER TABLE [dbo].[SRV_SED_MTBT] CHECK CONSTRAINT [fk_sedmtbt_empresas]
GO
ALTER TABLE [dbo].[SRV_SED_MTBT]  WITH NOCHECK ADD  CONSTRAINT [fk_sedmtbt_locali] FOREIGN KEY([LOCALIDAD], [EMPRESA], [SEMESTRE])
REFERENCES [dbo].[SRV_LOCALI] ([LOCALIDAD], [EMPRESA], [SEMESTRE])
GO
ALTER TABLE [dbo].[SRV_SED_MTBT] NOCHECK CONSTRAINT [fk_sedmtbt_locali]
GO
ALTER TABLE [dbo].[SRV_SED_MTBT]  WITH CHECK ADD  CONSTRAINT [fk_sedmtbt_semestre] FOREIGN KEY([SEMESTRE])
REFERENCES [dbo].[SRV_SEMESTRE_SEM] ([CODIGO])
GO
ALTER TABLE [dbo].[SRV_SED_MTBT] CHECK CONSTRAINT [fk_sedmtbt_semestre]
GO
ALTER TABLE [dbo].[SRV_SED_MTBT]  WITH NOCHECK ADD  CONSTRAINT [fk_sedmtbt_succeat] FOREIGN KEY([SUCURSAL], [EMPRESA], [SEMESTRE])
REFERENCES [dbo].[SRV_SUC_CEAT] ([CODIGOOFICINA], [EMPRESA], [SEMESTRE])
GO
ALTER TABLE [dbo].[SRV_SED_MTBT] NOCHECK CONSTRAINT [fk_sedmtbt_succeat]
GO
ALTER TABLE [dbo].[SRV_SETS]  WITH CHECK ADD  CONSTRAINT [fk_setempresa] FOREIGN KEY([EMPRESA])
REFERENCES [dbo].[SRV_EMPR_EMP] ([EMP_CODE])
GO
ALTER TABLE [dbo].[SRV_SETS] CHECK CONSTRAINT [fk_setempresa]
GO
ALTER TABLE [dbo].[SRV_SETS]  WITH NOCHECK ADD  CONSTRAINT [fk_setlocali] FOREIGN KEY([LOCALIDAD], [EMPRESA], [SEMESTRE])
REFERENCES [dbo].[SRV_LOCALI] ([LOCALIDAD], [EMPRESA], [SEMESTRE])
GO
ALTER TABLE [dbo].[SRV_SETS] NOCHECK CONSTRAINT [fk_setlocali]
GO
ALTER TABLE [dbo].[SRV_SETS]  WITH CHECK ADD  CONSTRAINT [fk_setsemestre] FOREIGN KEY([SEMESTRE])
REFERENCES [dbo].[SRV_SEMESTRE_SEM] ([CODIGO])
GO
ALTER TABLE [dbo].[SRV_SETS] CHECK CONSTRAINT [fk_setsemestre]
GO
ALTER TABLE [dbo].[SRV_SISTEMAS]  WITH CHECK ADD  CONSTRAINT [fk_sistemaempresa] FOREIGN KEY([EMPRESA])
REFERENCES [dbo].[SRV_EMPR_EMP] ([EMP_CODE])
GO
ALTER TABLE [dbo].[SRV_SISTEMAS] CHECK CONSTRAINT [fk_sistemaempresa]
GO
ALTER TABLE [dbo].[SRV_SISTEMAS]  WITH CHECK ADD  CONSTRAINT [fk_sistemasemestre] FOREIGN KEY([SEMESTRE])
REFERENCES [dbo].[SRV_SEMESTRE_SEM] ([CODIGO])
GO
ALTER TABLE [dbo].[SRV_SISTEMAS] CHECK CONSTRAINT [fk_sistemasemestre]
GO
ALTER TABLE [dbo].[SRV_SUC_CEAT]  WITH CHECK ADD  CONSTRAINT [fk_succeat_empresa] FOREIGN KEY([EMPRESA])
REFERENCES [dbo].[SRV_EMPR_EMP] ([EMP_CODE])
GO
ALTER TABLE [dbo].[SRV_SUC_CEAT] CHECK CONSTRAINT [fk_succeat_empresa]
GO
ALTER TABLE [dbo].[SRV_SUC_CEAT]  WITH NOCHECK ADD  CONSTRAINT [fk_succeat_localidad] FOREIGN KEY([LOCALIDAD], [EMPRESA], [SEMESTRE])
REFERENCES [dbo].[SRV_LOCALI] ([LOCALIDAD], [EMPRESA], [SEMESTRE])
GO
ALTER TABLE [dbo].[SRV_SUC_CEAT] NOCHECK CONSTRAINT [fk_succeat_localidad]
GO
ALTER TABLE [dbo].[SRV_SUC_CEAT]  WITH CHECK ADD  CONSTRAINT [fk_succeat_semestre] FOREIGN KEY([SEMESTRE])
REFERENCES [dbo].[SRV_SEMESTRE_SEM] ([CODIGO])
GO
ALTER TABLE [dbo].[SRV_SUC_CEAT] CHECK CONSTRAINT [fk_succeat_semestre]
GO
ALTER TABLE [dbo].[SRV_SUMINAT_MAT]  WITH CHECK ADD  CONSTRAINT [fk_suminatmat_empresas] FOREIGN KEY([EMPRESA])
REFERENCES [dbo].[SRV_EMPR_EMP] ([EMP_CODE])
GO
ALTER TABLE [dbo].[SRV_SUMINAT_MAT] CHECK CONSTRAINT [fk_suminatmat_empresas]
GO
ALTER TABLE [dbo].[SRV_SUMINAT_MAT]  WITH NOCHECK ADD  CONSTRAINT [fk_suminatmat_locali] FOREIGN KEY([LOCALIDAD], [EMPRESA], [SEMESTRE])
REFERENCES [dbo].[SRV_LOCALI] ([LOCALIDAD], [EMPRESA], [SEMESTRE])
GO
ALTER TABLE [dbo].[SRV_SUMINAT_MAT] NOCHECK CONSTRAINT [fk_suminatmat_locali]
GO
ALTER TABLE [dbo].[SRV_SUMINAT_MAT]  WITH NOCHECK ADD  CONSTRAINT [fk_suminatmat_medidor] FOREIGN KEY([MARCA])
REFERENCES [dbo].[SRV_MEDBRAND_MM] ([MM_MARCA])
GO
ALTER TABLE [dbo].[SRV_SUMINAT_MAT] NOCHECK CONSTRAINT [fk_suminatmat_medidor]
GO
ALTER TABLE [dbo].[SRV_SUMINAT_MAT]  WITH CHECK ADD  CONSTRAINT [fk_suminatmat_semestre] FOREIGN KEY([SEMESTRE])
REFERENCES [dbo].[SRV_SEMESTRE_SEM] ([CODIGO])
GO
ALTER TABLE [dbo].[SRV_SUMINAT_MAT] CHECK CONSTRAINT [fk_suminatmat_semestre]
GO
ALTER TABLE [dbo].[SRV_SUMINAT_MAT]  WITH NOCHECK ADD  CONSTRAINT [fk_suminatmat_set] FOREIGN KEY([SETCODE], [SEMESTRE])
REFERENCES [dbo].[SRV_SETS] ([SUBESTACION], [SEMESTRE])
GO
ALTER TABLE [dbo].[SRV_SUMINAT_MAT] NOCHECK CONSTRAINT [fk_suminatmat_set]
GO
ALTER TABLE [dbo].[SRV_SUMINBT]  WITH CHECK ADD  CONSTRAINT [fk_suminbt_empresa] FOREIGN KEY([EMPRESA])
REFERENCES [dbo].[SRV_EMPR_EMP] ([EMP_CODE])
GO
ALTER TABLE [dbo].[SRV_SUMINBT] CHECK CONSTRAINT [fk_suminbt_empresa]
GO
ALTER TABLE [dbo].[SRV_SUMINBT]  WITH NOCHECK ADD  CONSTRAINT [fk_suminbt_localidad] FOREIGN KEY([LOCALIDAD], [EMPRESA], [SEMESTRE])
REFERENCES [dbo].[SRV_LOCALI] ([LOCALIDAD], [EMPRESA], [SEMESTRE])
GO
ALTER TABLE [dbo].[SRV_SUMINBT] NOCHECK CONSTRAINT [fk_suminbt_localidad]
GO
ALTER TABLE [dbo].[SRV_SUMINBT]  WITH NOCHECK ADD  CONSTRAINT [fk_suminbt_medidor] FOREIGN KEY([MARCAMED])
REFERENCES [dbo].[SRV_MEDBRAND_MM] ([MM_MARCA])
GO
ALTER TABLE [dbo].[SRV_SUMINBT] NOCHECK CONSTRAINT [fk_suminbt_medidor]
GO
ALTER TABLE [dbo].[SRV_SUMINBT]  WITH NOCHECK ADD  CONSTRAINT [fk_suminbt_sed] FOREIGN KEY([SUBESTACION], [EMPRESA], [SEMESTRE])
REFERENCES [dbo].[SRV_SED_MTBT] ([SUBESTACION], [EMPRESA], [SEMESTRE])
GO
ALTER TABLE [dbo].[SRV_SUMINBT] NOCHECK CONSTRAINT [fk_suminbt_sed]
GO
ALTER TABLE [dbo].[SRV_SUMINBT]  WITH CHECK ADD  CONSTRAINT [fk_suminbt_semestre] FOREIGN KEY([SEMESTRE])
REFERENCES [dbo].[SRV_SEMESTRE_SEM] ([CODIGO])
GO
ALTER TABLE [dbo].[SRV_SUMINBT] CHECK CONSTRAINT [fk_suminbt_semestre]
GO
ALTER TABLE [dbo].[SRV_SUMINBT]  WITH NOCHECK ADD  CONSTRAINT [fk_suminbt_succeat] FOREIGN KEY([OFICINA], [EMPRESA], [SEMESTRE])
REFERENCES [dbo].[SRV_SUC_CEAT] ([CODIGOOFICINA], [EMPRESA], [SEMESTRE])
GO
ALTER TABLE [dbo].[SRV_SUMINBT] NOCHECK CONSTRAINT [fk_suminbt_succeat]
GO
ALTER TABLE [dbo].[SRV_SUMINMT]  WITH NOCHECK ADD  CONSTRAINT [fk_suminmt_alimmt] FOREIGN KEY([ALIMENTADOR], [EMPRESA], [SEMESTRE])
REFERENCES [dbo].[SRV_ALIME_MT] ([SECCION], [EMPRESA], [SEMESTRE])
GO
ALTER TABLE [dbo].[SRV_SUMINMT] NOCHECK CONSTRAINT [fk_suminmt_alimmt]
GO
ALTER TABLE [dbo].[SRV_SUMINMT]  WITH CHECK ADD  CONSTRAINT [fk_suminmt_empresa] FOREIGN KEY([EMPRESA])
REFERENCES [dbo].[SRV_EMPR_EMP] ([EMP_CODE])
GO
ALTER TABLE [dbo].[SRV_SUMINMT] CHECK CONSTRAINT [fk_suminmt_empresa]
GO
ALTER TABLE [dbo].[SRV_SUMINMT]  WITH NOCHECK ADD  CONSTRAINT [fk_suminmt_locali] FOREIGN KEY([LOCALIDAD], [EMPRESA], [SEMESTRE])
REFERENCES [dbo].[SRV_LOCALI] ([LOCALIDAD], [EMPRESA], [SEMESTRE])
GO
ALTER TABLE [dbo].[SRV_SUMINMT] NOCHECK CONSTRAINT [fk_suminmt_locali]
GO
ALTER TABLE [dbo].[SRV_SUMINMT]  WITH NOCHECK ADD  CONSTRAINT [fk_suminmt_medidor] FOREIGN KEY([MARCA])
REFERENCES [dbo].[SRV_MEDBRAND_MM] ([MM_MARCA])
GO
ALTER TABLE [dbo].[SRV_SUMINMT] NOCHECK CONSTRAINT [fk_suminmt_medidor]
GO
ALTER TABLE [dbo].[SRV_SUMINMT]  WITH CHECK ADD  CONSTRAINT [fk_suminmt_semestre] FOREIGN KEY([SEMESTRE])
REFERENCES [dbo].[SRV_SEMESTRE_SEM] ([CODIGO])
GO
ALTER TABLE [dbo].[SRV_SUMINMT] CHECK CONSTRAINT [fk_suminmt_semestre]
GO
ALTER TABLE [dbo].[SRV_SUMINMT]  WITH NOCHECK ADD  CONSTRAINT [fk_suminmt_set] FOREIGN KEY([SETCODE], [SEMESTRE])
REFERENCES [dbo].[SRV_SETS] ([SUBESTACION], [SEMESTRE])
GO
ALTER TABLE [dbo].[SRV_SUMINMT] NOCHECK CONSTRAINT [fk_suminmt_set]
GO
ALTER TABLE [dbo].[SRV_VIASAP]  WITH CHECK ADD  CONSTRAINT [fk_viasap_empresa] FOREIGN KEY([EMPRESA])
REFERENCES [dbo].[SRV_EMPR_EMP] ([EMP_CODE])
GO
ALTER TABLE [dbo].[SRV_VIASAP] CHECK CONSTRAINT [fk_viasap_empresa]
GO
ALTER TABLE [dbo].[SRV_VIASAP]  WITH NOCHECK ADD  CONSTRAINT [fk_viasap_localidad] FOREIGN KEY([LOCALIDAD], [EMPRESA], [SEMESTRE])
REFERENCES [dbo].[SRV_LOCALI] ([LOCALIDAD], [EMPRESA], [SEMESTRE])
GO
ALTER TABLE [dbo].[SRV_VIASAP] NOCHECK CONSTRAINT [fk_viasap_localidad]
GO
ALTER TABLE [dbo].[SRV_VIASAP]  WITH CHECK ADD  CONSTRAINT [fk_viasap_semestre] FOREIGN KEY([SEMESTRE])
REFERENCES [dbo].[SRV_SEMESTRE_SEM] ([CODIGO])
GO
ALTER TABLE [dbo].[SRV_VIASAP] CHECK CONSTRAINT [fk_viasap_semestre]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la empresa según anexo nº 3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_ALIME_BT', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de localidad' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_ALIME_BT', @level2type=N'COLUMN',@level2name=N'LOCALIDAD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la subestación MT/BT' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_ALIME_BT', @level2type=N'COLUMN',@level2name=N'SUBESTACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código del alimentador BT' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_ALIME_BT', @level2type=N'COLUMN',@level2name=N'ALIMENTADOR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tensión nominal (kv)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_ALIME_BT', @level2type=N'COLUMN',@level2name=N'TENSIONOMINAL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_ALIME_BT', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_ALIME_BT', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la empresa según anexo nº 3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_ALIME_MT', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de localidad' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_ALIME_MT', @level2type=N'COLUMN',@level2name=N'LOCALIDAD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la set' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_ALIME_MT', @level2type=N'COLUMN',@level2name=N'SUBESTACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la sección de alimentador o alimentador MT' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_ALIME_MT', @level2type=N'COLUMN',@level2name=N'SECCION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tensión nominal MT (kv)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_ALIME_MT', @level2type=N'COLUMN',@level2name=N'TENSIONNOMINAL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'(a) Cuando es alimentador MT (s) Cuando es sección de alimentador MT' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_ALIME_MT', @level2type=N'COLUMN',@level2name=N'TIPOALIMENTADOR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cuando es sección de alimentador se requiere se identifique a que alimentador MT pertenece.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_ALIME_MT', @level2type=N'COLUMN',@level2name=N'SECCIONALIMENTADOR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_ALIME_MT', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_ALIME_MT', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la empresa según anexo nº 3,que brinda el servicio de alumbrado público' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CLILIBRE', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la localidad' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CLILIBRE', @level2type=N'COLUMN',@level2name=N'CODIGOLOCALIDAD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la empresa según anexo nº 3,que brinda el suministro al cliente libre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CLILIBRE', @level2type=N'COLUMN',@level2name=N'EMPRESASUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Apellidos y nombres del cliente o razón social' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CLILIBRE', @level2type=N'COLUMN',@level2name=N'CLIENTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Dirección del suministro' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CLILIBRE', @level2type=N'COLUMN',@level2name=N'DIRECCIONSUMIN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Localidad' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CLILIBRE', @level2type=N'COLUMN',@level2name=N'LOCALIDAD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código ubicación geográfica (UBIGEO) de departamento, provincia y distrito según ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CLILIBRE', @level2type=N'COLUMN',@level2name=N'UBIGEO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Número del suministro' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CLILIBRE', @level2type=N'COLUMN',@level2name=N'SUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CLILIBRE', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_CLILIBRE', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo de la empresa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_EMPR_EMP', @level2type=N'COLUMN',@level2name=N'EMP_CODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre de la empresa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_EMPR_EMP', @level2type=N'COLUMN',@level2name=N'EMP_NOMBRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Actividad de la empresa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_EMPR_EMP', @level2type=N'COLUMN',@level2name=N'EMP_ACTIVIDAD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la empresa según anexo nº 3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_LINEA_AT_MT', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la línea at' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_LINEA_AT_MT', @level2type=N'COLUMN',@level2name=N'LINEAAT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre de la línea at' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_LINEA_AT_MT', @level2type=N'COLUMN',@level2name=N'NOMBRELINEAAT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la set de salida' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_LINEA_AT_MT', @level2type=N'COLUMN',@level2name=N'SETSALIDA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la set de llegada' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_LINEA_AT_MT', @level2type=N'COLUMN',@level2name=N'SETLLEGADA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tensión nominal de la línea at (kv)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_LINEA_AT_MT', @level2type=N'COLUMN',@level2name=N'TENSIONNOMINAL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tipo Linea AT o MAT' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_LINEA_AT_MT', @level2type=N'COLUMN',@level2name=N'TIPOLINEA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_LINEA_AT_MT', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_LINEA_AT_MT', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la empresa según anexo nº 3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_LOCALI', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código del sistema eléctrico' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_LOCALI', @level2type=N'COLUMN',@level2name=N'SISTEMAELECTRICO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de localidad' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_LOCALI', @level2type=N'COLUMN',@level2name=N'LOCALIDAD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre de localidad' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_LOCALI', @level2type=N'COLUMN',@level2name=N'NOMBRELOCALIDAD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Max. Deman. en kw (promedio últimos 6 meses)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_LOCALI', @level2type=N'COLUMN',@level2name=N'MAXIMADEMANDA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_LOCALI', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_LOCALI', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ingresa a SISA urbano, S=si , N=no, null =no ingresan.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_LOCALI', @level2type=N'COLUMN',@level2name=N'SISAU'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre Sistema' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MAESTRO_SISTEMAS', @level2type=N'COLUMN',@level2name=N'NOMBRE_SISTEMA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo Norma segun GART' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MAESTRO_SISTEMAS', @level2type=N'COLUMN',@level2name=N'CODIGO_GART'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo de empresa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MAESTRO_SISTEMAS', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Vigencia Hasta' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MAESTRO_SISTEMAS', @level2type=N'COLUMN',@level2name=N'VIGENCIA_HASTA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo Norma' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MAESTRO_SISTEMAS', @level2type=N'COLUMN',@level2name=N'CODIGO_NORMA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sector Tipico' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MAESTRO_SISTEMAS', @level2type=N'COLUMN',@level2name=N'SECTOR_TIPICO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo Norma segun GFEIT' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MAESTRO_SISTEMAS', @level2type=N'COLUMN',@level2name=N'CODIGO_GFEIT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Vigencia Desde' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MAESTRO_SISTEMAS', @level2type=N'COLUMN',@level2name=N'VIGENCIA_DESDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo Semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MAESTROS_SETS', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo de empresa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MAESTROS_SETS', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tensión Nominal en la SET' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MAESTROS_SETS', @level2type=N'COLUMN',@level2name=N'TENSION_NOMINAL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo Norma' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MAESTROS_SETS', @level2type=N'COLUMN',@level2name=N'CODIGO_NORMA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre SET' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MAESTROS_SETS', @level2type=N'COLUMN',@level2name=N'NOMBRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Marca del medidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MEDBRAND_MM', @level2type=N'COLUMN',@level2name=N'MM_MARCA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre de la marca' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MEDBRAND_MM', @level2type=N'COLUMN',@level2name=N'MM_NOMBRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la empresa suministradora' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MEDCALID', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Marca y modelo del equipo registrador' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MEDCALID', @level2type=N'COLUMN',@level2name=N'MARCAMODELO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Número de serie del equipo registrador' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MEDCALID', @level2type=N'COLUMN',@level2name=N'NROSERIE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Año de fabricación del equipo registrador' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MEDCALID', @level2type=N'COLUMN',@level2name=N'ANIOFABRICACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tipo de medición que puede efectuar 0 : Tensión monofásica 1 : Tensión Trifásica 2 : Tensión Trifásica + Energía 3 : Tensión + (Flicker o Armónicas) + Energía 4 : Tensión + Flicker + Armónicas + Energía' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MEDCALID', @level2type=N'COLUMN',@level2name=N'TIPOMEDICION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha de la última calibración' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MEDCALID', @level2type=N'COLUMN',@level2name=N'FECHACALIBRACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha en que se adquirió el equipo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MEDCALID', @level2type=N'COLUMN',@level2name=N'FECHAADQUISICION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MEDCALID', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_MEDCALID', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la empresa según anexo nº 3.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RELEVAD', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código que identifica al punto de la red' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RELEVAD', @level2type=N'COLUMN',@level2name=N'PUNTORED'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la set donde se ubica el punto' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RELEVAD', @level2type=N'COLUMN',@level2name=N'SUBESTACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de línea o alimentador asociado al punto' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RELEVAD', @level2type=N'COLUMN',@level2name=N'LINEAALIM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Dirección del set' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RELEVAD', @level2type=N'COLUMN',@level2name=N'SETDIRECCION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RELEVAD', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RELEVAD', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de localidad' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'LOCALIDAD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código Sistema Electrico' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'SISTEMA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sector Típico de Distribución' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'SECTOR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Max. Dem. KW' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'MAXIMA_DEMANDA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Pot. Ins. Gen. (MW)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'POTENCIA_INSTALADA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SUMINBT Monofasicos' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'SUMINISTROS_BT_MONOFASICOS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SUMINBT Trifasico' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'SUMINISTROS_BT_TRIFASICO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Suministros MT' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'SUMINISTROS_MT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Suministros AT' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'SUMINISTROS_AT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nro Seds MT BT' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'SEDS_MT_BT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Punto Entrega Generador (SET)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'PUNTO_ENTREGA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tensión Pto Entrega Gen. (KV)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'TENSION_PUNTO_ENTREGA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Región' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'REGION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cantidad Puntos de Entrega BT (Caso 1)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'CANTIDAD_PUNTOS_CASO_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cantidad Puntos de Entrega BT (Caso 2)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'CANTIDAD_PUNTOS_CASO_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cantidad Puntos de Entrega BT (Caso 3)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'CANTIDAD_PUNTOS_CASO_3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cantidad Puntos de Entrega BT (Caso 4)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'CANTIDAD_PUNTOS_CASO_4'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo de empresa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo de semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Usuario que crea el Registro' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'USUARIO_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Fecha de creacion del registro' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'FECHA_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Terminal creacion del registro' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'TERMINAL_CREACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Usuario de actualizacion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'USUARIO_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Fecha y hora de modificacion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'FECHA_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' Terminal de modificacion/actualizacion.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'TERMINAL_ACTUALIZACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_RESUMEN_SUMIN', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la empresa según anexo nº 3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SED_MTBT', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de localidad' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SED_MTBT', @level2type=N'COLUMN',@level2name=N'LOCALIDAD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código sucursal u oficina de atención comercial en cuya área se encuentra la sub estacion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SED_MTBT', @level2type=N'COLUMN',@level2name=N'SUCURSAL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la sub estacion MT/BT' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SED_MTBT', @level2type=N'COLUMN',@level2name=N'SUBESTACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre de la subestación MT/BT' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SED_MTBT', @level2type=N'COLUMN',@level2name=N'NOMBRESUBESTACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Dirección de la sub estación' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SED_MTBT', @level2type=N'COLUMN',@level2name=N'DIRECCIONSET'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ubicacion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SED_MTBT', @level2type=N'COLUMN',@level2name=N'UBICACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tensión nominal BT(kv)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SED_MTBT', @level2type=N'COLUMN',@level2name=N'TENSIOBT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tensión nominal MT(kv)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SED_MTBT', @level2type=N'COLUMN',@level2name=N'TENSIONMT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Capacidad de transformación (MVA)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SED_MTBT', @level2type=N'COLUMN',@level2name=N'CAPTRANSFORMACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Coordenada norte (UTM)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SED_MTBT', @level2type=N'COLUMN',@level2name=N'UTMNORTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Coordenada este (UTM)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SED_MTBT', @level2type=N'COLUMN',@level2name=N'UTMESTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de sección de línea o alimentador MT o línea AT' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SED_MTBT', @level2type=N'COLUMN',@level2name=N'SECCIONLINEA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SED_MTBT', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SED_MTBT', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'codigo interno del semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SEMESTRE_SEM', @level2type=N'COLUMN',@level2name=N'CODIGO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'nombre del periodo 2009S2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SEMESTRE_SEM', @level2type=N'COLUMN',@level2name=N'NOMBRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ddmmaaaa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SEMESTRE_SEM', @level2type=N'COLUMN',@level2name=N'DESDE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ddmmaaaa' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SEMESTRE_SEM', @level2type=N'COLUMN',@level2name=N'HASTA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la empresa según anexo nº 3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SETS', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de localidad' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SETS', @level2type=N'COLUMN',@level2name=N'LOCALIDAD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la SET' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SETS', @level2type=N'COLUMN',@level2name=N'SUBESTACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre de la SET' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SETS', @level2type=N'COLUMN',@level2name=N'NOMSET'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Dirección de la SET' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SETS', @level2type=N'COLUMN',@level2name=N'DIRSET'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de ubicación geográfica del departamento, provincia y distrito según ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SETS', @level2type=N'COLUMN',@level2name=N'UBICACIÓN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Teléfono (si tuviera)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SETS', @level2type=N'COLUMN',@level2name=N'TELEFONO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Capacidad total de transformación (MVA)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SETS', @level2type=N'COLUMN',@level2name=N'CAPTRANSFORMACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Coordenada norte (UTM)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SETS', @level2type=N'COLUMN',@level2name=N'UTMNORTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Coordenada este (UTM)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SETS', @level2type=N'COLUMN',@level2name=N'UTMESTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tensión nominal de barra N( kv )' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SETS', @level2type=N'COLUMN',@level2name=N'TENSIONNOMINALN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SETS', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SETS', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la empresa según anexo nº 3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SISTEMAS', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código del sistema eléctrico' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SISTEMAS', @level2type=N'COLUMN',@level2name=N'SISTEMA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre del sistema eléctrico' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SISTEMAS', @level2type=N'COLUMN',@level2name=N'NOMSISTEMA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tipo de sistema: AMAY: Aislado Mayor (Pot. Inst. Generación > 5 MW) AMEN: Aislado MenoR (Pot. Inst. Generación ? 5 MW) SEIN: Sistema Eléctrico Interconectado' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SISTEMAS', @level2type=N'COLUMN',@level2name=N'TIPOSISTEMA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código Sector Típico de Distribución : 1, 2, 3, 4, 5 ó E' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SISTEMAS', @level2type=N'COLUMN',@level2name=N'SECTORTIPICO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Demanda Máxima en MW' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SISTEMAS', @level2type=N'COLUMN',@level2name=N'DEMANDAMW'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo del semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SISTEMAS', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SISTEMAS', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la empresa según anexo nº 3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUC_CEAT', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de localidad' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUC_CEAT', @level2type=N'COLUMN',@level2name=N'LOCALIDAD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código oficina de atención comercial' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUC_CEAT', @level2type=N'COLUMN',@level2name=N'CODIGOOFICINA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre de la sucursal o centro de atención' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUC_CEAT', @level2type=N'COLUMN',@level2name=N'SUCURSAL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUC_CEAT', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUC_CEAT', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la empresa según anexo nº 3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINAT_MAT', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de localidad' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINAT_MAT', @level2type=N'COLUMN',@level2name=N'LOCALIDAD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'apellidos y nombres' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINAT_MAT', @level2type=N'COLUMN',@level2name=N'IDENTIFICACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'direcsuministro' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINAT_MAT', @level2type=N'COLUMN',@level2name=N'DIRECCION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ubicacion geografica' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINAT_MAT', @level2type=N'COLUMN',@level2name=N'UBICACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'nrotelefono' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINAT_MAT', @level2type=N'COLUMN',@level2name=N'TELEFONO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'nrosuministro' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINAT_MAT', @level2type=N'COLUMN',@level2name=N'SUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Modelo del medidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINAT_MAT', @level2type=N'COLUMN',@level2name=N'MODELOMED'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Marca del medidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINAT_MAT', @level2type=N'COLUMN',@level2name=N'MARCA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'numero medidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINAT_MAT', @level2type=N'COLUMN',@level2name=N'SERIE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'fabricacion del medidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINAT_MAT', @level2type=N'COLUMN',@level2name=N'ANIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'potecontratada' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINAT_MAT', @level2type=N'COLUMN',@level2name=N'POTENCIA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ten nominal(kv)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINAT_MAT', @level2type=N'COLUMN',@level2name=N'TENSION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'codigo dela set' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINAT_MAT', @level2type=N'COLUMN',@level2name=N'SETCODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de línea AT alimentadora ..n' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINAT_MAT', @level2type=N'COLUMN',@level2name=N'CODIGOLINEALIMMT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Tipo suministro AT o MAT' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINAT_MAT', @level2type=N'COLUMN',@level2name=N'TIPOSUMIN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINAT_MAT', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINAT_MAT', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la empresa según anexo nº 3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de localidad' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'LOCALIDAD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'codigodeatencion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'OFICINA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'apellidosynombres' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'IDENTIFICACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'direcsuministro' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'DIRECCION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ubicaciongeografica' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'UBICACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'nrotelefono' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'TELEFONO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'nrosuministro' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'SUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'tarifaria' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'OPCION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'marca medidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'MARCAMED'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Modelo medidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'MODELMED'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'numerodemedidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'SERIE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'fabricaciondelmedidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'ANIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'potecontratada' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'POTENCIA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'tennominal(kv)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'TENSION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'codigomt/bt' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'SUBESTACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'codigobt' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'ALIMENTADOR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'serviciourbanorural' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'TIPO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'fasesalimentador' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'FASES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'inmediatoanterior' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'NROSUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'puntosuministrocomun' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'LETRANUMERO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'codigopuntodeconexion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'PUNTOCONEXION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'codigo diferente' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'CODSUBESTACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'es diferente al campo 8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'CODSUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'campo de la subestacion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'ETIQUETA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'provicional bloquecolectivo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'TIPOSUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'electromanetico electronico' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'MEDIDOR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'corriente del medidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'NOMINAL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'corriente del medidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'MAXIMA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'presicion del medidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'CLASES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'afericion medidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'FECHA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'fecha ultima medidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'CONTRASTACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINBT', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la empresa según anexo nº 3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de localidad' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'LOCALIDAD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'apellidos y nombres' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'IDENTIFICACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'direcsuministro' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'DIRECCION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ubicacion geografica' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'UBICACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'nrotelefono' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'TELEFONO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'nrosuministro' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'SUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'tarifaria' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'OPCION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Marca del medidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'MARCA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Modelo del medidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'MODELOMED'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'numero medidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'SERIE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'fabricacion del medidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'ANIO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'potecontratada' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'POTENCIA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ten nominal(kv)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'TENSION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'codigo set' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'SETCODE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'cod mt' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'ALIMENTADOR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'codigopuntodeconexion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'PUNTOCONEXION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'codigo diferente' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'CODSUBESTACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'es difernte al campo 7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'CODSUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'campo subestacion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'ETIQUETA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'provicional bloque colectivo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'TIPOSUMINISTRO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'electromanetico electronico' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'MEDIDOR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'corriente del medidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'NOMINAL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'corriente del medidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'MAXIMA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'precision del medidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'CLASES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'afericion medidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'FECHAAFER'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'fecha ultima medidor' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'CONTRASTACION'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_SUMINMT', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la empresa según anexo nº 3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_VIASAP', @level2type=N'COLUMN',@level2name=N'EMPRESA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de localidad' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_VIASAP', @level2type=N'COLUMN',@level2name=N'LOCALIDAD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de la vía (asignado por la distribuidora)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_VIASAP', @level2type=N'COLUMN',@level2name=N'CODIGOVIA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Número de carriles: 1, 2, 3........., n' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_VIASAP', @level2type=N'COLUMN',@level2name=N'NUMCARRILES'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Denominación de la vía: AL ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_VIASAP', @level2type=N'COLUMN',@level2name=N'DENOMVIA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nombre de la vía' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_VIASAP', @level2type=N'COLUMN',@level2name=N'NOMVIA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Localidad donde comienza la vía' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_VIASAP', @level2type=N'COLUMN',@level2name=N'LOCALIDADINICIAVIA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código ubicación geográfica (UBIGEO) según INEI' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_VIASAP', @level2type=N'COLUMN',@level2name=N'UBICACIOGEO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Longitud total de la vía en km (sólo el tramo comprendido dentro de la zona urbana)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_VIASAP', @level2type=N'COLUMN',@level2name=N'LONGITUD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Cantidad de puntos luminosos' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_VIASAP', @level2type=N'COLUMN',@level2name=N'CANTPUNTOSLUMINOSOS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Clase de zona: ST1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_VIASAP', @level2type=N'COLUMN',@level2name=N'CLASEDEZONA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de tipo de vía (ver tabla de códigos)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_VIASAP', @level2type=N'COLUMN',@level2name=N'CODIGOTIPOVIA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de tipo de alumbrado' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_VIASAP', @level2type=N'COLUMN',@level2name=N'CODIGOTIPOALUMB'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Codigo semestre' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_VIASAP', @level2type=N'COLUMN',@level2name=N'SEMESTRE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Código de Cabecera' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SRV_VIASAP', @level2type=N'COLUMN',@level2name=N'ID_CABECERA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "SRV_SUMINMT"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 267
               Right = 290
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LOCALI"
            Begin Extent = 
               Top = 10
               Left = 405
               Bottom = 191
               Right = 586
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "SISTEMAS"
            Begin Extent = 
               Top = 13
               Left = 710
               Bottom = 246
               Right = 888
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Empresa"
            Begin Extent = 
               Top = 192
               Left = 405
               Bottom = 278
               Right = 587
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 36
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 15' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SUMINMT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'00
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 1560
         Table = 2085
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SUMINMT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SUMINMT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 229
               Right = 290
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 6
               Left = 328
               Bottom = 119
               Right = 540
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 6
               Left = 578
               Bottom = 119
               Right = 790
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 2040
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'UBIGEO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'UBIGEO'
GO
