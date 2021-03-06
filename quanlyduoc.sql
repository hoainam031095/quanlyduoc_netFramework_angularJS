USE [master]
GO
/****** Object:  Database [QL_Duoc1]    Script Date: 22/05/2019 11:55:49 ******/
CREATE DATABASE [QL_Duoc1] ON  PRIMARY 
( NAME = N'QL_Duoc1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\QL_Duoc1.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QL_Duoc1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\QL_Duoc1_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QL_Duoc1] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QL_Duoc1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QL_Duoc1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QL_Duoc1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QL_Duoc1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QL_Duoc1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QL_Duoc1] SET ARITHABORT OFF 
GO
ALTER DATABASE [QL_Duoc1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QL_Duoc1] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [QL_Duoc1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QL_Duoc1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QL_Duoc1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QL_Duoc1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QL_Duoc1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QL_Duoc1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QL_Duoc1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QL_Duoc1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QL_Duoc1] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QL_Duoc1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QL_Duoc1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QL_Duoc1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QL_Duoc1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QL_Duoc1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QL_Duoc1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QL_Duoc1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QL_Duoc1] SET RECOVERY FULL 
GO
ALTER DATABASE [QL_Duoc1] SET  MULTI_USER 
GO
ALTER DATABASE [QL_Duoc1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QL_Duoc1] SET DB_CHAINING OFF 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QL_Duoc1', N'ON'
GO
USE [QL_Duoc1]
GO
/****** Object:  User [hoainam]    Script Date: 22/05/2019 11:55:49 ******/
CREATE USER [hoainam] FOR LOGIN [hoainam] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [hoainam]
GO
/****** Object:  StoredProcedure [dbo].[List_Route]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[List_Route]
(
	@controller nvarchar(250)
)
as
begin
	select rt.ID, rt.Controller, rt.Action, rt.Name from Route rt
	left join NhomQuyenRoute nqrt on nqrt.IDRoute = rt.ID
	
	Group by rt.ID, rt.Controller, rt.Action, rt.Name
end

GO
/****** Object:  StoredProcedure [dbo].[Tk_Account_login]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Tk_Account_login]
(
	@tenTaiKhoan nvarchar(50),
	@matKhau nvarchar(50)
)
as
begin
	declare @count int
	declare @res bit
	select @count = count(*) from TaiKhoan where TaiKhoan = @tenTaiKhoan and MatKhau = @matKhau
	if @count > 0
		set @res = 1
	else
		set @res = 0
	select @res
end

GO
/****** Object:  Table [dbo].[ChamCong]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChamCong](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[MaTK] [nvarchar](50) NULL,
	[DiaDiem] [nvarchar](50) NULL,
	[ThoiGian] [datetime] NULL,
	[XepLoai] [int] NULL,
	[GhiChu] [nvarchar](500) NULL,
 CONSTRAINT [PK_ChamCong] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChiTietChuyenKhoThuoc]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietChuyenKhoThuoc](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaDT] [nvarchar](50) NULL,
	[MaKhoChuyen] [nvarchar](50) NULL,
	[DonVi] [nvarchar](50) NULL,
	[Soluong] [int] NULL,
	[MaKhoNhan] [nvarchar](50) NOT NULL,
	[NgayChuyen] [date] NULL,
 CONSTRAINT [PK_ChiTietChuyenKhoThuoc_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChiTietHoaDonMua]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietHoaDonMua](
	[MaHD] [nvarchar](50) NOT NULL,
	[MaDT] [nvarchar](50) NOT NULL,
	[MaDonVi] [bigint] NOT NULL,
	[SoLuong] [int] NULL,
	[DonGia] [int] NULL,
 CONSTRAINT [PK_ChiTietHoaDonMua] PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC,
	[MaDT] ASC,
	[MaDonVi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChiTietHoaDonNhap]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietHoaDonNhap](
	[MaHD] [nvarchar](50) NOT NULL,
	[MaDT] [nvarchar](50) NOT NULL,
	[MaDonVi] [bigint] NOT NULL,
	[SoLuong] [int] NULL,
	[DonGia] [int] NULL,
 CONSTRAINT [PK_ChiTietHoaDonNhap] PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC,
	[MaDT] ASC,
	[MaDonVi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChiTietHoaDonXuat]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietHoaDonXuat](
	[MaHD] [nvarchar](50) NOT NULL,
	[MaDT] [nvarchar](50) NOT NULL,
	[MaDonVi] [bigint] NOT NULL,
	[SoLuong] [int] NULL,
	[DonGia] [int] NULL,
 CONSTRAINT [PK_ChiTietHoaDonXuat] PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC,
	[MaDT] ASC,
	[MaDonVi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CongTy]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CongTy](
	[MaCongTy] [nvarchar](50) NOT NULL,
	[TenCongTy] [nvarchar](150) NULL,
	[ToaDo1] [nvarchar](50) NULL,
	[ToaDo2] [nvarchar](50) NULL,
	[ToaDo3] [nvarchar](50) NULL,
	[ToaDo4] [nvarchar](50) NULL,
 CONSTRAINT [PK_CongTy] PRIMARY KEY CLUSTERED 
(
	[MaCongTy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DauThuoc]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DauThuoc](
	[MaDT] [nvarchar](50) NOT NULL,
	[TenDauThuoc] [nvarchar](150) NULL,
	[CongDung] [nvarchar](max) NULL,
	[CachDung] [nvarchar](max) NULL,
	[Image] [nvarchar](max) NULL,
	[Status] [nvarchar](max) NULL,
	[GiaBanLe] [int] NULL,
	[MaNSX] [nvarchar](50) NULL,
 CONSTRAINT [PK_DauThuoc] PRIMARY KEY CLUSTERED 
(
	[MaDT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DonVi]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonVi](
	[ID] [bigint] NOT NULL,
	[IDParent] [bigint] NULL,
	[Ten] [nvarchar](50) NULL,
	[Heso] [int] NULL,
	[MaDT] [nvarchar](50) NULL,
	[TenDinhNghia] [nvarchar](50) NULL,
 CONSTRAINT [PK_DonVi] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HoaDonMua]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDonMua](
	[MaHD] [nvarchar](50) NOT NULL,
	[MaKH] [nvarchar](50) NULL,
	[NgayMua] [datetime] NULL,
	[MaTK] [nvarchar](50) NULL,
	[TrangThai] [int] NULL,
	[MaKho] [nvarchar](50) NULL,
	[MaHoaDonVanChuyen] [nvarchar](50) NULL,
 CONSTRAINT [PK_HoaDonMua] PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HoaDonNhap]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDonNhap](
	[MaHD] [nvarchar](50) NOT NULL,
	[MaKho] [nvarchar](50) NULL,
	[MaTK] [nvarchar](50) NULL,
	[MaNSX] [nvarchar](50) NULL,
	[NgayNhap] [datetime] NULL,
	[GhiChu] [nvarchar](500) NULL,
 CONSTRAINT [PK_HoaDonNhap] PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HoaDonVanChuyen]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDonVanChuyen](
	[MaHoaDonVanChuyen] [nvarchar](50) NOT NULL,
	[MaNguoiVanChuyen] [nvarchar](50) NULL,
	[NgayGioVanChuyen] [datetime] NULL,
	[SoGioDuTinh] [int] NULL,
 CONSTRAINT [PK_HoaDonVanChuyen] PRIMARY KEY CLUSTERED 
(
	[MaHoaDonVanChuyen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HoaDonXuat]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDonXuat](
	[MaHD] [nvarchar](50) NOT NULL,
	[MaKho] [nvarchar](50) NULL,
	[MaTK] [nvarchar](50) NULL,
	[MaKH] [nvarchar](50) NULL,
	[NgayXuat] [datetime] NULL,
	[TrangThai] [int] NULL,
	[MaHoaDonMua] [nvarchar](50) NULL,
	[MaHoaDonVanChuyen] [nvarchar](50) NULL,
 CONSTRAINT [PK_HoaDonXuat] PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KeHoachLamViec]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KeHoachLamViec](
	[ID] [nvarchar](50) NOT NULL,
	[CongViec] [nvarchar](max) NULL,
	[TrangThai1] [int] NULL,
	[TrangThai2] [int] NULL,
	[GhiChu] [nvarchar](500) NULL,
	[MaTD] [nvarchar](50) NULL,
 CONSTRAINT [PK_KeHoachLamViec] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKH] [nvarchar](50) NOT NULL,
	[HoTen] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](500) NULL,
	[MaQuanHuyen] [int] NULL,
	[MaTinhThanh] [int] NULL,
	[SDT] [nvarchar](20) NULL,
	[Email] [nvarchar](150) NULL,
 CONSTRAINT [PK_KhachHang] PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Kho]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kho](
	[MaKho] [nvarchar](50) NOT NULL,
	[TenKho] [nvarchar](500) NULL,
	[DiaChi] [nvarchar](500) NULL,
	[SDT] [nvarchar](20) NULL,
 CONSTRAINT [PK_Kho] PRIMARY KEY CLUSTERED 
(
	[MaKho] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KhoDauThuoc]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhoDauThuoc](
	[MaKho] [nvarchar](50) NOT NULL,
	[MaDT] [nvarchar](50) NOT NULL,
	[MaDonVi] [bigint] NOT NULL,
	[SoLuongCon] [int] NULL,
 CONSTRAINT [PK_KhoDauThuoc] PRIMARY KEY CLUSTERED 
(
	[MaKho] ASC,
	[MaDT] ASC,
	[MaDonVi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KhoNhanVien]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhoNhanVien](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaKho] [nvarchar](50) NULL,
	[MaTK] [nvarchar](50) NULL,
	[ChucVu] [nvarchar](50) NULL,
 CONSTRAINT [PK_KhoNhaVien] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KhuyenMai]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhuyenMai](
	[ID] [nvarchar](50) NOT NULL,
	[TenChuongTrinh] [nvarchar](500) NULL,
	[ChuDe] [nvarchar](500) NULL,
	[NoiDung] [nvarchar](max) NULL,
	[Image] [nvarchar](500) NULL,
	[ThoiGianBatDau] [datetime] NULL,
	[ThoiGianKetThuc] [datetime] NULL,
 CONSTRAINT [PK_KhuyenMai] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KhuyenMaiDauThuoc]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhuyenMaiDauThuoc](
	[ID] [nvarchar](50) NOT NULL,
	[MaKM] [nvarchar](50) NULL,
	[MaDT] [nvarchar](50) NULL,
 CONSTRAINT [PK_KhuyenMaiDauThuoc] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhaSanXuat]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaSanXuat](
	[MaNSX] [nvarchar](50) NOT NULL,
	[TenNSX] [nvarchar](150) NULL,
	[DiaChi] [nvarchar](500) NULL,
	[SDT] [nvarchar](20) NULL,
	[Email] [nvarchar](150) NULL,
 CONSTRAINT [PK_NhaSanXuat] PRIMARY KEY CLUSTERED 
(
	[MaNSX] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhomDauThuoc]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhomDauThuoc](
	[MaNhomThuoc] [nvarchar](50) NOT NULL,
	[TenNhom] [nvarchar](150) NULL,
	[Image] [nvarchar](max) NULL,
	[Status] [nvarchar](max) NULL,
 CONSTRAINT [PK_NhomDauThuoc] PRIMARY KEY CLUSTERED 
(
	[MaNhomThuoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhomQuyen]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhomQuyen](
	[MaNhomQuyen] [int] IDENTITY(1,1) NOT NULL,
	[TenNhomQuyen] [nvarchar](150) NULL,
	[MoTa] [nvarchar](500) NULL,
 CONSTRAINT [PK_NhomQuyen] PRIMARY KEY CLUSTERED 
(
	[MaNhomQuyen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NhomQuyenRoute]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhomQuyenRoute](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaNhomQuyen] [int] NULL,
	[IDRoute] [int] NULL,
 CONSTRAINT [PK_NhomQuyenRoute] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Page]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Page](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[description] [nvarchar](max) NULL,
	[controller] [nvarchar](250) NULL,
	[namespace] [nvarchar](250) NULL,
 CONSTRAINT [PK_Page] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Position]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Position](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[MaTK] [nvarchar](50) NULL,
	[Lat] [nvarchar](150) NULL,
	[Lng] [nvarchar](150) NULL,
	[Time] [datetime] NULL,
 CONSTRAINT [PK_Position] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PositionNow]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PositionNow](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaTK] [nvarchar](50) NULL,
	[Lat] [nvarchar](150) NULL,
	[Lng] [nvarchar](150) NULL,
	[Time] [datetime] NULL,
 CONSTRAINT [PK_PositionNow] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[QuanHuyen]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuanHuyen](
	[ID] [int] NOT NULL,
	[TenQuanHuyen] [nvarchar](150) NULL,
	[IDTinhThanh] [int] NULL,
 CONSTRAINT [PK_QuanHuyen] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Route]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Route](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Namespace] [nvarchar](250) NULL,
	[Controller] [nvarchar](250) NULL,
	[Action] [nvarchar](250) NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_Route] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TagsDThuocNThuoc]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TagsDThuocNThuoc](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaDauThuoc] [nvarchar](50) NULL,
	[MaNhomThuoc] [nvarchar](50) NULL,
	[TenDinhNghia] [nvarchar](500) NULL,
 CONSTRAINT [PK_TagsDThuocNThuoc] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[MaTK] [nvarchar](50) NOT NULL,
	[TenTaiKhoan] [nvarchar](50) NULL,
	[MatKhau] [nvarchar](50) NULL,
	[HoTen] [nvarchar](50) NULL,
	[SDT] [nvarchar](20) NULL,
	[Email] [nvarchar](250) NULL,
	[avatar] [nvarchar](max) NULL,
	[MaQuyen] [int] NULL,
	[MaNhomQuyen] [int] NULL,
	[MaTD] [nvarchar](50) NULL,
	[MaKH] [nvarchar](50) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[MaTK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ThuChi]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThuChi](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Ten] [nvarchar](500) NULL,
	[Loai] [nvarchar](50) NULL,
	[NgayLap] [datetime] NULL,
	[NguoiLap] [nvarchar](50) NULL,
	[GiaTri] [int] NULL,
 CONSTRAINT [PK_Thu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TinhThanhPho]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TinhThanhPho](
	[ID] [int] NOT NULL,
	[TenTinh] [nvarchar](150) NULL,
 CONSTRAINT [PK_TinhThanhPho] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TrinhDuoc]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrinhDuoc](
	[MaTD] [nvarchar](50) NOT NULL,
	[HoTen] [nvarchar](50) NULL,
	[SDT] [nvarchar](20) NULL,
	[NgaySinh] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](max) NULL,
	[KhuVuc] [nvarchar](250) NULL,
	[TrangThai] [int] NULL,
	[DanhGia] [float] NULL,
	[LuongTieuThu] [int] NULL,
 CONSTRAINT [PK_TrinhDuoc] PRIMARY KEY CLUSTERED 
(
	[MaTD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TrinhDuocKhachHang]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrinhDuocKhachHang](
	[MaTD] [nvarchar](50) NOT NULL,
	[MaKH] [nvarchar](50) NOT NULL,
	[NgayBatDau] [datetime] NOT NULL,
	[NgayKetThuc] [datetime] NULL,
 CONSTRAINT [PK_TrinhDuocKhachHang_1] PRIMARY KEY CLUSTERED 
(
	[MaTD] ASC,
	[MaKH] ASC,
	[NgayBatDau] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TuVan]    Script Date: 22/05/2019 11:55:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TuVan](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[HoTen] [nvarchar](150) NULL,
	[SDT] [nvarchar](20) NULL,
	[Email] [nvarchar](150) NULL,
	[DiaChi] [nvarchar](500) NULL,
	[NoiDung] [nvarchar](max) NULL,
 CONSTRAINT [PK_TuVan] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VanChuyen]    Script Date: 22/05/2019 11:55:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VanChuyen](
	[MaNguoiVanChuyen] [nvarchar](50) NOT NULL,
	[HoTen] [nvarchar](50) NULL,
	[DiaChi] [nvarchar](500) NULL,
	[SDT] [nvarchar](20) NULL,
	[Email] [nvarchar](150) NULL,
	[TrangThai] [int] NULL,
 CONSTRAINT [PK_VanChuyen] PRIMARY KEY CLUSTERED 
(
	[MaNguoiVanChuyen] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[tong]    Script Date: 22/05/2019 11:55:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  create view [dbo].[tong] as   select [Ten] from DonVi where MaDT= N'DT000001'
GO
SET IDENTITY_INSERT [dbo].[ChamCong] ON 

INSERT [dbo].[ChamCong] ([ID], [MaTK], [DiaDiem], [ThoiGian], [XepLoai], [GhiChu]) VALUES (16, N'TK000002', N'20.9875893, 105.83585099999999', CAST(0x0000AA2C008CC628 AS DateTime), 1, NULL)
SET IDENTITY_INSERT [dbo].[ChamCong] OFF
SET IDENTITY_INSERT [dbo].[ChiTietChuyenKhoThuoc] ON 

INSERT [dbo].[ChiTietChuyenKhoThuoc] ([ID], [MaDT], [MaKhoChuyen], [DonVi], [Soluong], [MaKhoNhan], [NgayChuyen]) VALUES (1, N'DT000003', N'KO000001', NULL, 22, N'KO000004', CAST(0x863F0B00 AS Date))
INSERT [dbo].[ChiTietChuyenKhoThuoc] ([ID], [MaDT], [MaKhoChuyen], [DonVi], [Soluong], [MaKhoNhan], [NgayChuyen]) VALUES (4, N'DT000003', N'KO000004', NULL, 22, N'KO000002', CAST(0x863F0B00 AS Date))
INSERT [dbo].[ChiTietChuyenKhoThuoc] ([ID], [MaDT], [MaKhoChuyen], [DonVi], [Soluong], [MaKhoNhan], [NgayChuyen]) VALUES (6, N'DT000003', N'KO000001', NULL, 20, N'KO000002', CAST(0x8B3F0B00 AS Date))
INSERT [dbo].[ChiTietChuyenKhoThuoc] ([ID], [MaDT], [MaKhoChuyen], [DonVi], [Soluong], [MaKhoNhan], [NgayChuyen]) VALUES (7, N'DT000002', N'KO000001', NULL, 10, N'KO000004', CAST(0x8B3F0B00 AS Date))
INSERT [dbo].[ChiTietChuyenKhoThuoc] ([ID], [MaDT], [MaKhoChuyen], [DonVi], [Soluong], [MaKhoNhan], [NgayChuyen]) VALUES (8, N'DT000003', N'KO000003', NULL, 22, N'KO000004', CAST(0x8F3F0B00 AS Date))
INSERT [dbo].[ChiTietChuyenKhoThuoc] ([ID], [MaDT], [MaKhoChuyen], [DonVi], [Soluong], [MaKhoNhan], [NgayChuyen]) VALUES (10, N'DT000003', N'KO000001', NULL, 20, N'KO000004', CAST(0x9C3F0B00 AS Date))
INSERT [dbo].[ChiTietChuyenKhoThuoc] ([ID], [MaDT], [MaKhoChuyen], [DonVi], [Soluong], [MaKhoNhan], [NgayChuyen]) VALUES (11, N'DT000003', N'KO000004', NULL, 33, N'KO000003', CAST(0x9C3F0B00 AS Date))
SET IDENTITY_INSERT [dbo].[ChiTietChuyenKhoThuoc] OFF
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000001', N'DT000001', 1, 3, 300000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000002', N'DT000007', 22, 5, 500000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000003', N'DT000008', 29, 3, 600000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000003', N'DT000014', 48, 3, 600000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000004', N'DT000001', 1, 2, 300000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000005', N'DT000006', 21, 3, 300000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000006', N'DT000004', 13, 3, 300000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000007', N'DT000002', 5, 1, 100000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000008', N'DT000006', 21, 3, 30000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000009', N'DT000006', 21, 3, 100000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000012', N'DT000002', 5, 22, 220000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000013', N'DT000001', 1, 3, 300000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000013', N'DT000001', 2, 3, 600000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000014', N'DT000006', 21, 2, 300000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000015', N'DT000001', 3, 3, 60000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000015', N'DT000006', 22, 3, 300000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000015', N'DT000006', 23, 3, 30000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000016', N'DT000001', 1, 22, NULL)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000016', N'DT000001', 2, 22, NULL)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000016', N'DT000001', 3, 22, NULL)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000016', N'DT000001', 4, 29, NULL)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000016', N'DT000004', 13, 2, NULL)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000016', N'DT000004', 14, 1, NULL)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000016', N'DT000004', 15, 1, NULL)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000016', N'DT000005', 17, 1, NULL)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000016', N'DT000005', 18, 1, NULL)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000016', N'DT000005', 19, 1, NULL)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000016', N'DT000005', 20, 1, NULL)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000017', N'DT000007', 25, 2, NULL)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000018', N'DT000001', 1, 3, 9000000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000019', N'DT000001', 3, 20, 400000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000020', N'DT000007', 27, 3, 30000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000021', N'DT000013', 46, 14, 84000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000022', N'DT000013', 46, 24, 144000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000023', N'DT000008', 30, 1, 100000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000024', N'DT000006', 22, 2, 200000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000024', N'DT000006', 23, 2, 20000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000025', N'DT000001', 4, 1, 1000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000026', N'DT000006', 24, 1, 1000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000027', N'DT000001', 1, 222, 666000000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000027', N'DT000007', 26, 222, 22200000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000028', N'DT000001', 1, 4, 12000000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000028', N'DT000001', 2, 4, 1200000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000029', N'DT000001', 1, 8, 24000000)
INSERT [dbo].[ChiTietHoaDonMua] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000030', N'DT000001', 2, 4, 1200000)
INSERT [dbo].[ChiTietHoaDonNhap] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000001', N'DT000001', 1, 1, 3000000)
INSERT [dbo].[ChiTietHoaDonNhap] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000001', N'DT000001', 2, 4, 1200000)
INSERT [dbo].[ChiTietHoaDonNhap] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000001', N'DT000001', 3, 1, 20000)
INSERT [dbo].[ChiTietHoaDonNhap] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000002', N'DT000007', 25, 3, 3000000)
INSERT [dbo].[ChiTietHoaDonNhap] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000002', N'DT000007', 26, 3, 300000)
INSERT [dbo].[ChiTietHoaDonNhap] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HD000003', N'DT000001', 2, 1, 300000)
INSERT [dbo].[ChiTietHoaDonXuat] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HX000001', N'DT000001', 3, 20, 400000)
INSERT [dbo].[ChiTietHoaDonXuat] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HX000002', N'DT000007', 27, 3, 30000)
INSERT [dbo].[ChiTietHoaDonXuat] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HX000003', N'DT000013', 46, 14, 84000)
INSERT [dbo].[ChiTietHoaDonXuat] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HX000004', N'DT000013', 46, 24, 144000)
INSERT [dbo].[ChiTietHoaDonXuat] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HX000005', N'DT000008', 30, 1, 100000)
INSERT [dbo].[ChiTietHoaDonXuat] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HX000006', N'DT000006', 22, 2, 200000)
INSERT [dbo].[ChiTietHoaDonXuat] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HX000006', N'DT000006', 23, 2, 20000)
INSERT [dbo].[ChiTietHoaDonXuat] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HX000007', N'DT000001', 4, 1, 1000)
INSERT [dbo].[ChiTietHoaDonXuat] ([MaHD], [MaDT], [MaDonVi], [SoLuong], [DonGia]) VALUES (N'HX000008', N'DT000006', 24, 1, 1000)
INSERT [dbo].[CongTy] ([MaCongTy], [TenCongTy], [ToaDo1], [ToaDo2], [ToaDo3], [ToaDo4]) VALUES (N'CT000001', N'Công ty cổ phần dược Nghệ An', N'20.991372, 105.835544', N'20.988289, 105.838719', N'20.985494, 105.836412', N'20.988429, 105.831670')
INSERT [dbo].[CongTy] ([MaCongTy], [TenCongTy], [ToaDo1], [ToaDo2], [ToaDo3], [ToaDo4]) VALUES (N'CT000002', N'Công ty dược Thanh Xuân', N'20.9877728 , 105.83561809999999', N'20.9877728 , 105.83561809999999', N'20.9877728 , 105.83561809999999', N'20.9877728 , 105.83561809999999')
INSERT [dbo].[DauThuoc] ([MaDT], [TenDauThuoc], [CongDung], [CachDung], [Image], [Status], [GiaBanLe], [MaNSX]) VALUES (N'DT000001', N'Ampicillin', N'kháng sinh', N'Uống thuốc 4 lần/ ngày (cách mỗi 6 giờ), hoặc dùng theo chỉ dẫn của bác sĩ. Hãy dùng ampicillin khi bụng trống (1 giờ trước hoặc 2 giờ sau bữa ăn) với nhiều nước. ', N'Ampicillin.jpg', N'<p><strong>Ampicillin 500mg - Liều d&ugrave;ng đối với người lớn</strong></p>

<ul>
	<li>Người bị nhiễm khuẩn: uống 250 - 500mg v&agrave; c&aacute;ch 6h/lần.</li>
	<li>Bệnh nh&acirc;n bị vi&ecirc;m nội tạng: b&aacute;c sĩ sẽ chỉ định ti&ecirc;m ampicillin 2g v&agrave; c&aacute;ch 4h/lần. Đồng thời, kết hợp với gentamicin hoặc streptomycin.</li>
	<li>Bệnh nh&acirc;n bị vi&ecirc;m m&agrave;ng n&atilde;o:</li>
</ul>

<p>+ Ti&ecirc;m vỏ n&atilde;o: 10 - 50mg/ng&agrave;y, đồng thời d&ugrave;ng thuốc ti&ecirc;m kh&aacute;ng sinh tĩnh mạch;</p>

<p>+ Ti&ecirc;m tĩnh mạch: 200mg/kg/ng&agrave;y v&agrave; sẽ tiến h&agrave;nh ti&ecirc;m nhiều lần liền v&agrave; 4h/lần. Ngo&agrave;i ra, sẽ kết hợp với thuốc ti&ecirc;m kh&aacute;ng sinh kh&aacute;c.;</p>

<ul>
	<li>Người bị nhiễm tr&ugrave;ng huyết: 150 - 200mg/kg/ng&agrave;y.</li>
	<li>Những người bị nhiễm khuẩn nội t&acirc;m mạc: tiến h&agrave;nh ti&ecirc;m bắp/tĩnh mạch v&agrave; liều ti&ecirc;m 6h/lần.</li>
	<li>Người bị bị vi&ecirc;m ruột: uống ampicillin 500mg hay c&oacute; thể tiến h&agrave;nh ti&ecirc;m bắp tay/tĩnh mạch, liều d&ugrave;ng l&agrave; 6h/lần.</li>
	<li>Nhiễm tr&ugrave;ng da hoặc m&ocirc; mềm: ti&ecirc;m 250 - 500mg ti&ecirc;m ở bắp/tĩnh mạch v&agrave; c&aacute;ch 6h/lần.</li>
	<li>Nhiễm khuẩn trong ổ bụng: uống ampicillin 500mg hay c&oacute; ti&ecirc;m ở bắp/tĩnh mạch, c&aacute;ch 6h ti&ecirc;m một lần.</li>
	<li>Người mắc bệnh vi&ecirc;m họng:</li>
</ul>

<p>+ Sử dụng thuốc uống 250mg;</p>

<p>+ Ti&ecirc;m ampicillin: c&aacute;c b&aacute;c sĩ c&oacute; thể tiến h&agrave;nh ti&ecirc;m bắp/tĩnh mạch 250 - 500mg;</p>

<ul>
	<li>Điều trị bệnh nh&acirc;n bị vi&ecirc;m xoang:</li>
</ul>

<p>+ Uống 250mg v&agrave; c&aacute;ch 6h/lần;</p>

<p>+ Ti&ecirc;m bắp/t&iacute;nh mạch: 250 - 500mg;</p>

<ul>
	<li>Liều d&ugrave;ng đối với bệnh nh&acirc;n nhiễm tr&ugrave;ng h&ocirc; hấp tr&ecirc;n:</li>
</ul>

<p>+ Sử dụng thuốc uống 250mg;</p>

<p>+ B&ecirc;n cạnh đ&oacute;, c&ograve;n được điều trị bằng c&aacute;ch ti&ecirc;m bắp/tĩnh mạch với liều lượng 25- - 500mg;</p>

<ul>
	<li>Liều d&ugrave;ng đối với bệnh nh&acirc;n nhiễm khuẩn đường tiết niệu: uống ampicillin 500mg hay c&oacute; thể tiến h&agrave;nh ti&ecirc;m.</li>
</ul>

<p>Liều d&ugrave;ng để ph&ograve;ng ngừa được bệnh nhiễm khuẩn nh&oacute;m B đối với phụ nữ mang thai: ti&ecirc;m tĩnh mạch 2g đối với liều ban đầu. Tiếp đến ti&ecirc;m tĩnh mạch 1g v&agrave; liều d&ugrave;ng 4h/lần cho đến khi sinh.</p>

<ul>
	<li>Người mắc bệnh leptospirosis:</li>
</ul>

<p>+ Mắc bệnh ở mức độ trung b&igrave;nh đến nặng: c&aacute;c b&aacute;c sĩ sẽ tiến h&agrave;nh ti&ecirc;m tĩnh mạch với liều 0.5 - 1g;</p>

<p>+ Mức độ nhẹ: c&aacute;c b&aacute;c sĩ sẽ chỉ định uống ampicillin 500-700mg;</p>

<ul>
	<li>Vi&ecirc;m tai giữa: uống 500mg hay c&oacute; thể ti&ecirc;m bắp/tĩnh mạch khoảng tầm 1 - 2g. T&ugrave;y v&agrave;o mức độ nhiễm tr&ugrave;ng c&aacute;c b&aacute;c sĩ sẽ chỉ định được liều d&ugrave;ng tương ứng.</li>
	<li>Liều d&ugrave;ng đối với người phẫu thuật: Gh&eacute;p gan: ti&ecirc;m tĩnh mạch 1g ampicillin, b&ecirc;n cạnh đ&oacute; sẽ kết hợp ti&ecirc;m cefotaxime 1g khi g&acirc;y m&ecirc;. Mỗi giờ d&ugrave;ng khoảng từ 6h/lần v&agrave; d&ugrave;ng 48h sau khi đ&atilde; phẫu thuật kết th&uacute;c.</li>
</ul>

<p><strong>Liều d&ugrave;ng thuốc ampicillin đối với trẻ em</strong></p>

<p><strong><em>Trẻ bị nhiễm tr&ugrave;ng do vi khuẩn</em></strong></p>

<p><strong>* Trẻ sơ sinh</strong></p>

<p>Trẻ 7 ng&agrave;y tuổi hay nhỏ hơn, &lt;2kg: ti&ecirc;m bắp/tĩnh mạch 50mg/kg; liều ti&ecirc;m 12h/lần.</p>

<p>Trẻ 7 ng&agrave;y tuổi hay nhỏ hơn, &gt;2kg: ti&ecirc;m bắp/tĩnh mạch 50mg/kg, mỗi liều c&aacute;ch nhau 8h.</p>

<p>8 - 28 ng&agrave;y tuổi, &gt;2kg: ti&ecirc;m ở bắp/ tĩnh mạch 50mg/kg v&agrave; liều d&ugrave;ng tương ứng c&aacute;ch nhau 6h/lần.</p>

<p>8 - 28 ng&agrave;y tuổi, trẻ &lt;2kg: ti&ecirc;m bắp/tĩnh mạch 50mg/kg v&agrave; c&aacute;ch 8h/liều.</p>

<p><strong>* Trẻ &gt;1 th&aacute;ng tuổi</strong></p>

<p>Trường hợp nhiễm tr&ugrave;ng ở mức độ nhẹ đến trung b&igrave;nh: c&aacute;c b&aacute;c sĩ sẽ tiến h&agrave;nh ti&ecirc;m bắp/tĩnh mạch: 25 - 37.5mg/kg. Hay c&oacute; thể d&ugrave;ng thuốc uống 12.5 - 25mg/kg. Liều d&ugrave;ng tối đa đối với những đối tượng n&agrave;y l&agrave; 4g/ng&agrave;y.</p>
', 1000, N'SX000001')
INSERT [dbo].[DauThuoc] ([MaDT], [TenDauThuoc], [CongDung], [CachDung], [Image], [Status], [GiaBanLe], [MaNSX]) VALUES (N'DT000002', N'Amoxicillin_500mg_785', N'có tác dụng diệt khuẩn, do thuốc gắn vào một hoặc nhiều protein gắn penicillin của vi khuẩn để ức chế sinh tổng hợp peptidoglycan, là một thành phần quan trọng của thành tế bào vi khuẩn, cuối cùng vi khuẩn tự phân hủy do các enzym tự hủy của thành tế bào vi khuẩn', N'Theo chỉ dẫn của bác sỹ.', N'Amoxicillin_500mg_785.jpg', N'<h3>C&aacute;ch d&ugrave;ng&nbsp;<a href="http://bbu.vn/thuoc-khang-sinh-dieu-tri-ho-hap-duong-mat-tieu-hoa-tiet-nieu-sinh-duc-amoxicillin-500mg.html">Thuốc kh&aacute;ng sinh diệt khuẩn Amoxicillin</a></h3>

<p>&ndash; Theo chỉ dẫn của b&aacute;c sỹ.<br />
&ndash; Liều thường d&ugrave;ng:<br />
+ Người lớn: uống 1 &ndash; 2 vi&ecirc;n/lần v&agrave; 2 &ndash; 3 lần/ng&agrave;y.<br />
+ Trẻ em: chia nhỏ thuốc&nbsp; uống 25 &ndash; 50mg/kg/ng&agrave;y v&agrave; chia l&agrave;m 2 &ndash; 3 lần.</p>

<p><strong><a href="http://bbu.vn/thuoc-khang-sinh-dieu-tri-ho-hap-duong-mat-tieu-hoa-tiet-nieu-sinh-duc-amoxicillin-500mg.html">Thuốc kh&aacute;ng sinh diệt khuẩn Amoxicillin</a></strong>&nbsp;kh&ocirc;ng d&ugrave;ng cho trường hợp:</p>

<p>&ndash; Mẫn cảm với c&aacute;c penicillin, cephalosporin.<br />
&ndash; Bệnh nh&acirc;n bị tăng bạch cầu đơn nh&acirc;n nhiễm khuẩn</p>

<p>&ndash; Bệnh nh&acirc;n suy thận cần điều chỉnh liều.</p>

<p>&ndash; Thận trọng khi sử dụng thuốc cho phụ nữ c&oacute; thai v&agrave; cho con b&uacute;<br />
<strong>Lưu &yacute;:</strong></p>

<p>&ndash; Định kỳ kiểm tra chức năng gan, thận trong qu&aacute; tr&igrave;nh điều trị d&agrave;i ng&agrave;y.<br />
&ndash; Khi c&oacute; biểu hiện dị ứng phải ngưng uống thuốc ngay v&agrave; hỏi &yacute; kiến b&aacute;c sĩ.<br />
&ndash;Phụ nữ c&oacute; thai v&agrave; cho con b&uacute; chỉ d&ugrave;ng thuốc khi thật cần thiết.<br />
&ndash;Thận trọng khi sử dụng cho người l&aacute;i t&agrave;u xe hoặc vận h&agrave;nh m&aacute;y.</p>
', 1000, N'SX000001')
INSERT [dbo].[DauThuoc] ([MaDT], [TenDauThuoc], [CongDung], [CachDung], [Image], [Status], [GiaBanLe], [MaNSX]) VALUES (N'DT000003', N'khang sinh 151117', N'kháng sinh', N'kháng sinh', N'khang sinh 151117.jpg', N'', 1000, N'SX000001')
INSERT [dbo].[DauThuoc] ([MaDT], [TenDauThuoc], [CongDung], [CachDung], [Image], [Status], [GiaBanLe], [MaNSX]) VALUES (N'DT000004', N'levofloxacin', N'Bạn có thể sử dụng thuốc này điều trị một loạt các chứng bệnh nhiễm trùng do vi khuẩn. Levofloxacin thuộc nhóm thuốc kháng sinh quinolone', N'Bạn nên đọc kỹ Hướng dẫn sử dụng thuốc trước khi bạn bắt đầu dùng levofloxacin và mỗi lần tái sử dụng. Nếu bạn có bất kỳ thắc mắc nào hãy tham khảo ý kiến bác sĩ hoặc dược sĩ.', N'levofloxacin.jpg', N'<h3>T&aacute;c dụng của thuốc levofloxacin l&agrave; g&igrave;?</h3>

<p>Bạn c&oacute; thể sử dụng thuốc n&agrave;y điều trị một loạt c&aacute;c chứng bệnh nhiễm tr&ugrave;ng do vi khuẩn. Levofloxacin thuộc nh&oacute;m thuốc kh&aacute;ng sinh quinolone. Thuốc hoạt động bằng c&aacute;ch ngăn chặn sự tăng trưởng của vi khuẩn. Thuốc n&agrave;y sẽ kh&ocirc;ng hiệu qủa cho chứng nhiễm virus (như cảm lạnh th&ocirc;ng thường, c&uacute;m). Việc sử dụng khi kh&ocirc;ng cần thiết hoặc lạm dụng kh&aacute;ng sinh c&oacute; thể giảm hiệu quả của thuốc.</p>

<h3>Bạn n&ecirc;n d&ugrave;ng thuốc levofloxacin như thế n&agrave;o?</h3>

<p>Bạn n&ecirc;n đọc kỹ Hướng dẫn sử dụng thuốc trước khi bạn bắt đầu d&ugrave;ng levofloxacin v&agrave; mỗi lần t&aacute;i sử dụng. Nếu bạn c&oacute; bất kỳ thắc mắc n&agrave;o h&atilde;y tham khảo &yacute; kiến b&aacute;c sĩ hoặc dược sĩ.</p>

<p>Bạn n&ecirc;n d&ugrave;ng thuốc bằng c&aacute;ch uống theo chỉ dẫn của b&aacute;c sĩ, thường d&ugrave;ng một lần mỗi ng&agrave;y với thức ăn hoặc kh&ocirc;ng. Uống nhiều nước trong khi d&ugrave;ng thuốc, trừ khi c&oacute; chỉ dẫn kh&aacute;c của b&aacute;c sĩ.</p>

<p>Liều lượng v&agrave; thời gian điều trị được dựa tr&ecirc;n chức năng của thận, t&igrave;nh trạng sức khỏe v&agrave; đ&aacute;p ứng điều trị của bạn. Khi sử dụng ở trẻ em với những hạn chế của chứng nhiễm tr&ugrave;ng, liều lượng sẽ dựa tr&ecirc;n trọng lượng.</p>

<p>Kh&aacute;ng sinh hiệu quả tốt nhất khi lượng thuốc trong cơ thể của bạn được giữ ở mức ổn định. V&igrave; vậy, uống thuốc v&agrave;o một thời điểm nhất định mỗi ng&agrave;y.</p>

<p>Tiếp tục d&ugrave;ng thuốc n&agrave;y cho đến khi ho&agrave;n th&agrave;nh đủ liều lượng quy định, ngay cả khi c&aacute;c triệu chứng biến mất sau một v&agrave;i ng&agrave;y. Việc ngưng d&ugrave;ng thuốc qu&aacute; sớm c&oacute; thể khiến c&aacute;c vi khuẩn tiếp tục ph&aacute;t triển, trong đ&oacute; c&oacute; thể dẫn đến t&aacute;i nhiễm tr&ugrave;ng.</p>

<p>Bạn cần d&ugrave;ng thuốc &iacute;t nhất 2 giờ trước hoặc 2 giờ sau khi d&ugrave;ng c&aacute;c sản phẩm kh&aacute;c c&oacute; thể kết hợp với thuốc v&agrave; l&agrave;m giảm hiệu quả của n&oacute;. Hỏi dược sĩ về c&aacute;c sản phẩm kh&aacute;c bạn đang d&ugrave;ng như: quinapril, vitamin hoặc kho&aacute;ng chất (bao gồm cả sắt v&agrave; chất bổ sung kẽm) v&agrave; c&aacute;c sản phẩm c&oacute; chứa magi&ecirc;, nh&ocirc;m, orcalcium (chẳng hạn như&nbsp;<a href="https://hellobacsi.com/class/thuoc-khang-axit-chong-trao-nguoc-chong-loet/" target="_blank">thuốc kh&aacute;ng axit</a>, dung dịch didanosine, bổ sung canxi). H&atilde;y cho b&aacute;c sĩ biết nếu t&igrave;nh trạng của bạn kh&ocirc;ng được cải thiện.</p>

<h3>Bạn n&ecirc;n bảo quản thuốc levofloxacin như thế n&agrave;o?</h3>

<p>Bạn n&ecirc;n bảo quản ở nhiệt độ ph&ograve;ng, tr&aacute;nh ẩm v&agrave; tr&aacute;nh &aacute;nh s&aacute;ng. Kh&ocirc;ng bảo quản trong ph&ograve;ng tắm hoặc trong ngăn đ&aacute;. Bạn n&ecirc;n nhớ rằng mỗi loại thuốc c&oacute; thể c&oacute; c&aacute;c phương ph&aacute;p bảo quản kh&aacute;c nhau. V&igrave; vậy,&nbsp; bạn n&ecirc;n đọc kỹ hướng dẫn bảo quản tr&ecirc;n bao b&igrave;, hoặc hỏi dược sĩ. Giữ thuốc tr&aacute;nh xa tầm tay trẻ em v&agrave;&nbsp; th&uacute; nu&ocirc;i.</p>

<p>Bạn kh&ocirc;ng n&ecirc;n vứt thuốc v&agrave;o toilet hoặc đường ống dẫn nước trừ khi c&oacute; y&ecirc;u cầu. Thay v&igrave; vậy, h&atilde;y vứt&nbsp; thuốc đ&uacute;ng c&aacute;ch khi thuốc qu&aacute; hạn hoặc kh&ocirc;ng thể sử dụng. Bạn c&oacute; thể tham khảo &yacute; kiến dược sĩ hoặc&nbsp; c&ocirc;ng ty xử l&yacute; r&aacute;c thải địa phương về c&aacute;ch ti&ecirc;u hủy thuốc an to&agrave;n.</p>

<h2>Liều d&ugrave;ng</h2>

<p><strong>Những th&ocirc;ng tin được cung cấp kh&ocirc;ng thể thay thế cho lời khuy&ecirc;n của c&aacute;c chuy&ecirc;n vi&ecirc;n y tế. H&atilde;y lu&ocirc;n tham khảo &yacute; kiến b&aacute;c sĩ hoặc dược sĩ trước khi quyết định d&ugrave;ng thuốc.</strong></p>

<h3>Liều d&ugrave;ng thuốc levofloxacin cho người lớn như thế n&agrave;o?</h3>

<p><em>Liều d&ugrave;ng th&ocirc;ng thường cho người lớn mắc bệnh</em>&nbsp;<em>vi&ecirc;m phổi bệnh viện:</em></p>

<p>Bạn d&ugrave;ng 750 mg uống hay ti&ecirc;m tĩnh mạch mỗi 24 giờ trong 7 đến 14 ng&agrave;y</p>

<p><em>Liều d&ugrave;ng th&ocirc;ng thường cho người lớn mắc bệnh</em>&nbsp;<em>vi&ecirc;m phổi:</em></p>

<p>Bạn d&ugrave;ng 750 mg uống hay ti&ecirc;m tĩnh mạch mỗi 24 giờ trong 5 ng&agrave;y</p>

<p><em>Liều d&ugrave;ng th&ocirc;ng thường cho người lớn mắc&nbsp;<a href="https://hellobacsi.com/benh/viem-xoang/">bệnh vi&ecirc;m xoang</a>:</em></p>

<p>Bạn d&ugrave;ng 500 mg uống hay ti&ecirc;m tĩnh mạch mỗi 24 giờ trong 10 đến 14 ng&agrave;y hoặc Bạn d&ugrave;ng 750 mg uống hay ti&ecirc;m tĩnh mạch mỗi 24 giờ trong 5 ng&agrave;y</p>

<p><em>Liều d&ugrave;ng th&ocirc;ng thường cho người lớn mắc bệnh&nbsp;</em><em><a href="https://hellobacsi.com/benh/viem-phe-quan-cap/">vi&ecirc;m phế quản</a>:</em></p>

<p>Bạn d&ugrave;ng 500 mg uống hay ti&ecirc;m tĩnh mạch một lần một ng&agrave;y trong 7 ng&agrave;y</p>

<p><em>Liều d&ugrave;ng th&ocirc;ng thường cho người lớn mắc bệnh&nbsp;</em><em>vi&ecirc;m da hoặc nhiễm tr&ugrave;ng m&ocirc; mềm:</em></p>

<p>Đối với trường hợp nhiễm tr&ugrave;ng kh&ocirc;ng biến chứng, bạn d&ugrave;ng 500 mg uống hay ti&ecirc;m tĩnh mạch một lần một ng&agrave;y trong 7-10 ng&agrave;y</p>

<p>Đối với trường hợp nhiễm tr&ugrave;ng biến chứng, bạn d&ugrave;ng 750 mg uống hay ti&ecirc;m tĩnh mạch một lần một ng&agrave;y trong 7-14 ng&agrave;y</p>

<p><em>Liều d&ugrave;ng th&ocirc;ng thường cho người lớn mắc bệnh&nbsp;<a href="https://hellobacsi.com/benh/viem-tuyen-tien-liet/">vi&ecirc;m tuyến tiền liệt</a>:</em></p>

<p>Bạn d&ugrave;ng 500 mg uống hay ti&ecirc;m tĩnh mạch mỗi 24 giờ trong 28 ng&agrave;y</p>

<p><em>Liều d&ugrave;ng th&ocirc;ng thường cho người lớn mắc bệnh&nbsp;</em><em><a href="https://hellobacsi.com/benh/nhiem-trung-duong-tiet-nieu/">nhiễm tr&ugrave;ng đường tiết niệu</a>:</em></p>

<p>Đối với trường hợp nhiễm tr&ugrave;ng biến chứng:</p>

<ul>
	<li>Do vi khuẩn&nbsp;<em>Enterococcus faecalis</em>,&nbsp;<em>Enterobacter cloacae</em>,&nbsp;<em>E coli</em>,&nbsp;<em>K pneumoniae</em>,&nbsp;<em>Proteus mirabilis</em>&nbsp;hoặc&nbsp;<em>Pseudomonas aeruginosa</em>, bạn d&ugrave;ng 250 mg uống hay ti&ecirc;m tĩnh mạch một lần một ng&agrave;y trong 10 ng&agrave;y.</li>
	<li>Do khuẩn&nbsp;<em>E coli</em>,&nbsp;<em>K pneumoniae</em>&nbsp;hoặc&nbsp;<em>P mirabilis</em>, bạn d&ugrave;ng 750 mg uống hay ti&ecirc;m tĩnh mạch một lần một ng&agrave;y trong 5 ng&agrave;y.</li>
</ul>

<p>Đối với trường hợp nhiễm tr&ugrave;ng kh&ocirc;ng c&oacute; biến chứng: bạn d&ugrave;ng 250 mg uống hay ti&ecirc;m tĩnh mạch một lần một ng&agrave;y trong 3 ng&agrave;y.</p>

<p><em>Liều d&ugrave;ng th&ocirc;ng thường cho người lớn mắc&nbsp;<a href="https://hellobacsi.com/benh/viem-dai-be-than/">bệnh vi&ecirc;m bể thận</a></em>&nbsp;<em>&ndash; cấp t&iacute;nh:</em></p>

<p>Đối với trường hợp do khuẩn&nbsp;<em>Escherichia coli</em>, bạn d&ugrave;ng 250 mg uống hay ti&ecirc;m tĩnh mạch một lần một ng&agrave;y trong 10 ng&agrave;y.</p>

<p>Đối với trường hợp do khuẩn&nbsp;<em>E coli</em>&nbsp;(kể cả trường hợp c&oacute; nhiễm khuẩn đồng thời), bạn d&ugrave;ng 750 mg uống hay ti&ecirc;m tĩnh mạch một lần một ng&agrave;y trong 5 ng&agrave;y.</p>

<p><em>Liều d&ugrave;ng th&ocirc;ng thường cho người lớn mắc bệnh v</em><em>i&ecirc;m b&agrave;ng quang:</em></p>

<p>Bạn d&ugrave;ng 250 mg uống hay ti&ecirc;m tĩnh mạch một lần một ng&agrave;y trong 3 ng&agrave;y</p>

<p><em>Liều d&ugrave;ng th&ocirc;ng thường cho người lớn&nbsp;</em><em>điều trị dự ph&ograve;ng Anthrax</em>:</p>

<p>Liều dự ph&ograve;ng sau phơi nhiễm với vi khuẩn Bacillus anthracis h&ocirc; hấp l&agrave; 500 mg uống hay ti&ecirc;m tĩnh mạch d&ugrave;ng một lần một ng&agrave;y trong v&ograve;ng 60 ng&agrave;y sau khi tiếp x&uacute;c.</p>

<p><em>Liều d&ugrave;ng th&ocirc;ng thường cho người lớn mắc bệnh d</em><em>ịch hạch</em>:</p>

<p>Để điều trị c&aacute;c bệnh dịch hạch (bao gồm cả vi&ecirc;m phổi v&agrave; nhiễm tr&ugrave;ng huyết bệnh dịch hạch) v&agrave; điều trị dự ph&ograve;ng, bạn d&ugrave;ng 500 mg uống hay ti&ecirc;m tĩnh mạch một lần một ng&agrave;y trong 10-14 ng&agrave;y.</p>

<p>Việc d&ugrave;ng thuốc n&ecirc;n bắt đầu c&agrave;ng sớm c&agrave;ng tốt sau khi bị nghi ngờ hoặc đ&atilde; x&aacute;c định tiếp x&uacute;c với virus&nbsp;<em>Yersinia pestis</em>. Liều cao (750 mg uống hay ti&ecirc;m tĩnh mạch một lần một ng&agrave;y) c&oacute; thể được sử dụng để điều trị c&aacute;c bệnh dịch hạch nếu c&oacute; chỉ định l&acirc;m s&agrave;ng.</p>

<p><em>Liều d&ugrave;ng th&ocirc;ng thường cho người lớn dự ph&ograve;ng&nbsp;</em><em>dịch hạch</em>:</p>

<p>Để điều trị c&aacute;c bệnh dịch hạch (bao gồm cả vi&ecirc;m phổi v&agrave; nhiễm tr&ugrave;ng huyết bệnh dịch hạch) v&agrave; điều trị dự ph&ograve;ng, bạn d&ugrave;ng 500 mg uống hay ti&ecirc;m tĩnh mạch một lần một ng&agrave;y trong 10-14 ng&agrave;y.</p>

<p>Việc d&ugrave;ng thuốc n&ecirc;n bắt đầu c&agrave;ng sớm c&agrave;ng tốt sau khi bị nghi ngờ hoặc đ&atilde; x&aacute;c định tiếp x&uacute;c với virus&nbsp;<em>Yersinia pestis</em>. Liều cao (750 mg uống hay ti&ecirc;m tĩnh mạch một lần một ng&agrave;y) c&oacute; thể được sử dụng để điều trị c&aacute;c bệnh dịch hạch nếu c&oacute; chỉ định l&acirc;m s&agrave;ng.</p>

<p><em>Liều d&ugrave;ng th&ocirc;ng thường cho người lớn mắc bệnh</em><em>&nbsp;virus Bacillus anthracis:</em></p>

<p>Liều cấp cứu điều trị phổ biến l&agrave; 500 mg uống hay ti&ecirc;m tĩnh mạch một lần một ng&agrave;y trong 60 ng&agrave;y.</p>

<p><em>Liều d&ugrave;ng th&ocirc;ng thường cho người lớn mắc bệnh&nbsp;</em><em>lao hoạt động</em>:</p>

<p>Bạn d&ugrave;ng 500-1000 mg uống hoặc ti&ecirc;m tĩnh mạch một lần một ng&agrave;y.</p>

<p><em>Liều d&ugrave;ng th&ocirc;ng thường cho người lớn mắc bệnh&nbsp;</em><em>vi&ecirc;m niệu đạo kh&ocirc;ng phải do lậu cầu:</em></p>

<p>Theo CDC, bạn d&ugrave;ng 500 mg uống một lần mỗi ng&agrave;y trong 7 ng&agrave;y.</p>

<p><em>Liều d&ugrave;ng th&ocirc;ng thường cho người lớn mắc bệnh n</em><em>hiễm khuẩn Chlamydia</em>:</p>

<p>Theo CDC, bạn d&ugrave;ng 500 mg uống một lần mỗi ng&agrave;y trong 7 ng&agrave;y.</p>

<p><em>Liều d&ugrave;ng th&ocirc;ng thường cho người lớn mắc bệnh&nbsp;</em><em>vi&ecirc;m v&ugrave;ng xương chậu (PID):</em></p>

<p>Đối với bệnh nhẹ đến nặng vừa, bạn d&ugrave;ng 500 mg uống mỗi ng&agrave;y một lần trong 14 ng&agrave;y.</p>

<p><em>Liều d&ugrave;ng th&ocirc;ng thường cho người lớn mắc bệnh&nbsp;</em><em>vi&ecirc;m m&agrave;o tinh ho&agrave;n &ndash; l&acirc;y truyền qua đường t&igrave;nh dục:</em></p>

<p>Theo CDC, bạn d&ugrave;ng 500 mg uống mỗi ng&agrave;y một lần trong 10 ng&agrave;y.</p>

<h3>Liều d&ugrave;ng thuốc levofloxacin cho trẻ em như thế n&agrave;o?</h3>

<p><em>Liều d&ugrave;ng th&ocirc;ng thường cho trẻ em d</em><em>ự ph&ograve;ng Anthrax hoặc điều trị bệnh dịch hạch</em>:</p>

<p>Điều trị dự ph&ograve;ng sau phơi nhiễm với khuẩn đường h&ocirc; hấp anthracis B hoặc điều trị c&aacute;c bệnh dịch hạch (bao gồm cả vi&ecirc;m phổi v&agrave; nhiễm tr&ugrave;ng huyết bệnh dịch hạch) v&agrave; điều trị dự ph&ograve;ng:</p>

<ul>
	<li>Trẻ 6 th&aacute;ng tuổi trở l&ecirc;n v&agrave; nhẹ hơn 50 kg, bạn d&ugrave;ng 8 mg/kg uống hoặc ti&ecirc;m tĩnh mạch mỗi 12 giờ trong 60 ng&agrave;y. Bạn kh&ocirc;ng d&ugrave;ng vượt qu&aacute; 250 mg mỗi liều cho bệnh nh&acirc;n.</li>
	<li>Trẻ 6 th&aacute;ng tuổi trở l&ecirc;n v&agrave; nặng 50 kg trở l&ecirc;n, bạn d&ugrave;ng 500 mg uống hay ti&ecirc;m tĩnh mạch mỗi 24 giờ trong 60 ng&agrave;y.</li>
</ul>

<p><em>Liều d&ugrave;ng th&ocirc;ng thường cho trẻ em dự ph&ograve;ng d</em><em>ịch hạch:</em></p>

<p>Điều trị c&aacute;c bệnh dịch hạch (bao gồm cả vi&ecirc;m phổi v&agrave; nhiễm tr&ugrave;ng huyết bệnh dịch hạch) v&agrave; điều trị dự ph&ograve;ng:</p>

<ul>
	<li>Trẻ 6 th&aacute;ng tuổi trở l&ecirc;n v&agrave; nhẹ hơn 50 kg, bạn d&ugrave;ng 8 mg/kg uống hoặc ti&ecirc;m tĩnh mạch mỗi 12 giờ trong 10 đến 14 ng&agrave;y. Bạn kh&ocirc;ng d&ugrave;ng vượt qu&aacute; 250 mg mỗi liều cho bệnh nh&acirc;n.</li>
	<li>Trẻ 6 th&aacute;ng tuổi trở l&ecirc;n v&agrave; nặng 50 kg trở l&ecirc;n, bạn d&ugrave;ng 500 mg uống hay ti&ecirc;m tĩnh mạch mỗi 24 giờ trong 10 đến 14 ng&agrave;y.</li>
</ul>

<h3>Thuốc levofloxacin c&oacute; những dạng v&agrave; h&agrave;m lượng n&agrave;o?</h3>

<p>Levofloxacin c&oacute; những dạng v&agrave; h&agrave;m lượng sau:</p>

<ul>
	<li>Vi&ecirc;n bao 500 mg, 250 mg;</li>
	<li>Levofloxacin hemihydrate ti&ecirc;m 500 mg/100 ml, 250 mg/50 ml;</li>
	<li>Levofloxacin hemihydrate dung dịch nhỏ mắt 5 mg/ml;</li>
	<li>Vi&ecirc;n n&eacute;n 100 mg.</li>
</ul>

<h2>T&aacute;c dụng phụ</h2>

<h3>Bạn sẽ gặp t&aacute;c dụng phụ n&agrave;o khi d&ugrave;ng thuốc levofloxacin?</h3>

<p>Gọi cấp cứu nếu bạn c&oacute; bất cứ dấu hiệu dị ứng: ph&aacute;t ban; kh&oacute; thở; sưng mặt, m&ocirc;i, lưỡi hoặc họng.</p>

<p>Ngừng sử dụng levofloxacin v&agrave; gọi cho b&aacute;c sĩ ngay nếu bạn c&oacute; t&aacute;c dụng phụ nghi&ecirc;m trọng như:</p>

<ul>
	<li>Đau ngực v&agrave; ch&oacute;ng mặt nặng, ngất,&nbsp;<a href="https://hellobacsi.com/benh/tim-dap-nhanh/" target="_blank">tim đập nhanh</a>&nbsp;;</li>
	<li>Đau đột ngột, khớp k&ecirc;u răng rắc, bầm t&iacute;m, sưng, đau, cứng khớp, hoặc mất khả năng cử động ở bất kỳ khớp xương n&agrave;o;</li>
	<li>Ti&ecirc;u chảy nước hoặc c&oacute; m&aacute;u;</li>
	<li>Nhầm lẫn, ảo gi&aacute;c, trầm cảm, run, cảm gi&aacute;c, suy nghĩ hay lo lắng bồn chồn bất thường, mất ngủ, &aacute;c mộng, động kinh (co giật);</li>
	<li>Nhức đầu dữ dội, &ugrave; tai, buồn n&ocirc;n, c&aacute;c vấn đề về thị lực, đau ph&iacute;a sau mắt ;</li>
	<li>Da t&aacute;i, sốt, suy nhược, dễ bị bầm t&iacute;m hoặc chảy m&aacute;u;</li>
	<li>Buồn n&ocirc;n, đau bụng tr&ecirc;n, ngứa, ch&aacute;n ăn, nước tiểu đậm m&agrave;u, ph&acirc;n m&agrave;u đất s&eacute;t, v&agrave;ng da (v&agrave;ng da hoặc mắt);</li>
	<li>Đi tiểu &iacute;t hơn b&igrave;nh thường hoặc kh&ocirc;ng thể tiểu;</li>
	<li>T&ecirc;, đau r&aacute;t, ngứa ran ở b&agrave;n tay hoặc b&agrave;n ch&acirc;n</li>
	<li>Dấu hiệu ph&aacute;t ban da, d&ugrave; nhẹ;</li>
	<li>Phản ứng da nghi&ecirc;m trọng &ndash; sốt, đau họng, sưng mặt hoặc lưỡi, r&aacute;t mắt, đau da, ph&aacute;t ban da đỏ hoặc t&iacute;m lan rộng (đặc biệt l&agrave; ở mặt hoặc cơ thể ph&iacute;a tr&ecirc;n) g&acirc;y phồng rộp v&agrave; bong tr&oacute;c.</li>
</ul>

<p>T&aacute;c dụng phụ &iacute;t nghi&ecirc;m trọng c&oacute; thể bao gồm:</p>

<ul>
	<li>Ti&ecirc;u chảy nhẹ, t&aacute;o b&oacute;n, n&ocirc;n mửa;</li>
	<li>Kh&oacute; ngủ (mất ngủ);</li>
	<li>Đau đầu nhẹ hoặc ch&oacute;ng mặt</li>
	<li>Ngứa &acirc;m đạo hoặc tiết dịch.</li>
</ul>

<p>Kh&ocirc;ng phải ai cũng gặp c&aacute;c t&aacute;c dụng phụ như tr&ecirc;n. C&oacute; thể c&oacute; c&aacute;c t&aacute;c dụng phụ kh&aacute;c kh&ocirc;ng được đề cập. Nếu bạn c&oacute; bất kỳ thắc mắc n&agrave;o về c&aacute;c t&aacute;c dụng phụ, h&atilde;y tham khảo &yacute; kiến b&aacute;c sĩ hoặc dược sĩ.</p>

<h2>Thận trọng trước khi d&ugrave;ng</h2>

<h3>Trước khi d&ugrave;ng thuốc levofloxacin bạn n&ecirc;n biết những g&igrave;?</h3>

<p>Trước khi d&ugrave;ng thuốc levofloxacin bạn n&ecirc;n ch&uacute; &yacute; những điều sau:</p>

<ul>
	<li>N&oacute;i với b&aacute;c sĩ v&agrave; dược sĩ nếu bạn bị dị ứng hoặc c&oacute; phản ứng nghi&ecirc;m trọng với levofloxacin; bất kỳ kh&aacute;ng sinh quinolone hoặc kh&aacute;ng sinh fluoroquinolone kh&aacute;c như&nbsp;<a href="https://hellobacsi.com/thuoc/ciprofloxacin/" target="_blank">ciprofloxacin&nbsp;</a>(Cipro&reg;), gatifloxacin (Tequin&reg; &ndash; hiện kh&ocirc;ng lưu h&agrave;nh ở Mỹ), gemifloxacin, lomefloxacin (Maxaquin&reg; &ndash; kh&ocirc;ng lưu h&agrave;nh ở Mỹ), moxifloxacin (Avelox&reg;), axit nalidixic (neggram&reg;), norfloxacin (Noroxin&reg;), ofloxacin (Floxin&reg;), v&agrave; sparfloxacin (Zagam&reg; &ndash; hiện kh&ocirc;ng lưu h&agrave;nh ở Mỹ); hoặc bất kỳ loại thuốc n&agrave;o kh&aacute;c, hoặc nếu bạn bị dị ứng với bất kỳ th&agrave;nh phần trong vi&ecirc;n thuốc hoặc dung dịch levofloxacin. Hỏi dược sĩ hoặc kiểm tra hướng dẫn thuốc về danh s&aacute;ch c&aacute;c th&agrave;nh phần.</li>
	<li>N&oacute;i với b&aacute;c sĩ v&agrave; dược sĩ về c&aacute;c thuốc k&ecirc; theo toa v&agrave; kh&ocirc;ng k&ecirc; theo toa kh&aacute;c, vitamin v&agrave; c&aacute;c chất bổ sung dinh dưỡng m&agrave; bạn đang d&ugrave;ng hoặc dự định d&ugrave;ng. Bạn cần chắc chắn đề cập đến c&aacute;c loại thuốc được liệt k&ecirc; sau đ&acirc;y: thuốc chống đ&ocirc;ng (&ldquo;pha lo&atilde;ng m&aacute;u&rdquo;) như&nbsp;<a href="https://hellobacsi.com/thuoc/warfarin/" target="_blank">warfarin&nbsp;</a>(Coumadin&reg;, Jantoven&reg;); thuốc chống trầm cảm n&agrave;o đ&oacute;; thuốc chống loạn thần (thuốc để điều trị bệnh t&acirc;m thần); cyclosporine (Gengraf&reg;, Neoral&reg;, SANDIMUNE&reg;); thuốc lợi tiểu (&ldquo;thuốc nước&rdquo;); insulin; thuốc uống cho bệnh tiểu đường như glyburide (diabeta, trong Glucovance&reg;, Micronase&reg;, những thuốc kh&aacute;c); một số thuốc cho tim đập kh&ocirc;ng đều như amiodarone (Cordarone&reg;), procainamide (Procanbid&reg;), quinidine, v&agrave; sotalol (Betapace&reg;, Betapace&reg; AF, Sorine&reg;); thuốc kh&aacute;ng vi&ecirc;m kh&ocirc;ng steroid (nsaids) như ibuprofen (Advil&reg;, Motrin&reg;, những thuốc kh&aacute;c) v&agrave; naproxen (Aleve&reg;, Naprosyn, những thuốc kh&aacute;c); tacrolimus (Prograf&reg;); hoặc theophylline (Elixophyllin&reg;, Theo-24&reg;, Uniphyl&reg;, những thuốc kh&aacute;c). B&aacute;c sĩ c&oacute; thể cần phải thay đổi liều thuốc của bạn hoặc theo d&otilde;i bạn một c&aacute;ch cẩn thận cho c&aacute;c t&aacute;c dụng phụ.</li>
	<li>Nếu bạn đang uống thuốc kh&aacute;ng acid c&oacute; chứa nh&ocirc;m hydroxide hay magnesium hydroxide (Maalox&reg;, Mylanta&reg;, Tums&reg;, những thuốc kh&aacute;c), didanosine (Videx&reg;), sucralfate (CARAFATE&reg;), hoặc vitamin hoặc kho&aacute;ng chất c&oacute; chứa sắt hoặc kẽm, d&ugrave;ng thuốc 2 giờ trước hoặc sau khi d&ugrave;ng levofloxacin.</li>
	<li>N&oacute;i với b&aacute;c sĩ nếu bạn hay bất cứ ai trong gia đ&igrave;nh bạn c&oacute; hay đ&atilde; từng c&oacute; bệnh QT k&eacute;o d&agrave;i (một vấn đề tim hiếm gặp m&agrave; c&oacute; thể g&acirc;y ra chứng tim đập kh&ocirc;ng đều, ngất xỉu, hoặc tử vong đột ngột) hoặc nhịp tim bất thường v&agrave; nếu bạn c&oacute; hay đ&atilde; từng c&oacute; vấn đề thần kinh; mức độ kali thấp trong m&aacute;u; nhịp tim chậm; xơ cứng động mạch n&atilde;o (thu hẹp c&aacute;c mạch m&aacute;u trong hoặc gần n&atilde;o c&oacute; thể dẫn đến đột quỵ hoặc đột quỵ nhỏ); co giật; đau ngực; hoặc bệnh gan.</li>
	<li>N&oacute;i với b&aacute;c sĩ của bạn nếu bạn đang mang thai, dự định c&oacute; thai, đang cho con b&uacute;. Nếu bạn c&oacute; thai trong khi d&ugrave;ng levofloxacin, gọi b&aacute;c sĩ của bạn.</li>
	<li>Levofloxacin c&oacute; thể g&acirc;y l&uacute; lẫn, ch&oacute;ng mặt, cho&aacute;ng v&aacute;ng, v&agrave; mệt mỏi. Kh&ocirc;ng l&aacute;i xe, vận h&agrave;nh m&aacute;y m&oacute;c, hoặc tham gia v&agrave;o c&aacute;c hoạt động đ&ograve;i hỏi sự tỉnh t&aacute;o hoặc phối hợp cho đến khi bạn biết được thuốc n&agrave;y ảnh hưởng đến bạn như thế n&agrave;o.</li>
	<li>L&ecirc;n kế hoạch để tr&aacute;nh tiếp x&uacute;c kh&ocirc;ng cần thiết hoặc k&eacute;o d&agrave;i với &aacute;nh nắng v&agrave; &aacute;nh s&aacute;ng cực t&iacute;m (giường tắm nắng v&agrave; đ&egrave;n cực t&iacute;m) ,mặc quần &aacute;o bảo hộ, k&iacute;nh m&aacute;t, v&agrave; kem chống nắng. Levofloxacin c&oacute; thể l&agrave;m cho l&agrave;n da của bạn nhạy cảm với &aacute;nh s&aacute;ng mặt trời hoặc &aacute;nh s&aacute;ng cực t&iacute;m. Nếu da của bạn trở n&ecirc;n ửng đỏ, sưng, hoặc phồng rộp như bị ch&aacute;y nắng, h&atilde;y gọi cho b&aacute;c sĩ của bạn.</li>
</ul>

<h3>Những điều cần lưu &yacute; nếu bạn đang mang thai hoặc cho con b&uacute;</h3>

<p>Vẫn chưa c&oacute; đầy đủ c&aacute;c nghi&ecirc;n cứu để x&aacute;c định rủi ro khi d&ugrave;ng thuốc n&agrave;y trong thời kỳ mang thai hoặc cho con b&uacute;. Trước khi d&ugrave;ng thuốc, h&atilde;y lu&ocirc;n hỏi &yacute; kiến b&aacute;c sĩ để c&acirc;n nhắc giữa lợi &iacute;ch v&agrave; nguy cơ.</p>

<p>Theo Cục quản l&yacute; Thực phẩm v&agrave; Dược phẩm Hoa Kỳ (FDA), thuốc n&agrave;y thuộc nh&oacute;m thuốc N đối với thai&nbsp; kỳ. Bạn c&oacute; thể tham khảo bảng ph&acirc;n loại thuốc d&ugrave;ng cho phụ nữ c&oacute; thai dưới đ&acirc;y:</p>

<ul>
	<li>A= Kh&ocirc;ng c&oacute; nguy cơ;</li>
	<li>B = Kh&ocirc;ng c&oacute; nguy cơ trong v&agrave;i nghi&ecirc;n cứu;</li>
	<li>C = C&oacute; thể c&oacute; nguy cơ;</li>
	<li>D = C&oacute; bằng chứng về nguy cơ;</li>
	<li>X = Chống chỉ định;</li>
	<li>N = Vẫn chưa biết.</li>
</ul>

<h2>Tương t&aacute;c thuốc</h2>

<h3>Thuốc levofloxacin c&oacute; thể tương t&aacute;c với thuốc n&agrave;o?</h3>

<p>Tương t&aacute;c thuốc c&oacute; thể l&agrave;m thay đổi khả năng hoạt động của thuốc hoặc gia tăng ảnh hưởng của c&aacute;c t&aacute;c dụng phụ. T&agrave;i liệu n&agrave;y kh&ocirc;ng bao gồm đầy đủ c&aacute;c tương t&aacute;c thuốc c&oacute; thể xảy ra. Tốt nhất l&agrave; bạn viết một danh s&aacute;ch những thuốc bạn đang d&ugrave;ng (bao gồm thuốc được k&ecirc; toa, kh&ocirc;ng k&ecirc; toa v&agrave; thực phẩm chức năng) v&agrave; cho b&aacute;c sĩ hoặc dược sĩ xem. Kh&ocirc;ng được tự &yacute; d&ugrave;ng thuốc, ngưng hoặc thay đổi liều lượng của thuốc m&agrave; kh&ocirc;ng c&oacute; sự cho ph&eacute;p của b&aacute;c sĩ.Thuốc lợi tiểu;</p>

<ul>
	<li><a href="https://hellobacsi.com/thuoc/theophylline/" target="_blank">Theophylline</a>;</li>
	<li>Thuốc trị loạn nhịp tim &ndash; amiodarone, disopyramide, dofetilide, dronedaron, procainamide, quinidine, sotalol v&agrave; những thuốc kh&aacute;c;</li>
	<li>Thuốc điều trị trầm cảm hoặc bệnh t&acirc;m thần &ndash; amitriptylline, clomipramine, desipramine, iloperidone, imipramine, nortriptyline, v&agrave; những thuốc kh&aacute;c;</li>
	<li>Nsaids (thuốc chống vi&ecirc;m kh&ocirc;ng steroid) &ndash; aspirin, ibuprofen (Advil&reg;, Motrin&reg;), naproxen (Aleve&reg;), celecoxib, diclofenac, indomethacin, meloxicam, v&agrave; những thuốc kh&aacute;c.</li>
</ul>

<h3>Thức ăn v&agrave; rượu bia c&oacute; tương t&aacute;c với thuốc levofloxacin kh&ocirc;ng?</h3>

<p>H&atilde;y tham khảo &yacute; kiến b&aacute;c sĩ về việc uống thuốc c&ugrave;ng thức ăn, rượu v&agrave; thuốc l&aacute;.</p>

<h3>T&igrave;nh trạng sức khỏe n&agrave;o ảnh hưởng đến thuốc levofloxacin?</h3>

<p>T&igrave;nh trạng sức khỏe của bạn c&oacute; thể ảnh hưởng đến việc sử dụng thuốc n&agrave;y. B&aacute;o cho b&aacute;c sĩ biết nếu bạn c&oacute; bất kỳ vấn đề sức khỏe n&agrave;o, đặc biệt l&agrave;:</p>

<ul>
	<li>Nhịp tim chậm;</li>
	<li><a href="https://hellobacsi.com/benh/chuyen-muc-tieu-duong/" target="_blank">Bệnh tiểu đường</a>;</li>
	<li>Ti&ecirc;u chảy;</li>
	<li>Vấn đề về nhịp tim (v&iacute; dụ như QT k&eacute;o d&agrave;i), hoặc tiền sử gia đ&igrave;nh mắc bệnh n&agrave;y;</li>
	<li>Hạ kali trong m&aacute;u (kali thấp trong m&aacute;u), hoặc chưa được điều trị;</li>
	<li>Bệnh gan (bao gồm vi&ecirc;m gan);</li>
	<li>Thiếu m&aacute;u cục bộ cơ tim (giảm nguồn cung cấp m&aacute;u trong tim);</li>
	<li>Động kinh;</li>
	<li>Bệnh n&atilde;o (v&iacute; dụ như xơ cứng động mạch);</li>
	<li>Bệnh thận, nặng;</li>
	<li>Gh&eacute;p nội tạng(v&iacute; dụ như tim, thận, phổi);</li>
	<li>Rối loạn g&acirc;n khớp (v&iacute; dụ như vi&ecirc;m khớp dạng thấp);</li>
	<li><a href="https://hellobacsi.com/benh/nhuoc-co-yeu-co/" target="_blank">Nhược cơ</a>&nbsp;(nhược cơ nặng).</li>
</ul>

<h2>Trường hợp khẩn cấp/qu&aacute; liều</h2>

<h3>Bạn n&ecirc;n l&agrave;m g&igrave; trong trường hợp khẩn cấp hoặc d&ugrave;ng qu&aacute; liều?</h3>

<p>Trong trường hợp khẩn cấp hoặc qu&aacute; liều, gọi ngay cho Trung t&acirc;m cấp cứu 115 hoặc đến trạm Y tế địa phương gần nhất.</p>

<h3>Bạn n&ecirc;n l&agrave;m g&igrave; nếu qu&ecirc;n một liều?</h3>

<p>Nếu bạn qu&ecirc;n d&ugrave;ng một liều thuốc, h&atilde;y d&ugrave;ng c&agrave;ng sớm c&agrave;ng tốt. Tuy nhi&ecirc;n, nếu gần với liều kế tiếp, h&atilde;y bỏ qua liều đ&atilde; qu&ecirc;n v&agrave; d&ugrave;ng liều kế tiếp v&agrave;o thời điểm như kế hoạch. Kh&ocirc;ng d&ugrave;ng gấp đ&ocirc;i liều đ&atilde; quy định.</p>

<p><a href="http://hellohealthgroup.com/">Hello Health Group</a>&nbsp;kh&ocirc;ng đưa ra c&aacute;c lời khuy&ecirc;n, chẩn đo&aacute;n hay c&aacute;c phương ph&aacute;p điều trị y khoa.</p>
', 1000, N'SX000001')
INSERT [dbo].[DauThuoc] ([MaDT], [TenDauThuoc], [CongDung], [CachDung], [Image], [Status], [GiaBanLe], [MaNSX]) VALUES (N'DT000005', N'Mekocefal_250', N'Thuốc kháng sinh điều trị viêm phổi, viêm xoang, viêm thanh quản Mekocefal 250', N'Dùng theo chỉ dẫn của thầy thuốc.
Thời gian điều trị phải duy trì tối thiểu từ 5– 10 ngày. Uống thuốc cùng thức ăn có thể giảm bớt tác dụng phụ trên đường tiêu hóa.', N'Mekocefal_250.jpg', N'<p>C&ocirc;ng dụng&nbsp;<a href="http://bbu.vn/thuoc-khang-sinh-dieu-tri-viem-phoi-viem-xoang-viem-thanh-quan-mekocefal-250.html"><strong>Thuốc kh&aacute;ng sinh điều trị vi&ecirc;m phổi, vi&ecirc;m xoang, vi&ecirc;m thanh quản Mekocefal 250</strong></a></p>

<p>Điều trị c&aacute;c nhiễm khuẩn g&acirc;y ra bởi vi khuẩn nhạy cảm với Cefadroxil:<br />
&ndash; Nhiễm khuẩn đường h&ocirc; hấp tr&ecirc;n, tai mũi họng: vi&ecirc;m tai giữa cấp v&agrave; m&atilde;n t&iacute;nh, vi&ecirc;m xoang, vi&ecirc;m họng, vi&ecirc;m amidan, vi&ecirc;m thanh quản.<br />
&ndash; Nhiễm khuẩn đường h&ocirc; hấp dưới: vi&ecirc;m phế quản cấp v&agrave; m&atilde;n t&iacute;nh, vi&ecirc;m phế quản&ndash; phổi, vi&ecirc;m phổi th&ugrave;y, ...<br />
&ndash; Nhiễm khuẩn đường niệu&ndash; sinh dục: vi&ecirc;m thận&ndash; bể thận cấp v&agrave; m&atilde;n t&iacute;nh, vi&ecirc;m b&agrave;ng quang, vi&ecirc;m niệu đạo, nhiễm khuẩn phụ khoa.<br />
&ndash; Nhiễm khuẩn da v&agrave; m&ocirc; mềm: &aacute;p xe, vi&ecirc;m hạch bạch huyết, bệnh nhọt, vi&ecirc;m quầng,&hellip;&nbsp;<br />
&ndash; Nhiễm khuẩn xương v&agrave; khớp: vi&ecirc;m xương tủy, vi&ecirc;m khớp nhiễm khuẩn.</p>

<p>Đ&oacute;ng g&oacute;i&nbsp;<a href="http://bbu.vn/thuoc-khang-sinh-dieu-tri-viem-phoi-viem-xoang-viem-thanh-quan-mekocefal-250.html"><strong>Thuốc kh&aacute;ng sinh điều trị vi&ecirc;m phổi, vi&ecirc;m xoang, vi&ecirc;m thanh quản Mekocefal 250</strong></a></p>

<p>Hộp 10 vỉ x 10 Vi&ecirc;n nang</p>

<p>C&ocirc;ng thức&nbsp;<a href="http://bbu.vn/thuoc-khang-sinh-dieu-tri-viem-phoi-viem-xoang-viem-thanh-quan-mekocefal-250.html"><strong>Thuốc kh&aacute;ng sinh điều trị vi&ecirc;m phổi, vi&ecirc;m xoang, vi&ecirc;m thanh quản Mekocefal 250</strong></a></p>

<p>Cefadroxil monohydrate tương đương Cefadroxil 250mg T&aacute; dược vừa đủ .1 g&oacute;i (Bột hương d&acirc;u, Colloidal silicon dioxide, Đường RE, Tinh dầu d&acirc;u, Crospovidone).</p>

<p>Dược lực học</p>

<p>&ndash; Cefadroxil&ndash; hoạt chất của Mekocefal, l&agrave; một kh&aacute;ng sinh họ b&ndash; lactam, nh&oacute;m Cephalosporin thế hệ I. Thuốc c&oacute; t&aacute;c dụng diệt khuẩn bằng c&aacute;ch ức chế sự tổng hợp th&agrave;nh tế b&agrave;o vi khuẩn.<br />
&ndash; Cefadroxil c&oacute; t&aacute;c dụng với phần lớn vi khuẩn Gram dương v&agrave; Gram &acirc;m.</p>

<p>Dược động học</p>

<p>&ndash; Cefadroxil được hấp thu gần như ho&agrave;n to&agrave;n qua đường ti&ecirc;u h&oacute;a, đạt nồng độ đỉnh trong huyết tương sau 1,5 &ndash;&nbsp;<br />
2 giờ. Thức ăn kh&ocirc;ng l&agrave;m thay đổi sự hấp thu của thuốc. Khoảng 20% Cefadroxil gắn kết với protein huyết tương. Thời gian b&aacute;n thải của thuốc trong huyết tương khoảng 1,5 giờ; thời gian n&agrave;y k&eacute;o d&agrave;i hơn ở bệnh nh&acirc;n suy thận.<br />
&ndash; Cefadroxil ph&acirc;n bố rộng khắp c&aacute;c m&ocirc; v&agrave; dịch cơ thể. Cefadroxil đi qua nhau thai v&agrave; b&agrave;i tiết trong sữa mẹ.<br />
&ndash; Hơn 90% liều d&ugrave;ng thải trừ trong nước tiểu ở dạng kh&ocirc;ng đổi trong v&ograve;ng 24 giờ qua lọc cầu thận v&agrave; b&agrave;i tiết ở ống thận.</p>

<p>Chống chỉ định</p>

<p>Mẫn cảm với c&aacute;c kh&aacute;ng sinh nh&oacute;m Cephalosporin, Penicillin.</p>

<p>T&aacute;c dụng phụ</p>

<p>Thường gặp: rối loạn ti&ecirc;u h&oacute;a như buồn n&ocirc;n, n&ocirc;n, đau bụng, ti&ecirc;u chảy.&nbsp;<br />
&ndash; &Iacute;t gặp: ngứa, nổi mề đay, tăng transaminase c&oacute; hồi phục.&nbsp;<br />
&ndash; Hiếm gặp: phản ứng phản vệ, sốt, đau khớp. Th&ocirc;ng b&aacute;o cho b&aacute;c sỹ những t&aacute;c dụng kh&ocirc;ng mong muốn gặp phải khi sử dụng thuốc.</p>

<p>Thận trọng</p>

<p>&ndash; Bệnh nh&acirc;n suy thận, c&oacute; tiền sử dị ứng, bệnh đường ti&ecirc;u h&oacute;a, trẻ sơ sinh, trẻ đẻ non.<br />
&ndash; Nếu c&oacute; biểu hiện dị ứng phải ngưng điều trị với Cefadroxil. Khi cần thiết, phải &aacute;p dụng trị liệu th&iacute;ch hợp.<br />
&ndash; D&ugrave;ng Cefadroxil d&agrave;i ng&agrave;y c&oacute; thể l&agrave;m c&aacute;c chủng kh&ocirc;ng nhạy cảm ph&aacute;t triển qu&aacute; mức.<br />
&ndash; Đ&atilde; c&oacute; b&aacute;o c&aacute;o vi&ecirc;m đại tr&agrave;ng m&agrave;ng giả xảy ra khi sử dụng kh&aacute;ng sinh phổ rộng, v&igrave; vậy n&ecirc;n ch&uacute; &yacute; đến chuẩn đo&aacute;n n&agrave;y ở bệnh nh&acirc;n bị ti&ecirc;u chảy nặng trong hoặc sau khi d&ugrave;ng kh&aacute;ng sinh<br />
&ndash; Do thuốc c&oacute; chứa Aspartame, tr&aacute;nh d&ugrave;ng trong trường hợp phenylketon niệu.</p>

<p>Tương t&aacute;c</p>

<p>Kh&ocirc;ng n&ecirc;n kết hợp Cefadroxil với kh&aacute;ng sinh k&igrave;m khuẩn như Tetracycline, Erythromycin, c&aacute;c Sulfonamide hoặc Chloramphenicol v&igrave; t&iacute;nh đối kh&aacute;ng c&oacute; thể xảy ra.&nbsp;<br />
&ndash; Khi kết hợp Cefadroxil với thuốc lợi tiểu quai liều cao (Furosemide) hay c&aacute;c kh&aacute;ng sinh c&oacute; khả năng độc thận (Aminoglycoside, Polymyxin, Colistin) l&agrave;m tăng độc t&iacute;nh với thận.&nbsp;<br />
&ndash; Probenecid l&agrave;m tăng nồng độ trong huyết thanh v&agrave; thời gian b&aacute;n thải của Cefadroxil.&nbsp;<br />
&ndash; Như c&aacute;c kh&aacute;ng sinh phổ rộng kh&aacute;c, Cefadroxil l&agrave;m giảm t&aacute;c dụng của thuốc</p>

<p>Hạn d&ugrave;ng</p>

<p>3 năm kể từ ng&agrave;y sản xuất</p>

<p>Bảo quản</p>

<p>Nơi kh&ocirc; (độ ẩm &le; 70%), nhiệt độ kh&ocirc;ng qu&aacute; 30oC, tr&aacute;nh &aacute;nh s&aacute;ng.</p>

<p>C&aacute;ch d&ugrave;ng&nbsp;<a href="http://bbu.vn/thuoc-khang-sinh-dieu-tri-viem-phoi-viem-xoang-viem-thanh-quan-mekocefal-250.html"><strong>Thuốc kh&aacute;ng sinh điều trị vi&ecirc;m phổi, vi&ecirc;m xoang, vi&ecirc;m thanh quản Mekocefal 250</strong></a></p>

<p>D&ugrave;ng theo chỉ dẫn của thầy thuốc.<br />
Thời gian điều trị phải duy tr&igrave; tối thiểu từ 5&ndash; 10 ng&agrave;y. Uống thuốc c&ugrave;ng thức ăn c&oacute; thể giảm bớt t&aacute;c dụng phụ tr&ecirc;n đường ti&ecirc;u h&oacute;a.<br />
Liều th&ocirc;ng thường:<br />
&ndash; Người lớn v&agrave; trẻ tr&ecirc;n 40kg: 1&ndash; 2 g (4&ndash; 8 g&oacute;i)/ng&agrave;y, uống 1 lần hoặc chia l&agrave;m 2 lần trong ng&agrave;y.<br />
&ndash; Trẻ em dưới 40kg: 25&ndash; 50mg/kg/ ng&agrave;y.<br />
●Tr&ecirc;n 6 tuổi: 1 g (4 g&oacute;i)/ ng&agrave;y, chia 2 lần.<br />
●Từ 1&ndash; 6 tuổi: 500 mg (2 g&oacute;i)/ng&agrave;y, chia 2 lần.<br />
●Dưới 1 tuổi: 25mg/kg/ ng&agrave;y, chia 2 &ndash; 3 lần.<br />
Liều khởi đầu: 500&ndash; 1000 mg Cefadroxil, những liều tiếp theo điều chỉnh theo bảng sau:&nbsp;<br />
Bệnh nh&acirc;n suy thận:</p>

<table border="1" cellpadding="0" cellspacing="0" style="width:598px">
	<tbody>
		<tr>
			<td style="vertical-align:top">
			<p>Độ thanh thải Creatinin</p>
			</td>
			<td style="vertical-align:top">
			<p>Liều</p>
			</td>
			<td style="vertical-align:top">
			<p>Khoảng thời gian giữa 2 liều</p>
			</td>
		</tr>
		<tr>
			<td style="vertical-align:top">
			<p>0&ndash; 10ml/ph&uacute;t</p>
			</td>
			<td style="vertical-align:top">
			<p>500&ndash; 1000 mg</p>
			</td>
			<td style="vertical-align:top">
			<p>36 giờ</p>
			</td>
		</tr>
		<tr>
			<td style="vertical-align:top">
			<p>11&ndash; 25ml/ph&uacute;t</p>
			</td>
			<td style="vertical-align:top">
			<p>500&ndash; 1000 mg</p>
			</td>
			<td style="vertical-align:top">
			<p>24 giờ</p>
			</td>
		</tr>
		<tr>
			<td style="vertical-align:top">
			<p>26&ndash; 50ml/ph&uacute;t</p>
			</td>
			<td style="vertical-align:top">
			<p>500&ndash; 1000 mg</p>
			</td>
			<td style="vertical-align:top">
			<p>12 giờ</p>
			</td>
		</tr>
	</tbody>
</table>
', 1000, N'SX000001')
INSERT [dbo].[DauThuoc] ([MaDT], [TenDauThuoc], [CongDung], [CachDung], [Image], [Status], [GiaBanLe], [MaNSX]) VALUES (N'DT000006', N'Berberine_100mg_431', N'Berberin có tác dụng kháng khuẩn với shigella, tụ cầu và liên cầu khuẩn', N'Người lớn: 4-6 viên 50mg hoặc 1-2 viên 100mg/lần x 2 lần/ngày. Trẻ em: tuỳ theo tuổi 1/2-3 viên 50mg/lần x 2 lần/ngày.', N'Berberine_100mg_431.jpg', N'<h3>T&aacute;c dụng :</h3>

<p>Berberin c&oacute; t&aacute;c dụng kh&aacute;ng khuẩn với shigella, tụ cầu v&agrave; li&ecirc;n cầu khuẩn. Những năm gần đ&acirc;y, một số nghi&ecirc;n cứu mới nhất ở nước ngo&agrave;i đ&atilde; x&aacute;c định berberin c&oacute; t&aacute;c dụng chống lại nhiều loại vi khuẩn gram dương (nhuộm theo phương ph&aacute;p gram vi khuẩn bắt m&agrave;u t&iacute;m), gram &acirc;m (bắt m&agrave;u đỏ) v&agrave; c&aacute;c vi khuẩn kh&aacute;ng axit. Ngo&agrave;i ra, n&oacute; c&ograve;n c&oacute; t&aacute;c dụng chống lại một số nấm men g&acirc;y bệnh v&agrave; một số động vật nguy&ecirc;n sinh.</p>

<h3>Chỉ định :</h3>

<p>Nhiễm tr&ugrave;ng đường ruột. Ti&ecirc;u chảy. Lỵ trực tr&ugrave;ng, hội chứng lỵ. Vi&ecirc;m ống mật.</p>

<h3>Liều lượng - c&aacute;ch d&ugrave;ng:</h3>

<p>Người lớn: 4-6 vi&ecirc;n 50mg hoặc 1-2 vi&ecirc;n 100mg/lần x 2 lần/ng&agrave;y. Trẻ em: tuỳ theo tuổi 1/2-3 vi&ecirc;n 50mg/lần x 2 lần/ng&agrave;y.</p>

<h3>Chống chỉ định :</h3>

<p>Phụ nữ c&oacute; thai.</p>

<h3>T&aacute;c dụng phụ</h3>

<p>T&aacute;o b&oacute;n.</p>
', 1000, N'SX000001')
INSERT [dbo].[DauThuoc] ([MaDT], [TenDauThuoc], [CongDung], [CachDung], [Image], [Status], [GiaBanLe], [MaNSX]) VALUES (N'DT000007', N'ích mau', N'trị đau bụng', N'trị đau bụng', N'ích mau.jpg', N'', 1000, N'SX000002')
INSERT [dbo].[DauThuoc] ([MaDT], [TenDauThuoc], [CongDung], [CachDung], [Image], [Status], [GiaBanLe], [MaNSX]) VALUES (N'DT000008', N'moc_hoa_trang_1489456096', N'trị đau bụng', N'trị đau bụng', N'moc_hoa_trang_1489456096.jpg', N'', 1000, N'SX000002')
INSERT [dbo].[DauThuoc] ([MaDT], [TenDauThuoc], [CongDung], [CachDung], [Image], [Status], [GiaBanLe], [MaNSX]) VALUES (N'DT000009', N'Trimeseptol', N'Nhiễm Trùng', N'Nhiễm Trùng', N'Trimeseptol.jpg', N'', 1000, N'SX000003')
INSERT [dbo].[DauThuoc] ([MaDT], [TenDauThuoc], [CongDung], [CachDung], [Image], [Status], [GiaBanLe], [MaNSX]) VALUES (N'DT000011', N'cefuroxim_1', N'Nhiễm Trùng', N'Nhiễm Trùng', N'cefuroxim_1.jpg', N'', 1000, N'SX000003')
INSERT [dbo].[DauThuoc] ([MaDT], [TenDauThuoc], [CongDung], [CachDung], [Image], [Status], [GiaBanLe], [MaNSX]) VALUES (N'DT000012', N'Genbay_8_30316', N'Nhiễm Trùng', N'Nhiễm Trùng', N'Genbay_8_30316.jpg', N'', 1000, N'SX000003')
INSERT [dbo].[DauThuoc] ([MaDT], [TenDauThuoc], [CongDung], [CachDung], [Image], [Status], [GiaBanLe], [MaNSX]) VALUES (N'DT000013', N'vinphaco_media', N'Nhiễm Trùng', N'Nhiễm Trùng', N'vinphaco_media_5a38c7447518b.jpg', N'', 1000, N'SX000003')
INSERT [dbo].[DauThuoc] ([MaDT], [TenDauThuoc], [CongDung], [CachDung], [Image], [Status], [GiaBanLe], [MaNSX]) VALUES (N'DT000014', N'0000389_samibio', N'Đường ruột', N'Đường ruột', N'0000389_samibio_tam_biet_tao_bon.jpg', N'', 1000, N'SX000004')
INSERT [dbo].[DauThuoc] ([MaDT], [TenDauThuoc], [CongDung], [CachDung], [Image], [Status], [GiaBanLe], [MaNSX]) VALUES (N'DT000015', N'00017036_olymediges', N'Đường ruột', N'Đường ruột', N'00017036_olymediges_gold_20_goi_x_3g_4477_5bb3_large.jpg', N'', 1000, N'SX000004')
INSERT [dbo].[DauThuoc] ([MaDT], [TenDauThuoc], [CongDung], [CachDung], [Image], [Status], [GiaBanLe], [MaNSX]) VALUES (N'DT000016', N'Bluemin 3_900x900', N'Đường ruột', N'Đường ruột', N'Bluemin 3_900x900.jpg', N'', 1000, N'SX000004')
INSERT [dbo].[DauThuoc] ([MaDT], [TenDauThuoc], [CongDung], [CachDung], [Image], [Status], [GiaBanLe], [MaNSX]) VALUES (N'DT000017', N'dai_trang_02_thumb', N'Đường ruột', N'Đường ruột', N'dai_trang_02_thumb.jpg', N'', 1000, N'SX000004')
INSERT [dbo].[DauThuoc] ([MaDT], [TenDauThuoc], [CongDung], [CachDung], [Image], [Status], [GiaBanLe], [MaNSX]) VALUES (N'DT000018', N'biovita', N'Đường ruột', N'Đường ruột', N'biovita.jpg', N'', 1000, N'SX000004')
INSERT [dbo].[DauThuoc] ([MaDT], [TenDauThuoc], [CongDung], [CachDung], [Image], [Status], [GiaBanLe], [MaNSX]) VALUES (N'DT000020', N'Vinprazol', N'
- Loét tá tràng cấp tính
- Loét dạ dày cấp tính
- Hội chứng trào ngược dạ dày - thực quản có hoặc không có viêm thực quản, loét hoặc trầy xước.
- Hội chứng Zollinger - Ellison', N'Theo chỉ định bác sĩ', N'vinphaco-media-59b898624c980_05_15_2019_11_35_44.jpg', N'<h3>M&ocirc; tả sản phẩm</h3>

<hr />
<table>
	<tbody>
		<tr>
			<td>
			<p>Số đăng k&yacute;:</p>
			</td>
			<td>
			<p>VD - 16617 - 12</p>
			</td>
		</tr>
		<tr>
			<td>
			<p>Dạng b&agrave;o chế:</p>
			</td>
			<td>Thuốc ti&ecirc;m bột đ&ocirc;ng kh&ocirc;</td>
		</tr>
		<tr>
			<td>
			<p>Th&agrave;nh phần:</p>
			</td>
			<td>
			<p><em>Lọ bột đ&ocirc;ng kh&ocirc;</em></p>

			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;Rabeprazol natri.............................................................. 20 mg</p>

			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;T&aacute; dược (Manitol, NaOH, dinatri edetat) vừa đủ ............... 1 lọ</p>

			<p><em>&nbsp; Ống dung m&ocirc;i:</em></p>

			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;Natri clorid&nbsp; .................................................................... 45 mg</p>

			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Nước cất pha ti&ecirc;m vừa đủ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5 ml</p>
			</td>
		</tr>
		<tr>
			<td>
			<p>Qui c&aacute;ch đ&oacute;ng g&oacute;i:</p>
			</td>
			<td>
			<p>Hộp 1 lọ bột&nbsp; đ&ocirc;ng kh&ocirc; v&agrave; 1 ống dung m&ocirc;i pha ti&ecirc;m</p>

			<p>Hộp 5 lọ bột &nbsp;đ&ocirc;ng kh&ocirc;</p>

			<p>Hộp 10 lọ bột đ&ocirc;ng kh&ocirc;</p>
			</td>
		</tr>
		<tr>
			<td>
			<p>Chỉ định:</p>
			</td>
			<td>
			<p>- Lo&eacute;t t&aacute; tr&agrave;ng cấp t&iacute;nh</p>

			<p>&nbsp;&nbsp;&nbsp; - Lo&eacute;t dạ d&agrave;y cấp t&iacute;nh</p>

			<p>&nbsp;&nbsp;&nbsp; - Hội chứng tr&agrave;o ngược dạ d&agrave;y - thực quản c&oacute; hoặc kh&ocirc;ng c&oacute; vi&ecirc;m thực quản, lo&eacute;t hoặc trầy xước.</p>

			<p>&nbsp;&nbsp;&nbsp; - Hội chứng Zollinger - Ellison</p>
			</td>
		</tr>
		<tr>
			<td>
			<p>Liều d&ugrave;ng:</p>
			</td>
			<td>
			<p>- Lo&eacute;t dạ d&agrave;y - t&aacute; tr&agrave;ng cấp t&iacute;nh: Liều th&ocirc;ng thường l&agrave; 20 mg/lần/ng&agrave;y. Sau đ&oacute; duy tr&igrave; tiếp với liều 10 mg - 20 mg mỗi ng&agrave;y t&ugrave;y theo đ&aacute;p ứng.&nbsp;</p>

			<p>- Hội chứng tr&agrave;o ngược dạ d&agrave;y - thực quản: 10 - 20 mg/lần/ng&agrave;y</p>

			<p>- Hội chứng Zollinger - Ellison: Người lớn, liều khởi đầu l&agrave; 60 mg mỗi ng&agrave;y. C&oacute; thể tăng liều l&ecirc;n tối đa 60 mg hai lần mỗi ng&agrave;y t&ugrave;y theo sự cần thiết đối với từng bệnh nh&acirc;n.</p>

			<p>Bệnh nh&acirc;n suy gan, suy thận: Kh&ocirc;ng cần điều chỉnh liều</p>

			<p>Trẻ em: Kh&ocirc;ng d&ugrave;ng v&igrave; chưa c&oacute; kinh nghiệm</p>
			</td>
		</tr>
		<tr>
			<td>
			<p>Đạt ti&ecirc;u chuẩn:</p>
			</td>
			<td>DĐVN IV</td>
		</tr>
		<tr>
			<td>
			<p>Hạn d&ugrave;ng:</p>
			</td>
			<td>36 th&aacute;ng kể từ ng&agrave;y sản xuất</td>
		</tr>
		<tr>
			<td>
			<p>Bảo quản:</p>
			</td>
			<td>Nơi kh&ocirc; r&aacute;o, tho&aacute;ng, tr&aacute;nh &aacute;nh s&aacute;ng, nhiệt độ dưới 30&ordm;C</td>
		</tr>
	</tbody>
</table>
', 500, N'SX000004')
INSERT [dbo].[DauThuoc] ([MaDT], [TenDauThuoc], [CongDung], [CachDung], [Image], [Status], [GiaBanLe], [MaNSX]) VALUES (N'DT000021', N'ALVERIN', N'Đau do co thắt cơ trơn ở đường tiêu hóa như hội chứng ruột kích thích, bệnh đau túi thừa đại tràng.', N'Theo chỉ định cảu bác sĩ', N'vinphaco-media-5a69407e0bb74_05_15_2019_11_51_18.jpg', N'<h3>M&ocirc; tả sản phẩm</h3>

<hr />
<table style="width:728px">
	<tbody>
		<tr>
			<td>
			<p><strong>Số đăng k&iacute;</strong></p>
			</td>
			<td>
			<p>VD - 28144 - 17</p>
			</td>
		</tr>
		<tr>
			<td>
			<p><strong>Th&agrave;nh phần</strong></p>
			</td>
			<td>
			<p><em>Dược chất</em>: Alverin citrat..............................................................40 mg</p>
			</td>
		</tr>
		<tr>
			<td>
			<p><strong>Dạng b&agrave;o chế</strong></p>
			</td>
			<td>
			<p>Vi&ecirc;n n&eacute;n m&agrave;u v&agrave;ng</p>
			</td>
		</tr>
		<tr>
			<td>
			<p><strong>Quy c&aacute;ch đ&oacute;ng g&oacute;i</strong></p>
			</td>
			<td>
			<p>Hộp 1 lọ x 100 vi&ecirc;n n&eacute;n</p>
			</td>
		</tr>
		<tr>
			<td>
			<p><strong>Chỉ định</strong></p>
			</td>
			<td>
			<p>Đau do co thắt cơ trơn ở đường ti&ecirc;u h&oacute;a như hội chứng ruột k&iacute;ch th&iacute;ch, bệnh đau t&uacute;i thừa đại tr&agrave;ng.</p>
			</td>
		</tr>
		<tr>
			<td>
			<p><strong>Liều d&ugrave;ng</strong></p>
			</td>
			<td>
			<p>Theo chỉ định của B&aacute;c sĩ</p>

			<p>Đọc kĩ hướng dẫn sử dụng trước khi d&ugrave;ng</p>
			</td>
		</tr>
		<tr>
			<td>
			<p><strong>Đạt ti&ecirc;u chuẩn</strong></p>
			</td>
			<td>
			<p>TCCS</p>
			</td>
		</tr>
		<tr>
			<td>
			<p><strong>Hạn d&ugrave;ng</strong></p>
			</td>
			<td>
			<p>36 th&aacute;ng kể từ ng&agrave;y sản xuất</p>
			</td>
		</tr>
		<tr>
			<td>
			<p><strong>Bảo quản</strong></p>
			</td>
			<td>
			<p>Nơi kh&ocirc; r&aacute;o, nhiệt độ dưới 300C, tr&aacute;nh &aacute;nh s&aacute;ng.</p>
			</td>
		</tr>
	</tbody>
</table>
', 100000, N'SX000001')
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (1, NULL, N'Thùng', 1, N'DT000001', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (2, 1, N'Hộp', 10, N'DT000001', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (3, 2, N'Vỉ', 15, N'DT000001', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (4, 3, N'Viên', 20, N'DT000001', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (5, NULL, N'Thùng', 1, N'DT000002', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (6, 5, N'Hộp', 20, N'DT000002', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (7, 6, N'Vỉ', 10, N'DT000002', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (8, 7, N'Viên', 10, N'DT000002', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (9, NULL, N'Thùng', 1, N'DT000003', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (10, 9, N'Hộp', 10, N'DT000003', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (11, 10, N'Vỉ', 10, N'DT000003', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (12, 11, N'Viên', 10, N'DT000003', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (13, NULL, N'Thùng', 1, N'DT000004', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (14, 13, N'Hộp', 10, N'DT000004', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (15, 14, N'Vỉ', 10, N'DT000004', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (16, 15, N'Viên', 10, N'DT000004', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (17, NULL, N'Thùng', 1, N'DT000005', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (18, 17, N'Hộp', 10, N'DT000005', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (19, 18, N'Vỉ', 10, N'DT000005', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (20, 19, N'Viên', 10, N'DT000005', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (21, NULL, N'Thùng', 1, N'DT000006', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (22, 21, N'Hộp', 10, N'DT000006', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (23, 22, N'Vỉ', 10, N'DT000006', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (24, 23, N'Viên', 10, N'DT000006', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (25, NULL, N'Thùng', 1, N'DT000007', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (26, 25, N'Hộp', 10, N'DT000007', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (27, 26, N'Vỉ', 10, N'DT000007', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (28, 27, N'Viên', 10, N'DT000007', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (29, NULL, N'Thùng', 1, N'DT000008', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (30, 29, N'Hộp', 10, N'DT000008', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (31, 30, N'Vỉ', 10, N'DT000008', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (32, 31, N'Viên', 10, N'DT000008', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (33, NULL, N'Thùng', 1, N'DT000009', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (34, 33, N'Hộp', 15, N'DT000009', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (35, 34, N'Chai', 5, N'DT000009', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (39, NULL, N'Thùng', 1, N'DT000011', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (40, 39, N'Hộp', 15, N'DT000011', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (41, 40, N'Chai', 5, N'DT000011', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (42, NULL, N'Thùng', 1, N'DT000012', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (43, 42, N'Hộp', 15, N'DT000012', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (44, 43, N'Chai', 5, N'DT000012', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (45, NULL, N'Thùng', 1, N'DT000013', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (46, 45, N'Hộp', 19, N'DT000013', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (47, 46, N'Chai', 6, N'DT000013', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (48, NULL, N'Thùng', 1, N'DT000014', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (49, 48, N'Hộp', 19, N'DT000014', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (50, 49, N'Chai', 6, N'DT000014', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (51, NULL, N'Thùng', 1, N'DT000015', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (52, 51, N'Hộp', 19, N'DT000015', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (53, 52, N'Chai', 6, N'DT000015', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (54, NULL, N'Thùng', 1, N'DT000016', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (55, 54, N'Hộp', 19, N'DT000016', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (56, 55, N'Chai', 6, N'DT000016', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (57, NULL, N'Thùng', 1, N'DT000017', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (58, 49, N'Hộp', 9, N'DT000017', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (59, 58, N'Chai', 4, N'DT000017', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (60, NULL, N'Thùng', 1, N'DT000018', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (61, 60, N'Hộp', 9, N'DT000018', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (62, 61, N'Chai', 4, N'DT000018', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (66, NULL, N'Thùng', 1, N'DT000020', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (67, 66, N'Hộp', 15, N'DT000020', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (68, 67, N'Vỉ', 10, N'DT000020', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (69, 68, N'Viên', 20, N'DT000020', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (70, NULL, N'Thùng', 1, N'DT000021', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (71, 70, N'Hộp', 20, N'DT000021', NULL)
INSERT [dbo].[DonVi] ([ID], [IDParent], [Ten], [Heso], [MaDT], [TenDinhNghia]) VALUES (72, 71, N'Chai', 1, N'DT000021', NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000001', N'KH000001', CAST(0x0000AA1B00735B40 AS DateTime), N'TK000001', 2, N'KO000002', NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000002', N'KH000002', CAST(0x0000AA1B00735B40 AS DateTime), N'TK000001', 2, N'KO000003', NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000003', N'KH000002', CAST(0x0000AA1B00735B40 AS DateTime), N'TK000001', 2, N'KO000003', NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000004', N'KH000001', CAST(0x0000AA1B00735B40 AS DateTime), N'TK000001', 2, N'KO000002', NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000005', N'KH000003', CAST(0x0000AA1B00735B40 AS DateTime), N'TK000001', 2, N'KO000001', NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000006', N'KH000004', CAST(0x0000AA1C00735B40 AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000007', N'KH000003', CAST(0x0000AA2200735B40 AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000008', N'KH000003', CAST(0x0000AA2200735B40 AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000009', N'KH000003', CAST(0x0000AA2200735B40 AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000012', N'KH000001', CAST(0x0000AA2500735B40 AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000013', N'KH000001', CAST(0x0000AA3100735B40 AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000014', N'KH000001', CAST(0x0000AA3100C06BC1 AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000015', N'KH000001', CAST(0x0000AA31015CF2D5 AS DateTime), N'TK000001', 2, N'KO000001', NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000016', N'KH000001', CAST(0x0000AA33010A6FFF AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000017', N'KH000001', CAST(0x0000AA3400B0C2B7 AS DateTime), N'TK000001', 2, N'KO000002', NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000018', N'KH000005', CAST(0x0000AA4200A3967F AS DateTime), N'TK000001', 2, N'KO000001', NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000019', N'KH000005', CAST(0x0000AA420107C14E AS DateTime), N'TK000001', 3, N'KO000001', NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000020', N'KH000002', CAST(0x0000AA03008FCCFE AS DateTime), N'TK000001', 3, N'KO000002', NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000021', N'KH000003', CAST(0x0000A9E7009257C6 AS DateTime), N'TK000001', 3, N'KO000003', NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000022', N'KH000004', CAST(0x0000A9E70093BF76 AS DateTime), N'TK000001', 3, N'KO000003', NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000023', N'KH000004', CAST(0x0000AA0300953631 AS DateTime), N'TK000001', 3, N'KO000001', NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000024', N'KH000002', CAST(0x0000AA22009C7F4E AS DateTime), N'TK000001', 3, N'KO000002', NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000025', N'KH000001', CAST(0x0000AA4501151E71 AS DateTime), N'TK000001', 3, N'KO000001', NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000026', N'KH000006', CAST(0x0000AA4501153B68 AS DateTime), N'TK000001', 3, N'KO000002', NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000027', N'KH000001', CAST(0x0000AA4600ABE2FD AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000028', N'KH000002', CAST(0x0000AA4F0091C799 AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000029', N'KH000001', CAST(0x0000AA4F0093E5BF AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[HoaDonMua] ([MaHD], [MaKH], [NgayMua], [MaTK], [TrangThai], [MaKho], [MaHoaDonVanChuyen]) VALUES (N'HD000030', N'KH000001', CAST(0x0000AA4F0093ED25 AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[HoaDonNhap] ([MaHD], [MaKho], [MaTK], [MaNSX], [NgayNhap], [GhiChu]) VALUES (N'HD000001', N'KO000001', N'TK000001', N'SX000001', CAST(0x0000AA5000EC4D5C AS DateTime), N'a')
INSERT [dbo].[HoaDonNhap] ([MaHD], [MaKho], [MaTK], [MaNSX], [NgayNhap], [GhiChu]) VALUES (N'HD000002', N'KO000001', N'TK000001', N'SX000001', CAST(0x0000AA4E00735B40 AS DateTime), N'a')
INSERT [dbo].[HoaDonNhap] ([MaHD], [MaKho], [MaTK], [MaNSX], [NgayNhap], [GhiChu]) VALUES (N'HD000003', N'KO000001', N'TK000001', N'SX000001', CAST(0x0000AA4E00735B40 AS DateTime), N'a')
INSERT [dbo].[HoaDonXuat] ([MaHD], [MaKho], [MaTK], [MaKH], [NgayXuat], [TrangThai], [MaHoaDonMua], [MaHoaDonVanChuyen]) VALUES (N'HX000001', N'KO000001', N'TK000001', N'KH000005', CAST(0x0000AA4300000000 AS DateTime), 1, N'HD000019', NULL)
INSERT [dbo].[HoaDonXuat] ([MaHD], [MaKho], [MaTK], [MaKH], [NgayXuat], [TrangThai], [MaHoaDonMua], [MaHoaDonVanChuyen]) VALUES (N'HX000002', N'KO000002', N'TK000001', N'KH000002', CAST(0x0000AA0300000000 AS DateTime), 1, N'HD000020', NULL)
INSERT [dbo].[HoaDonXuat] ([MaHD], [MaKho], [MaTK], [MaKH], [NgayXuat], [TrangThai], [MaHoaDonMua], [MaHoaDonVanChuyen]) VALUES (N'HX000003', N'KO000003', N'TK000001', N'KH000003', CAST(0x0000A9E700000000 AS DateTime), 1, N'HD000021', NULL)
INSERT [dbo].[HoaDonXuat] ([MaHD], [MaKho], [MaTK], [MaKH], [NgayXuat], [TrangThai], [MaHoaDonMua], [MaHoaDonVanChuyen]) VALUES (N'HX000004', N'KO000003', N'TK000001', N'KH000004', CAST(0x0000A9E700000000 AS DateTime), 1, N'HD000022', NULL)
INSERT [dbo].[HoaDonXuat] ([MaHD], [MaKho], [MaTK], [MaKH], [NgayXuat], [TrangThai], [MaHoaDonMua], [MaHoaDonVanChuyen]) VALUES (N'HX000005', N'KO000001', N'TK000001', N'KH000004', CAST(0x0000AA0300000000 AS DateTime), 1, N'HD000023', NULL)
INSERT [dbo].[HoaDonXuat] ([MaHD], [MaKho], [MaTK], [MaKH], [NgayXuat], [TrangThai], [MaHoaDonMua], [MaHoaDonVanChuyen]) VALUES (N'HX000006', N'KO000002', N'TK000001', N'KH000002', CAST(0x0000AA2200000000 AS DateTime), 1, N'HD000024', NULL)
INSERT [dbo].[HoaDonXuat] ([MaHD], [MaKho], [MaTK], [MaKH], [NgayXuat], [TrangThai], [MaHoaDonMua], [MaHoaDonVanChuyen]) VALUES (N'HX000007', N'KO000001', N'TK000001', N'KH000001', CAST(0x0000AA4500000000 AS DateTime), 1, N'HD000025', NULL)
INSERT [dbo].[HoaDonXuat] ([MaHD], [MaKho], [MaTK], [MaKH], [NgayXuat], [TrangThai], [MaHoaDonMua], [MaHoaDonVanChuyen]) VALUES (N'HX000008', N'KO000002', N'TK000001', N'KH000006', CAST(0x0000AA4500000000 AS DateTime), 1, N'HD000026', NULL)
INSERT [dbo].[KeHoachLamViec] ([ID], [CongViec], [TrangThai1], [TrangThai2], [GhiChu], [MaTD]) VALUES (N'KH000001', N'Đạt 50 khách hàng / tháng', 1, 1, NULL, N'TD000001')
INSERT [dbo].[KeHoachLamViec] ([ID], [CongViec], [TrangThai1], [TrangThai2], [GhiChu], [MaTD]) VALUES (N'KH000002', N'Đạt 50 sản phẩm / tháng', 2, 1, NULL, N'TD000001')
INSERT [dbo].[KeHoachLamViec] ([ID], [CongViec], [TrangThai1], [TrangThai2], [GhiChu], [MaTD]) VALUES (N'KH000003', N'Hoàn thành sản phẩm của 5 khu vực', 1, 2, NULL, N'TD000002')
INSERT [dbo].[KeHoachLamViec] ([ID], [CongViec], [TrangThai1], [TrangThai2], [GhiChu], [MaTD]) VALUES (N'KH000004', N'Đạt 30 khách hàng / tháng', 1, 2, NULL, N'TD000002')
INSERT [dbo].[KeHoachLamViec] ([ID], [CongViec], [TrangThai1], [TrangThai2], [GhiChu], [MaTD]) VALUES (N'KH000005', N'Tăng doanh số 5%', 1, 1, NULL, N'TD000001')
INSERT [dbo].[KeHoachLamViec] ([ID], [CongViec], [TrangThai1], [TrangThai2], [GhiChu], [MaTD]) VALUES (N'KH000006', N'Vượt chỉ tiêu 2%', 1, 1, NULL, N'TD000001')
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [DiaChi], [MaQuanHuyen], [MaTinhThanh], [SDT], [Email]) VALUES (N'KH000001', N'Lê Văn A', N'Yên Duyên', 8, 1, N'123456', N'A@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [DiaChi], [MaQuanHuyen], [MaTinhThanh], [SDT], [Email]) VALUES (N'KH000002', N'Lê Văn B', N'Thanh Hải', 491, 48, N'123457', N'B@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [DiaChi], [MaQuanHuyen], [MaTinhThanh], [SDT], [Email]) VALUES (N'KH000003', N'Lê Văn C', N'Yên Duyên-Yên Sở', 8, 1, N'123458', N'C@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [DiaChi], [MaQuanHuyen], [MaTinhThanh], [SDT], [Email]) VALUES (N'KH000004', N'Lê Văn D', N'Can Lai', 461, 45, N'123459', N'D@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [DiaChi], [MaQuanHuyen], [MaTinhThanh], [SDT], [Email]) VALUES (N'KH000005', N'Lê Văn E', N'Yên Duyên-Yên Sở-Hoàng Mai', 8, 79, N'123460', N'E@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [DiaChi], [MaQuanHuyen], [MaTinhThanh], [SDT], [Email]) VALUES (N'KH000006', N'Nguyễn Văn Tài', N'14 phượng Hoàng, Trung Đô', 412, 40, N'01274839989', N'tainv@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [DiaChi], [MaQuanHuyen], [MaTinhThanh], [SDT], [Email]) VALUES (N'KH000007', N'Phạm Bá Toại', N'Trù sơn', 427, 40, N'0367182718', N'toai95@gmail.com')
INSERT [dbo].[KhachHang] ([MaKH], [HoTen], [DiaChi], [MaQuanHuyen], [MaTinhThanh], [SDT], [Email]) VALUES (N'KH000008', N'Nguyễn Hoài Nam1', N'Quỳnh Lưu', 421, 40, N'012748399891', N'hoainam031095@gmail.com')
INSERT [dbo].[Kho] ([MaKho], [TenKho], [DiaChi], [SDT]) VALUES (N'KO000001', N'Kho 1', N'Hoàng Mai-Hà Nội', N'0126778787')
INSERT [dbo].[Kho] ([MaKho], [TenKho], [DiaChi], [SDT]) VALUES (N'KO000002', N'Kho 2', N'Thanh Xuân-Hà Nội', N'0987766226')
INSERT [dbo].[Kho] ([MaKho], [TenKho], [DiaChi], [SDT]) VALUES (N'KO000003', N'Kho 3', N'Cầu Giấy-Hà Nội', N'0976554454')
INSERT [dbo].[Kho] ([MaKho], [TenKho], [DiaChi], [SDT]) VALUES (N'KO000004', N'Kho 4', N'Hà Đông-Hà Nội', N'0976554454')
INSERT [dbo].[KhoDauThuoc] ([MaKho], [MaDT], [MaDonVi], [SoLuongCon]) VALUES (N'KO000001', N'DT000001', 1, 1)
INSERT [dbo].[KhoDauThuoc] ([MaKho], [MaDT], [MaDonVi], [SoLuongCon]) VALUES (N'KO000001', N'DT000001', 2, 5)
INSERT [dbo].[KhoDauThuoc] ([MaKho], [MaDT], [MaDonVi], [SoLuongCon]) VALUES (N'KO000001', N'DT000001', 3, 1)
INSERT [dbo].[KhoDauThuoc] ([MaKho], [MaDT], [MaDonVi], [SoLuongCon]) VALUES (N'KO000001', N'DT000007', 25, 3)
INSERT [dbo].[KhoDauThuoc] ([MaKho], [MaDT], [MaDonVi], [SoLuongCon]) VALUES (N'KO000001', N'DT000007', 26, 3)
SET IDENTITY_INSERT [dbo].[KhoNhanVien] ON 

INSERT [dbo].[KhoNhanVien] ([ID], [MaKho], [MaTK], [ChucVu]) VALUES (1, N'KO000001', N'TK000004', N'Quản kho')
SET IDENTITY_INSERT [dbo].[KhoNhanVien] OFF
INSERT [dbo].[KhuyenMai] ([ID], [TenChuongTrinh], [ChuDe], [NoiDung], [Image], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'KM000001', N'Tri ân khách hàng thân thiết', N'Mua 2 tặng 1', N'Khi khách hàng mua 2 sản phẩm nằm trong khung khuyến mại sẽ được tặng kèm 1 sản phẩm chức năng hoặc thuốc bổ', N'chuong-trinh-khuyen-mai-2018-1.jpg', CAST(0x0000AA1900000000 AS DateTime), CAST(0x0000AA3800000000 AS DateTime))
INSERT [dbo].[KhuyenMai] ([ID], [TenChuongTrinh], [ChuDe], [NoiDung], [Image], [ThoiGianBatDau], [ThoiGianKetThuc]) VALUES (N'KM000002', N'Khách hàng thường xuyên', N'Gửi tặng khách hàng thường xuyên', N'Giảm 5% cho khách hàng thường xuyên khi mua sản phẩm trong khung khuyến mại', N'chuong-trinh-khuyen-mai-2018-1.jpg', CAST(0x0000AA1900000000 AS DateTime), CAST(0x0000AA2000000000 AS DateTime))
INSERT [dbo].[NhaSanXuat] ([MaNSX], [TenNSX], [DiaChi], [SDT], [Email]) VALUES (N'SX000001', N'CTCP TRAPHACO', N'Yên Duyên-Yên Sở-Hoàng Mai-Hà Nội', N'26101995', N'A@gmail.com')
INSERT [dbo].[NhaSanXuat] ([MaNSX], [TenNSX], [DiaChi], [SDT], [Email]) VALUES (N'SX000002', N'CTCP PYMEPHARCO', N'Yên Duyên-Yên Sở-Hoàng Mai-Hà Nội', N'123456', N'B@gmail.com')
INSERT [dbo].[NhaSanXuat] ([MaNSX], [TenNSX], [DiaChi], [SDT], [Email]) VALUES (N'SX000003', N'CTCP Dược Hà Tây', N'Yên Duyên-Yên Sở-Hoàng Mai-Hà Nội', N'123456', N'C@gmail.com')
INSERT [dbo].[NhaSanXuat] ([MaNSX], [TenNSX], [DiaChi], [SDT], [Email]) VALUES (N'SX000004', N'CTCP Dược OPC', N'Yên Duyên-Yên Sở-Hoàng Mai-Hà Nội', N'123456', N'D@gmail.com')
INSERT [dbo].[NhaSanXuat] ([MaNSX], [TenNSX], [DiaChi], [SDT], [Email]) VALUES (N'SX000005', N'CTCP Dược Nam Hà', N'Yên Duyên-Yên Sở-Hoàng Mai-Hà Nội', N'123456', N'E@gmail.com')
INSERT [dbo].[NhaSanXuat] ([MaNSX], [TenNSX], [DiaChi], [SDT], [Email]) VALUES (N'SX000006', N'Kien Giang', N'Kien Giang', N'123456123', N'KienGiang@gmail.com')
INSERT [dbo].[NhaSanXuat] ([MaNSX], [TenNSX], [DiaChi], [SDT], [Email]) VALUES (N'SX000007', N'Cty Cổ Phần Dược Phẩm Vinacare', N'Số 18 Ngách 19/15 Kim Đồng, Giáp Bát, Hoàng Mai, Hà Nội', N'024 3664 9263', N'vinacarepharma@gmail.com')
INSERT [dbo].[NhaSanXuat] ([MaNSX], [TenNSX], [DiaChi], [SDT], [Email]) VALUES (N'SX000008', N'Công Ty Cp Dược Phẩm Cửu Long', N'89 Phố Nguyễn Văn Trỗi, Phương Liệt, Thanh Xuân, Hà Nội', N'2436648034', N'csc@pharimexco.vn')
INSERT [dbo].[NhaSanXuat] ([MaNSX], [TenNSX], [DiaChi], [SDT], [Email]) VALUES (N'SX000009', N'tay son', N'ha noi', N'11111111', N'bao1@gmai.com')
INSERT [dbo].[NhomDauThuoc] ([MaNhomThuoc], [TenNhom], [Image], [Status]) VALUES (N'NT000001', N'Kháng sinh', N'Amoxicillin_250mg.jpg', N'Kháng sinh còn được gọi là Trụ sinh là những chất được chiết xuất từ các vi sinh vật, nấm, được tổng hợp hoặc bán tổng hợp, có khả năng tiêu diệt vi khuẩn hay kìm hãm sự phát triển của vi khuẩn một cách đặc hiệu.')
INSERT [dbo].[NhomDauThuoc] ([MaNhomThuoc], [TenNhom], [Image], [Status]) VALUES (N'NT000002', N'Đau bụng', NULL, N'Đau bụng là triệu chứng bệnh lý thường mắc phải. Tất cả các cơ quan trong ổ bụng bị bất thường đều có thể gây đau bụng')
INSERT [dbo].[NhomDauThuoc] ([MaNhomThuoc], [TenNhom], [Image], [Status]) VALUES (N'NT000003', N'Nhiễm trùng', NULL, N'Nhiễm trùng (infection ) là sự xâm nhập của mầm bệnh vào cơ thể và phản ứng của cơ thể đối với thương tổn do mầm bệnh gây nên [1]. Quá trình nhiễm trùng là quá trình vi sinh vật gây bệnh xâm nhập và nhân lên trong (hoặc trên) cơ thể vật chủ hay cơ thể cảm nhiễm, hoặc qua hàng rào da, niêm mạc, xâm nhập và nhân lên ở mô tế bào cơ thể, hay xâm nhập vào tế bào hoặc mô cơ thể và lan tràn trong cơ thể.[2]. Nhiễm trùng có thể xảy ở bất cứ bộ phận nào của cơ thể, có khi cả toàn thân')
INSERT [dbo].[NhomDauThuoc] ([MaNhomThuoc], [TenNhom], [Image], [Status]) VALUES (N'NT000004', N'Đường ruột', NULL, N'Chống đau do co thắt cơ trơn đường tiêu hóa như hội chứng ruột kích thích, bệnh đau túi thừa ruột kết, đau do co thắt đường mật, cơn đau quặn thận, thống ...')
INSERT [dbo].[NhomDauThuoc] ([MaNhomThuoc], [TenNhom], [Image], [Status]) VALUES (N'NT000005', N'Ung thư', NULL, N'Ung thư là một nhóm các bệnh liên quan đến việc phân chia tế bào một cách vô tổ chức và những tế bào đó có khả năng xâm lấn những mô khác bằng cách phát triển trực tiếp vào mô lân cận hoặc di chuyển đến nơi xa (di căn)')
INSERT [dbo].[NhomDauThuoc] ([MaNhomThuoc], [TenNhom], [Image], [Status]) VALUES (N'NT000006', N'Tiêu hóa', N'vinphaco-media-59b898624c980_05_15_2019_11_33_27.jpg', N'Thuộc nhóm đường tiêu hóa')
SET IDENTITY_INSERT [dbo].[NhomQuyen] ON 

INSERT [dbo].[NhomQuyen] ([MaNhomQuyen], [TenNhomQuyen], [MoTa]) VALUES (1, N'Quản trị hệ thống', N'Quyền cao nhất, có thể thao tác với bất kỳ chức năng nào của hệ thống')
INSERT [dbo].[NhomQuyen] ([MaNhomQuyen], [TenNhomQuyen], [MoTa]) VALUES (10, N'Ban giám đốc', N'Quyền cao nhất trong hệ thống công ty')
INSERT [dbo].[NhomQuyen] ([MaNhomQuyen], [TenNhomQuyen], [MoTa]) VALUES (11, N'Giám đốc vùng', N'Quản lý vùng kinh doanh')
INSERT [dbo].[NhomQuyen] ([MaNhomQuyen], [TenNhomQuyen], [MoTa]) VALUES (12, N'Trưởng vùng', N'Trưởng vùng kinh doanh')
INSERT [dbo].[NhomQuyen] ([MaNhomQuyen], [TenNhomQuyen], [MoTa]) VALUES (13, N'Giám sát kinh doanh', N'Giám sát kinh doanh')
INSERT [dbo].[NhomQuyen] ([MaNhomQuyen], [TenNhomQuyen], [MoTa]) VALUES (14, N'Nhân viên kinh doanh', N'Nhân viên kinh doanh')
INSERT [dbo].[NhomQuyen] ([MaNhomQuyen], [TenNhomQuyen], [MoTa]) VALUES (15, N'Quản lý kho', N'Quản lý kho')
INSERT [dbo].[NhomQuyen] ([MaNhomQuyen], [TenNhomQuyen], [MoTa]) VALUES (16, N'Khách hàng', N'')
SET IDENTITY_INSERT [dbo].[NhomQuyen] OFF
SET IDENTITY_INSERT [dbo].[NhomQuyenRoute] ON 

INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (273, 1, 465)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (274, 1, 466)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (275, 1, 467)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (276, 1, 468)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (283, 1, 475)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (284, 1, 476)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (285, 1, 477)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (286, 1, 478)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (287, 1, 479)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (288, 1, 480)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (289, 1, 481)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (290, 1, 482)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (291, 1, 483)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (292, 1, 484)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (293, 1, 485)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (294, 1, 486)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (296, 1, 488)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (297, 1, 489)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (298, 1, 490)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (300, 1, 492)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (301, 1, 493)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (302, 1, 494)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (303, 1, 495)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (305, 1, 497)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (306, 1, 498)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (307, 1, 499)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (308, 1, 500)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (309, 1, 501)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (310, 1, 502)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (311, 1, 503)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (312, 1, 504)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (313, 1, 505)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (314, 1, 506)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (316, 1, 508)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (317, 1, 509)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (319, 1, 511)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (320, 1, 512)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (321, 1, 513)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (322, 1, 514)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (323, 1, 515)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (324, 1, 516)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (325, 1, 517)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (326, 1, 518)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (329, 1, 521)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (330, 1, 522)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (332, 1, 524)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (333, 1, 525)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (334, 1, 526)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (335, 1, 527)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (337, 1, 529)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (338, 1, 530)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (386, 14, 477)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (390, 14, 481)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (391, 14, 485)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (392, 14, 486)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (393, 14, 490)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (395, 14, 501)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (396, 14, 502)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (402, 16, 485)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (403, 16, 486)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (404, 14, 504)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (405, 14, 505)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (406, 14, 506)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (408, 15, 481)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (409, 15, 485)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (410, 15, 486)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (412, 15, 490)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (413, 15, 492)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (414, 15, 493)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (415, 15, 494)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (416, 15, 495)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (418, 15, 1028)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (419, 15, 509)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (421, 15, 515)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (422, 15, 1191)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (423, 15, 1192)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (424, 15, 1193)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (425, 15, 516)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (426, 15, 517)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (427, 15, 518)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (429, 1, 1507)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (431, 1, 1028)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (432, 1, 1514)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (434, 1, 1512)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (435, 1, 1513)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (436, 1, 1191)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (437, 1, 1192)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (438, 1, 1193)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (440, 1, 1022)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (445, 1, 1419)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (446, 1, 1508)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (447, 1, 1509)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (448, 1, 1510)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (449, 1, 1515)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (450, 1, 1516)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (451, 1, 1517)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (452, 1, 1518)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (453, 1, 1519)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (454, 1, 1520)
GO
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (455, 1, 1521)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (456, 10, 465)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (457, 10, 466)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (458, 10, 467)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (459, 10, 468)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (461, 10, 475)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (462, 10, 476)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (463, 10, 477)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (464, 10, 478)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (465, 10, 479)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (466, 10, 480)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (467, 10, 481)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (468, 10, 482)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (469, 10, 483)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (470, 10, 484)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (471, 10, 1507)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (472, 10, 490)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (473, 10, 492)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (474, 10, 493)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (475, 10, 494)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (476, 10, 495)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (478, 10, 1028)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (479, 10, 1514)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (482, 10, 497)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (483, 10, 498)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (484, 10, 499)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (485, 10, 500)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (486, 10, 501)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (487, 10, 502)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (488, 10, 503)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (489, 10, 504)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (490, 10, 505)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (491, 10, 506)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (493, 10, 508)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (494, 10, 1512)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (495, 10, 509)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (497, 10, 511)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (498, 10, 1513)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (499, 10, 512)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (500, 10, 513)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (501, 10, 514)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (502, 10, 515)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (503, 10, 1191)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (504, 10, 1192)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (505, 10, 1193)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (506, 10, 516)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (507, 10, 517)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (508, 10, 518)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (511, 10, 521)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (512, 10, 522)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (514, 10, 524)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (515, 10, 525)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (516, 10, 526)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (517, 10, 527)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (519, 10, 529)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (520, 10, 530)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (522, 10, 1022)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (527, 10, 1419)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (528, 10, 1508)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (529, 10, 1509)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (530, 10, 1510)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (531, 10, 1515)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (532, 10, 1516)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (533, 10, 1517)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (534, 10, 1518)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (535, 10, 1519)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (536, 10, 1520)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (537, 10, 1521)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (538, 10, 485)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (539, 10, 486)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (541, 10, 488)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (542, 10, 489)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (543, 11, 485)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (544, 11, 486)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (546, 11, 504)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (547, 11, 505)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (548, 11, 506)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (550, 11, 508)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (551, 11, 1512)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (552, 11, 509)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (554, 11, 511)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (555, 11, 1513)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (556, 11, 514)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (557, 11, 525)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (558, 11, 526)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (559, 11, 527)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (561, 11, 529)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (562, 11, 530)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (564, 11, 1022)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (566, 15, 501)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (567, 15, 504)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (568, 15, 505)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (569, 15, 506)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (571, 15, 508)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (572, 15, 1512)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (573, 15, 514)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (574, 15, 1419)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (575, 15, 1508)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (576, 15, 1509)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (577, 15, 1510)
GO
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (578, 15, 1515)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (579, 15, 1516)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (580, 15, 1517)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (581, 15, 1518)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (582, 15, 1519)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (583, 15, 1520)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (584, 15, 1521)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (585, 14, 508)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (586, 14, 1512)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (589, 11, 481)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (590, 11, 482)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (591, 11, 483)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (592, 11, 484)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (593, 11, 1507)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (594, 11, 488)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (595, 11, 489)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (596, 11, 501)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (597, 11, 502)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (598, 11, 515)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (599, 11, 1191)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (600, 11, 1192)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (601, 11, 1193)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (602, 11, 516)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (603, 11, 517)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (604, 11, 518)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (606, 14, 489)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (607, 15, 482)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (608, 15, 483)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (609, 15, 484)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (610, 15, 1507)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (611, 15, 1514)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (612, 15, 502)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (616, 14, 1522)
INSERT [dbo].[NhomQuyenRoute] ([ID], [MaNhomQuyen], [IDRoute]) VALUES (617, 14, 1523)
SET IDENTITY_INSERT [dbo].[NhomQuyenRoute] OFF
SET IDENTITY_INSERT [dbo].[Page] ON 

INSERT [dbo].[Page] ([id], [name], [description], [controller], [namespace]) VALUES (110, N'Quản lý tài khoản', NULL, N'Account', N'Quanlyduoc.Areas.Admin.Controllers')
INSERT [dbo].[Page] ([id], [name], [description], [controller], [namespace]) VALUES (113, N'Quản lý chức năng', NULL, N'ChucNang', N'Quanlyduoc.Areas.Admin.Controllers')
INSERT [dbo].[Page] ([id], [name], [description], [controller], [namespace]) VALUES (114, N'Chương trình khuyến mại', NULL, N'ChuongTrinhKhuyenMai', N'Quanlyduoc.Areas.Admin.Controllers')
INSERT [dbo].[Page] ([id], [name], [description], [controller], [namespace]) VALUES (115, N'Đầu thuốc', NULL, N'DauThuoc', N'Quanlyduoc.Areas.Admin.Controllers')
INSERT [dbo].[Page] ([id], [name], [description], [controller], [namespace]) VALUES (116, N'Hóa đơn đặt hàng', NULL, N'HoaDon', N'Quanlyduoc.Areas.Admin.Controllers')
INSERT [dbo].[Page] ([id], [name], [description], [controller], [namespace]) VALUES (117, N'Vận chuyển', NULL, N'HoaDonVanChuyen', N'Quanlyduoc.Areas.Admin.Controllers')
INSERT [dbo].[Page] ([id], [name], [description], [controller], [namespace]) VALUES (118, N'Hóa đơn xuất', NULL, N'HoaDonXuat', N'Quanlyduoc.Areas.Admin.Controllers')
INSERT [dbo].[Page] ([id], [name], [description], [controller], [namespace]) VALUES (120, N'Kế hoạch làm việc', NULL, N'KeHoachLamViec', N'Quanlyduoc.Areas.Admin.Controllers')
INSERT [dbo].[Page] ([id], [name], [description], [controller], [namespace]) VALUES (121, N'Khách hàng', NULL, N'KhachHang', N'Quanlyduoc.Areas.Admin.Controllers')
INSERT [dbo].[Page] ([id], [name], [description], [controller], [namespace]) VALUES (122, N'Quản lý kho', NULL, N'Kho', N'Quanlyduoc.Areas.Admin.Controllers')
INSERT [dbo].[Page] ([id], [name], [description], [controller], [namespace]) VALUES (123, N'Quản lý chức năng', NULL, N'Modul', N'Quanlyduoc.Areas.Admin.Controllers')
INSERT [dbo].[Page] ([id], [name], [description], [controller], [namespace]) VALUES (124, N'Quản lý người vận chuyển', NULL, N'NguoiVanChuyen', N'Quanlyduoc.Areas.Admin.Controllers')
INSERT [dbo].[Page] ([id], [name], [description], [controller], [namespace]) VALUES (125, N'Quản lý nhà sản xuất', NULL, N'NhaSanXuat', N'Quanlyduoc.Areas.Admin.Controllers')
INSERT [dbo].[Page] ([id], [name], [description], [controller], [namespace]) VALUES (126, N'Nhóm đầu thuốc', NULL, N'NhomDauThuoc', N'Quanlyduoc.Areas.Admin.Controllers')
INSERT [dbo].[Page] ([id], [name], [description], [controller], [namespace]) VALUES (127, N'Nhóm quyền', NULL, N'NhomQuyen', N'Quanlyduoc.Areas.Admin.Controllers')
INSERT [dbo].[Page] ([id], [name], [description], [controller], [namespace]) VALUES (128, N'Trình dược', NULL, N'TrinhDuoc', N'Quanlyduoc.Areas.Admin.Controllers')
INSERT [dbo].[Page] ([id], [name], [description], [controller], [namespace]) VALUES (224, N'Quản lý map', NULL, N'CheckMap', N'Quanlyduoc.Areas.Admin.Controllers')
INSERT [dbo].[Page] ([id], [name], [description], [controller], [namespace]) VALUES (319, N'Quản lý nhập', NULL, N'HoaDonNhap', N'Quanlyduoc.Areas.Admin.Controllers')
INSERT [dbo].[Page] ([id], [name], [description], [controller], [namespace]) VALUES (344, N'Quản lý thu chi', NULL, N'ThuChi', N'Quanlyduoc.Areas.Admin.Controllers')
INSERT [dbo].[Page] ([id], [name], [description], [controller], [namespace]) VALUES (345, NULL, NULL, N'Home', N'Quanlyduoc.Areas.Admin.Controllers')
SET IDENTITY_INSERT [dbo].[Page] OFF
SET IDENTITY_INSERT [dbo].[Position] ON 

INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (14, N'TK000002', N'20.9697149', N'105.87241309999999', CAST(0x0000AA25014ECE73 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (15, N'TK000002', N'20.9697158', N'105.8724129', CAST(0x0000AA25014EF264 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (16, N'TK000005', N'20.987684899999998', N'105.8357724', CAST(0x0000AA2600925143 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (17, N'TK000006', N'20.9876579', N'105.8359369', CAST(0x0000AA27008BB3A1 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (18, N'TK000006', N'20.9876208', N'105.8358217', CAST(0x0000AA27008C0FEE AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (19, N'TK000006', N'20.9731941', N'105.869948', CAST(0x0000AA2700D27012 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (20, N'TK000002', N'20.969729599999997', N'105.8723558', CAST(0x0000AA280165F3E2 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (21, N'TK000002', N'20.9697148', N'105.87236689999999', CAST(0x0000AA280179C789 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (22, N'TK000002', N'20.969723', N'105.8723686', CAST(0x0000AA280179E7A6 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (23, N'TK000002', N'20.969723', N'105.8723686', CAST(0x0000AA28017A0473 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (24, N'TK000002', N'20.969723', N'105.8723686', CAST(0x0000AA28017A2606 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (25, N'TK000002', N'20.969723', N'105.8723686', CAST(0x0000AA28017A561A AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (26, N'TK000002', N'20.969723', N'105.8723686', CAST(0x0000AA28017A6AF3 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (27, N'TK000002', N'20.969723', N'105.8723686', CAST(0x0000AA28017A6FA4 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (28, N'TK000002', N'20.969723', N'105.8723686', CAST(0x0000AA28017A7A8A AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (29, N'TK000002', N'20.969723', N'105.8723686', CAST(0x0000AA28017A81AA AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (30, N'TK000002', N'20.969723', N'105.8723686', CAST(0x0000AA28017A83F6 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (31, N'TK000002', N'20.969723', N'105.8723686', CAST(0x0000AA28017A8A61 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (32, N'TK000006', N'20.9723875', N'105.8703005', CAST(0x0000AA290081F651 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (33, N'TK000006', N'20.9731941', N'105.869948', CAST(0x0000AA2900824DAC AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (34, N'TK000006', N'20.9839348', N'105.8560018', CAST(0x0000AA290083E366 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (35, N'TK000006', N'20.985091', N'105.8552678', CAST(0x0000AA290083EAF5 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (37, N'TK000002', N'20.9877209', N'105.8358631', CAST(0x0000AA2A009B0551 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (38, N'TK000005', N'20.987723199999998', N'105.8356718', CAST(0x0000AA2B00DF2B6F AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (39, N'TK000002', N'20.987766099999998', N'105.8356706', CAST(0x0000AA2B00E0833B AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (40, N'TK000002', N'20.9878005', N'105.83565159999999', CAST(0x0000AA2B00E0A7D0 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (41, N'TK000002', N'20.987533499999998', N'105.8357704', CAST(0x0000AA2B00E17ABA AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (42, N'TK000002', N'20.987668199999998', N'105.8357283', CAST(0x0000AA2B00E24DA7 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (43, N'TK000002', N'20.9875451', N'105.8357573', CAST(0x0000AA2B00EC1558 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (44, N'TK000002', N'20.9875451', N'105.8357573', CAST(0x0000AA2B00EC1BC0 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (45, N'TK000002', N'20.9875096', N'105.83575719999999', CAST(0x0000AA2B00EC2644 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (46, N'TK000002', N'20.9876093', N'105.83571479999999', CAST(0x0000AA2B00EC4614 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (47, N'TK000002', N'20.987578799999998', N'105.8358432', CAST(0x0000AA2B00F62FDF AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (48, N'TK000002', N'20.987578799999998', N'105.8358432', CAST(0x0000AA2B00F637F2 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (49, N'TK000002', N'20.9876734', N'105.83570929999999', CAST(0x0000AA2B00F69E3F AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (50, N'TK000002', N'20.9876695', N'105.8357774', CAST(0x0000AA2B00F77108 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (51, N'TK000002', N'20.9876818', N'105.8357638', CAST(0x0000AA2B00F7FF8B AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (52, N'TK000002', N'20.9876818', N'105.8357638', CAST(0x0000AA2B00F804E1 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (53, N'TK000002', N'20.9876818', N'105.8357638', CAST(0x0000AA2B00F80C73 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (54, N'TK000002', N'20.9876818', N'105.8357638', CAST(0x0000AA2B00F82D0C AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (55, N'TK000002', N'20.987827799999998', N'105.8356039', CAST(0x0000AA2B00F95F0D AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (56, N'TK000002', N'20.987827799999998', N'105.8356039', CAST(0x0000AA2B00F96585 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (57, N'TK000002', N'20.9876419', N'105.8356979', CAST(0x0000AA2B00FA4845 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (58, N'TK000002', N'20.9876419', N'105.8356979', CAST(0x0000AA2B00FA4FC7 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (59, N'TK000002', N'20.9876419', N'105.8356979', CAST(0x0000AA2B00FA58E5 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (60, N'TK000002', N'20.987604100000002', N'105.8357119', CAST(0x0000AA2B00FAB10A AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (61, N'TK000002', N'20.987604100000002', N'105.8357119', CAST(0x0000AA2B00FAB5BE AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (62, N'TK000002', N'20.987602799999998', N'105.83575379999999', CAST(0x0000AA2B00FABD4E AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (63, N'TK000002', N'20.987602799999998', N'105.83575379999999', CAST(0x0000AA2B00FACE9E AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (64, N'TK000002', N'20.987602799999998', N'105.83575379999999', CAST(0x0000AA2B00FAD5FA AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (65, N'TK000002', N'20.987602799999998', N'105.83575379999999', CAST(0x0000AA2B00FAEDB1 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (66, N'TK000002', N'20.987602799999998', N'105.83575379999999', CAST(0x0000AA2B00FAF202 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (67, N'TK000002', N'20.987584899999998', N'105.8357723', CAST(0x0000AA2B00FB265B AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (68, N'TK000002', N'20.987584899999998', N'105.8357723', CAST(0x0000AA2B00FB2D6D AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (69, N'TK000002', N'20.987584899999998', N'105.8357723', CAST(0x0000AA2B00FB32AE AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (70, N'TK000002', N'20.987584899999998', N'105.8357723', CAST(0x0000AA2B00FB38BA AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (71, N'TK000002', N'20.987655', N'105.83577340000001', CAST(0x0000AA2B01008260 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (72, N'TK000002', N'20.987655', N'105.83577340000001', CAST(0x0000AA2B0100871C AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (73, N'TK000002', N'20.987655', N'105.83577340000001', CAST(0x0000AA2B0100A8DA AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (74, N'TK000002', N'20.9876535', N'105.83580889999999', CAST(0x0000AA2B0101009F AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (75, N'TK000002', N'20.9876535', N'105.83580889999999', CAST(0x0000AA2B010106FC AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (76, N'TK000002', N'20.9875766', N'105.83577629999999', CAST(0x0000AA2B0101A91B AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (77, N'TK000002', N'20.9875766', N'105.83577629999999', CAST(0x0000AA2B0101B159 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (78, N'TK000002', N'20.9876261', N'105.83583019999999', CAST(0x0000AA2B0101E326 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (79, N'TK000002', N'20.9876261', N'105.83583019999999', CAST(0x0000AA2B0101F923 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (80, N'TK000002', N'20.987587299999998', N'105.8357496', CAST(0x0000AA2B010242B7 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (81, N'TK000002', N'20.987587299999998', N'105.8357496', CAST(0x0000AA2B010256A0 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (82, N'TK000002', N'20.987656299999998', N'105.83559980000001', CAST(0x0000AA2B010292EE AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (83, N'TK000002', N'20.987623799999998', N'105.83577389999999', CAST(0x0000AA2B01030DEC AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (84, N'TK000002', N'20.987623799999998', N'105.83577389999999', CAST(0x0000AA2B01032403 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (85, N'TK000002', N'20.9876913', N'105.8357211', CAST(0x0000AA2B0103B194 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (86, N'TK000002', N'20.9876501', N'105.8358051', CAST(0x0000AA2B01048468 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (87, N'TK000002', N'20.9876082', N'105.8357599', CAST(0x0000AA2B0105157B AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (88, N'TK000002', N'20.9876586', N'105.8357886', CAST(0x0000AA2B01057776 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (89, N'TK000002', N'20.9876586', N'105.8357886', CAST(0x0000AA2B01057DCB AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (90, N'TK000002', N'20.9876586', N'105.8357886', CAST(0x0000AA2B01059846 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (91, N'TK000002', N'20.9875901', N'105.83582129999999', CAST(0x0000AA2B01064E99 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (92, N'TK000002', N'20.9875901', N'105.83582129999999', CAST(0x0000AA2B010653F8 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (93, N'TK000002', N'20.9875901', N'105.83582129999999', CAST(0x0000AA2B01067537 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (94, N'TK000002', N'20.9875901', N'105.83582129999999', CAST(0x0000AA2B0106788C AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (95, N'TK000002', N'20.9875901', N'105.83582129999999', CAST(0x0000AA2B01067B94 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (96, N'TK000002', N'20.9876622', N'105.8357142', CAST(0x0000AA2B0106E941 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (97, N'TK000002', N'20.9876622', N'105.8357142', CAST(0x0000AA2B0106EEB5 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (98, N'TK000002', N'20.9876622', N'105.8357142', CAST(0x0000AA2B0106F4FC AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (99, N'TK000002', N'20.9878', N'105.835636', CAST(0x0000AA2B010C8C9F AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (100, N'TK000002', N'20.9878', N'105.835636', CAST(0x0000AA2B010C90B8 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (101, N'TK000002', N'20.987665099999997', N'105.8358519', CAST(0x0000AA2B010D63C9 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (102, N'TK000002', N'20.9876415', N'105.835822', CAST(0x0000AA2B010E36C3 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (103, N'TK000002', N'20.9876315', N'105.83578349999999', CAST(0x0000AA2B010F09C5 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (104, N'TK000002', N'20.9876085', N'105.8358093', CAST(0x0000AA2B010FDC9D AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (105, N'TK000002', N'20.987625400000002', N'105.83581769999999', CAST(0x0000AA2B0110AF84 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (106, N'TK000002', N'20.987602700000004', N'105.8358062', CAST(0x0000AA2B0111828A AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (107, N'TK000002', N'20.9876131', N'105.8358623', CAST(0x0000AA2B0112556D AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (108, N'TK000002', N'20.9875622', N'105.83575719999999', CAST(0x0000AA2B01132858 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (109, N'TK000002', N'20.9875711', N'105.83580169999999', CAST(0x0000AA2B0113FB40 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (110, N'TK000002', N'20.987701299999998', N'105.8356779', CAST(0x0000AA2B0114CE26 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (111, N'TK000002', N'20.9875676', N'105.83578829999999', CAST(0x0000AA2B0115A10B AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (112, N'TK000002', N'20.9876015', N'105.8358356', CAST(0x0000AA2B01169596 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (113, N'TK000002', N'20.987609499999998', N'105.8358002', CAST(0x0000AA2B011B5B9F AS DateTime))
GO
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (114, N'TK000002', N'20.9876491', N'105.8358954', CAST(0x0000AA2B011C2E82 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (115, N'TK000002', N'20.987588199999998', N'105.8357977', CAST(0x0000AA2B011D0168 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (116, N'TK000002', N'20.987596', N'105.83577509999999', CAST(0x0000AA2B011DD456 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (117, N'TK000002', N'20.9876358', N'105.8358162', CAST(0x0000AA2B011EEB00 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (118, N'TK000002', N'20.9876358', N'105.8358162', CAST(0x0000AA2B011EEFA7 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (119, N'TK000002', N'20.9876211', N'105.83572989999999', CAST(0x0000AA2B012151FF AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (120, N'TK000002', N'20.987724099999998', N'105.8356735', CAST(0x0000AA2B0121AA23 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (121, N'TK000002', N'20.987668400000004', N'105.8357511', CAST(0x0000AA2B0121BD1F AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (122, N'TK000002', N'20.9876558', N'105.8358523', CAST(0x0000AA2C008FF129 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (123, N'TK000002', N'20.987582500000002', N'105.83586489999999', CAST(0x0000AA2C0090C416 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (124, N'TK000002', N'20.9878149', N'105.8356743', CAST(0x0000AA4A009F714E AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (125, N'TK000002', N'20.9878149', N'105.8356743', CAST(0x0000AA4A009F7BC2 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (126, N'TK000002', N'20.987798899999998', N'105.83570119999999', CAST(0x0000AA4A009F8096 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (127, N'TK000002', N'20.987747199999998', N'105.83575189999999', CAST(0x0000AA4A009FC8A5 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (128, N'TK000002', N'20.987747199999998', N'105.83575189999999', CAST(0x0000AA4A009FCD5B AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (129, N'TK000002', N'20.987747199999998', N'105.83575189999999', CAST(0x0000AA4A009FED0A AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (130, N'TK000002', N'20.987751799999998', N'105.83585300000001', CAST(0x0000AA4A00A0C02A AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (131, N'TK000002', N'20.9877495', N'105.83571549999999', CAST(0x0000AA4A00A19301 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (132, N'TK000002', N'20.987668499999998', N'105.8358737', CAST(0x0000AA4A00A265F0 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (133, N'TK000002', N'20.9876784', N'105.8358592', CAST(0x0000AA4A00A31C57 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (134, N'TK000002', N'20.987705', N'105.83585219999999', CAST(0x0000AA4A00A3EF3F AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (135, N'TK000002', N'20.987705', N'105.83585219999999', CAST(0x0000AA4A00A3F735 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (136, N'TK000002', N'20.9877283', N'105.8357348', CAST(0x0000AA4A00A43600 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (137, N'TK000002', N'20.9877277', N'105.8357241', CAST(0x0000AA4A00A4808B AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (138, N'TK000002', N'20.9877277', N'105.8357241', CAST(0x0000AA4A00A4A15C AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (139, N'TK000002', N'20.9876458', N'105.8359993', CAST(0x0000AA4A00A57427 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (140, N'TK000002', N'20.9876705', N'105.8358669', CAST(0x0000AA4A00A5A8E3 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (141, N'TK000002', N'20.9876586', N'105.8359296', CAST(0x0000AA4A00A5D50B AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (142, N'TK000002', N'20.9876996', N'105.83585839999999', CAST(0x0000AA4A00A619BC AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (143, N'TK000002', N'20.9876996', N'105.83585839999999', CAST(0x0000AA4A00A61BE2 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (144, N'TK000002', N'20.9878069', N'105.83573349999999', CAST(0x0000AA4A00A7A601 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (145, N'TK000002', N'20.9876859', N'105.835931', CAST(0x0000AA4A00A7EAC0 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (146, N'TK000002', N'20.987775799999998', N'105.8357403', CAST(0x0000AA4A00A894D0 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (147, N'TK000002', N'20.9876403', N'105.8358959', CAST(0x0000AA4A00A967C0 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (148, N'TK000005', N'20.9876674', N'105.8358468', CAST(0x0000AA540092BCD2 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (149, N'TK000005', N'20.9876674', N'105.8358468', CAST(0x0000AA540092C312 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (150, N'TK000005', N'20.9876674', N'105.8358468', CAST(0x0000AA540092CB9D AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (151, N'TK000005', N'20.98774', N'105.8358758', CAST(0x0000AA5400935993 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (152, N'TK000005', N'20.98774', N'105.8358758', CAST(0x0000AA54009360F7 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (153, N'TK000005', N'20.987718599999997', N'105.83582659999999', CAST(0x0000AA540094340D AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (154, N'TK000005', N'20.987757', N'105.8357928', CAST(0x0000AA54009506FC AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (155, N'TK000005', N'20.987757', N'105.8357928', CAST(0x0000AA540095126C AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (156, N'TK000005', N'20.987759', N'105.8358068', CAST(0x0000AA54009552CE AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (157, N'TK000005', N'20.9877219', N'105.8358245', CAST(0x0000AA5400956C25 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (158, N'TK000005', N'20.9877936', N'105.83578', CAST(0x0000AA540095FDB8 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (159, N'TK000005', N'20.9876799', N'105.8359947', CAST(0x0000AA54009AA1CA AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (160, N'TK000006', N'20.9876799', N'105.8359947', CAST(0x0000AA54009AD272 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (161, N'TK000006', N'20.9876799', N'105.8359947', CAST(0x0000AA54009ADBC7 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (162, N'TK000006', N'20.987739899999998', N'105.8358588', CAST(0x0000AA54009AF578 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (163, N'TK000006', N'20.987739899999998', N'105.8358588', CAST(0x0000AA54009AFB65 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (164, N'TK000006', N'20.987739899999998', N'105.8358588', CAST(0x0000AA54009AFE37 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (165, N'TK000006', N'20.987739899999998', N'105.8358588', CAST(0x0000AA54009B0022 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (166, N'TK000006', N'20.987739899999998', N'105.8358588', CAST(0x0000AA54009B04D1 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (167, N'TK000006', N'20.987739899999998', N'105.8358588', CAST(0x0000AA54009B0656 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (168, N'TK000006', N'20.987739899999998', N'105.8358588', CAST(0x0000AA54009B07F9 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (169, N'TK000006', N'20.987739899999998', N'105.8358588', CAST(0x0000AA54009B0DBE AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (170, N'TK000006', N'20.987739899999998', N'105.8358588', CAST(0x0000AA54009B103E AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (171, N'TK000006', N'20.987739899999998', N'105.8358588', CAST(0x0000AA54009B13C2 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (172, N'TK000006', N'20.987739899999998', N'105.8358588', CAST(0x0000AA54009B1ABF AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (173, N'TK000006', N'20.9877146', N'105.8358746', CAST(0x0000AA54009B22CF AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (174, N'TK000006', N'20.9877146', N'105.8358746', CAST(0x0000AA54009B252A AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (175, N'TK000006', N'20.9877146', N'105.8358746', CAST(0x0000AA54009B2983 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (176, N'TK000006', N'20.9876865', N'105.83580649999999', CAST(0x0000AA54009B7236 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (177, N'TK000006', N'20.9876865', N'105.83580649999999', CAST(0x0000AA54009BA27E AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (178, N'TK000006', N'20.9877344', N'105.8358155', CAST(0x0000AA54009BAE4E AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (179, N'TK000006', N'20.9877344', N'105.8358155', CAST(0x0000AA54009BB1FF AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (180, N'TK000002', N'20.9878009', N'105.83573080000001', CAST(0x0000AA5500B24815 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (181, N'TK000002', N'20.9878009', N'105.83573080000001', CAST(0x0000AA5500B258E7 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (182, N'TK000002', N'20.9877914', N'105.8356553', CAST(0x0000AA5500BDBEF2 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (183, N'TK000002', N'20.987743599999998', N'105.8357838', CAST(0x0000AA5500BE1589 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (184, N'TK000002', N'20.987743599999998', N'105.8357838', CAST(0x0000AA5500BE1D10 AS DateTime))
INSERT [dbo].[Position] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (185, N'TK000002', N'20.9877754', N'105.8358732', CAST(0x0000AA5500BE25D5 AS DateTime))
SET IDENTITY_INSERT [dbo].[Position] OFF
SET IDENTITY_INSERT [dbo].[PositionNow] ON 

INSERT [dbo].[PositionNow] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (15, N'TK000002', N'20.9877754', N'105.8358732', CAST(0x0000AA5500BE25D5 AS DateTime))
INSERT [dbo].[PositionNow] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (16, N'TK000005', N'20.9876799', N'105.8359947', CAST(0x0000AA54009AA1CC AS DateTime))
INSERT [dbo].[PositionNow] ([ID], [MaTK], [Lat], [Lng], [Time]) VALUES (17, N'TK000006', N'20.9877344', N'105.8358155', CAST(0x0000AA54009BB201 AS DateTime))
SET IDENTITY_INSERT [dbo].[PositionNow] OFF
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (1, N'Quận Ba Đình', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (2, N'Quận Hoàn Kiếm', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (3, N'Quận Tây Hồ', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (4, N'Quận Long Biên', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (5, N'Quận Cầu Giấy', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (6, N'Quận Đống Đa', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (7, N'Quận Hai Bà Trưng', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (8, N'Quận Hoàng Mai', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (9, N'Quận Thanh Xuân', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (16, N'Huyện Sóc Sơn', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (17, N'Huyện Đông Anh', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (18, N'Huyện Gia Lâm', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (19, N'Quận Nam Từ Liêm', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (20, N'Huyện Thanh Trì', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (21, N'Quận Bắc Từ Liêm', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (24, N'Thành phố Hà Giang', 2)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (26, N'Huyện Đồng Văn', 2)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (27, N'Huyện Mèo Vạc', 2)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (28, N'Huyện Yên Minh', 2)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (29, N'Huyện Quản Bạ', 2)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (30, N'Huyện Vị Xuyên', 2)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (31, N'Huyện Bắc Mê', 2)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (32, N'Huyện Hoàng Su Phì', 2)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (33, N'Huyện Xín Mần', 2)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (34, N'Huyện Bắc Quang', 2)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (35, N'Huyện Quang Bình', 2)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (40, N'Thành phố Cao Bằng', 4)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (42, N'Huyện Bảo Lâm', 4)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (43, N'Huyện Bảo Lạc', 4)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (44, N'Huyện Thông Nông', 4)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (45, N'Huyện Hà Quảng', 4)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (46, N'Huyện Trà Lĩnh', 4)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (47, N'Huyện Trùng Khánh', 4)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (48, N'Huyện Hạ Lang', 4)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (49, N'Huyện Quảng Uyên', 4)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (50, N'Huyện Phục Hoà', 4)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (51, N'Huyện Hoà An', 4)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (52, N'Huyện Nguyên Bình', 4)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (53, N'Huyện Thạch An', 4)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (58, N'Thành Phố Bắc Kạn', 6)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (60, N'Huyện Pác Nặm', 6)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (61, N'Huyện Ba Bể', 6)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (62, N'Huyện Ngân Sơn', 6)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (63, N'Huyện Bạch Thông', 6)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (64, N'Huyện Chợ Đồn', 6)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (65, N'Huyện Chợ Mới', 6)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (66, N'Huyện Na Rì', 6)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (70, N'Thành phố Tuyên Quang', 8)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (71, N'Huyện Lâm Bình', 8)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (72, N'Huyện Na Hang', 8)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (73, N'Huyện Chiêm Hóa', 8)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (74, N'Huyện Hàm Yên', 8)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (75, N'Huyện Yên Sơn', 8)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (76, N'Huyện Sơn Dương', 8)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (80, N'Thành phố Lào Cai', 10)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (82, N'Huyện Bát Xát', 10)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (83, N'Huyện Mường Khương', 10)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (84, N'Huyện Si Ma Cai', 10)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (85, N'Huyện Bắc Hà', 10)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (86, N'Huyện Bảo Thắng', 10)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (87, N'Huyện Bảo Yên', 10)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (88, N'Huyện Sa Pa', 10)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (89, N'Huyện Văn Bàn', 10)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (94, N'Thành phố Điện Biên Phủ', 11)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (95, N'Thị Xã Mường Lay', 11)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (96, N'Huyện Mường Nhé', 11)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (97, N'Huyện Mường Chà', 11)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (98, N'Huyện Tủa Chùa', 11)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (99, N'Huyện Tuần Giáo', 11)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (100, N'Huyện Điện Biên', 11)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (101, N'Huyện Điện Biên Đông', 11)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (102, N'Huyện Mường Ảng', 11)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (103, N'Huyện Nậm Pồ', 11)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (105, N'Thành phố Lai Châu', 12)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (106, N'Huyện Tam Đường', 12)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (107, N'Huyện Mường Tè', 12)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (108, N'Huyện Sìn Hồ', 12)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (109, N'Huyện Phong Thổ', 12)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (110, N'Huyện Than Uyên', 12)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (111, N'Huyện Tân Uyên', 12)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (112, N'Huyện Nậm Nhùn', 12)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (116, N'Thành phố Sơn La', 14)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (118, N'Huyện Quỳnh Nhai', 14)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (119, N'Huyện Thuận Châu', 14)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (120, N'Huyện Mường La', 14)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (121, N'Huyện Bắc Yên', 14)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (122, N'Huyện Phù Yên', 14)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (123, N'Huyện Mộc Châu', 14)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (124, N'Huyện Yên Châu', 14)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (125, N'Huyện Mai Sơn', 14)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (126, N'Huyện Sông Mã', 14)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (127, N'Huyện Sốp Cộp', 14)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (128, N'Huyện Vân Hồ', 14)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (132, N'Thành phố Yên Bái', 15)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (133, N'Thị xã Nghĩa Lộ', 15)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (135, N'Huyện Lục Yên', 15)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (136, N'Huyện Văn Yên', 15)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (137, N'Huyện Mù Căng Chải', 15)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (138, N'Huyện Trấn Yên', 15)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (139, N'Huyện Trạm Tấu', 15)
GO
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (140, N'Huyện Văn Chấn', 15)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (141, N'Huyện Yên Bình', 15)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (148, N'Thành phố Hòa Bình', 17)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (150, N'Huyện Đà Bắc', 17)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (151, N'Huyện Kỳ Sơn', 17)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (152, N'Huyện Lương Sơn', 17)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (153, N'Huyện Kim Bôi', 17)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (154, N'Huyện Cao Phong', 17)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (155, N'Huyện Tân Lạc', 17)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (156, N'Huyện Mai Châu', 17)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (157, N'Huyện Lạc Sơn', 17)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (158, N'Huyện Yên Thủy', 17)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (159, N'Huyện Lạc Thủy', 17)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (164, N'Thành phố Thái Nguyên', 19)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (165, N'Thành phố Sông Công', 19)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (167, N'Huyện Định Hóa', 19)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (168, N'Huyện Phú Lương', 19)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (169, N'Huyện Đồng Hỷ', 19)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (170, N'Huyện Võ Nhai', 19)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (171, N'Huyện Đại Từ', 19)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (172, N'Thị xã Phổ Yên', 19)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (173, N'Huyện Phú Bình', 19)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (178, N'Thành phố Lạng Sơn', 20)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (180, N'Huyện Tràng Định', 20)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (181, N'Huyện Bình Gia', 20)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (182, N'Huyện Văn Lãng', 20)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (183, N'Huyện Cao Lộc', 20)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (184, N'Huyện Văn Quan', 20)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (185, N'Huyện Bắc Sơn', 20)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (186, N'Huyện Hữu Lũng', 20)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (187, N'Huyện Chi Lăng', 20)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (188, N'Huyện Lộc Bình', 20)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (189, N'Huyện Đình Lập', 20)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (193, N'Thành phố Hạ Long', 22)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (194, N'Thành phố Móng Cái', 22)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (195, N'Thành phố Cẩm Phả', 22)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (196, N'Thành phố Uông Bí', 22)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (198, N'Huyện Bình Liêu', 22)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (199, N'Huyện Tiên Yên', 22)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (200, N'Huyện Đầm Hà', 22)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (201, N'Huyện Hải Hà', 22)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (202, N'Huyện Ba Chẽ', 22)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (203, N'Huyện Vân Đồn', 22)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (204, N'Huyện Hoành Bồ', 22)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (205, N'Thị xã Đông Triều', 22)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (206, N'Thị xã Quảng Yên', 22)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (207, N'Huyện Cô Tô', 22)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (213, N'Thành phố Bắc Giang', 24)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (215, N'Huyện Yên Thế', 24)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (216, N'Huyện Tân Yên', 24)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (217, N'Huyện Lạng Giang', 24)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (218, N'Huyện Lục Nam', 24)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (219, N'Huyện Lục Ngạn', 24)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (220, N'Huyện Sơn Động', 24)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (221, N'Huyện Yên Dũng', 24)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (222, N'Huyện Việt Yên', 24)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (223, N'Huyện Hiệp Hòa', 24)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (227, N'Thành phố Việt Trì', 25)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (228, N'Thị xã Phú Thọ', 25)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (230, N'Huyện Đoan Hùng', 25)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (231, N'Huyện Hạ Hoà', 25)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (232, N'Huyện Thanh Ba', 25)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (233, N'Huyện Phù Ninh', 25)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (234, N'Huyện Yên Lập', 25)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (235, N'Huyện Cẩm Khê', 25)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (236, N'Huyện Tam Nông', 25)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (237, N'Huyện Lâm Thao', 25)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (238, N'Huyện Thanh Sơn', 25)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (239, N'Huyện Thanh Thuỷ', 25)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (240, N'Huyện Tân Sơn', 25)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (243, N'Thành phố Vĩnh Yên', 26)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (244, N'Thị xã Phúc Yên', 26)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (246, N'Huyện Lập Thạch', 26)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (247, N'Huyện Tam Dương', 26)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (248, N'Huyện Tam Đảo', 26)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (249, N'Huyện Bình Xuyên', 26)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (250, N'Huyện Mê Linh', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (251, N'Huyện Yên Lạc', 26)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (252, N'Huyện Vĩnh Tường', 26)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (253, N'Huyện Sông Lô', 26)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (256, N'Thành phố Bắc Ninh', 27)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (258, N'Huyện Yên Phong', 27)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (259, N'Huyện Quế Võ', 27)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (260, N'Huyện Tiên Du', 27)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (261, N'Thị xã Từ Sơn', 27)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (262, N'Huyện Thuận Thành', 27)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (263, N'Huyện Gia Bình', 27)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (264, N'Huyện Lương Tài', 27)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (268, N'Quận Hà Đông', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (269, N'Thị xã Sơn Tây', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (271, N'Huyện Ba Vì', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (272, N'Huyện Phúc Thọ', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (273, N'Huyện Đan Phượng', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (274, N'Huyện Hoài Đức', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (275, N'Huyện Quốc Oai', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (276, N'Huyện Thạch Thất', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (277, N'Huyện Chương Mỹ', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (278, N'Huyện Thanh Oai', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (279, N'Huyện Thường Tín', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (280, N'Huyện Phú Xuyên', 1)
GO
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (281, N'Huyện Ứng Hòa', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (282, N'Huyện Mỹ Đức', 1)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (288, N'Thành phố Hải Dương', 30)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (290, N'Thị xã Chí Linh', 30)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (291, N'Huyện Nam Sách', 30)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (292, N'Huyện Kinh Môn', 30)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (293, N'Huyện Kim Thành', 30)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (294, N'Huyện Thanh Hà', 30)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (295, N'Huyện Cẩm Giàng', 30)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (296, N'Huyện Bình Giang', 30)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (297, N'Huyện Gia Lộc', 30)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (298, N'Huyện Tứ Kỳ', 30)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (299, N'Huyện Ninh Giang', 30)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (300, N'Huyện Thanh Miện', 30)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (303, N'Quận Hồng Bàng', 31)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (304, N'Quận Ngô Quyền', 31)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (305, N'Quận Lê Chân', 31)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (306, N'Quận Hải An', 31)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (307, N'Quận Kiến An', 31)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (308, N'Quận Đồ Sơn', 31)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (309, N'Quận Dương Kinh', 31)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (311, N'Huyện Thuỷ Nguyên', 31)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (312, N'Huyện An Dương', 31)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (313, N'Huyện An Lão', 31)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (314, N'Huyện Kiến Thuỵ', 31)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (315, N'Huyện Tiên Lãng', 31)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (316, N'Huyện Vĩnh Bảo', 31)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (317, N'Huyện Cát Hải', 31)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (318, N'Huyện Bạch Long Vĩ', 31)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (323, N'Thành phố Hưng Yên', 33)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (325, N'Huyện Văn Lâm', 33)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (326, N'Huyện Văn Giang', 33)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (327, N'Huyện Yên Mỹ', 33)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (328, N'Huyện Mỹ Hào', 33)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (329, N'Huyện Ân Thi', 33)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (330, N'Huyện Khoái Châu', 33)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (331, N'Huyện Kim Động', 33)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (332, N'Huyện Tiên Lữ', 33)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (333, N'Huyện Phù Cừ', 33)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (336, N'Thành phố Thái Bình', 34)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (338, N'Huyện Quỳnh Phụ', 34)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (339, N'Huyện Hưng Hà', 34)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (340, N'Huyện Đông Hưng', 34)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (341, N'Huyện Thái Thụy', 34)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (342, N'Huyện Tiền Hải', 34)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (343, N'Huyện Kiến Xương', 34)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (344, N'Huyện Vũ Thư', 34)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (347, N'Thành phố Phủ Lý', 35)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (349, N'Huyện Duy Tiên', 35)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (350, N'Huyện Kim Bảng', 35)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (351, N'Huyện Thanh Liêm', 35)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (352, N'Huyện Bình Lục', 35)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (353, N'Huyện Lý Nhân', 35)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (356, N'Thành phố Nam Định', 36)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (358, N'Huyện Mỹ Lộc', 36)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (359, N'Huyện Vụ Bản', 36)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (360, N'Huyện Ý Yên', 36)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (361, N'Huyện Nghĩa Hưng', 36)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (362, N'Huyện Nam Trực', 36)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (363, N'Huyện Trực Ninh', 36)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (364, N'Huyện Xuân Trường', 36)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (365, N'Huyện Giao Thủy', 36)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (366, N'Huyện Hải Hậu', 36)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (369, N'Thành phố Ninh Bình', 37)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (370, N'Thành phố Tam Điệp', 37)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (372, N'Huyện Nho Quan', 37)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (373, N'Huyện Gia Viễn', 37)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (374, N'Huyện Hoa Lư', 37)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (375, N'Huyện Yên Khánh', 37)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (376, N'Huyện Kim Sơn', 37)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (377, N'Huyện Yên Mô', 37)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (380, N'Thành phố Thanh Hóa', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (381, N'Thị xã Bỉm Sơn', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (382, N'Thành phố Sầm Sơn', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (384, N'Huyện Mường Lát', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (385, N'Huyện Quan Hóa', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (386, N'Huyện Bá Thước', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (387, N'Huyện Quan Sơn', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (388, N'Huyện Lang Chánh', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (389, N'Huyện Ngọc Lặc', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (390, N'Huyện Cẩm Thủy', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (391, N'Huyện Thạch Thành', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (392, N'Huyện Hà Trung', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (393, N'Huyện Vĩnh Lộc', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (394, N'Huyện Yên Định', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (395, N'Huyện Thọ Xuân', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (396, N'Huyện Thường Xuân', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (397, N'Huyện Triệu Sơn', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (398, N'Huyện Thiệu Hóa', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (399, N'Huyện Hoằng Hóa', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (400, N'Huyện Hậu Lộc', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (401, N'Huyện Nga Sơn', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (402, N'Huyện Như Xuân', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (403, N'Huyện Như Thanh', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (404, N'Huyện Nông Cống', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (405, N'Huyện Đông Sơn', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (406, N'Huyện Quảng Xương', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (407, N'Huyện Tĩnh Gia', 38)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (412, N'Thành phố Vinh', 40)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (413, N'Thị xã Cửa Lò', 40)
GO
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (414, N'Thị xã Thái Hoà', 40)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (415, N'Huyện Quế Phong', 40)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (416, N'Huyện Quỳ Châu', 40)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (417, N'Huyện Kỳ Sơn', 40)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (418, N'Huyện Tương Dương', 40)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (419, N'Huyện Nghĩa Đàn', 40)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (420, N'Huyện Quỳ Hợp', 40)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (421, N'Huyện Quỳnh Lưu', 40)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (422, N'Huyện Con Cuông', 40)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (423, N'Huyện Tân Kỳ', 40)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (424, N'Huyện Anh Sơn', 40)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (425, N'Huyện Diễn Châu', 40)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (426, N'Huyện Yên Thành', 40)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (427, N'Huyện Đô Lương', 40)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (428, N'Huyện Thanh Chương', 40)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (429, N'Huyện Nghi Lộc', 40)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (430, N'Huyện Nam Đàn', 40)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (431, N'Huyện Hưng Nguyên', 40)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (432, N'Thị xã Hoàng Mai', 40)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (436, N'Thành phố Hà Tĩnh', 42)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (437, N'Thị xã Hồng Lĩnh', 42)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (439, N'Huyện Hương Sơn', 42)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (440, N'Huyện Đức Thọ', 42)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (441, N'Huyện Vũ Quang', 42)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (442, N'Huyện Nghi Xuân', 42)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (443, N'Huyện Can Lộc', 42)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (444, N'Huyện Hương Khê', 42)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (445, N'Huyện Thạch Hà', 42)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (446, N'Huyện Cẩm Xuyên', 42)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (447, N'Huyện Kỳ Anh', 42)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (448, N'Huyện Lộc Hà', 42)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (449, N'Thị xã Kỳ Anh', 42)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (450, N'Thành Phố Đồng Hới', 44)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (452, N'Huyện Minh Hóa', 44)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (453, N'Huyện Tuyên Hóa', 44)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (454, N'Huyện Quảng Trạch', 44)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (455, N'Huyện Bố Trạch', 44)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (456, N'Huyện Quảng Ninh', 44)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (457, N'Huyện Lệ Thủy', 44)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (458, N'Thị xã Ba Đồn', 44)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (461, N'Thành phố Đông Hà', 45)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (462, N'Thị xã Quảng Trị', 45)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (464, N'Huyện Vĩnh Linh', 45)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (465, N'Huyện Hướng Hóa', 45)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (466, N'Huyện Gio Linh', 45)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (467, N'Huyện Đa Krông', 45)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (468, N'Huyện Cam Lộ', 45)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (469, N'Huyện Triệu Phong', 45)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (470, N'Huyện Hải Lăng', 45)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (471, N'Huyện Cồn Cỏ', 45)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (474, N'Thành phố Huế', 46)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (476, N'Huyện Phong Điền', 46)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (477, N'Huyện Quảng Điền', 46)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (478, N'Huyện Phú Vang', 46)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (479, N'Thị xã Hương Thủy', 46)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (480, N'Thị xã Hương Trà', 46)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (481, N'Huyện A Lưới', 46)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (482, N'Huyện Phú Lộc', 46)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (483, N'Huyện Nam Đông', 46)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (490, N'Quận Liên Chiểu', 48)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (491, N'Quận Thanh Khê', 48)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (492, N'Quận Hải Châu', 48)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (493, N'Quận Sơn Trà', 48)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (494, N'Quận Ngũ Hành Sơn', 48)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (495, N'Quận Cẩm Lệ', 48)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (497, N'Huyện Hòa Vang', 48)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (498, N'Huyện Hoàng Sa', 48)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (502, N'Thành phố Tam Kỳ', 49)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (503, N'Thành phố Hội An', 49)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (504, N'Huyện Tây Giang', 49)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (505, N'Huyện Đông Giang', 49)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (506, N'Huyện Đại Lộc', 49)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (507, N'Thị xã Điện Bàn', 49)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (508, N'Huyện Duy Xuyên', 49)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (509, N'Huyện Quế Sơn', 49)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (510, N'Huyện Nam Giang', 49)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (511, N'Huyện Phước Sơn', 49)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (512, N'Huyện Hiệp Đức', 49)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (513, N'Huyện Thăng Bình', 49)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (514, N'Huyện Tiên Phước', 49)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (515, N'Huyện Bắc Trà My', 49)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (516, N'Huyện Nam Trà My', 49)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (517, N'Huyện Núi Thành', 49)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (518, N'Huyện Phú Ninh', 49)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (519, N'Huyện Nông Sơn', 49)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (522, N'Thành phố Quảng Ngãi', 51)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (524, N'Huyện Bình Sơn', 51)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (525, N'Huyện Trà Bồng', 51)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (526, N'Huyện Tây Trà', 51)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (527, N'Huyện Sơn Tịnh', 51)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (528, N'Huyện Tư Nghĩa', 51)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (529, N'Huyện Sơn Hà', 51)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (530, N'Huyện Sơn Tây', 51)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (531, N'Huyện Minh Long', 51)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (532, N'Huyện Nghĩa Hành', 51)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (533, N'Huyện Mộ Đức', 51)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (534, N'Huyện Đức Phổ', 51)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (535, N'Huyện Ba Tơ', 51)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (536, N'Huyện Lý Sơn', 51)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (540, N'Thành phố Qui Nhơn', 52)
GO
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (542, N'Huyện An Lão', 52)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (543, N'Huyện Hoài Nhơn', 52)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (544, N'Huyện Hoài Ân', 52)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (545, N'Huyện Phù Mỹ', 52)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (546, N'Huyện Vĩnh Thạnh', 52)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (547, N'Huyện Tây Sơn', 52)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (548, N'Huyện Phù Cát', 52)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (549, N'Thị xã An Nhơn', 52)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (550, N'Huyện Tuy Phước', 52)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (551, N'Huyện Vân Canh', 52)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (555, N'Thành phố Tuy Hoà', 54)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (557, N'Thị xã Sông Cầu', 54)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (558, N'Huyện Đồng Xuân', 54)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (559, N'Huyện Tuy An', 54)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (560, N'Huyện Sơn Hòa', 54)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (561, N'Huyện Sông Hinh', 54)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (562, N'Huyện Tây Hoà', 54)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (563, N'Huyện Phú Hoà', 54)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (564, N'Huyện Đông Hòa', 54)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (568, N'Thành phố Nha Trang', 56)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (569, N'Thành phố Cam Ranh', 56)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (570, N'Huyện Cam Lâm', 56)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (571, N'Huyện Vạn Ninh', 56)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (572, N'Thị xã Ninh Hòa', 56)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (573, N'Huyện Khánh Vĩnh', 56)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (574, N'Huyện Diên Khánh', 56)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (575, N'Huyện Khánh Sơn', 56)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (576, N'Huyện Trường Sa', 56)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (582, N'Thành phố Phan Rang-Tháp Chàm', 58)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (584, N'Huyện Bác Ái', 58)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (585, N'Huyện Ninh Sơn', 58)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (586, N'Huyện Ninh Hải', 58)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (587, N'Huyện Ninh Phước', 58)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (588, N'Huyện Thuận Bắc', 58)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (589, N'Huyện Thuận Nam', 58)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (593, N'Thành phố Phan Thiết', 60)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (594, N'Thị xã La Gi', 60)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (595, N'Huyện Tuy Phong', 60)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (596, N'Huyện Bắc Bình', 60)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (597, N'Huyện Hàm Thuận Bắc', 60)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (598, N'Huyện Hàm Thuận Nam', 60)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (599, N'Huyện Tánh Linh', 60)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (600, N'Huyện Đức Linh', 60)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (601, N'Huyện Hàm Tân', 60)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (602, N'Huyện Phú Quí', 60)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (608, N'Thành phố Kon Tum', 62)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (610, N'Huyện Đắk Glei', 62)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (611, N'Huyện Ngọc Hồi', 62)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (612, N'Huyện Đắk Tô', 62)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (613, N'Huyện Kon Plông', 62)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (614, N'Huyện Kon Rẫy', 62)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (615, N'Huyện Đắk Hà', 62)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (616, N'Huyện Sa Thầy', 62)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (617, N'Huyện Tu Mơ Rông', 62)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (618, N'Huyện Ia H'' Drai', 62)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (622, N'Thành phố Pleiku', 64)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (623, N'Thị xã An Khê', 64)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (624, N'Thị xã Ayun Pa', 64)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (625, N'Huyện KBang', 64)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (626, N'Huyện Đăk Đoa', 64)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (627, N'Huyện Chư Păh', 64)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (628, N'Huyện Ia Grai', 64)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (629, N'Huyện Mang Yang', 64)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (630, N'Huyện Kông Chro', 64)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (631, N'Huyện Đức Cơ', 64)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (632, N'Huyện Chư Prông', 64)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (633, N'Huyện Chư Sê', 64)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (634, N'Huyện Đăk Pơ', 64)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (635, N'Huyện Ia Pa', 64)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (637, N'Huyện Krông Pa', 64)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (638, N'Huyện Phú Thiện', 64)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (639, N'Huyện Chư Pưh', 64)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (643, N'Thành phố Buôn Ma Thuột', 66)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (644, N'Thị Xã Buôn Hồ', 66)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (645, N'Huyện Ea H''leo', 66)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (646, N'Huyện Ea Súp', 66)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (647, N'Huyện Buôn Đôn', 66)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (648, N'Huyện Cư M''gar', 66)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (649, N'Huyện Krông Búk', 66)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (650, N'Huyện Krông Năng', 66)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (651, N'Huyện Ea Kar', 66)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (652, N'Huyện M''Đrắk', 66)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (653, N'Huyện Krông Bông', 66)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (654, N'Huyện Krông Pắc', 66)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (655, N'Huyện Krông A Na', 66)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (656, N'Huyện Lắk', 66)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (657, N'Huyện Cư Kuin', 66)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (660, N'Thị xã Gia Nghĩa', 67)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (661, N'Huyện Đăk Glong', 67)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (662, N'Huyện Cư Jút', 67)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (663, N'Huyện Đắk Mil', 67)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (664, N'Huyện Krông Nô', 67)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (665, N'Huyện Đắk Song', 67)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (666, N'Huyện Đắk R''Lấp', 67)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (667, N'Huyện Tuy Đức', 67)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (672, N'Thành phố Đà Lạt', 68)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (673, N'Thành phố Bảo Lộc', 68)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (674, N'Huyện Đam Rông', 68)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (675, N'Huyện Lạc Dương', 68)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (676, N'Huyện Lâm Hà', 68)
GO
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (677, N'Huyện Đơn Dương', 68)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (678, N'Huyện Đức Trọng', 68)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (679, N'Huyện Di Linh', 68)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (680, N'Huyện Bảo Lâm', 68)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (681, N'Huyện Đạ Huoai', 68)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (682, N'Huyện Đạ Tẻh', 68)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (683, N'Huyện Cát Tiên', 68)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (688, N'Thị xã Phước Long', 70)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (689, N'Thị xã Đồng Xoài', 70)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (690, N'Thị xã Bình Long', 70)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (691, N'Huyện Bù Gia Mập', 70)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (692, N'Huyện Lộc Ninh', 70)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (693, N'Huyện Bù Đốp', 70)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (694, N'Huyện Hớn Quản', 70)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (695, N'Huyện Đồng Phú', 70)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (696, N'Huyện Bù Đăng', 70)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (697, N'Huyện Chơn Thành', 70)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (698, N'Huyện Phú Riềng', 70)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (703, N'Thành phố Tây Ninh', 72)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (705, N'Huyện Tân Biên', 72)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (706, N'Huyện Tân Châu', 72)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (707, N'Huyện Dương Minh Châu', 72)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (708, N'Huyện Châu Thành', 72)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (709, N'Huyện Hòa Thành', 72)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (710, N'Huyện Gò Dầu', 72)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (711, N'Huyện Bến Cầu', 72)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (712, N'Huyện Trảng Bàng', 72)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (718, N'Thành phố Thủ Dầu Một', 74)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (719, N'Huyện Bàu Bàng', 74)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (720, N'Huyện Dầu Tiếng', 74)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (721, N'Thị xã Bến Cát', 74)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (722, N'Huyện Phú Giáo', 74)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (723, N'Thị xã Tân Uyên', 74)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (724, N'Thị xã Dĩ An', 74)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (725, N'Thị xã Thuận An', 74)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (726, N'Huyện Bắc Tân Uyên', 74)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (731, N'Thành phố Biên Hòa', 75)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (732, N'Thị xã Long Khánh', 75)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (734, N'Huyện Tân Phú', 75)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (735, N'Huyện Vĩnh Cửu', 75)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (736, N'Huyện Định Quán', 75)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (737, N'Huyện Trảng Bom', 75)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (738, N'Huyện Thống Nhất', 75)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (739, N'Huyện Cẩm Mỹ', 75)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (740, N'Huyện Long Thành', 75)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (741, N'Huyện Xuân Lộc', 75)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (742, N'Huyện Nhơn Trạch', 75)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (747, N'Thành phố Vũng Tàu', 77)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (748, N'Thành phố Bà Rịa', 77)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (750, N'Huyện Châu Đức', 77)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (751, N'Huyện Xuyên Mộc', 77)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (752, N'Huyện Long Điền', 77)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (753, N'Huyện Đất Đỏ', 77)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (754, N'Huyện Tân Thành', 77)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (755, N'Huyện Côn Đảo', 77)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (760, N'Quận 1', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (761, N'Quận 12', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (762, N'Quận Thủ Đức', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (763, N'Quận 9', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (764, N'Quận Gò Vấp', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (765, N'Quận Bình Thạnh', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (766, N'Quận Tân Bình', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (767, N'Quận Tân Phú', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (768, N'Quận Phú Nhuận', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (769, N'Quận 2', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (770, N'Quận 3', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (771, N'Quận 10', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (772, N'Quận 11', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (773, N'Quận 4', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (774, N'Quận 5', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (775, N'Quận 6', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (776, N'Quận 8', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (777, N'Quận Bình Tân', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (778, N'Quận 7', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (783, N'Huyện Củ Chi', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (784, N'Huyện Hóc Môn', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (785, N'Huyện Bình Chánh', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (786, N'Huyện Nhà Bè', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (787, N'Huyện Cần Giờ', 79)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (794, N'Thành phố Tân An', 80)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (795, N'Thị xã Kiến Tường', 80)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (796, N'Huyện Tân Hưng', 80)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (797, N'Huyện Vĩnh Hưng', 80)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (798, N'Huyện Mộc Hóa', 80)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (799, N'Huyện Tân Thạnh', 80)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (800, N'Huyện Thạnh Hóa', 80)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (801, N'Huyện Đức Huệ', 80)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (802, N'Huyện Đức Hòa', 80)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (803, N'Huyện Bến Lức', 80)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (804, N'Huyện Thủ Thừa', 80)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (805, N'Huyện Tân Trụ', 80)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (806, N'Huyện Cần Đước', 80)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (807, N'Huyện Cần Giuộc', 80)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (808, N'Huyện Châu Thành', 80)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (815, N'Thành phố Mỹ Tho', 82)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (816, N'Thị xã Gò Công', 82)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (817, N'Thị xã Cai Lậy', 82)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (818, N'Huyện Tân Phước', 82)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (819, N'Huyện Cái Bè', 82)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (820, N'Huyện Cai Lậy', 82)
GO
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (821, N'Huyện Châu Thành', 82)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (822, N'Huyện Chợ Gạo', 82)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (823, N'Huyện Gò Công Tây', 82)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (824, N'Huyện Gò Công Đông', 82)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (825, N'Huyện Tân Phú Đông', 82)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (829, N'Thành phố Bến Tre', 83)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (831, N'Huyện Châu Thành', 83)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (832, N'Huyện Chợ Lách', 83)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (833, N'Huyện Mỏ Cày Nam', 83)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (834, N'Huyện Giồng Trôm', 83)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (835, N'Huyện Bình Đại', 83)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (836, N'Huyện Ba Tri', 83)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (837, N'Huyện Thạnh Phú', 83)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (838, N'Huyện Mỏ Cày Bắc', 83)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (842, N'Thành phố Trà Vinh', 84)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (844, N'Huyện Càng Long', 84)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (845, N'Huyện Cầu Kè', 84)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (846, N'Huyện Tiểu Cần', 84)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (847, N'Huyện Châu Thành', 84)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (848, N'Huyện Cầu Ngang', 84)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (849, N'Huyện Trà Cú', 84)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (850, N'Huyện Duyên Hải', 84)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (851, N'Thị xã Duyên Hải', 84)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (855, N'Thành phố Vĩnh Long', 86)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (857, N'Huyện Long Hồ', 86)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (858, N'Huyện Mang Thít', 86)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (859, N'Huyện  Vũng Liêm', 86)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (860, N'Huyện Tam Bình', 86)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (861, N'Thị xã Bình Minh', 86)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (862, N'Huyện Trà Ôn', 86)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (863, N'Huyện Bình Tân', 86)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (866, N'Thành phố Cao Lãnh', 87)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (867, N'Thành phố Sa Đéc', 87)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (868, N'Thị xã Hồng Ngự', 87)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (869, N'Huyện Tân Hồng', 87)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (870, N'Huyện Hồng Ngự', 87)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (871, N'Huyện Tam Nông', 87)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (872, N'Huyện Tháp Mười', 87)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (873, N'Huyện Cao Lãnh', 87)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (874, N'Huyện Thanh Bình', 87)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (875, N'Huyện Lấp Vò', 87)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (876, N'Huyện Lai Vung', 87)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (877, N'Huyện Châu Thành', 87)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (883, N'Thành phố Long Xuyên', 89)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (884, N'Thành phố Châu Đốc', 89)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (886, N'Huyện An Phú', 89)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (887, N'Thị xã Tân Châu', 89)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (888, N'Huyện Phú Tân', 89)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (889, N'Huyện Châu Phú', 89)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (890, N'Huyện Tịnh Biên', 89)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (891, N'Huyện Tri Tôn', 89)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (892, N'Huyện Châu Thành', 89)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (893, N'Huyện Chợ Mới', 89)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (894, N'Huyện Thoại Sơn', 89)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (899, N'Thành phố Rạch Giá', 91)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (900, N'Thị xã Hà Tiên', 91)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (902, N'Huyện Kiên Lương', 91)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (903, N'Huyện Hòn Đất', 91)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (904, N'Huyện Tân Hiệp', 91)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (905, N'Huyện Châu Thành', 91)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (906, N'Huyện Giồng Riềng', 91)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (907, N'Huyện Gò Quao', 91)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (908, N'Huyện An Biên', 91)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (909, N'Huyện An Minh', 91)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (910, N'Huyện Vĩnh Thuận', 91)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (911, N'Huyện Phú Quốc', 91)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (912, N'Huyện Kiên Hải', 91)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (913, N'Huyện U Minh Thượng', 91)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (914, N'Huyện Giang Thành', 91)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (916, N'Quận Ninh Kiều', 92)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (917, N'Quận Ô Môn', 92)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (918, N'Quận Bình Thuỷ', 92)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (919, N'Quận Cái Răng', 92)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (923, N'Quận Thốt Nốt', 92)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (924, N'Huyện Vĩnh Thạnh', 92)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (925, N'Huyện Cờ Đỏ', 92)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (926, N'Huyện Phong Điền', 92)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (927, N'Huyện Thới Lai', 92)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (930, N'Thành phố Vị Thanh', 93)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (931, N'Thị xã Ngã Bảy', 93)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (932, N'Huyện Châu Thành A', 93)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (933, N'Huyện Châu Thành', 93)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (934, N'Huyện Phụng Hiệp', 93)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (935, N'Huyện Vị Thuỷ', 93)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (936, N'Huyện Long Mỹ', 93)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (937, N'Thị xã Long Mỹ', 93)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (941, N'Thành phố Sóc Trăng', 94)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (942, N'Huyện Châu Thành', 94)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (943, N'Huyện Kế Sách', 94)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (944, N'Huyện Mỹ Tú', 94)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (945, N'Huyện Cù Lao Dung', 94)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (946, N'Huyện Long Phú', 94)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (947, N'Huyện Mỹ Xuyên', 94)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (948, N'Thị xã Ngã Năm', 94)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (949, N'Huyện Thạnh Trị', 94)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (950, N'Thị xã Vĩnh Châu', 94)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (951, N'Huyện Trần Đề', 94)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (954, N'Thành phố Bạc Liêu', 95)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (956, N'Huyện Hồng Dân', 95)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (957, N'Huyện Phước Long', 95)
GO
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (958, N'Huyện Vĩnh Lợi', 95)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (959, N'Thị xã Giá Rai', 95)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (960, N'Huyện Đông Hải', 95)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (961, N'Huyện Hoà Bình', 95)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (964, N'Thành phố Cà Mau', 96)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (966, N'Huyện U Minh', 96)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (967, N'Huyện Thới Bình', 96)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (968, N'Huyện Trần Văn Thời', 96)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (969, N'Huyện Cái Nước', 96)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (970, N'Huyện Đầm Dơi', 96)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (971, N'Huyện Năm Căn', 96)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (972, N'Huyện Phú Tân', 96)
INSERT [dbo].[QuanHuyen] ([ID], [TenQuanHuyen], [IDTinhThanh]) VALUES (973, N'Huyện Ngọc Hiển', 96)
SET IDENTITY_INSERT [dbo].[Route] ON 

INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (465, N'Quanlyduoc.Areas.Admin.Controllers', N'Account', N'Index', N'Xem', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (466, N'Quanlyduoc.Areas.Admin.Controllers', N'Account', N'suaTaiKhoan', N'Sửa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (467, N'Quanlyduoc.Areas.Admin.Controllers', N'Account', N'themTaiKhoan', N'Thêm', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (468, N'Quanlyduoc.Areas.Admin.Controllers', N'Account', N'xoaTaiKhoan', N'Xóa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (475, N'Quanlyduoc.Areas.Admin.Controllers', N'ChucNang', N'danhSachChucNang', N'Xem', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (476, N'Quanlyduoc.Areas.Admin.Controllers', N'ChucNang', N'suaChucNang', N'Sửa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (477, N'Quanlyduoc.Areas.Admin.Controllers', N'ChuongTrinhKhuyenMai', N'Index', N'Xem', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (478, N'Quanlyduoc.Areas.Admin.Controllers', N'ChuongTrinhKhuyenMai', N'ThemKhuyenMai', N'Thêm', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (479, N'Quanlyduoc.Areas.Admin.Controllers', N'ChuongTrinhKhuyenMai', N'SuaKhuyenMai', N'Sửa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (480, N'Quanlyduoc.Areas.Admin.Controllers', N'ChuongTrinhKhuyenMai', N'xoaKhuyenMai', N'Xóa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (481, N'Quanlyduoc.Areas.Admin.Controllers', N'DauThuoc', N'Index', N'Xem', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (482, N'Quanlyduoc.Areas.Admin.Controllers', N'DauThuoc', N'Themdauthuoc', N'Thêm', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (483, N'Quanlyduoc.Areas.Admin.Controllers', N'DauThuoc', N'SuaDauThuoc', N'Sửa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (484, N'Quanlyduoc.Areas.Admin.Controllers', N'DauThuoc', N'XoaDauThuoc', N'Xóa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (485, N'Quanlyduoc.Areas.Admin.Controllers', N'HoaDon', N'Index', N'Xem', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (486, N'Quanlyduoc.Areas.Admin.Controllers', N'HoaDon', N'themHoaDon', N'Thêm', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (488, N'Quanlyduoc.Areas.Admin.Controllers', N'HoaDon', N'pheDuyetHoaDon', N'Phê duyệt', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (489, N'Quanlyduoc.Areas.Admin.Controllers', N'HoaDon', N'xoaHoaDon', N'Xóa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (490, N'Quanlyduoc.Areas.Admin.Controllers', N'HoaDonVanChuyen', N'Index', N'Xem', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (492, N'Quanlyduoc.Areas.Admin.Controllers', N'HoaDonVanChuyen', N'ThemHoaDonVanChuyen', N'Thêm', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (493, N'Quanlyduoc.Areas.Admin.Controllers', N'HoaDonXuat', N'Index', N'Xem', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (494, N'Quanlyduoc.Areas.Admin.Controllers', N'HoaDonXuat', N'taoPhieuXuat', N'Tạo', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (495, N'Quanlyduoc.Areas.Admin.Controllers', N'HoaDonXuat', N'xoaHoaDonXuat', N'Xóa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (497, N'Quanlyduoc.Areas.Admin.Controllers', N'KeHoachLamViec', N'Index', N'Xem tất cả', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (498, N'Quanlyduoc.Areas.Admin.Controllers', N'KeHoachLamViec', N'themKeHoach', N'Thêm', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (499, N'Quanlyduoc.Areas.Admin.Controllers', N'KeHoachLamViec', N'suaKeHoach', N'Sửa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (500, N'Quanlyduoc.Areas.Admin.Controllers', N'KeHoachLamViec', N'xoaKeHoach', N'Xóa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (501, N'Quanlyduoc.Areas.Admin.Controllers', N'KeHoachLamViec', N'kehoachcanhan', N'Xem của cá nhân', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (502, N'Quanlyduoc.Areas.Admin.Controllers', N'KeHoachLamViec', N'hoanThanhCongViec', N'yêu cầu hoàn thành', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (503, N'Quanlyduoc.Areas.Admin.Controllers', N'KeHoachLamViec', N'pheDuyetCongViec', N'Phê duyệt', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (504, N'Quanlyduoc.Areas.Admin.Controllers', N'KhachHang', N'Index', N'Xem', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (505, N'Quanlyduoc.Areas.Admin.Controllers', N'KhachHang', N'themKhachHang', N'Thêm', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (506, N'Quanlyduoc.Areas.Admin.Controllers', N'KhachHang', N'checkTaiKhoanKhachHang', N'Tạo tài khoản', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (508, N'Quanlyduoc.Areas.Admin.Controllers', N'KhachHang', N'Xoa', N'Xóa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (509, N'Quanlyduoc.Areas.Admin.Controllers', N'Kho', N'Index', N'Quản lý kho', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (511, N'Quanlyduoc.Areas.Admin.Controllers', N'Kho', N'themKho', N'Thêm', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (512, N'Quanlyduoc.Areas.Admin.Controllers', N'Modul', N'Index', N'Xem', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (513, N'Quanlyduoc.Areas.Admin.Controllers', N'Modul', N'suaModul', N'Sửa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (514, N'Quanlyduoc.Areas.Admin.Controllers', N'NguoiVanChuyen', N'Index', N'Xem', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (515, N'Quanlyduoc.Areas.Admin.Controllers', N'NhaSanXuat', N'Index', N'Xem', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (516, N'Quanlyduoc.Areas.Admin.Controllers', N'NhomDauThuoc', N'Index', N'Xem', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (517, N'Quanlyduoc.Areas.Admin.Controllers', N'NhomDauThuoc', N'ThemNhomDauThuoc', N'Thêm', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (518, N'Quanlyduoc.Areas.Admin.Controllers', N'NhomDauThuoc', N'SuaNhomDauThuoc', N'Sửa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (521, N'Quanlyduoc.Areas.Admin.Controllers', N'NhomQuyen', N'ThemNhomQuyen', N'Thêm', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (522, N'Quanlyduoc.Areas.Admin.Controllers', N'NhomQuyen', N'caiDatQuyen', N'Cài đặt', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (524, N'Quanlyduoc.Areas.Admin.Controllers', N'NhomQuyen', N'xoaNhomQuyen', N'Xóa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (525, N'Quanlyduoc.Areas.Admin.Controllers', N'TrinhDuoc', N'Index', N'Xem', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (526, N'Quanlyduoc.Areas.Admin.Controllers', N'TrinhDuoc', N'Themtrinhduoc', N'Thêm', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (527, N'Quanlyduoc.Areas.Admin.Controllers', N'TrinhDuoc', N'checkTaiKhoanTrinhDuoc', N'Tạo tài khoản', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (529, N'Quanlyduoc.Areas.Admin.Controllers', N'TrinhDuoc', N'suaTrinhDuoc', N'Sửa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (530, N'Quanlyduoc.Areas.Admin.Controllers', N'TrinhDuoc', N'Xoa', N'Xóa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1022, N'Quanlyduoc.Areas.Admin.Controllers', N'CheckMap', N'mapNhanVien', N'Xem', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1028, N'Quanlyduoc.Areas.Admin.Controllers', N'HoaDonXuat', N'kiemTraTrangThaiVanChuyen', N'Kiểm tra', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1191, N'Quanlyduoc.Areas.Admin.Controllers', N'NhaSanXuat', N'ThemNhaSanXuat', N'Thêm', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1192, N'Quanlyduoc.Areas.Admin.Controllers', N'NhaSanXuat', N'SuaNhaSanXuat', N'Sửa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1193, N'Quanlyduoc.Areas.Admin.Controllers', N'NhaSanXuat', N'XoaNhaSanXuat', N'Xóa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1419, N'Quanlyduoc.Areas.Admin.Controllers', N'HoaDonNhap', N'SuaHoaDonNhap', N'Sửa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1507, N'Quanlyduoc.Areas.Admin.Controllers', N'DauThuoc', N'chitietdauthuoc', N'Xem chi tiết', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1508, N'Quanlyduoc.Areas.Admin.Controllers', N'HoaDonNhap', N'Index', N'Xem', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1509, N'Quanlyduoc.Areas.Admin.Controllers', N'HoaDonNhap', N'themhoadonnhap', N'Thêm', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1510, N'Quanlyduoc.Areas.Admin.Controllers', N'HoaDonNhap', N'xoahoadonnhap', N'Xóa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1512, N'Quanlyduoc.Areas.Admin.Controllers', N'KhachHang', N'suaKhachHang', N'Sửa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1513, N'Quanlyduoc.Areas.Admin.Controllers', N'Kho', N'suakho', N'Sửa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1514, N'Quanlyduoc.Areas.Admin.Controllers', N'HoaDonXuat', N'Export', N'Xuất file', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1515, N'Quanlyduoc.Areas.Admin.Controllers', N'HoaDonNhap', N'Export', N'Xuất file', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1516, N'Quanlyduoc.Areas.Admin.Controllers', N'ThuChi', N'Index', N'Tổng hợp thu chi', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1517, N'Quanlyduoc.Areas.Admin.Controllers', N'ThuChi', N'themthuchi', N'Thêm', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1518, N'Quanlyduoc.Areas.Admin.Controllers', N'ThuChi', N'Export', N'Xuất file', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1519, N'Quanlyduoc.Areas.Admin.Controllers', N'ThuChi', N'danhsachthuchi', N'Xem danh sách', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1520, N'Quanlyduoc.Areas.Admin.Controllers', N'ThuChi', N'xoathuchi', N'Xóa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1521, N'Quanlyduoc.Areas.Admin.Controllers', N'ThuChi', N'suathuchi', N'Sửa', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1522, N'Quanlyduoc.Areas.Admin.Controllers', N'CheckMap', N'chamCong', N'Chấm công', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1523, N'Quanlyduoc.Areas.Admin.Controllers', N'CheckMap', N'xinNghi', N'Xin nghỉ', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1524, N'Quanlyduoc.Areas.Admin.Controllers', N'CheckMap', N'luuToaDoCongTy', N'Cài tọa độ công ty', NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1525, N'Quanlyduoc.Areas.Admin.Controllers', N'Home', N'Index', NULL, NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1526, N'Quanlyduoc.Areas.Admin.Controllers', N'Kho', N'layThongTinKho', NULL, NULL)
INSERT [dbo].[Route] ([ID], [Namespace], [Controller], [Action], [Name], [Description]) VALUES (1527, N'Quanlyduoc.Areas.Admin.Controllers', N'NhomDauThuoc', N'XoaNhomDau', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Route] OFF
SET IDENTITY_INSERT [dbo].[TagsDThuocNThuoc] ON 

INSERT [dbo].[TagsDThuocNThuoc] ([ID], [MaDauThuoc], [MaNhomThuoc], [TenDinhNghia]) VALUES (4, N'DT000002', N'NT000001', NULL)
INSERT [dbo].[TagsDThuocNThuoc] ([ID], [MaDauThuoc], [MaNhomThuoc], [TenDinhNghia]) VALUES (5, N'DT000003', N'NT000001', NULL)
INSERT [dbo].[TagsDThuocNThuoc] ([ID], [MaDauThuoc], [MaNhomThuoc], [TenDinhNghia]) VALUES (6, N'DT000004', N'NT000001', NULL)
INSERT [dbo].[TagsDThuocNThuoc] ([ID], [MaDauThuoc], [MaNhomThuoc], [TenDinhNghia]) VALUES (7, N'DT000005', N'NT000001', NULL)
INSERT [dbo].[TagsDThuocNThuoc] ([ID], [MaDauThuoc], [MaNhomThuoc], [TenDinhNghia]) VALUES (8, N'DT000006', N'NT000001', NULL)
INSERT [dbo].[TagsDThuocNThuoc] ([ID], [MaDauThuoc], [MaNhomThuoc], [TenDinhNghia]) VALUES (9, N'DT000007', N'NT000002', NULL)
INSERT [dbo].[TagsDThuocNThuoc] ([ID], [MaDauThuoc], [MaNhomThuoc], [TenDinhNghia]) VALUES (10, N'DT000008', N'NT000002', NULL)
INSERT [dbo].[TagsDThuocNThuoc] ([ID], [MaDauThuoc], [MaNhomThuoc], [TenDinhNghia]) VALUES (11, N'DT000009', N'NT000003', NULL)
INSERT [dbo].[TagsDThuocNThuoc] ([ID], [MaDauThuoc], [MaNhomThuoc], [TenDinhNghia]) VALUES (12, N'DT000011', N'NT000003', NULL)
INSERT [dbo].[TagsDThuocNThuoc] ([ID], [MaDauThuoc], [MaNhomThuoc], [TenDinhNghia]) VALUES (13, N'DT000012', N'NT000003', NULL)
INSERT [dbo].[TagsDThuocNThuoc] ([ID], [MaDauThuoc], [MaNhomThuoc], [TenDinhNghia]) VALUES (14, N'DT000013', N'NT000003', NULL)
INSERT [dbo].[TagsDThuocNThuoc] ([ID], [MaDauThuoc], [MaNhomThuoc], [TenDinhNghia]) VALUES (28, N'DT000001', N'NT000001', NULL)
INSERT [dbo].[TagsDThuocNThuoc] ([ID], [MaDauThuoc], [MaNhomThuoc], [TenDinhNghia]) VALUES (29, N'DT000001', N'NT000003', NULL)
SET IDENTITY_INSERT [dbo].[TagsDThuocNThuoc] OFF
INSERT [dbo].[TaiKhoan] ([MaTK], [TenTaiKhoan], [MatKhau], [HoTen], [SDT], [Email], [avatar], [MaQuyen], [MaNhomQuyen], [MaTD], [MaKH]) VALUES (N'TK000001', N'admin', N'1', N'Nguyễn Hoài Nam', N'0366561924', N'nam@gmail.com', N'admin1.png', 1, 1, NULL, NULL)
INSERT [dbo].[TaiKhoan] ([MaTK], [TenTaiKhoan], [MatKhau], [HoTen], [SDT], [Email], [avatar], [MaQuyen], [MaNhomQuyen], [MaTD], [MaKH]) VALUES (N'TK000002', N'trinhduoc', N'1', N'Hồ Văn Bảo', N'0366561924', N'bao@gmail.com', NULL, 2, 14, N'TD000001', NULL)
INSERT [dbo].[TaiKhoan] ([MaTK], [TenTaiKhoan], [MatKhau], [HoTen], [SDT], [Email], [avatar], [MaQuyen], [MaNhomQuyen], [MaTD], [MaKH]) VALUES (N'TK000004', N'quankho', N'1', N'Nguyễn Văn A', N'0123445566', N'a@gmail.com', NULL, 4, 15, NULL, NULL)
INSERT [dbo].[TaiKhoan] ([MaTK], [TenTaiKhoan], [MatKhau], [HoTen], [SDT], [Email], [avatar], [MaQuyen], [MaNhomQuyen], [MaTD], [MaKH]) VALUES (N'TK000005', N'trinhduoc2', N'1', N'Nguyễn Văn B', N'0366561924', N'b@gmail.com', N'trinhduoc-1.png', 2, 14, N'TD000002', NULL)
INSERT [dbo].[TaiKhoan] ([MaTK], [TenTaiKhoan], [MatKhau], [HoTen], [SDT], [Email], [avatar], [MaQuyen], [MaNhomQuyen], [MaTD], [MaKH]) VALUES (N'TK000006', N'trinhduoc3', N'1', N'Nguyễn Thi Sao Mai', N'123458', N'mai@gmail.com', N'trinh-duoc-vien-2-1.png', 2, 14, N'TD000003', NULL)
INSERT [dbo].[TaiKhoan] ([MaTK], [TenTaiKhoan], [MatKhau], [HoTen], [SDT], [Email], [avatar], [MaQuyen], [MaNhomQuyen], [MaTD], [MaKH]) VALUES (N'TK000007', N'KhachHang', N'1', N'Phạm Bá Toại', N'0367182718', N'toai95@gmail.com', NULL, 3, 16, NULL, N'KH000007')
INSERT [dbo].[TaiKhoan] ([MaTK], [TenTaiKhoan], [MatKhau], [HoTen], [SDT], [Email], [avatar], [MaQuyen], [MaNhomQuyen], [MaTD], [MaKH]) VALUES (N'TK000008', N'khachhang1', N'1', N'Lê Văn A', N'123456', N'a@gmail.com', NULL, 3, 16, NULL, N'KH000001')
SET IDENTITY_INSERT [dbo].[ThuChi] ON 

INSERT [dbo].[ThuChi] ([ID], [Ten], [Loai], [NgayLap], [NguoiLap], [GiaTri]) VALUES (2, N'Tiền sale', N'chi', CAST(0x0000AA5300A1D176 AS DateTime), N'Nguyễn Hoài Nam', 1000000)
INSERT [dbo].[ThuChi] ([ID], [Ten], [Loai], [NgayLap], [NguoiLap], [GiaTri]) VALUES (3, N'Thưởng nhân viên', N'chi', CAST(0x0000AA5300A37AC3 AS DateTime), N'Nguyễn Hoài Nam', 2000000)
INSERT [dbo].[ThuChi] ([ID], [Ten], [Loai], [NgayLap], [NguoiLap], [GiaTri]) VALUES (4, N'Khám bệnh', N'thu', CAST(0x0000AA5300000000 AS DateTime), N'Nguyễn Hoài Nam', 3000000)
SET IDENTITY_INSERT [dbo].[ThuChi] OFF
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (1, N'Hà Nội')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (2, N'Tỉnh Hà Giang')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (4, N'Tỉnh Cao Bằng')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (6, N'Tỉnh Bắc Kạn')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (8, N'Tỉnh Tuyên Quang')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (10, N'Tỉnh Lào Cai')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (11, N'Tỉnh Điện Biên')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (12, N'Tỉnh Lai Châu')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (14, N'Tỉnh Sơn La')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (15, N'Tỉnh Yên Bái')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (17, N'Tỉnh Hoà Bình')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (19, N'Tỉnh Thái Nguyên')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (20, N'Tỉnh Lạng Sơn')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (22, N'Tỉnh Quảng Ninh')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (24, N'Tỉnh Bắc Giang')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (25, N'Tỉnh Phú Thọ')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (26, N'Tỉnh Vĩnh Phúc')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (27, N'Tỉnh Bắc Ninh')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (30, N'Tỉnh Hải Dương')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (31, N'Thành phố Hải Phòng')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (33, N'Tỉnh Hưng Yên')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (34, N'Tỉnh Thái Bình')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (35, N'Tỉnh Hà Nam')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (36, N'Tỉnh Nam Định')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (37, N'Tỉnh Ninh Bình')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (38, N'Tỉnh Thanh Hóa')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (40, N'Tỉnh Nghệ An')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (42, N'Tỉnh Hà Tĩnh')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (44, N'Tỉnh Quảng Bình')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (45, N'Tỉnh Quảng Trị')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (46, N'Tỉnh Thừa Thiên Huế')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (48, N'Thành phố Đà Nẵng')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (49, N'Tỉnh Quảng Nam')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (51, N'Tỉnh Quảng Ngãi')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (52, N'Tỉnh Bình Định')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (54, N'Tỉnh Phú Yên')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (56, N'Tỉnh Khánh Hòa')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (58, N'Tỉnh Ninh Thuận')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (60, N'Tỉnh Bình Thuận')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (62, N'Tỉnh Kon Tum')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (64, N'Tỉnh Gia Lai')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (66, N'Tỉnh Đắk Lắk')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (67, N'Tỉnh Đắk Nông')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (68, N'Tỉnh Lâm Đồng')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (70, N'Tỉnh Bình Phước')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (72, N'Tỉnh Tây Ninh')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (74, N'Tỉnh Bình Dương')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (75, N'Tỉnh Đồng Nai')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (77, N'Tỉnh Bà Rịa - Vũng Tàu')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (79, N'Thành phố Hồ Chí Minh')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (80, N'Tỉnh Long An')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (82, N'Tỉnh Tiền Giang')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (83, N'Tỉnh Bến Tre')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (84, N'Tỉnh Trà Vinh')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (86, N'Tỉnh Vĩnh Long')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (87, N'Tỉnh Đồng Tháp')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (89, N'Tỉnh An Giang')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (91, N'Tỉnh Kiên Giang')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (92, N'Thành phố Cần Thơ')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (93, N'Tỉnh Hậu Giang')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (94, N'Tỉnh Sóc Trăng')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (95, N'Tỉnh Bạc Liêu')
INSERT [dbo].[TinhThanhPho] ([ID], [TenTinh]) VALUES (96, N'Tỉnh Cà Mau')
INSERT [dbo].[TrinhDuoc] ([MaTD], [HoTen], [SDT], [NgaySinh], [DiaChi], [KhuVuc], [TrangThai], [DanhGia], [LuongTieuThu]) VALUES (N'TD000001', N'Hồ Văn Bảo', N'123456', N'1995-03-01', N'Hoàng Mai-Hà Nội', N'Hoàng Mai - Hà Nội', 1, 1, 1)
INSERT [dbo].[TrinhDuoc] ([MaTD], [HoTen], [SDT], [NgaySinh], [DiaChi], [KhuVuc], [TrangThai], [DanhGia], [LuongTieuThu]) VALUES (N'TD000002', N'Nguyễn Văn B', N'0366561924', N'1995-03-01', N'Hoàng Mai-Hà Nội', N'Hoàng Mai - Hà Nội', 1, 1, 1)
INSERT [dbo].[TrinhDuoc] ([MaTD], [HoTen], [SDT], [NgaySinh], [DiaChi], [KhuVuc], [TrangThai], [DanhGia], [LuongTieuThu]) VALUES (N'TD000003', N'Trần Văn C', N'123458', N'1995-03-01', N'Hoàng Mai-Hà Nội', N'Hoàng Mai - Hà Nội', 1, 1, 1)
INSERT [dbo].[TrinhDuoc] ([MaTD], [HoTen], [SDT], [NgaySinh], [DiaChi], [KhuVuc], [TrangThai], [DanhGia], [LuongTieuThu]) VALUES (N'TD000004', N'Lê Thị D', N'123459', N'1995-03-01', N'Hoàng Mai-Hà Nội', N'Hoàng Mai - Hà Nội', 1, 1, 1)
INSERT [dbo].[TrinhDuoc] ([MaTD], [HoTen], [SDT], [NgaySinh], [DiaChi], [KhuVuc], [TrangThai], [DanhGia], [LuongTieuThu]) VALUES (N'TD000005', N'Nguyễn Văn E', N'123460', N'1995-03-01', N'Hoàng Mai-Hà Nội', N'Hoàng Mai - Hà Nội', 1, 1, 1)
INSERT [dbo].[TrinhDuoc] ([MaTD], [HoTen], [SDT], [NgaySinh], [DiaChi], [KhuVuc], [TrangThai], [DanhGia], [LuongTieuThu]) VALUES (N'TD000006', N'aaa', N'111', N'2019-04-29', N'1', N'Tỉnh Bình Định - Huyện Tây Sơn', NULL, NULL, NULL)
INSERT [dbo].[TrinhDuocKhachHang] ([MaTD], [MaKH], [NgayBatDau], [NgayKetThuc]) VALUES (N'TD000001', N'KH000001', CAST(0x0000AA1B00000000 AS DateTime), NULL)
INSERT [dbo].[TrinhDuocKhachHang] ([MaTD], [MaKH], [NgayBatDau], [NgayKetThuc]) VALUES (N'TD000001', N'KH000002', CAST(0x0000AA1B00000000 AS DateTime), NULL)
INSERT [dbo].[VanChuyen] ([MaNguoiVanChuyen], [HoTen], [DiaChi], [SDT], [Email], [TrangThai]) VALUES (N'NC000001', N'Nguyễn Hoàng Long', N'20/10/2018', N'2', NULL, 1)
INSERT [dbo].[VanChuyen] ([MaNguoiVanChuyen], [HoTen], [DiaChi], [SDT], [Email], [TrangThai]) VALUES (N'NC000002', N'Lê Hải', N'20/10/2019', N'3', NULL, 1)
INSERT [dbo].[VanChuyen] ([MaNguoiVanChuyen], [HoTen], [DiaChi], [SDT], [Email], [TrangThai]) VALUES (N'NC000003', N'Trần Văn Minh', N'20/10/2020', N'2', NULL, 2)
INSERT [dbo].[VanChuyen] ([MaNguoiVanChuyen], [HoTen], [DiaChi], [SDT], [Email], [TrangThai]) VALUES (N'NC000004', N'Nguyễn Hải Nam', N'20/10/2021', N'2', NULL, 2)
INSERT [dbo].[VanChuyen] ([MaNguoiVanChuyen], [HoTen], [DiaChi], [SDT], [Email], [TrangThai]) VALUES (N'NC000005', N'Hồ Văn Sơn', N'20/10/2022', N'2', NULL, 1)
ALTER TABLE [dbo].[ChamCong]  WITH CHECK ADD  CONSTRAINT [FK_ChamCong_TaiKhoan] FOREIGN KEY([MaTK])
REFERENCES [dbo].[TaiKhoan] ([MaTK])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChamCong] CHECK CONSTRAINT [FK_ChamCong_TaiKhoan]
GO
ALTER TABLE [dbo].[ChiTietChuyenKhoThuoc]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietChuyenKhoThuoc_DauThuoc] FOREIGN KEY([MaDT])
REFERENCES [dbo].[DauThuoc] ([MaDT])
GO
ALTER TABLE [dbo].[ChiTietChuyenKhoThuoc] CHECK CONSTRAINT [FK_ChiTietChuyenKhoThuoc_DauThuoc]
GO
ALTER TABLE [dbo].[ChiTietChuyenKhoThuoc]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietChuyenKhoThuoc_Kho] FOREIGN KEY([MaKhoChuyen])
REFERENCES [dbo].[Kho] ([MaKho])
GO
ALTER TABLE [dbo].[ChiTietChuyenKhoThuoc] CHECK CONSTRAINT [FK_ChiTietChuyenKhoThuoc_Kho]
GO
ALTER TABLE [dbo].[ChiTietChuyenKhoThuoc]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietChuyenKhoThuoc_Kho1] FOREIGN KEY([MaKhoNhan])
REFERENCES [dbo].[Kho] ([MaKho])
GO
ALTER TABLE [dbo].[ChiTietChuyenKhoThuoc] CHECK CONSTRAINT [FK_ChiTietChuyenKhoThuoc_Kho1]
GO
ALTER TABLE [dbo].[ChiTietHoaDonMua]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDonMua_DauThuoc] FOREIGN KEY([MaDT])
REFERENCES [dbo].[DauThuoc] ([MaDT])
GO
ALTER TABLE [dbo].[ChiTietHoaDonMua] CHECK CONSTRAINT [FK_ChiTietHoaDonMua_DauThuoc]
GO
ALTER TABLE [dbo].[ChiTietHoaDonMua]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDonMua_DonVi] FOREIGN KEY([MaDonVi])
REFERENCES [dbo].[DonVi] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietHoaDonMua] CHECK CONSTRAINT [FK_ChiTietHoaDonMua_DonVi]
GO
ALTER TABLE [dbo].[ChiTietHoaDonMua]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDonMua_HoaDonMua] FOREIGN KEY([MaHD])
REFERENCES [dbo].[HoaDonMua] ([MaHD])
GO
ALTER TABLE [dbo].[ChiTietHoaDonMua] CHECK CONSTRAINT [FK_ChiTietHoaDonMua_HoaDonMua]
GO
ALTER TABLE [dbo].[ChiTietHoaDonNhap]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDonNhap_DauThuoc] FOREIGN KEY([MaDT])
REFERENCES [dbo].[DauThuoc] ([MaDT])
GO
ALTER TABLE [dbo].[ChiTietHoaDonNhap] CHECK CONSTRAINT [FK_ChiTietHoaDonNhap_DauThuoc]
GO
ALTER TABLE [dbo].[ChiTietHoaDonNhap]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDonNhap_DonVi] FOREIGN KEY([MaDonVi])
REFERENCES [dbo].[DonVi] ([ID])
GO
ALTER TABLE [dbo].[ChiTietHoaDonNhap] CHECK CONSTRAINT [FK_ChiTietHoaDonNhap_DonVi]
GO
ALTER TABLE [dbo].[ChiTietHoaDonNhap]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDonNhap_HoaDonNhap] FOREIGN KEY([MaHD])
REFERENCES [dbo].[HoaDonNhap] ([MaHD])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietHoaDonNhap] CHECK CONSTRAINT [FK_ChiTietHoaDonNhap_HoaDonNhap]
GO
ALTER TABLE [dbo].[ChiTietHoaDonXuat]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDonXuat_DauThuoc] FOREIGN KEY([MaDT])
REFERENCES [dbo].[DauThuoc] ([MaDT])
GO
ALTER TABLE [dbo].[ChiTietHoaDonXuat] CHECK CONSTRAINT [FK_ChiTietHoaDonXuat_DauThuoc]
GO
ALTER TABLE [dbo].[ChiTietHoaDonXuat]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDonXuat_DonVi] FOREIGN KEY([MaDonVi])
REFERENCES [dbo].[DonVi] ([ID])
GO
ALTER TABLE [dbo].[ChiTietHoaDonXuat] CHECK CONSTRAINT [FK_ChiTietHoaDonXuat_DonVi]
GO
ALTER TABLE [dbo].[ChiTietHoaDonXuat]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietHoaDonXuat_HoaDonXuat] FOREIGN KEY([MaHD])
REFERENCES [dbo].[HoaDonXuat] ([MaHD])
GO
ALTER TABLE [dbo].[ChiTietHoaDonXuat] CHECK CONSTRAINT [FK_ChiTietHoaDonXuat_HoaDonXuat]
GO
ALTER TABLE [dbo].[DauThuoc]  WITH CHECK ADD  CONSTRAINT [FK_DauThuoc_NhaSanXuat1] FOREIGN KEY([MaNSX])
REFERENCES [dbo].[NhaSanXuat] ([MaNSX])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DauThuoc] CHECK CONSTRAINT [FK_DauThuoc_NhaSanXuat1]
GO
ALTER TABLE [dbo].[DonVi]  WITH CHECK ADD  CONSTRAINT [FK_DonVi_DauThuoc] FOREIGN KEY([MaDT])
REFERENCES [dbo].[DauThuoc] ([MaDT])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DonVi] CHECK CONSTRAINT [FK_DonVi_DauThuoc]
GO
ALTER TABLE [dbo].[HoaDonMua]  WITH CHECK ADD  CONSTRAINT [FK_HoaDonMua_HoaDonVanChuyen] FOREIGN KEY([MaHoaDonVanChuyen])
REFERENCES [dbo].[HoaDonVanChuyen] ([MaHoaDonVanChuyen])
GO
ALTER TABLE [dbo].[HoaDonMua] CHECK CONSTRAINT [FK_HoaDonMua_HoaDonVanChuyen]
GO
ALTER TABLE [dbo].[HoaDonMua]  WITH CHECK ADD  CONSTRAINT [FK_HoaDonMua_Kho] FOREIGN KEY([MaKho])
REFERENCES [dbo].[Kho] ([MaKho])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HoaDonMua] CHECK CONSTRAINT [FK_HoaDonMua_Kho]
GO
ALTER TABLE [dbo].[HoaDonMua]  WITH CHECK ADD  CONSTRAINT [FK_HoaDonMua_TaiKhoan] FOREIGN KEY([MaTK])
REFERENCES [dbo].[TaiKhoan] ([MaTK])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HoaDonMua] CHECK CONSTRAINT [FK_HoaDonMua_TaiKhoan]
GO
ALTER TABLE [dbo].[HoaDonNhap]  WITH CHECK ADD  CONSTRAINT [FK_HoaDonNhap_Kho] FOREIGN KEY([MaKho])
REFERENCES [dbo].[Kho] ([MaKho])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HoaDonNhap] CHECK CONSTRAINT [FK_HoaDonNhap_Kho]
GO
ALTER TABLE [dbo].[HoaDonNhap]  WITH CHECK ADD  CONSTRAINT [FK_HoaDonNhap_NhaSanXuat] FOREIGN KEY([MaNSX])
REFERENCES [dbo].[NhaSanXuat] ([MaNSX])
GO
ALTER TABLE [dbo].[HoaDonNhap] CHECK CONSTRAINT [FK_HoaDonNhap_NhaSanXuat]
GO
ALTER TABLE [dbo].[HoaDonNhap]  WITH CHECK ADD  CONSTRAINT [FK_HoaDonNhap_TaiKhoan] FOREIGN KEY([MaTK])
REFERENCES [dbo].[TaiKhoan] ([MaTK])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HoaDonNhap] CHECK CONSTRAINT [FK_HoaDonNhap_TaiKhoan]
GO
ALTER TABLE [dbo].[HoaDonVanChuyen]  WITH CHECK ADD  CONSTRAINT [FK_HoaDonVanChuyen_VanChuyen] FOREIGN KEY([MaNguoiVanChuyen])
REFERENCES [dbo].[VanChuyen] ([MaNguoiVanChuyen])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HoaDonVanChuyen] CHECK CONSTRAINT [FK_HoaDonVanChuyen_VanChuyen]
GO
ALTER TABLE [dbo].[HoaDonXuat]  WITH CHECK ADD  CONSTRAINT [FK_HoaDonXuat_HoaDonMua] FOREIGN KEY([MaHoaDonMua])
REFERENCES [dbo].[HoaDonMua] ([MaHD])
GO
ALTER TABLE [dbo].[HoaDonXuat] CHECK CONSTRAINT [FK_HoaDonXuat_HoaDonMua]
GO
ALTER TABLE [dbo].[HoaDonXuat]  WITH CHECK ADD  CONSTRAINT [FK_HoaDonXuat_HoaDonVanChuyen] FOREIGN KEY([MaHoaDonVanChuyen])
REFERENCES [dbo].[HoaDonVanChuyen] ([MaHoaDonVanChuyen])
GO
ALTER TABLE [dbo].[HoaDonXuat] CHECK CONSTRAINT [FK_HoaDonXuat_HoaDonVanChuyen]
GO
ALTER TABLE [dbo].[HoaDonXuat]  WITH CHECK ADD  CONSTRAINT [FK_HoaDonXuat_KhachHang] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[HoaDonXuat] CHECK CONSTRAINT [FK_HoaDonXuat_KhachHang]
GO
ALTER TABLE [dbo].[HoaDonXuat]  WITH CHECK ADD  CONSTRAINT [FK_HoaDonXuat_Kho] FOREIGN KEY([MaKho])
REFERENCES [dbo].[Kho] ([MaKho])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HoaDonXuat] CHECK CONSTRAINT [FK_HoaDonXuat_Kho]
GO
ALTER TABLE [dbo].[HoaDonXuat]  WITH CHECK ADD  CONSTRAINT [FK_HoaDonXuat_TaiKhoan] FOREIGN KEY([MaTK])
REFERENCES [dbo].[TaiKhoan] ([MaTK])
GO
ALTER TABLE [dbo].[HoaDonXuat] CHECK CONSTRAINT [FK_HoaDonXuat_TaiKhoan]
GO
ALTER TABLE [dbo].[KeHoachLamViec]  WITH CHECK ADD  CONSTRAINT [FK_KeHoachLamViec_TrinhDuoc] FOREIGN KEY([MaTD])
REFERENCES [dbo].[TrinhDuoc] ([MaTD])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[KeHoachLamViec] CHECK CONSTRAINT [FK_KeHoachLamViec_TrinhDuoc]
GO
ALTER TABLE [dbo].[KhoDauThuoc]  WITH CHECK ADD  CONSTRAINT [FK_KhoDauThuoc_DauThuoc] FOREIGN KEY([MaDT])
REFERENCES [dbo].[DauThuoc] ([MaDT])
GO
ALTER TABLE [dbo].[KhoDauThuoc] CHECK CONSTRAINT [FK_KhoDauThuoc_DauThuoc]
GO
ALTER TABLE [dbo].[KhoDauThuoc]  WITH CHECK ADD  CONSTRAINT [FK_KhoDauThuoc_DonVi] FOREIGN KEY([MaDonVi])
REFERENCES [dbo].[DonVi] ([ID])
GO
ALTER TABLE [dbo].[KhoDauThuoc] CHECK CONSTRAINT [FK_KhoDauThuoc_DonVi]
GO
ALTER TABLE [dbo].[KhoDauThuoc]  WITH CHECK ADD  CONSTRAINT [FK_KhoDauThuoc_Kho] FOREIGN KEY([MaKho])
REFERENCES [dbo].[Kho] ([MaKho])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[KhoDauThuoc] CHECK CONSTRAINT [FK_KhoDauThuoc_Kho]
GO
ALTER TABLE [dbo].[KhoNhanVien]  WITH CHECK ADD  CONSTRAINT [FK_KhoNhaVien_Kho] FOREIGN KEY([MaKho])
REFERENCES [dbo].[Kho] ([MaKho])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[KhoNhanVien] CHECK CONSTRAINT [FK_KhoNhaVien_Kho]
GO
ALTER TABLE [dbo].[KhoNhanVien]  WITH CHECK ADD  CONSTRAINT [FK_KhoNhaVien_TaiKhoan] FOREIGN KEY([MaTK])
REFERENCES [dbo].[TaiKhoan] ([MaTK])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[KhoNhanVien] CHECK CONSTRAINT [FK_KhoNhaVien_TaiKhoan]
GO
ALTER TABLE [dbo].[KhuyenMaiDauThuoc]  WITH CHECK ADD  CONSTRAINT [FK_KhuyenMaiDauThuoc_DauThuoc] FOREIGN KEY([MaDT])
REFERENCES [dbo].[DauThuoc] ([MaDT])
GO
ALTER TABLE [dbo].[KhuyenMaiDauThuoc] CHECK CONSTRAINT [FK_KhuyenMaiDauThuoc_DauThuoc]
GO
ALTER TABLE [dbo].[KhuyenMaiDauThuoc]  WITH CHECK ADD  CONSTRAINT [FK_KhuyenMaiDauThuoc_KhuyenMai] FOREIGN KEY([MaKM])
REFERENCES [dbo].[KhuyenMai] ([ID])
GO
ALTER TABLE [dbo].[KhuyenMaiDauThuoc] CHECK CONSTRAINT [FK_KhuyenMaiDauThuoc_KhuyenMai]
GO
ALTER TABLE [dbo].[NhomQuyenRoute]  WITH CHECK ADD  CONSTRAINT [FK_NhomQuyenRoute_NhomQuyen] FOREIGN KEY([MaNhomQuyen])
REFERENCES [dbo].[NhomQuyen] ([MaNhomQuyen])
GO
ALTER TABLE [dbo].[NhomQuyenRoute] CHECK CONSTRAINT [FK_NhomQuyenRoute_NhomQuyen]
GO
ALTER TABLE [dbo].[NhomQuyenRoute]  WITH CHECK ADD  CONSTRAINT [FK_NhomQuyenRoute_Route] FOREIGN KEY([IDRoute])
REFERENCES [dbo].[Route] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[NhomQuyenRoute] CHECK CONSTRAINT [FK_NhomQuyenRoute_Route]
GO
ALTER TABLE [dbo].[Position]  WITH CHECK ADD  CONSTRAINT [FK_Position_TaiKhoan] FOREIGN KEY([MaTK])
REFERENCES [dbo].[TaiKhoan] ([MaTK])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Position] CHECK CONSTRAINT [FK_Position_TaiKhoan]
GO
ALTER TABLE [dbo].[PositionNow]  WITH CHECK ADD  CONSTRAINT [FK_PositionNow_TaiKhoan] FOREIGN KEY([MaTK])
REFERENCES [dbo].[TaiKhoan] ([MaTK])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PositionNow] CHECK CONSTRAINT [FK_PositionNow_TaiKhoan]
GO
ALTER TABLE [dbo].[QuanHuyen]  WITH CHECK ADD  CONSTRAINT [FK_QuanHuyen_TinhThanhPho] FOREIGN KEY([IDTinhThanh])
REFERENCES [dbo].[TinhThanhPho] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[QuanHuyen] CHECK CONSTRAINT [FK_QuanHuyen_TinhThanhPho]
GO
ALTER TABLE [dbo].[TagsDThuocNThuoc]  WITH CHECK ADD  CONSTRAINT [FK_TagsDThuocNThuoc_DauThuoc] FOREIGN KEY([MaDauThuoc])
REFERENCES [dbo].[DauThuoc] ([MaDT])
GO
ALTER TABLE [dbo].[TagsDThuocNThuoc] CHECK CONSTRAINT [FK_TagsDThuocNThuoc_DauThuoc]
GO
ALTER TABLE [dbo].[TagsDThuocNThuoc]  WITH CHECK ADD  CONSTRAINT [FK_TagsDThuocNThuoc_NhomDauThuoc] FOREIGN KEY([MaNhomThuoc])
REFERENCES [dbo].[NhomDauThuoc] ([MaNhomThuoc])
GO
ALTER TABLE [dbo].[TagsDThuocNThuoc] CHECK CONSTRAINT [FK_TagsDThuocNThuoc_NhomDauThuoc]
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD  CONSTRAINT [FK_TaiKhoan_NhomQuyen] FOREIGN KEY([MaNhomQuyen])
REFERENCES [dbo].[NhomQuyen] ([MaNhomQuyen])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TaiKhoan] CHECK CONSTRAINT [FK_TaiKhoan_NhomQuyen]
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD  CONSTRAINT [FK_TaiKhoan_TrinhDuoc] FOREIGN KEY([MaTD])
REFERENCES [dbo].[TrinhDuoc] ([MaTD])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TaiKhoan] CHECK CONSTRAINT [FK_TaiKhoan_TrinhDuoc]
GO
ALTER TABLE [dbo].[TrinhDuocKhachHang]  WITH CHECK ADD  CONSTRAINT [FK_TrinhDuocKhachHang_KhachHang] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TrinhDuocKhachHang] CHECK CONSTRAINT [FK_TrinhDuocKhachHang_KhachHang]
GO
ALTER TABLE [dbo].[TrinhDuocKhachHang]  WITH CHECK ADD  CONSTRAINT [FK_TrinhDuocKhachHang_TrinhDuoc] FOREIGN KEY([MaTD])
REFERENCES [dbo].[TrinhDuoc] ([MaTD])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TrinhDuocKhachHang] CHECK CONSTRAINT [FK_TrinhDuocKhachHang_TrinhDuoc]
GO
USE [master]
GO
ALTER DATABASE [QL_Duoc1] SET  READ_WRITE 
GO
