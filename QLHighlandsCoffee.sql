use master
go
if(exists (select*from sysdatabases where name='ManagerHighlandsCoffee'))
	Drop database ManagerHighlandsCoffee
create database ManagerHighlandsCoffee

use ManagerHighlandsCoffee
go
CREATE TABLE KhuyenMai
(	
	MaKhuyenMai Nvarchar(20) PRIMARY KEY not null,
	PhanTram int not null,
	NgayBatDau Datetime,
	NgayKetThuc Datetime
)
CREATE TABLE DanhMuc
(	MaDM Nvarchar(20) PRIMARY KEY not null,
	TenDM Nvarchar(30) not null
)
CREATE TABLE HangHoa
(	MaHang Nvarchar(20)PRIMARY KEY not null,
	TenHang Nvarchar(50) not null,
	MoTa Nvarchar(150) not null,
	AnhHang Image,
	MaDM Nvarchar(20) not null,
	FOREIGN KEY(MaDM) references DanhMuc(MaDM)
	on update cascade on delete cascade
)
CREATE TABLE SizeHang
(	
	Size Nvarchar(20) PRIMARY KEY not null
)
CREATE TABLE HangBan
(	MaHang Nvarchar(20) not null,
	Size Nvarchar(20) not null,
	DonGia Float not null,
	PRIMARY KEY(MaHang,Size),
	FOREIGN KEY(MaHang) references HangHoa(MaHang)
	on update cascade on delete cascade,
	FOREIGN KEY(Size) references SizeHang(Size)
	on update cascade on delete cascade,
)
CREATE TABLE CaLamViec
(	MaCLV Nvarchar(20)PRIMARY KEY not null,
	GioBatDau Float not null,
	GioKetThuc Float not null,
	LuongGio Float not null,
	LuongQL Float not null
)

CREATE TABLE NhanVien
(	MaNV Nvarchar(20)PRIMARY KEY not null,
	TenNV Nvarchar(50) not null,
	GioiTinh Nvarchar(50) not null,
	SDT Nvarchar(50) not null,
	DiaChi Nvarchar(150) not null,
	AnhNV Image,
	ChucVu Nvarchar(100) not null,
	MaCLV nvarchar(20) not null
)

CREATE TABLE BangChamCong
(
	MaNV Nvarchar(20) not null,
	MaCLV Nvarchar(20) not null,
	TenNV Nvarchar(50) not null,
	NgayLam Datetime not null,
	GioVao Float,
	GioRa Float,
	Cong Float,
	PRIMARY KEY(MaNV,MaCLV,NgayLam,GioVao,GioRa),
	FOREIGN KEY(MaNV) references NhanVien(MaNV)
	on update cascade on delete cascade,
	FOREIGN KEY(MaCLV) references CaLamViec(MaCLV)
	on update cascade on delete cascade
)
CREATE TABLE BangUngLuong
(
	MaNV Nvarchar(20) not null,
	MaCLV Nvarchar(20) not null,
	LuongThang Nvarchar(20) not null,
	LuongNam Nvarchar(20) not null,
	TamUng Float,
	PRIMARY KEY(MaNV,MaCLV,LuongThang, LuongNam),
	FOREIGN KEY(MaNV) references NhanVien(MaNV)
	on update cascade on delete cascade,
	FOREIGN KEY(MaCLV) references CaLamViec(MaCLV)
	on update cascade on delete cascade
)
CREATE TABLE Luong
(	MaNV Nvarchar(20) not null,
	MaCLV Nvarchar(20) not null,
	NgayCong Float,
	Thuong Float,
	TongLuong Float,
	TamUng Float,
	LuongThang Nvarchar(20) not null,
	LuongNam Nvarchar(20) not null,
	PRIMARY KEY(MaNV,MaCLV,LuongThang, LuongNam),
	FOREIGN KEY(MaNV) references NhanVien(MaNV)
	on update cascade on delete cascade,
	FOREIGN KEY(MaCLV) references CaLamViec(MaCLV)
	on update cascade on delete cascade
)
CREATE TABLE KhachHang
(	MaKH  Int IDENTITY PRIMARY KEY,
	TenKH Nvarchar(50) not null,
	GioiTinh Nvarchar(50) not null,
	SDT Nvarchar(50) not null,
	DiaChi Nvarchar(150) not null,
	DiemTichLuy int
)
CREATE TABLE Ban
(	MaBan Nvarchar(20)PRIMARY KEY not null,
	TrangThai Nvarchar(50) not null
)
CREATE TABLE HoaDon
(	MaHoaDon Int IDENTITY PRIMARY KEY,
	NgayLap Datetime,
	TongTien Float not null,
	GiamGia Float,
	TruDiemTL Int,
	MaNV Nvarchar(20) not null,
	MaKH int,
	MaBan Nvarchar(20),
	FOREIGN KEY(MaNV) references NhanVien(MaNV)
	on update cascade on delete cascade,
	FOREIGN KEY(MaKH) references KhachHang(MaKH)
	on update cascade on delete cascade,
	FOREIGN KEY(MaBan) references Ban(MaBan)
	on update cascade on delete cascade
)
CREATE TABLE ChiTietHoaDon
(	
	MaHoaDon Int,
	MaHang Nvarchar(20) not null,
	Size Nvarchar(20) not null,
	SoLuong int not null,
	PRIMARY KEY(MaHoaDon,MaHang,Size),
	FOREIGN KEY(MaHoaDon) references HoaDon(MaHoaDon)
	on update cascade on delete cascade,
	FOREIGN KEY(MaHang,Size) references HangBan(MaHang,Size)
	on update cascade on delete cascade,
)
CREATE TABLE NhaCC
(
	MaNCC Nvarchar(20) PRIMARY KEY not null,
	TenNCC Nvarchar(100) not null,
	SDT Nvarchar(50) not null,
	DiaChi Nvarchar(150) not null,
	
)
CREATE TABLE NguyenLieu
(
	MaNL Nvarchar(20) PRIMARY KEY not null,
	TenNL Nvarchar(50) not null,
	MaNCC Nvarchar(20)not null,
	DonViTinh nvarchar(20) not null,
	DonGiaNhap Float not null,
)
CREATE TABLE DonDatHang
(	MaDDH INT IDENTITY(1,1) PRIMARY KEY not null,
	MaNV Nvarchar(20) not null,
	MaNCC Nvarchar(20) not null,
	NgayLap Datetime,
	TongTien Float not null,
	NguoiNhap Nvarchar(50),
	TrangThai Nvarchar(30) not null,
	FOREIGN KEY(MaNCC) references NhaCC(MaNCC)
	on update cascade on delete cascade,
	FOREIGN KEY(MaNV) references NhanVien(MaNV)
	on update cascade on delete cascade
)
CREATE TABLE ChiTietDatHang
(	MaDDH INT not null,
	MaNL Nvarchar(20) not null,
	SoLuongNhap int not null,
	PRIMARY KEY (MaDDH, MaNL),
	FOREIGN KEY(MaDDH) references DonDatHang(MaDDH)
	on update cascade on delete cascade,
	FOREIGN KEY(MaNL) references NguyenLieu(MaNL)
	on update cascade on delete cascade
)

CREATE TABLE TaiKhoan
(	TenTK Nvarchar(20)PRIMARY KEY not null,
	MatKhau Nvarchar(50) not null
)

INSERT INTO DanhMuc (MaDM,TenDM)VALUES
('DM001',N'Cà phê pha phin'),
('DM002',N'Cà phê Espresso'),
('DM003',N'Phindi'),
('DM004',N'Trà'),
('DM005',N'Freeze'),
('DM006',N'Bánh'),
('DM007',N'Thức uống khác')

INSERT INTO SizeHang (Size)VALUES
('S'),('M'),('L'),(N'Bánh')

INSERT INTO CaLamViec (MaCLV,GioBatDau,GioKetThuc,LuongGio,LuongQL)VALUES
('CA001',8,15,25000,50000),
('CA002',14,22,25000,50000),
('CA003',18,22,30000,50000),
('CA004',8,18,50000,50000),
('CA005',15,22,55000,50000)

INSERT INTO KhachHang (TenKH,GioiTinh,SDT,DiaChi,DiemTichLuy)VALUES
(N'Khách lẻ','null','null','null',0),
(N'Lê Thị Thanh Mỹ',N'Nữ','0398820876',N'Thanh Hóa',150),
(N'Phạm Thị Thanh',N'Nữ','0752036547',N'Thái Bình',175),
(N'Quách Phương Thảo',N'Nữ','0342365812',N'Hà Nội',95),
(N'Bùi Công Nam',N'Nam','0965423322',N'Hà Nội',79)

INSERT INTO Ban (MaBan, TrangThai)VALUES
('B01',N'Trống'),
('B02',N'Trống'),
('B03',N'Trống'),
('B04',N'Trống'),
('B05',N'Trống'),
('B06',N'Trống'),
('B07',N'Trống'),
('B08',N'Trống'),
('B09',N'Trống'),
('B10',N'Trống'),
('B11',N'Trống'),
('B12',N'Trống'),
('B13',N'Trống'),
('B14',N'Trống'),
('B15',N'Trống'),
('0', N'Trống')

INSERT INTO TaiKhoan (TenTK, MatKhau)VALUES
('NV001',N'123'),
('NV002',N'123'),
('NV003',N'123'),
('NV004',N'123'),
('QL001',N'123'),
('QL002',N'123')

INSERT INTO NhaCC(MaNCC, TenNCC, DiaChi, SDT) values
('NhCC001','HighLands',N'Quận Thanh Xuân, Hà Nội','0967543234'),
('NhCC002','Minh Thanh',N'Quận Cầu Giấy, Hà Nội','0967543234')

INSERT INTO NguyenLieu(MaNL, TenNL, MaNCC,DonViTinh, DonGiaNhap) VALUES
('NL001',N'Cà phê bột','NhCC001',N'Túi',140000),
('NL002',N'Hạt cà phê','NhCC001',N'Túi',200000),
('NL003',N'Trà hoa cúc','NhCC001',N'Hộp',150000),
('NL004',N'Bột matcha','NhCC001',N'Túi',145000),
('NL005',N'kem Vani','NhCC001',N'Hộp',100000),
('NL006',N'Sốt dark chocolate ','NhCC001',N'Chai',260000),
('NL007',N'Siro boduo dâu','NhCC001',N'Chai',100000),
('NL008',N'Siro boduo đào','NhCC001',N'chai',100000),
('NL009',N'Siro đường đen','NhCC001',N'chai',180000),
('NL010',N'Bột ca cao','NhCC001',N'Túi',150000),
('NL011',N'Sữa tươi không đường','NhCC001',N'Lít',100000),
('NL012',N'Trà thái xanh','NhCC001',N'Túi',60000),
('NL013',N'Trà thái đỏ','NhCC001',N'Túi',60000),
('NL014',N'Bột kem trứng','NhCC001',N'Túi',200000),
('NL015',N'Bột sữa socola','NhCC001',N'Túi',180000),
('NL016',N'Trà nhài','NhCC001',N'Túi',210000),
('NL017',N'Trà đen','NhCC001',N'Túi',180000),
('NL018',N'Bột ca cao','NhCC002',N'Túi',150000),
('NL019',N'Sữa tươi không đường','NhCC002',N'Lít',100000),
('NL020',N'Trà thái xanh','NhCC002',N'Túi',60000),
('NL021',N'Trà thái đỏ','NhCC002',N'Túi',60000),
('NL022',N'Bột kem trứng','NhCC002',N'Túi',200000),
('NL023',N'Sốt hoa quả','NhCC002',N'Chai',120000),
('NL0024',N'Bột sữa socola','NhCC002',N'Túi',180000),
('NL0025',N'Trà nhài','NhCC002',N'Túi',210000),
('NL0026',N'Trà đen','NhCC002',N'Túi',180000),
('NL0027',N'Trà đào','NhCC002',N'Túi',180000),
('NL0028',N'Trà olong','NhCC002',N'Túi',200000),
('NL0029',N'Hồng trà','NhCC002',N'Túi',180000),
('NL0030',N'Trà sâm','NhCC002',N'Túi',170000)






