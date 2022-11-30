create proc sp_ThemNhanVien
	@HONV NVARCHAR(15), @TENLOT NVARCHAR(15),
	@TENNV NVARCHAR(15), @MANV NVARCHAR(15),
	@NGSINH DATETIME , @DCHI NVARCHAR (15),
	@PHAI NVARCHAR(3),@LUONG FLOAT, @PHG INT
as
begin
	if not exists (select * from PHONGBAN where  TENPHG = 'IT')
	begin
		print 'Phòng này là phòng IT';
		return;
	end;
	declare @Ma_NQL nvarchar(15);
	if @LUONG > 25000
		set @Ma_NQL ='005';
	else
		set @Ma_NQL ='009';
	declare @age int;
	select @age = DATEDIFF(year,@ngsinh,getdate() )+1;
	if @PHAI = 'Nam' and (@age<18 or @age>60)
	begin
		print N'Nam phải có dộ tuổi từ 18 đến 65'
		return;
	end;
	else if @PHAI = 'Nữ' and (@age < 16 or @age > 60)
	begin
		print N'Nữ phải có đọ tuổi từ 18 đến 60';
		return;
	end;
	insert into  [dbo].[NHANVIEN] 
		(HONV,TENLOT,TENNV,MANV,NGSINH,DCHI,PHAI,LUONG,MA_NQL,PHG)
	values 
		(@HONV,@TENLOT,@TENNV,@MANV,@NGSINH,@DCHI,@PHAI,@LUONG,@MA_NQL,@PHG);
end;

 exec [dbo].[sp_ThemNhanVien] N'Nguyễn ', N'Văn ',N'Quyết','030','1-11-1998',N'Bình Thuận','Nam ',300000,6;