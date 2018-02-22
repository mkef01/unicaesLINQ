USE [master]
GO
/****** Object:  Database [biblioteca]    Script Date: 21/02/2018 22:36:07 ******/
CREATE DATABASE [biblioteca]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'biblioteca', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\biblioteca.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'biblioteca_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\biblioteca_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [biblioteca] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [biblioteca].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [biblioteca] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [biblioteca] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [biblioteca] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [biblioteca] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [biblioteca] SET ARITHABORT OFF 
GO
ALTER DATABASE [biblioteca] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [biblioteca] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [biblioteca] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [biblioteca] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [biblioteca] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [biblioteca] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [biblioteca] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [biblioteca] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [biblioteca] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [biblioteca] SET  ENABLE_BROKER 
GO
ALTER DATABASE [biblioteca] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [biblioteca] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [biblioteca] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [biblioteca] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [biblioteca] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [biblioteca] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [biblioteca] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [biblioteca] SET RECOVERY FULL 
GO
ALTER DATABASE [biblioteca] SET  MULTI_USER 
GO
ALTER DATABASE [biblioteca] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [biblioteca] SET DB_CHAINING OFF 
GO
ALTER DATABASE [biblioteca] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [biblioteca] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [biblioteca] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'biblioteca', N'ON'
GO
ALTER DATABASE [biblioteca] SET QUERY_STORE = OFF
GO
USE [biblioteca]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [biblioteca]
GO
/****** Object:  User [POO]    Script Date: 21/02/2018 22:36:07 ******/
CREATE USER [POO] FOR LOGIN [POO] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [POO]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [POO]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [POO]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [POO]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [POO]
GO
ALTER ROLE [db_datareader] ADD MEMBER [POO]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [POO]
GO
ALTER ROLE [db_denydatareader] ADD MEMBER [POO]
GO
ALTER ROLE [db_denydatawriter] ADD MEMBER [POO]
GO
/****** Object:  Table [dbo].[autores]    Script Date: 21/02/2018 22:36:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[autores](
	[codautor] [int] IDENTITY(1,1) NOT NULL,
	[autor] [varchar](50) NULL,
 CONSTRAINT [PK_autores] PRIMARY KEY CLUSTERED 
(
	[codautor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[autorexlibro]    Script Date: 21/02/2018 22:36:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[autorexlibro](
	[codlibro] [int] NULL,
	[codautor] [int] NULL,
	[autorxlibro] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[libros]    Script Date: 21/02/2018 22:36:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[libros](
	[codlibro] [int] IDENTITY(1,1) NOT NULL,
	[titulo] [varchar](150) NULL,
	[codtema] [int] NULL,
	[codeditorial] [int] NULL,
	[codidioma] [int] NULL,
	[precio] [money] NULL,
	[year] [int] NULL,
	[donado] [char](1) NULL,
 CONSTRAINT [PK_libros] PRIMARY KEY CLUSTERED 
(
	[codlibro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VistaxAutores]    Script Date: 21/02/2018 22:36:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[VistaxAutores] as
select top 100 au.autor,lib.titulo from autores au
join autorexlibro axl on au.codautor = axl.codautor
join libros lib on lib.codlibro = axl.codlibro
order by au.autor
GO
/****** Object:  Table [dbo].[alumnos]    Script Date: 21/02/2018 22:36:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[alumnos](
	[codalumno] [varchar](10) NOT NULL,
	[nombre] [varchar](150) NULL,
	[telefono] [varchar](9) NULL,
	[numPrestados] [int] NULL,
 CONSTRAINT [PK_alumnos] PRIMARY KEY CLUSTERED 
(
	[codalumno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[editoriales]    Script Date: 21/02/2018 22:36:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[editoriales](
	[codeditorial] [int] IDENTITY(1,1) NOT NULL,
	[editorial] [varchar](50) NULL,
 CONSTRAINT [PK_editoriales] PRIMARY KEY CLUSTERED 
(
	[codeditorial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ejemplares]    Script Date: 21/02/2018 22:36:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ejemplares](
	[codejemplar] [int] IDENTITY(1,1) NOT NULL,
	[codestado] [int] NULL,
	[codlibro] [int] NULL,
 CONSTRAINT [PK_ejemplares] PRIMARY KEY CLUSTERED 
(
	[codejemplar] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[estados]    Script Date: 21/02/2018 22:36:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[estados](
	[codestado] [int] IDENTITY(1,1) NOT NULL,
	[estado] [varchar](30) NULL,
 CONSTRAINT [PK_estados] PRIMARY KEY CLUSTERED 
(
	[codestado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[idiomas]    Script Date: 21/02/2018 22:36:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[idiomas](
	[codidioma] [int] IDENTITY(1,1) NOT NULL,
	[idioma] [varchar](40) NULL,
 CONSTRAINT [PK_idiomas] PRIMARY KEY CLUSTERED 
(
	[codidioma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[prestamos]    Script Date: 21/02/2018 22:36:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[prestamos](
	[codprestamo] [int] IDENTITY(1,1) NOT NULL,
	[codejemplar] [int] NULL,
	[fechaprestamo] [date] NULL,
	[fechadevolucion] [date] NULL,
	[fecharealdevo] [date] NULL,
	[codalumno] [varchar](10) NULL,
 CONSTRAINT [PK_prestamos] PRIMARY KEY CLUSTERED 
(
	[codprestamo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tematicas]    Script Date: 21/02/2018 22:36:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tematicas](
	[codtema] [int] IDENTITY(1,1) NOT NULL,
	[tema] [varchar](150) NULL,
 CONSTRAINT [PK_temas] PRIMARY KEY CLUSTERED 
(
	[codtema] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[alumnos] ([codalumno], [nombre], [telefono], [numPrestados]) VALUES (N'122311', N'Mario Guzman', N'7190-9844', 2)
GO
INSERT [dbo].[alumnos] ([codalumno], [nombre], [telefono], [numPrestados]) VALUES (N'234324', N'José Guzman', N'7001-4439', 1)
GO
INSERT [dbo].[alumnos] ([codalumno], [nombre], [telefono], [numPrestados]) VALUES (N'234932', N'Claudia Ruíz', N'7701-4554', 1)
GO
INSERT [dbo].[alumnos] ([codalumno], [nombre], [telefono], [numPrestados]) VALUES (N'324311', N'Luis Zepeda', N'7701-9834', 1)
GO
INSERT [dbo].[alumnos] ([codalumno], [nombre], [telefono], [numPrestados]) VALUES (N'787822', N'Luis García', N'7104-3432', 1)
GO
INSERT [dbo].[alumnos] ([codalumno], [nombre], [telefono], [numPrestados]) VALUES (N'892311', N'Ana Toledo', N'7710-4764', 1)
GO
INSERT [dbo].[alumnos] ([codalumno], [nombre], [telefono], [numPrestados]) VALUES (N'893474', N'Ana García', N'7789-3233', 1)
GO
INSERT [dbo].[alumnos] ([codalumno], [nombre], [telefono], [numPrestados]) VALUES (N'897642', N'Juan Mejía', N'7086-4334', 1)
GO
INSERT [dbo].[alumnos] ([codalumno], [nombre], [telefono], [numPrestados]) VALUES (N'988311', N'Julia Toledo', N'7101-4863', 1)
GO
INSERT [dbo].[alumnos] ([codalumno], [nombre], [telefono], [numPrestados]) VALUES (N'989032', N'José Castro', N'7102-4555', 1)
GO
SET IDENTITY_INSERT [dbo].[autores] ON 
GO
INSERT [dbo].[autores] ([codautor], [autor]) VALUES (1, N'Enrique Palacios')
GO
INSERT [dbo].[autores] ([codautor], [autor]) VALUES (2, N'Fernando Remiro')
GO
INSERT [dbo].[autores] ([codautor], [autor]) VALUES (3, N'Lucas J. López')
GO
INSERT [dbo].[autores] ([codautor], [autor]) VALUES (4, N'Osvaldo Cairó')
GO
INSERT [dbo].[autores] ([codautor], [autor]) VALUES (5, N'Silva Guardati')
GO
INSERT [dbo].[autores] ([codautor], [autor]) VALUES (6, N'Victor P. Nelson')
GO
INSERT [dbo].[autores] ([codautor], [autor]) VALUES (7, N'Troy Nagle')
GO
INSERT [dbo].[autores] ([codautor], [autor]) VALUES (8, N'Bill D. Carroll')
GO
INSERT [dbo].[autores] ([codautor], [autor]) VALUES (9, N'J. David Irwin')
GO
INSERT [dbo].[autores] ([codautor], [autor]) VALUES (10, N'Grady Booch')
GO
INSERT [dbo].[autores] ([codautor], [autor]) VALUES (11, N'Morris Mano')
GO
SET IDENTITY_INSERT [dbo].[autores] OFF
GO
SET IDENTITY_INSERT [dbo].[autorexlibro] ON 
GO
INSERT [dbo].[autorexlibro] ([codlibro], [codautor], [autorxlibro]) VALUES (1, 10, 1)
GO
INSERT [dbo].[autorexlibro] ([codlibro], [codautor], [autorxlibro]) VALUES (2, 6, 2)
GO
INSERT [dbo].[autorexlibro] ([codlibro], [codautor], [autorxlibro]) VALUES (2, 7, 3)
GO
INSERT [dbo].[autorexlibro] ([codlibro], [codautor], [autorxlibro]) VALUES (2, 8, 4)
GO
INSERT [dbo].[autorexlibro] ([codlibro], [codautor], [autorxlibro]) VALUES (2, 9, 5)
GO
INSERT [dbo].[autorexlibro] ([codlibro], [codautor], [autorxlibro]) VALUES (3, 4, 6)
GO
INSERT [dbo].[autorexlibro] ([codlibro], [codautor], [autorxlibro]) VALUES (3, 5, 7)
GO
INSERT [dbo].[autorexlibro] ([codlibro], [codautor], [autorxlibro]) VALUES (4, 1, 8)
GO
INSERT [dbo].[autorexlibro] ([codlibro], [codautor], [autorxlibro]) VALUES (4, 2, 9)
GO
INSERT [dbo].[autorexlibro] ([codlibro], [codautor], [autorxlibro]) VALUES (4, 3, 10)
GO
INSERT [dbo].[autorexlibro] ([codlibro], [codautor], [autorxlibro]) VALUES (5, 11, 11)
GO
INSERT [dbo].[autorexlibro] ([codlibro], [codautor], [autorxlibro]) VALUES (9, 6, 13)
GO
INSERT [dbo].[autorexlibro] ([codlibro], [codautor], [autorxlibro]) VALUES (10, 11, 14)
GO
INSERT [dbo].[autorexlibro] ([codlibro], [codautor], [autorxlibro]) VALUES (11, 1, 15)
GO
INSERT [dbo].[autorexlibro] ([codlibro], [codautor], [autorxlibro]) VALUES (12, 2, 16)
GO
INSERT [dbo].[autorexlibro] ([codlibro], [codautor], [autorxlibro]) VALUES (13, 8, 17)
GO
INSERT [dbo].[autorexlibro] ([codlibro], [codautor], [autorxlibro]) VALUES (14, 10, 18)
GO
INSERT [dbo].[autorexlibro] ([codlibro], [codautor], [autorxlibro]) VALUES (15, 9, 19)
GO
INSERT [dbo].[autorexlibro] ([codlibro], [codautor], [autorxlibro]) VALUES (18, 11, 22)
GO
INSERT [dbo].[autorexlibro] ([codlibro], [codautor], [autorxlibro]) VALUES (16, 9, 20)
GO
INSERT [dbo].[autorexlibro] ([codlibro], [codautor], [autorxlibro]) VALUES (17, 7, 21)
GO
SET IDENTITY_INSERT [dbo].[autorexlibro] OFF
GO
SET IDENTITY_INSERT [dbo].[editoriales] ON 
GO
INSERT [dbo].[editoriales] ([codeditorial], [editorial]) VALUES (1, N'Pearson')
GO
INSERT [dbo].[editoriales] ([codeditorial], [editorial]) VALUES (2, N'Mc Graw Hill')
GO
INSERT [dbo].[editoriales] ([codeditorial], [editorial]) VALUES (3, N'AlfaOmega')
GO
INSERT [dbo].[editoriales] ([codeditorial], [editorial]) VALUES (4, N'Addison Wesley')
GO
SET IDENTITY_INSERT [dbo].[editoriales] OFF
GO
SET IDENTITY_INSERT [dbo].[ejemplares] ON 
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (1, 3, 1)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (2, 3, 1)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (3, 2, 1)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (4, 3, 1)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (5, 1, 2)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (6, 1, 2)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (7, 1, 2)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (8, 1, 2)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (9, 1, 2)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (10, 3, 3)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (11, 3, 3)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (12, 3, 3)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (13, 1, 4)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (14, 1, 4)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (15, 1, 4)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (16, 1, 4)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (17, 2, 4)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (18, 2, 4)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (19, 2, 4)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (20, 3, 5)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (21, 3, 5)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (22, 3, 5)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (23, 3, 5)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (24, 3, 5)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (25, 3, 5)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (26, 3, 5)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (27, 1, 5)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (28, 1, 5)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (29, 1, 5)
GO
INSERT [dbo].[ejemplares] ([codejemplar], [codestado], [codlibro]) VALUES (30, 1, 5)
GO
SET IDENTITY_INSERT [dbo].[ejemplares] OFF
GO
SET IDENTITY_INSERT [dbo].[estados] ON 
GO
INSERT [dbo].[estados] ([codestado], [estado]) VALUES (1, N'Disponible')
GO
INSERT [dbo].[estados] ([codestado], [estado]) VALUES (2, N'Reservado')
GO
INSERT [dbo].[estados] ([codestado], [estado]) VALUES (3, N'Prestado')
GO
SET IDENTITY_INSERT [dbo].[estados] OFF
GO
SET IDENTITY_INSERT [dbo].[idiomas] ON 
GO
INSERT [dbo].[idiomas] ([codidioma], [idioma]) VALUES (1, N'Español')
GO
INSERT [dbo].[idiomas] ([codidioma], [idioma]) VALUES (2, N'Inglés')
GO
INSERT [dbo].[idiomas] ([codidioma], [idioma]) VALUES (3, N'Portugués')
GO
INSERT [dbo].[idiomas] ([codidioma], [idioma]) VALUES (4, N'Italiano')
GO
INSERT [dbo].[idiomas] ([codidioma], [idioma]) VALUES (5, N'Alemán')
GO
SET IDENTITY_INSERT [dbo].[idiomas] OFF
GO
SET IDENTITY_INSERT [dbo].[libros] ON 
GO
INSERT [dbo].[libros] ([codlibro], [titulo], [codtema], [codeditorial], [codidioma], [precio], [year], [donado]) VALUES (1, N'Análisis y Diseño Orientado a Objetos con aplicaciones', 14, 4, 1, 45.0000, 2013, N'N')
GO
INSERT [dbo].[libros] ([codlibro], [titulo], [codtema], [codeditorial], [codidioma], [precio], [year], [donado]) VALUES (2, N'Análisis y Diseño de Circuitos Lógicos Digitales', 13, 1, 1, 57.0000, 2014, N'N')
GO
INSERT [dbo].[libros] ([codlibro], [titulo], [codtema], [codeditorial], [codidioma], [precio], [year], [donado]) VALUES (3, N'Estructura de datos', 12, 2, 1, 60.0000, 2012, N'N')
GO
INSERT [dbo].[libros] ([codlibro], [titulo], [codtema], [codeditorial], [codidioma], [precio], [year], [donado]) VALUES (4, N'Microcontrolador PIC16F84', 13, 3, 2, 57.1500, 2010, N'S')
GO
INSERT [dbo].[libros] ([codlibro], [titulo], [codtema], [codeditorial], [codidioma], [precio], [year], [donado]) VALUES (5, N'Digital circuit design', 13, 1, 2, 65.0000, 2009, N'S')
GO
INSERT [dbo].[libros] ([codlibro], [titulo], [codtema], [codeditorial], [codidioma], [precio], [year], [donado]) VALUES (7, N'Redes CISCO', 10, 3, 1, 25.0000, 2016, N'S')
GO
INSERT [dbo].[libros] ([codlibro], [titulo], [codtema], [codeditorial], [codidioma], [precio], [year], [donado]) VALUES (8, N'C#', 14, 1, 2, 150.5000, 2010, N' ')
GO
INSERT [dbo].[libros] ([codlibro], [titulo], [codtema], [codeditorial], [codidioma], [precio], [year], [donado]) VALUES (9, N'C++', 14, 4, 5, 500.5500, 2016, N'N')
GO
INSERT [dbo].[libros] ([codlibro], [titulo], [codtema], [codeditorial], [codidioma], [precio], [year], [donado]) VALUES (10, N'Circuitos Lógicos y Matemáticos', 13, 2, 1, 15.3000, 1999, N'S')
GO
INSERT [dbo].[libros] ([codlibro], [titulo], [codtema], [codeditorial], [codidioma], [precio], [year], [donado]) VALUES (11, N'VB.NET 6', 14, 2, 1, 25.3500, 1998, N'S')
GO
INSERT [dbo].[libros] ([codlibro], [titulo], [codtema], [codeditorial], [codidioma], [precio], [year], [donado]) VALUES (12, N'Linux Servers', 11, 2, 1, 225.9900, 2010, N'S')
GO
INSERT [dbo].[libros] ([codlibro], [titulo], [codtema], [codeditorial], [codidioma], [precio], [year], [donado]) VALUES (13, N'Windows Servers', 11, 1, 4, 5.5000, 1990, N'S')
GO
INSERT [dbo].[libros] ([codlibro], [titulo], [codtema], [codeditorial], [codidioma], [precio], [year], [donado]) VALUES (14, N'Solaris server', 11, 2, 2, 150.6000, 2015, N'N')
GO
INSERT [dbo].[libros] ([codlibro], [titulo], [codtema], [codeditorial], [codidioma], [precio], [year], [donado]) VALUES (15, N'JAVA', 14, 3, 1, 50.0000, 1999, N'S')
GO
INSERT [dbo].[libros] ([codlibro], [titulo], [codtema], [codeditorial], [codidioma], [precio], [year], [donado]) VALUES (16, N'C', 14, 4, 1, 55.2500, 1990, N'S')
GO
INSERT [dbo].[libros] ([codlibro], [titulo], [codtema], [codeditorial], [codidioma], [precio], [year], [donado]) VALUES (17, N'GO by GOOGLE', 14, 3, 2, 150.5500, 2017, N'S')
GO
INSERT [dbo].[libros] ([codlibro], [titulo], [codtema], [codeditorial], [codidioma], [precio], [year], [donado]) VALUES (18, N'Seguridad COBIT', 9, 3, 4, 240.3600, 1999, N'S')
GO
SET IDENTITY_INSERT [dbo].[libros] OFF
GO
SET IDENTITY_INSERT [dbo].[prestamos] ON 
GO
INSERT [dbo].[prestamos] ([codprestamo], [codejemplar], [fechaprestamo], [fechadevolucion], [fecharealdevo], [codalumno]) VALUES (1, 1, CAST(N'2016-10-01' AS Date), CAST(N'2016-10-03' AS Date), CAST(N'2016-10-02' AS Date), N'122311')
GO
INSERT [dbo].[prestamos] ([codprestamo], [codejemplar], [fechaprestamo], [fechadevolucion], [fecharealdevo], [codalumno]) VALUES (2, 4, CAST(N'2016-10-01' AS Date), CAST(N'2016-10-03' AS Date), CAST(N'2016-10-04' AS Date), N'122311')
GO
INSERT [dbo].[prestamos] ([codprestamo], [codejemplar], [fechaprestamo], [fechadevolucion], [fecharealdevo], [codalumno]) VALUES (3, 5, CAST(N'2016-10-01' AS Date), CAST(N'2016-10-03' AS Date), CAST(N'2016-10-02' AS Date), N'892311')
GO
INSERT [dbo].[prestamos] ([codprestamo], [codejemplar], [fechaprestamo], [fechadevolucion], [fecharealdevo], [codalumno]) VALUES (4, 6, CAST(N'2016-10-02' AS Date), CAST(N'2016-10-04' AS Date), CAST(N'2016-10-03' AS Date), N'892311')
GO
INSERT [dbo].[prestamos] ([codprestamo], [codejemplar], [fechaprestamo], [fechadevolucion], [fecharealdevo], [codalumno]) VALUES (5, 7, CAST(N'2016-10-02' AS Date), CAST(N'2016-10-04' AS Date), CAST(N'2016-10-05' AS Date), N'892311')
GO
INSERT [dbo].[prestamos] ([codprestamo], [codejemplar], [fechaprestamo], [fechadevolucion], [fecharealdevo], [codalumno]) VALUES (6, 8, CAST(N'2016-10-02' AS Date), CAST(N'2016-10-04' AS Date), CAST(N'2016-10-03' AS Date), N'324311')
GO
INSERT [dbo].[prestamos] ([codprestamo], [codejemplar], [fechaprestamo], [fechadevolucion], [fecharealdevo], [codalumno]) VALUES (7, 11, CAST(N'2016-10-02' AS Date), CAST(N'2016-10-04' AS Date), CAST(N'2016-10-03' AS Date), N'988311')
GO
INSERT [dbo].[prestamos] ([codprestamo], [codejemplar], [fechaprestamo], [fechadevolucion], [fecharealdevo], [codalumno]) VALUES (8, 15, CAST(N'2016-10-02' AS Date), CAST(N'2016-10-04' AS Date), CAST(N'2016-10-03' AS Date), N'988311')
GO
INSERT [dbo].[prestamos] ([codprestamo], [codejemplar], [fechaprestamo], [fechadevolucion], [fecharealdevo], [codalumno]) VALUES (9, 16, CAST(N'2016-10-03' AS Date), CAST(N'2016-10-05' AS Date), CAST(N'2016-10-04' AS Date), N'892311')
GO
INSERT [dbo].[prestamos] ([codprestamo], [codejemplar], [fechaprestamo], [fechadevolucion], [fecharealdevo], [codalumno]) VALUES (10, 22, CAST(N'2016-10-03' AS Date), CAST(N'2016-10-05' AS Date), CAST(N'2016-10-07' AS Date), N'324311')
GO
INSERT [dbo].[prestamos] ([codprestamo], [codejemplar], [fechaprestamo], [fechadevolucion], [fecharealdevo], [codalumno]) VALUES (11, 24, CAST(N'2016-10-06' AS Date), CAST(N'2016-10-08' AS Date), CAST(N'2016-10-07' AS Date), N'892311')
GO
INSERT [dbo].[prestamos] ([codprestamo], [codejemplar], [fechaprestamo], [fechadevolucion], [fecharealdevo], [codalumno]) VALUES (12, 30, CAST(N'2016-10-03' AS Date), CAST(N'2016-10-05' AS Date), CAST(N'2016-10-04' AS Date), N'324311')
GO
INSERT [dbo].[prestamos] ([codprestamo], [codejemplar], [fechaprestamo], [fechadevolucion], [fecharealdevo], [codalumno]) VALUES (13, 10, CAST(N'2016-10-03' AS Date), CAST(N'2016-10-05' AS Date), CAST(N'2016-10-04' AS Date), N'988311')
GO
INSERT [dbo].[prestamos] ([codprestamo], [codejemplar], [fechaprestamo], [fechadevolucion], [fecharealdevo], [codalumno]) VALUES (14, 4, CAST(N'2016-10-05' AS Date), CAST(N'2016-10-07' AS Date), CAST(N'2016-10-06' AS Date), N'988311')
GO
INSERT [dbo].[prestamos] ([codprestamo], [codejemplar], [fechaprestamo], [fechadevolucion], [fecharealdevo], [codalumno]) VALUES (15, 4, CAST(N'2016-10-04' AS Date), CAST(N'2016-10-06' AS Date), CAST(N'2016-10-09' AS Date), N'988311')
GO
INSERT [dbo].[prestamos] ([codprestamo], [codejemplar], [fechaprestamo], [fechadevolucion], [fecharealdevo], [codalumno]) VALUES (16, 10, CAST(N'2016-10-04' AS Date), CAST(N'2016-10-06' AS Date), CAST(N'2016-10-05' AS Date), N'892311')
GO
INSERT [dbo].[prestamos] ([codprestamo], [codejemplar], [fechaprestamo], [fechadevolucion], [fecharealdevo], [codalumno]) VALUES (17, 10, CAST(N'2016-10-04' AS Date), CAST(N'2016-10-06' AS Date), CAST(N'2016-10-05' AS Date), N'892311')
GO
INSERT [dbo].[prestamos] ([codprestamo], [codejemplar], [fechaprestamo], [fechadevolucion], [fecharealdevo], [codalumno]) VALUES (18, 11, CAST(N'2016-10-04' AS Date), CAST(N'2016-10-06' AS Date), CAST(N'2016-10-12' AS Date), N'892311')
GO
INSERT [dbo].[prestamos] ([codprestamo], [codejemplar], [fechaprestamo], [fechadevolucion], [fecharealdevo], [codalumno]) VALUES (19, 11, CAST(N'2016-10-04' AS Date), CAST(N'2016-10-06' AS Date), CAST(N'2016-10-05' AS Date), N'892311')
GO
INSERT [dbo].[prestamos] ([codprestamo], [codejemplar], [fechaprestamo], [fechadevolucion], [fecharealdevo], [codalumno]) VALUES (20, 11, CAST(N'2016-10-04' AS Date), CAST(N'2016-10-06' AS Date), CAST(N'2016-10-05' AS Date), N'892311')
GO
INSERT [dbo].[prestamos] ([codprestamo], [codejemplar], [fechaprestamo], [fechadevolucion], [fecharealdevo], [codalumno]) VALUES (21, 1, CAST(N'2016-10-21' AS Date), NULL, NULL, N'122311')
GO
INSERT [dbo].[prestamos] ([codprestamo], [codejemplar], [fechaprestamo], [fechadevolucion], [fecharealdevo], [codalumno]) VALUES (22, 2, CAST(N'2016-10-21' AS Date), NULL, NULL, N'122311')
GO
SET IDENTITY_INSERT [dbo].[prestamos] OFF
GO
SET IDENTITY_INSERT [dbo].[tematicas] ON 
GO
INSERT [dbo].[tematicas] ([codtema], [tema]) VALUES (1, N'Informática')
GO
INSERT [dbo].[tematicas] ([codtema], [tema]) VALUES (2, N'Matemática')
GO
INSERT [dbo].[tematicas] ([codtema], [tema]) VALUES (3, N'Sociales')
GO
INSERT [dbo].[tematicas] ([codtema], [tema]) VALUES (4, N'Estadística')
GO
INSERT [dbo].[tematicas] ([codtema], [tema]) VALUES (5, N'Salud')
GO
INSERT [dbo].[tematicas] ([codtema], [tema]) VALUES (6, N'Ciencias Jurídicas')
GO
INSERT [dbo].[tematicas] ([codtema], [tema]) VALUES (7, N'Robótica')
GO
INSERT [dbo].[tematicas] ([codtema], [tema]) VALUES (8, N'Administración de empresas')
GO
INSERT [dbo].[tematicas] ([codtema], [tema]) VALUES (9, N'Auditoría de sistemas')
GO
INSERT [dbo].[tematicas] ([codtema], [tema]) VALUES (10, N'Redes informáticas')
GO
INSERT [dbo].[tematicas] ([codtema], [tema]) VALUES (11, N'Sistemas operativos')
GO
INSERT [dbo].[tematicas] ([codtema], [tema]) VALUES (12, N'Bases de datos')
GO
INSERT [dbo].[tematicas] ([codtema], [tema]) VALUES (13, N'Electrónica')
GO
INSERT [dbo].[tematicas] ([codtema], [tema]) VALUES (14, N'Programación')
GO
SET IDENTITY_INSERT [dbo].[tematicas] OFF
GO
ALTER TABLE [dbo].[libros] ADD  CONSTRAINT [DF_libros_donado]  DEFAULT ((0)) FOR [donado]
GO
ALTER TABLE [dbo].[autorexlibro]  WITH CHECK ADD  CONSTRAINT [FK_autorexlibro_autores] FOREIGN KEY([codautor])
REFERENCES [dbo].[autores] ([codautor])
GO
ALTER TABLE [dbo].[autorexlibro] CHECK CONSTRAINT [FK_autorexlibro_autores]
GO
ALTER TABLE [dbo].[autorexlibro]  WITH CHECK ADD  CONSTRAINT [FK_autorexlibro_libros] FOREIGN KEY([codlibro])
REFERENCES [dbo].[libros] ([codlibro])
GO
ALTER TABLE [dbo].[autorexlibro] CHECK CONSTRAINT [FK_autorexlibro_libros]
GO
ALTER TABLE [dbo].[ejemplares]  WITH CHECK ADD  CONSTRAINT [FK_ejemplares_estados] FOREIGN KEY([codestado])
REFERENCES [dbo].[estados] ([codestado])
GO
ALTER TABLE [dbo].[ejemplares] CHECK CONSTRAINT [FK_ejemplares_estados]
GO
ALTER TABLE [dbo].[ejemplares]  WITH CHECK ADD  CONSTRAINT [FK_ejemplares_libros] FOREIGN KEY([codlibro])
REFERENCES [dbo].[libros] ([codlibro])
GO
ALTER TABLE [dbo].[ejemplares] CHECK CONSTRAINT [FK_ejemplares_libros]
GO
ALTER TABLE [dbo].[libros]  WITH CHECK ADD  CONSTRAINT [FK_libros_editoriales] FOREIGN KEY([codeditorial])
REFERENCES [dbo].[editoriales] ([codeditorial])
GO
ALTER TABLE [dbo].[libros] CHECK CONSTRAINT [FK_libros_editoriales]
GO
ALTER TABLE [dbo].[libros]  WITH CHECK ADD  CONSTRAINT [FK_libros_idiomas] FOREIGN KEY([codidioma])
REFERENCES [dbo].[idiomas] ([codidioma])
GO
ALTER TABLE [dbo].[libros] CHECK CONSTRAINT [FK_libros_idiomas]
GO
ALTER TABLE [dbo].[libros]  WITH CHECK ADD  CONSTRAINT [FK_libros_temas] FOREIGN KEY([codtema])
REFERENCES [dbo].[tematicas] ([codtema])
GO
ALTER TABLE [dbo].[libros] CHECK CONSTRAINT [FK_libros_temas]
GO
ALTER TABLE [dbo].[prestamos]  WITH CHECK ADD  CONSTRAINT [FK_prestamos_alumnos] FOREIGN KEY([codalumno])
REFERENCES [dbo].[alumnos] ([codalumno])
GO
ALTER TABLE [dbo].[prestamos] CHECK CONSTRAINT [FK_prestamos_alumnos]
GO
ALTER TABLE [dbo].[prestamos]  WITH CHECK ADD  CONSTRAINT [FK_prestamos_ejemplares] FOREIGN KEY([codejemplar])
REFERENCES [dbo].[ejemplares] ([codejemplar])
GO
ALTER TABLE [dbo].[prestamos] CHECK CONSTRAINT [FK_prestamos_ejemplares]
GO
/****** Object:  StoredProcedure [dbo].[aloha]    Script Date: 21/02/2018 22:36:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[insertarAutorxLibro]    Script Date: 21/02/2018 22:36:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[insertarAutorxLibro] @libro int, @autor int as insert into autorexlibro(codlibro,codautor) values (@libro,@autor)
GO
USE [master]
GO
ALTER DATABASE [biblioteca] SET  READ_WRITE 
GO
