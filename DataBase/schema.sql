USE [master]
GO
/****** Object:  Database [HotelBooking]    Script Date: 30/08/2020 8:54:34 SA ******/
CREATE DATABASE [HotelBooking]
GO
ALTER DATABASE [HotelBooking] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HotelBooking].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HotelBooking] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HotelBooking] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HotelBooking] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HotelBooking] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HotelBooking] SET ARITHABORT OFF 
GO
ALTER DATABASE [HotelBooking] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HotelBooking] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HotelBooking] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HotelBooking] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HotelBooking] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HotelBooking] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HotelBooking] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HotelBooking] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HotelBooking] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HotelBooking] SET  ENABLE_BROKER 
GO
ALTER DATABASE [HotelBooking] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HotelBooking] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HotelBooking] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HotelBooking] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HotelBooking] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HotelBooking] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HotelBooking] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HotelBooking] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [HotelBooking] SET  MULTI_USER 
GO
ALTER DATABASE [HotelBooking] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HotelBooking] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HotelBooking] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HotelBooking] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HotelBooking] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HotelBooking] SET QUERY_STORE = OFF
GO
USE [HotelBooking]
GO
/****** Object:  UserDefinedFunction [dbo].[Fn_MinRemain]    Script Date: 30/08/2020 8:54:39 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 17/08/2020
-- Description:	Return min remain of RoomType from @CheckInDate to @CheckOutDate
-- =============================================
CREATE FUNCTION [dbo].[Fn_MinRemain]
(
	@RoomTypeId int,
	@CheckInDate DATE,
	@CheckOutDate DATE
)
RETURNS INT
AS
	BEGIN
	DECLARE @tableDate TABLE (
		Dates DATE
	);
	DECLARE @Counter INT, @TotalCount INT
	SET @Counter = 0
	SET @TotalCount = DateDiff(DD,@CheckInDate,@CheckOutDate)
	DECLARE @DateValue DATETIME
	DECLARE @Result INT
	SET @Result = (SELECT Quantity FROM ROOMTYPE WHERE RoomTypeId = @RoomTypeId)
	WHILE (@Counter < @TotalCount)
	BEGIN
		SET  @DateValue= DATEADD(DD,@Counter,@CheckInDate)
		DECLARE @CurrentRemain INT
		SET @CurrentRemain = (SELECT Quantity FROM ROOMTYPE WHERE RoomTypeId = @RoomTypeId) - (SELECT SUM(RoomQuantity) FROM BOOKINGROOMDETAILS WHERE @DateValue = Date AND RoomTypeId = @RoomTypeId)
		IF (@CurrentRemain < @Result)
		BEGIN
			SET @Result = @CurrentRemain
		END
		SET @Counter = @Counter + 1
	END
	RETURN @Result
END
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](450) NOT NULL,
	[ProviderKey] [nvarchar](450) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[Name] [nvarchar](30) NOT NULL,
	[Avatar] [nvarchar](max) NULL,
	[Gender] [int] NOT NULL,
	[Address] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](450) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BOOKING]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BOOKING](
	[BookingId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[CheckinDate] [datetime] NULL,
	[CheckoutDate] [datetime] NULL,
	[NumberofAdults] [int] NULL,
	[NumberofChildren] [int] NULL,
	[ServiceAmount] [float] NULL,
	[RoomAmount] [float] NULL,
	[IsCanceled] [bit] NOT NULL,
	[CouponId] [int] NULL,
 CONSTRAINT [PK_BOOKING] PRIMARY KEY CLUSTERED 
(
	[BookingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BOOKINGROOMDETAILS]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BOOKINGROOMDETAILS](
	[BookingRoomDetailsId] [int] IDENTITY(1,1) NOT NULL,
	[BookingId] [int] NOT NULL,
	[RoomTypeId] [int] NOT NULL,
	[RoomQuantity] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[RoomPrice] [float] NOT NULL,
 CONSTRAINT [PK_BOOKINGROOMDETAILS] PRIMARY KEY CLUSTERED 
(
	[BookingRoomDetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BOOKINGSERVICEDETAILS]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BOOKINGSERVICEDETAILS](
	[BookingServiceDetailsId] [int] IDENTITY(1,1) NOT NULL,
	[BookingId] [int] NOT NULL,
	[ServiceId] [int] NOT NULL,
	[ServiceQuantity] [int] NOT NULL,
	[ServicePrice] [float] NOT NULL,
 CONSTRAINT [PK_BOOKINGSERVICEDETAILS] PRIMARY KEY CLUSTERED 
(
	[BookingServiceDetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[COUPON]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COUPON](
	[CouponId] [int] IDENTITY(1,1) NOT NULL,
	[CouponCode] [nvarchar](50) NOT NULL,
	[Remain] [int] NOT NULL,
	[Reduction] [float] NOT NULL,
	[EndDate] [date] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_COUPON] PRIMARY KEY CLUSTERED 
(
	[CouponId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CUSTOMER]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUSTOMER](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[PhoneNumber] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_CUSTOMER] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACILITIES]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACILITIES](
	[FacilityId] [int] IDENTITY(1,1) NOT NULL,
	[FacilityName] [nvarchar](50) NOT NULL,
	[FacilityImage] [nvarchar](max) NULL,
 CONSTRAINT [PK_FACILITIES] PRIMARY KEY CLUSTERED 
(
	[FacilityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FACILITIESAPPLY]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FACILITIESAPPLY](
	[FacilitiesApplyId] [int] IDENTITY(1,1) NOT NULL,
	[FacilityId] [int] NOT NULL,
	[RoomTypeId] [int] NOT NULL,
 CONSTRAINT [PK_FACILITIESAPPLY] PRIMARY KEY CLUSTERED 
(
	[FacilitiesApplyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROMOTION]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROMOTION](
	[PromotionId] [int] IDENTITY(1,1) NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[DiscountRates] [float] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[PromotionName] [nvarchar](50) NULL,
 CONSTRAINT [PK_PROMOTION] PRIMARY KEY CLUSTERED 
(
	[PromotionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PROMOTIONAPPLY]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PROMOTIONAPPLY](
	[PromotionApplyId] [int] IDENTITY(1,1) NOT NULL,
	[PromotionId] [int] NOT NULL,
	[RoomTypeId] [int] NOT NULL,
 CONSTRAINT [PK_PROMOTIONAPPLY] PRIMARY KEY CLUSTERED 
(
	[PromotionApplyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ROOM]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROOM](
	[RoomNumber] [int] NOT NULL,
	[RoomTypeId] [int] NOT NULL,
	[IsOccupied] [bit] NOT NULL,
 CONSTRAINT [PK_ROOM] PRIMARY KEY CLUSTERED 
(
	[RoomNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ROOMTYPE]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROOMTYPE](
	[RoomTypeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[DefaultPrice] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[MaxAdult] [int] NOT NULL,
	[MaxChildren] [int] NOT NULL,
	[MaxPeople] [int] NOT NULL,
 CONSTRAINT [PK_ROOMTYPE] PRIMARY KEY CLUSTERED 
(
	[RoomTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ROOMTYPEIMAGES]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROOMTYPEIMAGES](
	[RoomTypeImageId] [int] IDENTITY(1,1) NOT NULL,
	[ImageData] [nvarchar](max) NOT NULL,
	[RoomTypeId] [int] NOT NULL,
 CONSTRAINT [PK_ROOMTYPEIMAGES] PRIMARY KEY CLUSTERED 
(
	[RoomTypeImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SERVICE]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SERVICE](
	[ServiceId] [int] IDENTITY(1,1) NOT NULL,
	[ServiceName] [nvarchar](50) NOT NULL,
	[Price] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_SERVICE] PRIMARY KEY CLUSTERED 
(
	[ServiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SERVICEIMAGES]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SERVICEIMAGES](
	[ServiceImageId] [int] IDENTITY(1,1) NOT NULL,
	[ImageData] [nvarchar](max) NOT NULL,
	[ServiceId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ServiceImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetRoleClaims_RoleId]    Script Date: 30/08/2020 8:54:40 SA ******/
CREATE NONCLUSTERED INDEX [IX_AspNetRoleClaims_RoleId] ON [dbo].[AspNetRoleClaims]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 30/08/2020 8:54:40 SA ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserClaims_UserId]    Script Date: 30/08/2020 8:54:40 SA ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserClaims_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserLogins_UserId]    Script Date: 30/08/2020 8:54:40 SA ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserLogins_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserRoles_RoleId]    Script Date: 30/08/2020 8:54:40 SA ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserRoles_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [EmailIndex]    Script Date: 30/08/2020 8:54:40 SA ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 30/08/2020 8:54:40 SA ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[BOOKING]  WITH CHECK ADD  CONSTRAINT [FK_BOOKING_COUPON] FOREIGN KEY([CouponId])
REFERENCES [dbo].[COUPON] ([CouponId])
GO
ALTER TABLE [dbo].[BOOKING] CHECK CONSTRAINT [FK_BOOKING_COUPON]
GO
ALTER TABLE [dbo].[BOOKING]  WITH CHECK ADD  CONSTRAINT [FK_BOOKING_CUSTOMER] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[CUSTOMER] ([CustomerId])
GO
ALTER TABLE [dbo].[BOOKING] CHECK CONSTRAINT [FK_BOOKING_CUSTOMER]
GO
ALTER TABLE [dbo].[BOOKINGROOMDETAILS]  WITH CHECK ADD  CONSTRAINT [FK_BOOKINGROOMDETAILS_BOOKING] FOREIGN KEY([BookingId])
REFERENCES [dbo].[BOOKING] ([BookingId])
GO
ALTER TABLE [dbo].[BOOKINGROOMDETAILS] CHECK CONSTRAINT [FK_BOOKINGROOMDETAILS_BOOKING]
GO
ALTER TABLE [dbo].[BOOKINGROOMDETAILS]  WITH CHECK ADD  CONSTRAINT [FK_BOOKINGROOMDETAILS_ROOMTYPE] FOREIGN KEY([RoomTypeId])
REFERENCES [dbo].[ROOMTYPE] ([RoomTypeId])
GO
ALTER TABLE [dbo].[BOOKINGROOMDETAILS] CHECK CONSTRAINT [FK_BOOKINGROOMDETAILS_ROOMTYPE]
GO
ALTER TABLE [dbo].[BOOKINGSERVICEDETAILS]  WITH CHECK ADD  CONSTRAINT [FK_BOOKINGSERVICEDETAILS_BOOKING] FOREIGN KEY([BookingId])
REFERENCES [dbo].[BOOKING] ([BookingId])
GO
ALTER TABLE [dbo].[BOOKINGSERVICEDETAILS] CHECK CONSTRAINT [FK_BOOKINGSERVICEDETAILS_BOOKING]
GO
ALTER TABLE [dbo].[BOOKINGSERVICEDETAILS]  WITH CHECK ADD  CONSTRAINT [FK_BOOKINGSERVICEDETAILS_SERVICE] FOREIGN KEY([ServiceId])
REFERENCES [dbo].[SERVICE] ([ServiceId])
GO
ALTER TABLE [dbo].[BOOKINGSERVICEDETAILS] CHECK CONSTRAINT [FK_BOOKINGSERVICEDETAILS_SERVICE]
GO
ALTER TABLE [dbo].[FACILITIESAPPLY]  WITH CHECK ADD  CONSTRAINT [FK_FACILITIESAPPLY_FACILITIES] FOREIGN KEY([FacilityId])
REFERENCES [dbo].[FACILITIES] ([FacilityId])
GO
ALTER TABLE [dbo].[FACILITIESAPPLY] CHECK CONSTRAINT [FK_FACILITIESAPPLY_FACILITIES]
GO
ALTER TABLE [dbo].[FACILITIESAPPLY]  WITH CHECK ADD  CONSTRAINT [FK_FACILITIESAPPLY_ROOMTYPE] FOREIGN KEY([RoomTypeId])
REFERENCES [dbo].[ROOMTYPE] ([RoomTypeId])
GO
ALTER TABLE [dbo].[FACILITIESAPPLY] CHECK CONSTRAINT [FK_FACILITIESAPPLY_ROOMTYPE]
GO
ALTER TABLE [dbo].[PROMOTIONAPPLY]  WITH CHECK ADD  CONSTRAINT [FK_PROMOTIONAPPLY_PROMOTION] FOREIGN KEY([PromotionId])
REFERENCES [dbo].[PROMOTION] ([PromotionId])
GO
ALTER TABLE [dbo].[PROMOTIONAPPLY] CHECK CONSTRAINT [FK_PROMOTIONAPPLY_PROMOTION]
GO
ALTER TABLE [dbo].[PROMOTIONAPPLY]  WITH CHECK ADD  CONSTRAINT [FK_PROMOTIONAPPLY_ROOMTYPE] FOREIGN KEY([RoomTypeId])
REFERENCES [dbo].[ROOMTYPE] ([RoomTypeId])
GO
ALTER TABLE [dbo].[PROMOTIONAPPLY] CHECK CONSTRAINT [FK_PROMOTIONAPPLY_ROOMTYPE]
GO
ALTER TABLE [dbo].[ROOM]  WITH CHECK ADD  CONSTRAINT [FK_ROOM_ROOMTYPE] FOREIGN KEY([RoomTypeId])
REFERENCES [dbo].[ROOMTYPE] ([RoomTypeId])
GO
ALTER TABLE [dbo].[ROOM] CHECK CONSTRAINT [FK_ROOM_ROOMTYPE]
GO
ALTER TABLE [dbo].[ROOMTYPEIMAGES]  WITH CHECK ADD  CONSTRAINT [FK_ROOMTYPEIMAGES_ROOMTYPE] FOREIGN KEY([RoomTypeId])
REFERENCES [dbo].[ROOMTYPE] ([RoomTypeId])
GO
ALTER TABLE [dbo].[ROOMTYPEIMAGES] CHECK CONSTRAINT [FK_ROOMTYPEIMAGES_ROOMTYPE]
GO
ALTER TABLE [dbo].[SERVICEIMAGES]  WITH CHECK ADD FOREIGN KEY([ServiceId])
REFERENCES [dbo].[SERVICE] ([ServiceId])
GO
ALTER TABLE [dbo].[SERVICEIMAGES]  WITH CHECK ADD FOREIGN KEY([ServiceId])
REFERENCES [dbo].[SERVICE] ([ServiceId])
GO
ALTER TABLE [dbo].[SERVICEIMAGES]  WITH CHECK ADD FOREIGN KEY([ServiceId])
REFERENCES [dbo].[SERVICE] ([ServiceId])
GO
/****** Object:  StoredProcedure [dbo].[Booking_Delete]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Booking_Delete>
-- =============================================
CREATE PROCEDURE [dbo].[Booking_Delete]
	-- Add the parameters for the stored procedure here
	@BookingId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		UPDATE [dbo].BOOKING
		   SET IsCanceled = 1
		WHERE BookingId = @BookingId
		SET @Message = 'Service has been deleted successfully!'
		SELECT @BookingId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @BookingId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[Booking_GetAll]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Booking_GetAll>
-- =============================================
CREATE PROCEDURE [dbo].[Booking_GetAll]
	-- Add the parameters for the stored procedure here
AS
BEGIN 
SELECT *
  FROM [dbo].BOOKING
  WHERE IsCanceled = 0
END

GO
/****** Object:  StoredProcedure [dbo].[Booking_GetByBookingId]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Booking_GetAll>
-- =============================================
CREATE PROCEDURE [dbo].[Booking_GetByBookingId]
	-- Add the parameters for the stored procedure here
	@BookingId INT
AS
BEGIN 
SELECT *
  FROM [dbo].BOOKING
  WHERE IsCanceled = 0 AND @BookingId = BookingId
END

GO
/****** Object:  StoredProcedure [dbo].[Booking_GetListDate]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Room_Save>
-- =============================================
CREATE PROCEDURE [dbo].[Booking_GetListDate]
	-- Add the parameters for the stored procedure here
	@BookingId INT
AS
BEGIN 
DECLARE @StartDate DATETIME
DECLARE @EndDate DATETIME
DECLARE @tableDate TABLE (
    Dates DATE
);
SET @StartDate = (SELECT CheckinDate FROM BOOKING WHERE BookingId = @BookingId)
SET @EndDate = (SELECT CheckoutDate FROM BOOKING WHERE BookingId = @BookingId)

DECLARE @Counter INT, @TotalCount INT
SET @Counter = 0
SET @TotalCount = DateDiff(DD,@StartDate,@EndDate)
  
 
WHILE (@Counter <=@TotalCount)
BEGIN
  DECLARE @DateValue DATETIME
  SET  @DateValue= DATEADD(DD,@Counter,@StartDate)
  
    INSERT INTO @tableDate(Dates)
    VALUES(@DateValue)
 
    SET @Counter = @Counter + 1
END 
		SELECT * FROM @tableDate
END
GO
/****** Object:  StoredProcedure [dbo].[Booking_Save]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Booking_Save>
-- =============================================
CREATE PROCEDURE [dbo].[Booking_Save]
	-- Add the parameters for the stored procedure here
	@BookingId INT,
	@CustomerId INT,
	@CouponId INT,
	@CheckinDate DATETIME,
	@CheckoutDate DATETIME,
	@NumberofAdults INT,
	@NumberofChildren INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
DECLARE @ServiceAmount FLOAT
DECLARE @RoomAmount FLOAT
DECLARE @Reduction FLOAT
DECLARE @CreateDate DATE
DECLARE @UpdateCouponId INT = NULL
BEGIN TRY
SET @CreateDate = GETDATE()
IF(EXISTS(SELECT Reduction FROM COUPON WHERE (CouponId = @CouponId) AND (Remain > 0) AND (@CreateDate < EndDate) AND (IsDeleted = 0)))
	BEGIN
		SET @Reduction = (SELECT Reduction FROM COUPON WHERE (CouponId = @CouponId) AND (Remain > 0) AND (@CreateDate < EndDate) AND (IsDeleted = 0))
		SET @RoomAmount = (SELECT SUM(RoomPrice) FROM BOOKINGROOMDETAILS WHERE BookingId = @BookingId)*(1-@Reduction)
		SET @UpdateCouponId = @CouponId
	END
ELSE 
	BEGIN
		SET @RoomAmount = (SELECT SUM(RoomPrice) FROM BOOKINGROOMDETAILS WHERE BookingId = @BookingId)
	END
SET @ServiceAmount = (SELECT SUM(ServicePrice) FROM BOOKINGSERVICEDETAILS WHERE BookingId = @BookingId)

	IF (@BookingId = 0 OR @BookingId = NULL)
		BEGIN -- Create new RoomType
			INSERT INTO [dbo].[BOOKING]
           (CustomerId
           ,CreateDate
		   ,ServiceAmount
		   ,RoomAmount
		   ,CouponId
		   ,IsCanceled
		   ,CheckinDate
		   ,CheckoutDate
		   ,NumberofAdults
		   ,NumberofChildren)
			VALUES
           (@CustomerId
		   ,@CreateDate
		   ,0
		   ,0
		   ,@UpdateCouponId
		   ,0
		   ,@CheckinDate
		   ,@CheckoutDate
		   ,@NumberofAdults
		   ,@NumberofChildren)
			SET @BookingId = SCOPE_IDENTITY()
			SET @Message = 'Booking has been created successfully!'
		END
	ELSE
		BEGIN
			UPDATE [dbo].[BOOKING]
			   SET CustomerId = @CustomerId,
				   ServiceAmount = @ServiceAmount,
				   RoomAmount = @RoomAmount,
				   CouponId = @UpdateCouponId,
				   CheckinDate = @CheckinDate,
				   CheckoutDate = @CheckoutDate,
				   NumberofAdults = @NumberofAdults,
				   NumberofChildren = @NumberofChildren
			 WHERE @BookingId = BookingId
			 SET @Message = 'Booking has been updated successfully!'
		END;
		SELECT @BookingId AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SET @BookingId = 0
		SELECT @BookingId AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[BookingRoomDetails_Delete]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: BookingRoomDetails_Delete>
-- =============================================
CREATE PROCEDURE [dbo].[BookingRoomDetails_Delete]
	-- Add the parameters for the stored procedure here
	@BookingRoomDetailsId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		DELETE FROM [dbo].[BOOKINGROOMDETAILS]
		WHERE BookingRoomDetailsId = @BookingRoomDetailsId
		SET @Message = 'BookingRoomDetails has been deleted successfully!'
		SELECT @BookingRoomDetailsId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @BookingRoomDetailsId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[BookingRoomDetails_DeletebyBookingId]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: BookingRoomDetails_Delete>
-- =============================================
CREATE PROCEDURE [dbo].[BookingRoomDetails_DeletebyBookingId]
	-- Add the parameters for the stored procedure here
	@BookingId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		DELETE FROM [dbo].BOOKINGROOMDETAILS
		WHERE @BookingId = BookingId
		SET @Message = 'BookingServiceDetails has been deleted successfully!'
		SELECT @BookingId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @BookingId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[BookingRoomDetails_DisplayBookingRoomTypesByBookingId]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: BookingRoomDetails_DisplayBookingRoomTypesByBookingId>
-- =============================================
CREATE PROCEDURE [dbo].[BookingRoomDetails_DisplayBookingRoomTypesByBookingId]
	-- Add the parameters for the stored procedure here
	@BookingId INT
AS

BEGIN

SELECT RoomTypeId, RoomQuantity
  FROM [dbo].BOOKINGROOMDETAILS
  WHERE @BookingId = BOOKINGROOMDETAILS.BookingId AND EXISTS(SELECT * FROM [dbo].BOOKING WHERE @BookingId = BOOKING.BookingId AND BOOKING.IsCanceled = 0)
  GROUP BY RoomTypeId, RoomQuantity
END
GO
/****** Object:  StoredProcedure [dbo].[BookingRoomDetails_GetAll]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Service_Search>
-- =============================================
CREATE PROCEDURE [dbo].[BookingRoomDetails_GetAll]
	-- Add the parameters for the stored procedure here
AS
BEGIN 
SELECT *
  FROM [dbo].BOOKINGROOMDETAILS
END
GO
/****** Object:  StoredProcedure [dbo].[BookingRoomDetails_GetByBookingId]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: BookingRoomDetails_GetByBookingId>
-- =============================================
CREATE PROCEDURE [dbo].[BookingRoomDetails_GetByBookingId]
	-- Add the parameters for the stored procedure here
	@BookingId INT
AS

BEGIN

SELECT *
  FROM [dbo].BOOKINGROOMDETAILS
  WHERE @BookingId = BOOKINGROOMDETAILS.BookingId AND EXISTS(SELECT * FROM [dbo].BOOKING WHERE @BookingId = BOOKING.BookingId AND BOOKING.IsCanceled = 0)
END
GO
/****** Object:  StoredProcedure [dbo].[BookingRoomDetails_Save]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: BookingRoomDetails_Save>
-- =============================================
CREATE PROCEDURE [dbo].[BookingRoomDetails_Save]
	-- Add the parameters for the stored procedure here
	@RoomTypeId INT,
	@BookingId INT,
	@RoomQuantity INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'

DECLARE @StartDate DATETIME
DECLARE @EndDate DATETIME
DECLARE @Counter INT, @TotalCount INT


BEGIN TRY

SET @StartDate = (SELECT CheckinDate FROM BOOKING WHERE BookingId = @BookingId)
SET @EndDate = (SELECT CheckoutDate FROM BOOKING WHERE BookingId = @BookingId)
SET @Counter = 0
SET @TotalCount = DateDiff(DD,@StartDate,@EndDate)-1
		WHILE (@Counter <=@TotalCount)
			BEGIN
				DECLARE @DateValue DATETIME
				SET  @DateValue= DATEADD(DD,@Counter,@StartDate)

				DECLARE @RoomPrice FLOAT
				DECLARE @DiscountRates FLOAT
				SET @DiscountRates = (SELECT MIN(DiscountRates) AS DiscountRates FROM PROMOTION  
									 INNER JOIN PROMOTIONAPPLY
									 ON PROMOTION.PromotionId = PROMOTIONAPPLY.PromotionId
									 WHERE PROMOTIONAPPLY.RoomTypeId = @RoomTypeId
									 GROUP BY StartDate, EndDate
									 HAVING @DateValue >= StartDate AND @DateValue <= EndDate)

				IF (@DiscountRates<>0)
				BEGIN
					SET @RoomPrice = 
					 (SELECT DefaultPrice FROM ROOMTYPE WHERE ROOMTYPE.RoomTypeId = @RoomTypeId)
					*(1-@DiscountRates) 
					*(@RoomQuantity)
				END
				ELSE
				BEGIN
					SET @RoomPrice = 
					 (SELECT DefaultPrice FROM ROOMTYPE WHERE ROOMTYPE.RoomTypeId = @RoomTypeId)
					*(@RoomQuantity)
				END

				INSERT INTO [dbo].BOOKINGROOMDETAILS
			   (RoomTypeId
			   ,BookingId
			   ,RoomQuantity
			   ,[Date]
			   ,RoomPrice)
				VALUES
			   (@RoomTypeId
			   ,@BookingId
			   ,@RoomQuantity
			   ,@DateValue
			   ,@RoomPrice)
			   SET @Counter = @Counter + 1
			END
			SET @Message = 'BookingRoomDetails has been created successfully!'
		SELECT @RoomTypeId AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SET @RoomTypeId = 0
		SELECT @RoomTypeId AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[BookingServiceDetails_Delete]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: BookingRoomDetails_Delete>
-- =============================================
CREATE PROCEDURE [dbo].[BookingServiceDetails_Delete]
	-- Add the parameters for the stored procedure here
	@BookingServiceDetailsId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		DELETE FROM [dbo].BOOKINGSERVICEDETAILS
		WHERE @BookingServiceDetailsId = BookingServiceDetailsId
		SET @Message = 'BookingServiceDetails has been deleted successfully!'
		SELECT @BookingServiceDetailsId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @BookingServiceDetailsId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[BookingServiceDetails_DeletebyBookingId]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: BookingRoomDetails_Delete>
-- =============================================
CREATE PROCEDURE [dbo].[BookingServiceDetails_DeletebyBookingId]
	-- Add the parameters for the stored procedure here
	@BookingId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		DELETE FROM [dbo].BOOKINGSERVICEDETAILS
		WHERE @BookingId = BookingId
		SET @Message = 'BookingServiceDetails has been deleted successfully!'
		SELECT @BookingId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @BookingId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[BookingServiceDetails_GetAll]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Service_Search>
-- =============================================
CREATE PROCEDURE [dbo].[BookingServiceDetails_GetAll]
	-- Add the parameters for the stored procedure here
AS
BEGIN 
SELECT *
  FROM [dbo].BOOKINGSERVICEDETAILS
END
GO
/****** Object:  StoredProcedure [dbo].[BookingServiceDetails_GetByBookingId]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Service_Search>
-- =============================================
CREATE PROCEDURE [dbo].[BookingServiceDetails_GetByBookingId]
	-- Add the parameters for the stored procedure here
	@BookingId INT
AS
BEGIN 
SELECT *
  FROM [dbo].BOOKINGSERVICEDETAILS
  WHERE @BookingId = BOOKINGSERVICEDETAILS.BookingId AND EXISTS(SELECT * FROM [dbo].BOOKING WHERE @BookingId = BOOKING.BookingId AND BOOKING.IsCanceled = 0)
END
GO
/****** Object:  StoredProcedure [dbo].[BookingServiceDetails_Save]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: BookingServiceDetails_Save>
-- =============================================
CREATE PROCEDURE [dbo].[BookingServiceDetails_Save]
	-- Add the parameters for the stored procedure here
	@BookingId INT,
	@ServiceId INT,
	@ServiceQuantity INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
DECLARE @ServicePrice FLOAT
BEGIN TRY
SET @ServicePrice = (SELECT Price FROM [SERVICE] WHERE [SERVICE].ServiceId = @ServiceId)
				   *(@ServiceQuantity)
			INSERT INTO [dbo].BOOKINGSERVICEDETAILS
           (BookingId
           ,ServiceId
		   ,ServiceQuantity
		   ,ServicePrice)
			VALUES
           (@BookingId
		   ,@ServiceId
		   ,@ServiceQuantity
		   ,@ServicePrice)
			SET @Message = 'BookingServiceDetails has been created successfully!'
		SELECT @ServiceId AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SET @ServiceId = 0
		SELECT @ServiceId AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Coupon_Delete]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Customer_Delete>
-- =============================================
CREATE PROCEDURE [dbo].[Coupon_Delete]
	-- Add the parameters for the stored procedure here
	@CouponId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		UPDATE [dbo].COUPON
		   SET IsDeleted = 1
		WHERE CouponId = @CouponId
		SET @Message = 'Customer has been deleted successfully!'
		SELECT @CouponId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @CouponId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[Coupon_GetAll]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Booking_GetAll>
-- =============================================
CREATE PROCEDURE [dbo].[Coupon_GetAll]
	-- Add the parameters for the stored procedure here
AS
BEGIN 
SELECT *
  FROM [dbo].COUPON WHERE (IsDeleted = 0)
END

GO
/****** Object:  StoredProcedure [dbo].[Coupon_GetbyId]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Booking_GetAll>
-- =============================================
CREATE PROCEDURE [dbo].[Coupon_GetbyId]
	-- Add the parameters for the stored procedure here
	@CouponId INT
AS
BEGIN 
SELECT *
  FROM [dbo].COUPON
  WHERE CouponId = @CouponId AND (IsDeleted = 0)
END

GO
/****** Object:  StoredProcedure [dbo].[Coupon_Save]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Service_Save>
-- =============================================
CREATE PROCEDURE [dbo].[Coupon_Save]
	-- Add the parameters for the stored procedure here
	@CouponId INT,
	@CouponCode NVARCHAR(50),
	@Remain INT,
	@Reduction FLOAT,
	@EndDate DATE
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
BEGIN TRY
	IF (@CouponId = 0 OR @CouponId = NULL)
		BEGIN -- Create new RoomType
			INSERT INTO [dbo].[COUPON]
           ([CouponCode]
           ,[Remain]
		   ,[Reduction]
		   ,[EndDate]
		   ,[IsDeleted])
			VALUES
           (@CouponCode
		   ,@Remain
		   ,@Reduction
		   ,@EndDate
		   ,0)
			SET @CouponId = SCOPE_IDENTITY()
			SET @Message = 'Coupon has been created successfully!'
		END
	ELSE
		BEGIN
			UPDATE [dbo].[COUPON]
			   SET [CouponCode] = @CouponCode,
				   [Remain] = @Remain,
				   [Reduction] = @Reduction,
				   [EndDate] = @EndDate
			 WHERE CouponId = @CouponId
			 SET @Message = 'Coupon has been updated successfully!'
		END;
		SELECT @CouponId AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SET @CouponId = 0
		SELECT @CouponId AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Coupon_Search]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Booking_GetAll>
-- =============================================
CREATE PROCEDURE [dbo].[Coupon_Search]
	-- Add the parameters for the stored procedure here
	@CouponCode NVARCHAR(50)
AS
BEGIN 

DECLARE @message NVARCHAR(100) = N'Mã không tồn tại hoặc đã quá hạn xin vui lòng thử lại!'

IF(EXISTS(SELECT CouponId
  FROM [dbo].COUPON
  WHERE CouponCode = @CouponCode AND (IsDeleted = 0) AND (GETDATE() < EndDate) AND (Remain <> 0)))
BEGIN
	SELECT CouponId, Reduction, CONCAT(N'Mã giảm giá hợp lệ, bạn được giảm giá ', Reduction * 100, '%') AS [Message]
	FROM [dbo].COUPON
	WHERE CouponCode = @CouponCode AND (IsDeleted = 0) AND (GETDATE() < EndDate) AND (Remain <> 0);
END
ELSE
BEGIN
	SELECT 0 AS CouponId, 0 AS Reduction, @message AS [Message]
END

END

GO
/****** Object:  StoredProcedure [dbo].[Customer_Delete]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Customer_Delete>
-- =============================================
CREATE PROCEDURE [dbo].[Customer_Delete]
	-- Add the parameters for the stored procedure here
	@CustomerId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		UPDATE [dbo].CUSTOMER
		   SET IsDeleted = 1
		WHERE CustomerId = @CustomerId
		SET @Message = 'Customer has been deleted successfully!'
		SELECT @CustomerId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @CustomerId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[Customer_GetAll]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Service_GetAll>
-- =============================================
CREATE PROCEDURE [dbo].[Customer_GetAll]
	-- Add the parameters for the stored procedure here
AS
BEGIN 
SELECT *
  FROM [dbo].CUSTOMER
  WHERE IsDeleted = 0
END

GO
/****** Object:  StoredProcedure [dbo].[Customer_GetByCustomerId]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Customer_GetByCustomerId>
-- =============================================
CREATE PROCEDURE [dbo].[Customer_GetByCustomerId]
	-- Add the parameters for the stored procedure here
	@CustomerId INT
AS
BEGIN 
SELECT *
  FROM [dbo].[CUSTOMER]
  WHERE IsDeleted = 0 AND @CustomerId = CustomerId
END

GO
/****** Object:  StoredProcedure [dbo].[Customer_Save]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Customer_Save>
-- =============================================
CREATE PROCEDURE [dbo].[Customer_Save]
	-- Add the parameters for the stored procedure here
	@CustomerId INT,
	@Name NVARCHAR(50),
	@PhoneNumber NVARCHAR(50),
	@Email NVARCHAR(50)
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
BEGIN TRY
	IF (@CustomerId = 0 OR @CustomerId = NULL)
		BEGIN -- Create new RoomType
			INSERT INTO [dbo].CUSTOMER
           ([Name]
		   ,PhoneNumber
		   ,Email
		   ,IsDeleted)
			VALUES
           (@Name
		   ,@PhoneNumber
		   ,@Email
		   ,0)
			SET @CustomerId = SCOPE_IDENTITY()
			SET @Message = 'Customer has been created successfully!'
		END
	ELSE
		BEGIN
			UPDATE [dbo].CUSTOMER
			   SET [Name] = @Name,
				   PhoneNumber = @PhoneNumber,
				   Email = @Email
			 WHERE @CustomerId = CustomerId
			 SET @Message = 'Customer has been updated successfully!'
		END;
		SELECT @CustomerId AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SET @CustomerId = 0
		SELECT @CustomerId AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[DateTable_Create]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Room_Save>
-- =============================================
CREATE PROCEDURE [dbo].[DateTable_Create]
	-- Add the parameters for the stored procedure here
	@StartDate DATETIME,
	@EndDate DATETIME
AS
BEGIN 
DECLARE @tableDate TABLE (
    Dates DATE
);
DECLARE @Counter INT, @TotalCount INT
SET @Counter = 0
SET @TotalCount = DateDiff(DD,@StartDate,@EndDate)
  
 
WHILE (@Counter <=@TotalCount)
BEGIN
  DECLARE @DateValue DATETIME
  SET  @DateValue= DATEADD(DD,@Counter,@StartDate)
  
    INSERT INTO @tableDate(Dates)
    VALUES(@DateValue)
 
    SET @Counter = @Counter + 1
END 
		SELECT * FROM @tableDate
END
GO
/****** Object:  StoredProcedure [dbo].[Facility_Delete]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 05/08/2020
-- Description:
-- =============================================
CREATE PROCEDURE [dbo].[Facility_Delete]
	@FacilityId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		DELETE FROM [dbo].FACILITIES
		WHERE FacilityId = @FacilityId
		SET @Message = 'RoomType has been deleted successfully!'
		SELECT @FacilityId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @FacilityId AS Id, @Message AS [Message]
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Facility_GetAll]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 05/08/2020
-- Description:
-- =============================================
CREATE PROCEDURE [dbo].[Facility_GetAll]
AS
BEGIN 
SELECT *
  FROM [dbo].FACILITIES
END

GO
/****** Object:  StoredProcedure [dbo].[Facility_GetbyId]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 05/08/2020
-- Description:
-- =============================================
CREATE PROCEDURE [dbo].[Facility_GetbyId]
	@FacilityId INT
AS
BEGIN 
SELECT *
  FROM [dbo].FACILITIES
  WHERE FacilityId = @FacilityId
END

GO
/****** Object:  StoredProcedure [dbo].[Facility_Save]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 5/8/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Facility_Save]
	@FacilityId INT,
	@FacilityName NVARCHAR(50),
	@FacilityImage NVARCHAR(MAX)
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
BEGIN TRY
	IF (@FacilityId = 0 OR @FacilityId = NULL)
		BEGIN
			INSERT INTO [dbo].FACILITIES
           (FacilityName
           ,FacilityImage)
			VALUES
           (@FacilityName
		   ,@FacilityImage)
			SET @FacilityId = SCOPE_IDENTITY()
			SET @Message = 'Facility has been created successfully!'
		END
	ELSE
		BEGIN
			UPDATE [dbo].FACILITIES
			   SET FacilityName = @FacilityName,
				   FacilityImage = @FacilityImage
			 WHERE FacilityId = @FacilityId
			 SET @Message = 'Facility has been updated successfully!'
		END;
		SELECT @FacilityId AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SET @FacilityId = 0
		SELECT @FacilityId AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[FacilityApply_Delete]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Trung
-- Create date: 5/8/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[FacilityApply_Delete]
	@FacilitiesApplyId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		DELETE FROM [dbo].[FACILITIESAPPLY]
		WHERE @FacilitiesApplyId = FacilitiesApplyId
		SET @Message = 'Facility has been removed successfully!'
		SELECT @FacilitiesApplyId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @FacilitiesApplyId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[FacilityApply_DeleteByRoomTypeId]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Trung
-- Create date: 5/8/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[FacilityApply_DeleteByRoomTypeId]
	@RoomTypeId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		DELETE FROM [dbo].[FACILITIESAPPLY]
		WHERE @RoomTypeId = RoomTypeId
		SET @Message = 'Facility has been removed successfully!'
		SELECT @RoomTypeId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @RoomTypeId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[FacilityApply_GetByRoomTypeId]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 5/8/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[FacilityApply_GetByRoomTypeId]
	@RoomTypeId INT
AS
BEGIN
	SELECT * FROM [dbo].[FACILITIESAPPLY] WHERE RoomTypeId = @RoomTypeId
END
GO
/****** Object:  StoredProcedure [dbo].[FacilityApply_Save]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 31/07/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[FacilityApply_Save]
	@FacilityId INT,
	@RoomTypeId INT
AS
BEGIN
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
BEGIN TRY
	BEGIN
		INSERT INTO [dbo].[FACILITIESAPPLY]
        (FacilityId
		,RoomTypeId)
		VALUES
        (@FacilityId
		,@RoomTypeId)
		SET @FacilityId = SCOPE_IDENTITY()
		SET @Message = 'Facility has been added successfully!'
	END
END TRY
BEGIN CATCH
		SET @FacilityId = 0
END CATCH
SELECT @FacilityId AS Id, @Message AS [Message]
END
GO
/****** Object:  StoredProcedure [dbo].[Promotion_Delete]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Promotion_Delete>
-- =============================================
CREATE PROCEDURE [dbo].[Promotion_Delete]
	-- Add the parameters for the stored procedure here
	@PromotionId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		UPDATE [dbo].PROMOTION
		   SET IsDeleted = 1
		WHERE PromotionId = @PromotionId
		SET @Message = 'Promotion has been deleted successfully!'
		SELECT @PromotionId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @PromotionId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[Promotion_GetAll]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: [Promotion_GetAll]>
-- =============================================
CREATE PROCEDURE [dbo].[Promotion_GetAll]
	-- Add the parameters for the stored procedure here
AS
BEGIN 
SELECT *
  FROM [dbo].PROMOTION WHERE IsDeleted = 0
END

GO
/****** Object:  StoredProcedure [dbo].[Promotion_GetAvailable]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 14/8/2020
-- Description:	Get Promotion's Max DiscountRates available
-- =============================================
CREATE PROCEDURE [dbo].[Promotion_GetAvailable]
AS
BEGIN
	DECLARE @CurrentDate DATE
	SET @CurrentDate = GETDATE()
	SELECT RoomTypeId, MAX(DiscountRates) AS DiscountRates FROM PROMOTION
	INNER JOIN PROMOTIONAPPLY ON PROMOTION.PromotionId = PROMOTIONAPPLY.PromotionId
	WHERE @CurrentDate >= StartDate AND @CurrentDate <= EndDate AND IsDeleted = 0
	GROUP BY RoomTypeId
END
GO
/****** Object:  StoredProcedure [dbo].[Promotion_GetAvailableForDate]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 23/8/2020
-- Description:	Get Promotion's Max DiscountRates available for @Date
-- =============================================
CREATE PROCEDURE [dbo].[Promotion_GetAvailableForDate]
	@Date date
AS
BEGIN
	SELECT RoomTypeId, MAX(DiscountRates) AS DiscountRates FROM PROMOTION
	INNER JOIN PROMOTIONAPPLY ON PROMOTION.PromotionId = PROMOTIONAPPLY.PromotionId
	WHERE @Date >= StartDate AND @Date <= EndDate AND IsDeleted = 0
	GROUP BY RoomTypeId
END
GO
/****** Object:  StoredProcedure [dbo].[Promotion_GetAvailableForDateAndRoomId]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 23/8/2020
-- Description:	Get Promotion's Max DiscountRates available for @Date and @RoomTypeId
-- =============================================
CREATE PROCEDURE [dbo].[Promotion_GetAvailableForDateAndRoomId]
	@RoomTypeId INT,
	@Date date
AS
BEGIN
	SELECT MAX(DiscountRates) AS DiscountRates FROM PROMOTION
	INNER JOIN PROMOTIONAPPLY ON PROMOTION.PromotionId = PROMOTIONAPPLY.PromotionId
	WHERE @Date >= StartDate AND @Date <= EndDate AND IsDeleted = 0 AND RoomTypeId = @RoomTypeId
	GROUP BY RoomTypeId
END
GO
/****** Object:  StoredProcedure [dbo].[Promotion_GetById]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 04/08/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Promotion_GetById]
	-- Add the parameters for the stored procedure here
	@PromotionId INT
AS
BEGIN 
SELECT *
  FROM [dbo].[PROMOTION]
  WHERE IsDeleted = 0 AND PromotionId = @PromotionId
END

GO
/****** Object:  StoredProcedure [dbo].[Promotion_Save]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Promotion_Save>
-- =============================================
CREATE PROCEDURE [dbo].[Promotion_Save]
	-- Add the parameters for the stored procedure here
	@PromotionId INT,
	@PromotionName NVARCHAR(50),
	@StartDate DATE,
	@EndDate DATE,
	@DiscountRates FLOAT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
BEGIN TRY
	IF (@PromotionId = 0 OR @PromotionId = NULL)
		BEGIN -- Create new RoomType
			INSERT INTO [dbo].PROMOTION
           (PromotionName,
		    StartDate,
			EndDate,
			DiscountRates,
			IsDeleted)
			VALUES
           (@PromotionName,
		   @StartDate,
		   @EndDate,
		   @DiscountRates,
		   0)
			SET @PromotionId = SCOPE_IDENTITY()
			SET @Message = 'Promotion has been created successfully!'
		END
	ELSE
		BEGIN
			UPDATE [dbo].PROMOTION
			   SET StartDate = @StartDate,
				   EndDate = @EndDate,
				   DiscountRates = @DiscountRates
			 WHERE PromotionId = @PromotionId
			 SET @Message = 'Promotion has been updated successfully!'
		END;
		SELECT @PromotionId AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SET @PromotionId = 0
		SELECT @PromotionId AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[PromotionApply_Delete]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Trung
-- Create date: 1/8/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[PromotionApply_Delete]
	@PromotionApplyId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		DELETE FROM [dbo].[PromotionApply]
		WHERE @PromotionApplyId = PromotionApplyId
		SET @Message = 'PromotionApply has been deleted successfully!'
		SELECT @PromotionApplyId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @PromotionApplyId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[PromotionApply_DeleteByPromotionId]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 14/8/2020
-- Description:	Delete PromotionApply By Promotion Id
-- =============================================
CREATE PROCEDURE [dbo].[PromotionApply_DeleteByPromotionId]
	@PromotionId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		DELETE FROM [dbo].[PROMOTIONAPPLY]
		WHERE @PromotionId = PromotionId
		SET @Message = 'Promotion Apply has been removed successfully!'
		SELECT @PromotionId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @PromotionId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[PromotionApply_GetAll]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 1/8/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[PromotionApply_GetAll]
AS
BEGIN
	SELECT * FROM [dbo].[PROMOTIONAPPLY]
END
GO
/****** Object:  StoredProcedure [dbo].[PromotionApply_GetByPromotionId]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 14/8/2020
-- Description:	Get PromotionApply By Promotion Id
-- =============================================
CREATE PROCEDURE [dbo].[PromotionApply_GetByPromotionId]
	@PromotionId INT
AS
BEGIN
	SELECT * FROM [dbo].[PROMOTIONAPPLY] WHERE PromotionId = @PromotionId
END
GO
/****** Object:  StoredProcedure [dbo].[PromotionApply_GetByRoomTypeId]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 1/8/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[PromotionApply_GetByRoomTypeId]
	@RoomTypeId INT
AS
BEGIN
	SELECT * FROM [dbo].[PROMOTIONAPPLY] WHERE RoomTypeId = @RoomTypeId
END
GO
/****** Object:  StoredProcedure [dbo].[PromotionApply_Save]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 31/07/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[PromotionApply_Save]
	@PromotionApplyId INT,
	@PromotionId INT,
	@RoomTypeId INT
AS
BEGIN
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
BEGIN TRY
	IF (@PromotionApplyId = 0 OR @PromotionApplyId = NULL)
		BEGIN -- Create new RoomType
			INSERT INTO [dbo].[PromotionApply]
           (PromotionId
		   ,RoomTypeId)
			VALUES
           (@PromotionId
		   ,@RoomTypeId)
			SET @PromotionApplyId = SCOPE_IDENTITY()
			SET @Message = 'Promotion has been applied successfully!'
		END
	ELSE
		BEGIN
			UPDATE [dbo].[PromotionApply]
			   SET PromotionId = @PromotionId,
				   RoomTypeId = @RoomTypeId
			 WHERE PromotionApplyId = @PromotionApplyId
			 SET @Message = 'Promotion apply has been updated successfully!'
		END;
		SELECT @PromotionApplyId AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SET @PromotionApplyId = 0
		SELECT @PromotionApplyId AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Room_GetAll]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Room_GetAll>
-- =============================================
CREATE PROCEDURE [dbo].[Room_GetAll]
	-- Add the parameters for the stored procedure here
AS
BEGIN
SELECT [RoomNumber]
      ,[RoomTypeId]
  FROM [dbo].[ROOM]
  WHERE IsOccupied = 0
END

GO
/****** Object:  StoredProcedure [dbo].[Room_GetByRoomNumber]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Room_GetRoomNumber>
-- =============================================
CREATE PROCEDURE [dbo].[Room_GetByRoomNumber]
	-- Add the parameters for the stored procedure here
	@RoomNumber INT
AS
BEGIN
SELECT [RoomNumber]
      ,[RoomTypeId]
  FROM [dbo].[ROOM]
  WHERE IsOccupied = 0 AND RoomNumber = @RoomNumber
END

GO
/****** Object:  StoredProcedure [dbo].[Room_GetByRoomTypeId]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Room_GetRoomNumber>
-- =============================================
CREATE PROCEDURE [dbo].[Room_GetByRoomTypeId]
	-- Add the parameters for the stored procedure here
	@RoomTypeId INT
AS
BEGIN
SELECT [RoomNumber]
      ,[RoomTypeId]
  FROM [dbo].[ROOM]
  WHERE IsOccupied = 0 AND RoomTypeId = @RoomTypeId
END

GO
/****** Object:  StoredProcedure [dbo].[Room_Save]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Room_Save>
-- =============================================
CREATE PROCEDURE [dbo].[Room_Save]
	-- Add the parameters for the stored procedure here
	@RoomNumber INT,
	@RoomTypeId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
BEGIN TRY
	IF(NOT EXISTS(SELECT * FROM ROOM WHERE @RoomNumber = RoomNumber))
		BEGIN -- Create new RoomType
			INSERT INTO [dbo].ROOM
           ([RoomTypeId]
		   ,RoomNumber
		   ,IsOccupied)
			VALUES
           (@RoomTypeId
		   ,@RoomNumber
		   ,0)
			SET @Message = 'Room has been created successfully!'
		END
	ELSE
		BEGIN
			UPDATE [dbo].ROOM
			   SET RoomTypeId = @RoomTypeId
			 WHERE @RoomNumber = RoomNumber
			 SET @Message = 'Room has been updated successfully!'
		END;
		SELECT @RoomNumber AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SET @RoomNumber = 0
		SELECT @RoomNumber AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[RoomType_Delete]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: RoomType_Delete>
-- =============================================
CREATE PROCEDURE [dbo].[RoomType_Delete]
	-- Add the parameters for the stored procedure here
	@RoomTypeId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		UPDATE [dbo].ROOMTYPE
		   SET IsDeleted = 1
		WHERE RoomTypeId = @RoomTypeId
		SET @Message = 'RoomType has been deleted successfully!'
		SELECT @RoomTypeId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @RoomTypeId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[RoomType_GetAll]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: RoomType_GetAll>
-- =============================================
CREATE PROCEDURE [dbo].[RoomType_GetAll]
	-- Add the parameters for the stored procedure here
AS
BEGIN 
SELECT *
  FROM [dbo].RoomType
  WHERE IsDeleted = 0
END

GO
/****** Object:  StoredProcedure [dbo].[RoomType_GetById]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: RoomType_GetAll>
-- =============================================
CREATE PROCEDURE [dbo].[RoomType_GetById]
	-- Add the parameters for the stored procedure here
	@RoomTypeId INT
AS
BEGIN 
SELECT *
  FROM [dbo].RoomType
  WHERE IsDeleted = 0 AND RoomTypeId = @RoomTypeId
END

GO
/****** Object:  StoredProcedure [dbo].[RoomType_Save]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: RoomType_Delete>
-- =============================================
CREATE PROCEDURE [dbo].[RoomType_Save]
	-- Add the parameters for the stored procedure here
	@RoomTypeId INT,
	@Name NVARCHAR(50),
	@DefaultPrice INT,
	@Quantity INT,
	@Description NVARCHAR(max),
	@MaxAdult INT,
	@MaxChildren INT,
	@MaxPeople INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
BEGIN TRY
	IF (@RoomTypeId = 0 OR @RoomTypeId = NULL)
		BEGIN -- Create new RoomType
			INSERT INTO [dbo].ROOMTYPE
           ([Name]
           ,[DefaultPrice]
		   ,Quantity
		   ,IsDeleted
		   ,Description
		   ,MaxAdult
		   ,MaxChildren
		   ,MaxPeople)
			VALUES
           (@Name
		   ,@DefaultPrice
		   ,@Quantity
		   ,0
		   ,@Description
		   ,@MaxAdult
		   ,@MaxChildren
		   ,@MaxPeople)
			SET @RoomTypeId = SCOPE_IDENTITY()
			SET @Message = 'RoomType has been created successfully!'
		END
	ELSE
		BEGIN
			UPDATE [dbo].ROOMTYPE
			   SET [Name] = @Name,
				   DefaultPrice = @DefaultPrice,
				   Quantity = @Quantity,
				   Description = @Description,
				   MaxAdult = @MaxAdult,
				   MaxChildren = @MaxChildren,
				   MaxPeople = @MaxPeople
			 WHERE RoomTypeId = @RoomTypeId
			 SET @Message = 'RoomType has been updated successfully!'
		END;
		SELECT @RoomTypeId AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SET @RoomTypeId = 0
		SELECT @RoomTypeId AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[RoomType_Search]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 11/8/2020
-- Description:	Search RoomType Available and return min remain from @CheckInDate to @CheckOutDate
-- =============================================
CREATE PROCEDURE [dbo].[RoomType_Search]
	@Adult INT,
	@Children INT,
	@CheckInDate DATE,
	@CheckOutDate DATE
AS
BEGIN 
	SELECT RoomTypeId, (SELECT ([dbo].Fn_MinRemain(ROOMTYPE.RoomTypeId, @CheckInDate, @CheckOutDate))) AS MinRemain FROM ROOMTYPE
	WHERE ROOMTYPE.IsDeleted = 0 
	AND MaxAdult >= @Adult AND MaxChildren >= @Children AND MaxPeople >= (@Adult + @Children)
	AND ((SELECT ([dbo].Fn_MinRemain(ROOMTYPE.RoomTypeId, @CheckInDate, @CheckOutDate))) > 0)
END
GO
/****** Object:  StoredProcedure [dbo].[RoomTypeImage_Delete]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 7/8/2020
-- Description:
-- =============================================
CREATE PROCEDURE [dbo].[RoomTypeImage_Delete]
	@RoomTypeImageId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		DELETE FROM [dbo].ROOMTYPEIMAGES
		WHERE RoomTypeImageId = @RoomTypeImageId
		SET @Message = 'Image has been deleted successfully!'
	END TRY
	BEGIN CATCH
	END CATCH
	SELECT @RoomTypeImageId AS Id, @Message AS [Message]
END  

GO
/****** Object:  StoredProcedure [dbo].[RoomTypeImage_GetByRoomTypeId]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 7/8/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[RoomTypeImage_GetByRoomTypeId]
	@RoomTypeId INT
AS
BEGIN
	SELECT * FROM [dbo].[ROOMTYPEIMAGES] WHERE RoomTypeId = @RoomTypeId
END
GO
/****** Object:  StoredProcedure [dbo].[RoomTypeImage_Save]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 7/8/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[RoomTypeImage_Save]
	@RoomTypeId INT,
	@ImageData NVARCHAR(max)
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
BEGIN TRY
		INSERT INTO [dbo].[ROOMTYPEIMAGES]
        (RoomTypeId,
		ImageData)
		VALUES
        (@RoomTypeId,
		@ImageData)
		SET @Message = 'RoomType Image has been save successfully!'
		SELECT SCOPE_IDENTITY() AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SELECT 0 AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Service_Delete]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: RoomType_Delete>
-- =============================================
CREATE PROCEDURE [dbo].[Service_Delete]
	-- Add the parameters for the stored procedure here
	@ServiceId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		UPDATE [dbo].[SERVICE]
		   SET IsDeleted = 1
		WHERE ServiceId = @ServiceId
		SET @Message = 'Service has been deleted successfully!'
		SELECT @ServiceId AS Id, @Message AS [Message]
	END TRY
	BEGIN CATCH
		SELECT @ServiceId AS Id, @Message AS [Message]
	END CATCH
END  

GO
/****** Object:  StoredProcedure [dbo].[Service_GetAll]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Service_GetAll>
-- =============================================
CREATE PROCEDURE [dbo].[Service_GetAll]
	-- Add the parameters for the stored procedure here
AS
BEGIN 
SELECT *
  FROM [dbo].[SERVICE]
  WHERE IsDeleted = 0
END

GO
/****** Object:  StoredProcedure [dbo].[Service_GetByServiceId]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Service_Search>
-- =============================================
CREATE PROCEDURE [dbo].[Service_GetByServiceId]
	-- Add the parameters for the stored procedure here
	@ServiceId INT
AS
BEGIN 
SELECT *
  FROM [dbo].[SERVICE]
  WHERE IsDeleted = 0 AND @ServiceId = ServiceId
END
GO
/****** Object:  StoredProcedure [dbo].[Service_Save]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Service_Save>
-- =============================================
CREATE PROCEDURE [dbo].[Service_Save]
	-- Add the parameters for the stored procedure here
	@ServiceId INT,
	@ServiceName NVARCHAR(50),
	@Price INT,
	@Description NVARCHAR(MAX)
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
BEGIN TRY
	IF (@ServiceId = 0 OR @ServiceId = NULL)
		BEGIN -- Create new RoomType
			INSERT INTO [dbo].[SERVICE]
           ([ServiceName]
           ,[Price]
		   ,IsDeleted
		   ,Description)
			VALUES
           (@ServiceName
		   ,@Price
		   ,0
		   ,@Description)
			SET @ServiceId = SCOPE_IDENTITY()
			SET @Message = 'Service has been created successfully!'
		END
	ELSE
		BEGIN
			UPDATE [dbo].[SERVICE]
			   SET [ServiceName] = @ServiceName,
				   Price = @Price
			 WHERE ServiceId = @ServiceId
			 SET @Message = 'Service has been updated successfully!'
		END;
		SELECT @ServiceId AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SET @ServiceId = 0
		SELECT @ServiceId AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Service_Search]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Service_Search>
-- =============================================
CREATE PROCEDURE [dbo].[Service_Search]
	-- Add the parameters for the stored procedure here
	@keyWord NVARCHAR(50)
AS
BEGIN 
SELECT *
  FROM [dbo].[SERVICE]
  WHERE IsDeleted = 0 AND ServiceName LIKE ('%'+@keyWord+'%')
END

GO
/****** Object:  StoredProcedure [dbo].[ServiceImage_Delete]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 7/8/2020
-- Description:
-- =============================================
CREATE PROCEDURE [dbo].[ServiceImage_Delete]
	@ServiceImageId INT
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again'
	BEGIN TRY
		DELETE FROM [dbo].SERVICEIMAGES
		WHERE ServiceImageId = @ServiceImageId
		SET @Message = 'Image has been deleted successfully!'
	END TRY
	BEGIN CATCH
	END CATCH
	SELECT @ServiceImageId AS Id, @Message AS [Message]
END  

GO
/****** Object:  StoredProcedure [dbo].[ServiceImage_GetByServiceId]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 7/8/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[ServiceImage_GetByServiceId]
	@ServiceId INT
AS
BEGIN
	SELECT * FROM [dbo].[SERVICEIMAGES] WHERE ServiceId = @ServiceId
END
GO
/****** Object:  StoredProcedure [dbo].[ServiceImage_Save]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Trung
-- Create date: 15/8/2020
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[ServiceImage_Save]
	@ServiceId INT,
	@ImageData NVARCHAR(max)
AS
BEGIN 
DECLARE @Message NVARCHAR(200) = 'Something went wrong, please try again!'
BEGIN TRY
		INSERT INTO [dbo].[SERVICEIMAGES]
        (ServiceId,
		ImageData)
		VALUES
        (@ServiceId,
		@ImageData)
		SET @Message = 'Service Image has been save successfully!'
		SELECT SCOPE_IDENTITY() AS Id, @Message AS [Message]
END TRY
BEGIN CATCH
		SELECT 0 AS Id, @Message AS [Message]
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Supports_CreateDateTable]    Script Date: 30/08/2020 8:54:40 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author: QuangNguyen>
-- Create date: <Create Date: 30/07/2020>
-- Description:	<Description: Room_Save>
-- =============================================
CREATE PROCEDURE [dbo].[Supports_CreateDateTable]
	-- Add the parameters for the stored procedure here
	@StartDate DATETIME,
	@EndDate DATETIME
AS
BEGIN 
DECLARE @tableDate TABLE (
    Dates DATE
);
DECLARE @Counter INT, @TotalCount INT
SET @Counter = 0
SET @TotalCount = DateDiff(DD,@StartDate,@EndDate)
  
 
WHILE (@Counter <=@TotalCount)
BEGIN
  DECLARE @DateValue DATETIME
  SET  @DateValue= DATEADD(DD,@Counter,@StartDate)
  
    INSERT INTO @tableDate(Dates)
    VALUES(@DateValue)
 
    SET @Counter = @Counter + 1
END 
		SELECT * FROM @tableDate
END
GO
USE [master]
GO
ALTER DATABASE [HotelBooking] SET  READ_WRITE 
GO
