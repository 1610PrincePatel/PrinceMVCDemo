USE [master]
GO
/****** Object:  Database [MegaMindsDB]    Script Date: 06-06-2024 9.27.53 PM ******/
CREATE DATABASE [MegaMindsDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MegaMindsDB', FILENAME = N'C:\Users\admin\MegaMindsDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MegaMindsDB_log', FILENAME = N'C:\Users\admin\MegaMindsDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [MegaMindsDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MegaMindsDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MegaMindsDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MegaMindsDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MegaMindsDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MegaMindsDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MegaMindsDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [MegaMindsDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MegaMindsDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MegaMindsDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MegaMindsDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MegaMindsDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MegaMindsDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MegaMindsDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MegaMindsDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MegaMindsDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MegaMindsDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MegaMindsDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MegaMindsDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MegaMindsDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MegaMindsDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MegaMindsDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MegaMindsDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MegaMindsDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MegaMindsDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MegaMindsDB] SET  MULTI_USER 
GO
ALTER DATABASE [MegaMindsDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MegaMindsDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MegaMindsDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MegaMindsDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MegaMindsDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MegaMindsDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [MegaMindsDB] SET QUERY_STORE = OFF
GO
USE [MegaMindsDB]
GO
/****** Object:  Table [dbo].[City]    Script Date: 06-06-2024 9.27.54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[City](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CityName] [varchar](30) NOT NULL,
	[StateId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[State]    Script Date: 06-06-2024 9.27.54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[State](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StateName] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserDetails]    Script Date: 06-06-2024 9.27.54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserDetails](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](30) NOT NULL,
	[Email] [nvarchar](60) NOT NULL,
	[PhoneNo] [nvarchar](15) NOT NULL,
	[Address] [nvarchar](255) NULL,
	[CityId] [int] NOT NULL,
	[Agree] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[City]  WITH CHECK ADD FOREIGN KEY([StateId])
REFERENCES [dbo].[State] ([Id])
GO
ALTER TABLE [dbo].[UserDetails]  WITH CHECK ADD FOREIGN KEY([CityId])
REFERENCES [dbo].[City] ([Id])
GO
/****** Object:  StoredProcedure [dbo].[DeleteUserDetails]    Script Date: 06-06-2024 9.27.54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteUserDetails]
    @UserID INT
AS
BEGIN
    DELETE FROM UserDetails
    WHERE UserID = @UserID;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetAllCitiesAndStates]    Script Date: 06-06-2024 9.27.54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllCitiesAndStates]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        c.Id AS CityId,
        c.CityName,
        s.Id AS StateId,
        s.StateName
    FROM 
        City c
    INNER JOIN 
        State s ON c.StateId = s.Id;
END
GO
/****** Object:  StoredProcedure [dbo].[GetAllUserDetails]    Script Date: 06-06-2024 9.27.54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllUserDetails]
AS
BEGIN
    SELECT 
        UD.UserID,
        UD.Name,
        UD.Email,
        UD.PhoneNo,
        UD.Address,
        C.CityName,
		S.StateName,
        UD.Agree
    FROM 
        UserDetails UD
    INNER JOIN 
        City AS c  ON UD.CityId = C.Id
	INNER JOIN 
        State AS S ON C.StateId = S.Id;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetUserDetailsById]    Script Date: 06-06-2024 9.27.54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetUserDetailsById]
    @UserID INT
AS
BEGIN
    SELECT 
        UD.UserID,
        UD.Name,
        UD.Email,
        UD.PhoneNo,
        UD.Address,
        C.CityName,
        S.StateName,
		C.Id AS CityId,
		S.Id AS StateId,
        UD.Agree
    FROM 
        UserDetails UD
    INNER JOIN 
        City AS C ON UD.CityId = C.Id
    INNER JOIN 
        State AS S ON C.StateId = S.Id
    WHERE 
        UD.UserID = @UserID;
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertUserDetails]    Script Date: 06-06-2024 9.27.54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertUserDetails]
	@UserID INT,
    @Name VARCHAR(30),
    @Email NVARCHAR(60),
    @PhoneNo NVARCHAR(15),
    @Address NVARCHAR(255),
    @CityId INT,
    @Agree BIT
AS
BEGIN
    INSERT INTO UserDetails (Name, Email, PhoneNo, Address, CityId, Agree)
    VALUES (@Name, @Email, @PhoneNo, @Address, @CityId, @Agree);
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateUserDetails]    Script Date: 06-06-2024 9.27.54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateUserDetails]
    @UserID INT,
    @Name VARCHAR(30),
    @Email NVARCHAR(60),
    @PhoneNo NVARCHAR(15),
    @Address NVARCHAR(255),
    @CityId INT,
    @Agree BIT
AS
BEGIN
    UPDATE UserDetails
    SET 
        Name = @Name,
        Email = @Email,
        PhoneNo = @PhoneNo,
        Address = @Address,
        CityId = @CityId,
        Agree = @Agree
    WHERE 
        UserID = @UserID;
END;
GO
USE [master]
GO
ALTER DATABASE [MegaMindsDB] SET  READ_WRITE 
GO
