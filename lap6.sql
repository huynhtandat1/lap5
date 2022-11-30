---6.1.1----
create trigger trg_nhanvien
	on NhanVien
	for insert,update
as
	if (select luong from inserted) <15000
	begin
		print N'Lương tối thiểu phải từ 15000'
		rollback transaction;
	end;

		INSERT INTO [dbo].[NHANVIEN]
        ([HONV],[TENLOT],[TENNV],[MANV],[NGSINH],[DCHI],[PHAI],[LUONG],[MA_NQL],[PHG])
		VALUES
		(N'Huỳnh',N'Tấn',N'đạt','2','10-9-1999','an giang','Nam',20000,'005',1);

---6.1.2---
create trigger trg_nhanVien2 on NHANVIEN
for insert
as
	declare @a int
	set @a = YEAR(GETDATE()) - (select YEAR (NgSinh) from inserted)
	if (@a < 18 or @a > 65)
		begin
			print 'Tuoi khong hop le'
			rollback transaction
		end
insert into NHANVIEN
([HONV],[TENLOT],[TENNV],[MANV],[NGSINH],[DCHI],[PHAI],[LUONG],[MA_NQL],[PHG])
VALUES
		(N'Huỳnh',N'Tấn',N'đạt','2','10-9-1999','an giang','Nam',20000,'005',1);

---6.1.3---
create trigger trg_nhanVien3 on NhanVien
for update
as 
	if(select dchi from inserted) like '%HCM%'
		begin
			print 'Dia Chi Khong Hop Le' 
			rollback transaction
		end
select * from NHANVIEN
update NHANVIEN set TENNV = N'ĐẠT' where MANV ='005'

---6.2.1---
create trigger trg_TongNVsau
   on NHANVIEN
   AFTER INSERT
AS
   Declare @male int, @female int;
   select @female = count(Manv) from NHANVIEN where PHAI = N'Nư';
   select @male = count(Manv) from NHANVIEN where PHAI = N'Nam';
   print N'Tổng số nhân viên là nư: ' + cast(@female as varchar);
   print N'Tổng số nhân viên là nam: ' + cast(@male as varchar);

---CÂU Lệnh Kiểm Tra
INSERT INTO [dbo].[NHANVIEN]([HONV],[TENLOT],[TENNV],[MANV],[NGSINH],[DCHI],[PHAI],[LUONG],[MA_NQL],[PHG])
     VALUES (N'HUỲNH',N'TẤN ',N'ĐẠT','123','10-12-1999','HCM','Nam',200000,'005',1)
GO
-----6.2.2---
create trigger trg_TongNV2
   on NHANVIEN
   AFTER update
AS
   if (select top 1 PHAI FROM deleted) != (select top 1 PHAI FROM inserted)
   begin
      Declare @male int, @female int;
      select @female = count(Manv) from NHANVIEN where PHAI = N'Nu';
      select @male = count(Manv) from NHANVIEN where PHAI = N'Nam';
      print 'Tong Nhan Vien La Nu: ' + cast(@female as varchar);
      print 'Tong NHan Vien la nam: ' + cast(@male as varchar);
   end;
UPDATE [dbo].[NHANVIEN]
   SET [HONV] = 'nguyễn'
      ,[PHAI] = N'Nữ'
 WHERE  MaNV = '123'
GO

----6.2.3----
CREATE TRIGGER trg_TongNV3 on DEAN
AFTER DELETE
AS
begin
   SELECT MA_NVIEN, COUNT(MADA) as 'Số đề án đã tham gia' from PHANCONG
      GROUP BY MA_NVIEN
	  end
	  select * from DEAN
insert into dean values ('SQL', 50, 'HH', 4)
delete from dean where MADA=50

----6.3.1----
create trigger trg_delete on NhanVien
instead of delete
as
begin
	delete from THANNHAN where MA_NVIEN in (select MANV from deleted)
	delete from NHANVIEN where MANV in (select MANV from deleted)
end
delete NHANVIEN where MANV ='123'
select * from NHANVIEN

----6.3.2---------
create trigger nhanvien3 on NHANVIEN
after insert 
as
begin
insert into PHANCONG values ((select manv from inserted), 1,2,20)
end
INSERT INTO NHANVIEN
   VALUES (N'HUỲNH',N'TẤN ',N'ĐẠT','123','10-12-1999','HCM','Nam',200000,'005',1)