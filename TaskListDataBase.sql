USE [master]
GO
/****** Object:  Database [TaskList]    Script Date: 7/4/2023 2:36:14 PM ******/
CREATE DATABASE [TaskList]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TaskList', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\TaskList.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TaskList_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\TaskList_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [TaskList] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TaskList].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TaskList] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TaskList] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TaskList] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TaskList] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TaskList] SET ARITHABORT OFF 
GO
ALTER DATABASE [TaskList] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [TaskList] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TaskList] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TaskList] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TaskList] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TaskList] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TaskList] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TaskList] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TaskList] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TaskList] SET  ENABLE_BROKER 
GO
ALTER DATABASE [TaskList] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TaskList] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TaskList] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TaskList] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TaskList] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TaskList] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TaskList] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TaskList] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TaskList] SET  MULTI_USER 
GO
ALTER DATABASE [TaskList] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TaskList] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TaskList] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TaskList] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TaskList] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TaskList] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [TaskList] SET QUERY_STORE = ON
GO
ALTER DATABASE [TaskList] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [TaskList]
GO
/****** Object:  Table [dbo].[Attachment]    Script Date: 7/4/2023 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attachment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TaskId] [int] NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[Path] [nvarchar](4000) NOT NULL,
 CONSTRAINT [PK_Attachment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 7/4/2023 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TaskId] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[CommentText] [nvarchar](4000) NOT NULL,
	[Date] [datetime] NOT NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 7/4/2023 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Surname] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Patronymic] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Observer]    Script Date: 7/4/2023 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Observer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TaskId] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
 CONSTRAINT [PK_Observer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Project]    Script Date: 7/4/2023 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Project](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FullTitle] [nvarchar](100) NOT NULL,
	[Icon] [nvarchar](2) NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[DeletedTime] [datetime] NOT NULL,
	[StartScheduledDate] [datetime] NOT NULL,
	[FinishScheduledDate] [datetime] NOT NULL,
	[Description] [nvarchar](4000) NOT NULL,
	[CreatorEmployeeId] [int] NOT NULL,
	[ResponsibleEmplyeeId] [int] NOT NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Task]    Script Date: 7/4/2023 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FullTitle] [nvarchar](100) NOT NULL,
	[ShortTitle] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](4000) NOT NULL,
	[ExecutiveEmployeeId] [int] NOT NULL,
	[StatusId] [int] NOT NULL,
	[CreatedTime] [datetime] NOT NULL,
	[UpdatedTime] [datetime] NOT NULL,
	[DeletedTime] [datetime] NOT NULL,
	[Deadline] [datetime] NOT NULL,
	[StartActualTime] [datetime] NOT NULL,
	[FinishActualTime] [datetime] NOT NULL,
	[PreviousTaskId] [int] NULL,
	[ProjectId] [int] NOT NULL,
 CONSTRAINT [PK_Task] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaskStatus]    Script Date: 7/4/2023 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[ColorHex] [nvarchar](50) NULL,
 CONSTRAINT [PK_TaskStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UpdateStatus]    Script Date: 7/4/2023 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UpdateStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TaskId] [int] NOT NULL,
	[StatusId] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
 CONSTRAINT [PK_UpdateStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([Id], [Surname], [Name], [Patronymic]) VALUES (1, N'Манаков', N'Арсений', N'Игоревич')
INSERT [dbo].[Employee] ([Id], [Surname], [Name], [Patronymic]) VALUES (2, N'Шпалитов', N'Аскар', N'Эдуардович')
INSERT [dbo].[Employee] ([Id], [Surname], [Name], [Patronymic]) VALUES (3, N'Куликов', N'Дмитрий ', N'Николаевич')
INSERT [dbo].[Employee] ([Id], [Surname], [Name], [Patronymic]) VALUES (4, N'Осипов', N'Кирилл', N'Андреевич')
INSERT [dbo].[Employee] ([Id], [Surname], [Name], [Patronymic]) VALUES (5, N'Дмитриев', N'Егор ', N'Павлович')
INSERT [dbo].[Employee] ([Id], [Surname], [Name], [Patronymic]) VALUES (6, N'Юсупов', N'Инсаф', N'Алмасович')
INSERT [dbo].[Employee] ([Id], [Surname], [Name], [Patronymic]) VALUES (7, N'Кириенко', N'Виталий', N'Сергеевич')
INSERT [dbo].[Employee] ([Id], [Surname], [Name], [Patronymic]) VALUES (8, N'Лапенко', N'Анатолий', N'Владимирович')
INSERT [dbo].[Employee] ([Id], [Surname], [Name], [Patronymic]) VALUES (9, N'Бобров', N'Андрей', N'Евгеньевич')
INSERT [dbo].[Employee] ([Id], [Surname], [Name], [Patronymic]) VALUES (10, N'Мирный', N'Камиль', N'Маратович')
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
SET IDENTITY_INSERT [dbo].[Project] ON 

INSERT [dbo].[Project] ([Id], [FullTitle], [Icon], [CreatedTime], [DeletedTime], [StartScheduledDate], [FinishScheduledDate], [Description], [CreatorEmployeeId], [ResponsibleEmplyeeId]) VALUES (1, N'Сделать сессию 1', N'CC', CAST(N'2023-06-26T18:17:00.000' AS DateTime), CAST(N'2023-07-07T18:17:00.000' AS DateTime), CAST(N'2023-06-26T18:17:00.000' AS DateTime), CAST(N'2023-07-07T18:17:00.000' AS DateTime), N'Подготовиться к чемпионату', 1, 2)
INSERT [dbo].[Project] ([Id], [FullTitle], [Icon], [CreatedTime], [DeletedTime], [StartScheduledDate], [FinishScheduledDate], [Description], [CreatorEmployeeId], [ResponsibleEmplyeeId]) VALUES (2, N'2', N'2', CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-07-07T18:17:00.000' AS DateTime), CAST(N'2023-06-26T18:17:00.000' AS DateTime), CAST(N'2023-07-07T18:17:00.000' AS DateTime), N'Подготовиться к чемпионату', 2, 1)
SET IDENTITY_INSERT [dbo].[Project] OFF
GO
SET IDENTITY_INSERT [dbo].[Task] ON 

INSERT [dbo].[Task] ([Id], [FullTitle], [ShortTitle], [Description], [ExecutiveEmployeeId], [StatusId], [CreatedTime], [UpdatedTime], [DeletedTime], [Deadline], [StartActualTime], [FinishActualTime], [PreviousTaskId], [ProjectId]) VALUES (3, N'1', N'1', N'1', 1, 1, CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), NULL, 2)
INSERT [dbo].[Task] ([Id], [FullTitle], [ShortTitle], [Description], [ExecutiveEmployeeId], [StatusId], [CreatedTime], [UpdatedTime], [DeletedTime], [Deadline], [StartActualTime], [FinishActualTime], [PreviousTaskId], [ProjectId]) VALUES (4, N'2', N'2', N'1', 1, 1, CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), 3, 2)
INSERT [dbo].[Task] ([Id], [FullTitle], [ShortTitle], [Description], [ExecutiveEmployeeId], [StatusId], [CreatedTime], [UpdatedTime], [DeletedTime], [Deadline], [StartActualTime], [FinishActualTime], [PreviousTaskId], [ProjectId]) VALUES (5, N'7', N'7', N'1', 1, 1, CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), 4, 2)
INSERT [dbo].[Task] ([Id], [FullTitle], [ShortTitle], [Description], [ExecutiveEmployeeId], [StatusId], [CreatedTime], [UpdatedTime], [DeletedTime], [Deadline], [StartActualTime], [FinishActualTime], [PreviousTaskId], [ProjectId]) VALUES (6, N'8', N'8', N'1', 1, 3, CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), 5, 2)
INSERT [dbo].[Task] ([Id], [FullTitle], [ShortTitle], [Description], [ExecutiveEmployeeId], [StatusId], [CreatedTime], [UpdatedTime], [DeletedTime], [Deadline], [StartActualTime], [FinishActualTime], [PreviousTaskId], [ProjectId]) VALUES (7, N'3', N'3', N'1', 2, 2, CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-07-07T00:00:00.000' AS DateTime), 4, 2)
INSERT [dbo].[Task] ([Id], [FullTitle], [ShortTitle], [Description], [ExecutiveEmployeeId], [StatusId], [CreatedTime], [UpdatedTime], [DeletedTime], [Deadline], [StartActualTime], [FinishActualTime], [PreviousTaskId], [ProjectId]) VALUES (8, N'4', N'4', N'1', 3, 2, CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-07-10T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), NULL, 2)
INSERT [dbo].[Task] ([Id], [FullTitle], [ShortTitle], [Description], [ExecutiveEmployeeId], [StatusId], [CreatedTime], [UpdatedTime], [DeletedTime], [Deadline], [StartActualTime], [FinishActualTime], [PreviousTaskId], [ProjectId]) VALUES (9, N'5', N'5', N'1', 2, 3, CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), NULL, 2)
INSERT [dbo].[Task] ([Id], [FullTitle], [ShortTitle], [Description], [ExecutiveEmployeeId], [StatusId], [CreatedTime], [UpdatedTime], [DeletedTime], [Deadline], [StartActualTime], [FinishActualTime], [PreviousTaskId], [ProjectId]) VALUES (10, N'6', N'6', N'1', 4, 1, CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-07-05T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), CAST(N'2023-06-29T00:00:00.000' AS DateTime), NULL, 2)
SET IDENTITY_INSERT [dbo].[Task] OFF
GO
SET IDENTITY_INSERT [dbo].[TaskStatus] ON 

INSERT [dbo].[TaskStatus] ([Id], [Name], [ColorHex]) VALUES (1, N'В работе', NULL)
INSERT [dbo].[TaskStatus] ([Id], [Name], [ColorHex]) VALUES (2, N'Открыта', NULL)
INSERT [dbo].[TaskStatus] ([Id], [Name], [ColorHex]) VALUES (3, N'Завершена', NULL)
SET IDENTITY_INSERT [dbo].[TaskStatus] OFF
GO
ALTER TABLE [dbo].[Attachment]  WITH CHECK ADD  CONSTRAINT [FK_Attachment_Task] FOREIGN KEY([TaskId])
REFERENCES [dbo].[Task] ([Id])
GO
ALTER TABLE [dbo].[Attachment] CHECK CONSTRAINT [FK_Attachment_Task]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Employee]
GO
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Task] FOREIGN KEY([TaskId])
REFERENCES [dbo].[Task] ([Id])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Task]
GO
ALTER TABLE [dbo].[Observer]  WITH CHECK ADD  CONSTRAINT [FK_Observer_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[Observer] CHECK CONSTRAINT [FK_Observer_Employee]
GO
ALTER TABLE [dbo].[Observer]  WITH CHECK ADD  CONSTRAINT [FK_Observer_Task] FOREIGN KEY([TaskId])
REFERENCES [dbo].[Task] ([Id])
GO
ALTER TABLE [dbo].[Observer] CHECK CONSTRAINT [FK_Observer_Task]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_Employee] FOREIGN KEY([CreatorEmployeeId])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [FK_Project_Employee]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_Employee1] FOREIGN KEY([ResponsibleEmplyeeId])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [FK_Project_Employee1]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_Employee] FOREIGN KEY([ExecutiveEmployeeId])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_Employee]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_Project] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([Id])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_Project]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_Task] FOREIGN KEY([PreviousTaskId])
REFERENCES [dbo].[Task] ([Id])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_Task]
GO
ALTER TABLE [dbo].[Task]  WITH CHECK ADD  CONSTRAINT [FK_Task_TaskStatus] FOREIGN KEY([StatusId])
REFERENCES [dbo].[TaskStatus] ([Id])
GO
ALTER TABLE [dbo].[Task] CHECK CONSTRAINT [FK_Task_TaskStatus]
GO
ALTER TABLE [dbo].[UpdateStatus]  WITH CHECK ADD  CONSTRAINT [FK_UpdateStatus_Task] FOREIGN KEY([TaskId])
REFERENCES [dbo].[Task] ([Id])
GO
ALTER TABLE [dbo].[UpdateStatus] CHECK CONSTRAINT [FK_UpdateStatus_Task]
GO
ALTER TABLE [dbo].[UpdateStatus]  WITH CHECK ADD  CONSTRAINT [FK_UpdateStatus_TaskStatus] FOREIGN KEY([StatusId])
REFERENCES [dbo].[TaskStatus] ([Id])
GO
ALTER TABLE [dbo].[UpdateStatus] CHECK CONSTRAINT [FK_UpdateStatus_TaskStatus]
GO
USE [master]
GO
ALTER DATABASE [TaskList] SET  READ_WRITE 
GO
