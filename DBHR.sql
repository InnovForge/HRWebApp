USE [master]
--GO
--/****** Object:  Database [HR]    Script Date: 4/1/2017 11:37:19 AM ******/
--CREATE DATABASE [HR]
-- CONTAINMENT = NONE
-- ON  PRIMARY 
--( NAME = N'HR', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\HR.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
-- LOG ON 
--( NAME = N'HR_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\HR_log.ldf' , SIZE = 1088KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
--GO
--ALTER DATABASE [HR] SET COMPATIBILITY_LEVEL = 110
--GO
--IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
--begin
--EXEC [HR].[dbo].[sp_fulltext_database] @action = 'enable'
--end
GO
ALTER DATABASE [HR] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HR] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HR] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HR] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HR] SET ARITHABORT OFF 
GO
ALTER DATABASE [HR] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HR] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [HR] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HR] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HR] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HR] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HR] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HR] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HR] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HR] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HR] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HR] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HR] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HR] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HR] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HR] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HR] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [HR] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HR] SET RECOVERY FULL 
GO
ALTER DATABASE [HR] SET  MULTI_USER 
GO
ALTER DATABASE [HR] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HR] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HR] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HR] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'HR', N'ON'
GO
USE [HR]
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 4/1/2017 11:37:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Benefit_Plans]    Script Date: 4/1/2017 11:37:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Benefit_Plans](
	[Benefit_Plan_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[Plan_Name] [nvarchar](50) NULL,
	[Deductable] [numeric](18, 0) NULL,
	[Percentage_CoPay] [int] NULL,
 CONSTRAINT [PK_dbo.Benefit_Plans] PRIMARY KEY CLUSTERED 
(
	[Benefit_Plan_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Emergency_Contacts]    Script Date: 4/1/2017 11:37:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Emergency_Contacts](
	[Employee_ID] [numeric](18, 0) NOT NULL,
	[Emergency_Contact_Name] [nvarchar](50) NULL,
	[Phone_Number] [nvarchar](50) NULL,
	[Relationship] [nvarchar](50) NULL,
 CONSTRAINT [PK_dbo.Emergency_Contacts] PRIMARY KEY CLUSTERED 
(
	[Employee_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Employment]    Script Date: 4/1/2017 11:37:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employment](
	[Employee_ID] [numeric](18, 0) NOT NULL,
	[Employment_Status] [nvarchar](50) NULL,
	[Hire_Date] [datetime] NULL,
	[Workers_Comp_Code] [nvarchar](50) NULL,
	[Termination_Date] [datetime] NULL,
	[Rehire_Date] [datetime] NULL,
	[Last_Review_Date] [datetime] NULL,
 CONSTRAINT [PK_dbo.Employment] PRIMARY KEY CLUSTERED 
(
	[Employee_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Job_History]    Script Date: 4/1/2017 11:37:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Job_History](
	[ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[Employee_ID] [numeric](18, 0) NOT NULL,
	[Department] [nvarchar](50) NULL,
	[Division] [nvarchar](50) NULL,
	[Start_Date] [datetime] NULL,
	[End_Date] [datetime] NULL,
	[Job_Title] [nvarchar](50) NULL,
	[Supervisor] [numeric](18, 0) NULL,
	[Job_Category] [nvarchar](50) NULL,
	[Location] [nvarchar](50) NULL,
	[Departmen_Code] [numeric](18, 0) NULL,
	[Salary_Type] [numeric](18, 0) NULL,
	[Pay_Period] [nvarchar](50) NULL,
	[Hours_per_Week] [numeric](18, 0) NULL,
	[Hazardous_Training] [bit] NULL,
 CONSTRAINT [PK_dbo.Job_History] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Personal]    Script Date: 4/1/2017 11:37:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personal](
	[Employee_ID] [numeric](18, 0) NOT NULL,
	[First_Name] [nvarchar](50) NULL,
	[Last_Name] [nvarchar](50) NULL,
	[Middle_Initial] [nvarchar](50) NULL,
	[Address1] [nvarchar](50) NULL,
	[Address2] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[Zip] [numeric](18, 0) NULL,
	[Email] [nvarchar](50) NULL,
	[Phone_Number] [nvarchar](50) NULL,
	[Social_Security_Number] [nvarchar](50) NULL,
	[Drivers_License] [nvarchar](50) NULL,
	[Marital_Status] [nvarchar](50) NULL,
	[Gender] [bit] NULL,
	[Shareholder_Status] [bit] NOT NULL,
	[Benefit_Plans] [numeric](18, 0) NULL,
	[Ethnicity] [nvarchar](50) NULL,
 CONSTRAINT [PK_dbo.Personal] PRIMARY KEY CLUSTERED 
(
	[Employee_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Index [IX_Employee_ID]    Script Date: 4/1/2017 11:37:20 AM ******/
CREATE NONCLUSTERED INDEX [IX_Employee_ID] ON [dbo].[Emergency_Contacts]
(
	[Employee_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Employee_ID]    Script Date: 4/1/2017 11:37:20 AM ******/
CREATE NONCLUSTERED INDEX [IX_Employee_ID] ON [dbo].[Employment]
(
	[Employee_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Employee_ID]    Script Date: 4/1/2017 11:37:20 AM ******/
CREATE NONCLUSTERED INDEX [IX_Employee_ID] ON [dbo].[Job_History]
(
	[Employee_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Benefit_Plans]    Script Date: 4/1/2017 11:37:20 AM ******/
CREATE NONCLUSTERED INDEX [IX_Benefit_Plans] ON [dbo].[Personal]
(
	[Benefit_Plans] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Emergency_Contacts]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Emergency_Contacts_dbo.Personal_Employee_ID] FOREIGN KEY([Employee_ID])
REFERENCES [dbo].[Personal] ([Employee_ID])
GO
ALTER TABLE [dbo].[Emergency_Contacts] CHECK CONSTRAINT [FK_dbo.Emergency_Contacts_dbo.Personal_Employee_ID]
GO
ALTER TABLE [dbo].[Employment]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Employment_dbo.Personal_Employee_ID] FOREIGN KEY([Employee_ID])
REFERENCES [dbo].[Personal] ([Employee_ID])
GO
ALTER TABLE [dbo].[Employment] CHECK CONSTRAINT [FK_dbo.Employment_dbo.Personal_Employee_ID]
GO
ALTER TABLE [dbo].[Job_History]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Job_History_dbo.Personal_Employee_ID] FOREIGN KEY([Employee_ID])
REFERENCES [dbo].[Personal] ([Employee_ID])
GO
ALTER TABLE [dbo].[Job_History] CHECK CONSTRAINT [FK_dbo.Job_History_dbo.Personal_Employee_ID]
GO
ALTER TABLE [dbo].[Personal]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Personal_dbo.Benefit_Plans_Benefit_Plans] FOREIGN KEY([Benefit_Plans])
REFERENCES [dbo].[Benefit_Plans] ([Benefit_Plan_ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Personal] CHECK CONSTRAINT [FK_dbo.Personal_dbo.Benefit_Plans_Benefit_Plans]
GO
USE [master]
GO
ALTER DATABASE [HR] SET  READ_WRITE 
GO

--CREATE LOGIN ngtuonghy WITH PASSWORD = '@Ngtuonghy';
--ALTER SERVER ROLE sysadmin ADD MEMBER ngtuonghy;

--SELECT name, type_desc, is_disabled, create_date 
--FROM sys.server_principals
--WHERE type IN ('S', 'U', 'G') -- S: SQL Login, U: Windows User, G: Windows Group
--ORDER BY name;
