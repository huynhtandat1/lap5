﻿---Câu 1a---
create proc cau1_a
@name nvarchar(20)
as
	begin
		print N'xin chào: : ' + @name
	end
go
exec cau1_a N'huỳnh tấn đạt '


---Câu 1b---

create proc bt_b @a1 int,@a2 int out
as
begin
	declare @tg int
	set @tg=@a1+@a2
	print N'Tổng là: '+ CAST(@tg as varchar(10))
end
go
exec bt_b 3,4 


---------------Câu 1 c)Nhập vào số nguyên @n. In ra tổng các số chẵn từ 1 đến @n.
create proc bt_c @n int 
as
begin
	declare @tong int = 0,@tang int = 0
	while @tang < @n
	begin
		set @tong = @tong + @tang
		set @tang = @tang + 2
	end
	print N'Tổng: ' + cast(@tong as varchar(10))
	end
go
exec bt_c 20

--------------------Câu 1 d)Nhập vào 2 số. In ra ước chung lớn nhất của chúng-------------------------
create proc bt_d @a int, @b int
as
	begin
		while (@a != @b)
			begin
				if(@a > @b)
					set @a = @a - @b
				else
					set @b = @b - @a
			end
			return @a
	end
go
declare @uoc varchar(10)
exec @uoc = bt_d 12,20
print N'Ước chung là :' + @uoc
go

-------------------Câu 2 a) Nhập vào @Manv, xuất thông tin các nhân viên theo @Manv.
create proc bt2_a @MaNV varchar(20)
as
	begin
		select * from NHANVIEN where MANV = @MaNV
	end
go
exec bt2_a '002'
go
-----------------Câu 2 b)Nhập vào @MaDa (mã đề án), cho biết số lượng nhân viên tham gia đề án đó

create proc bt2_b @MaDa int
as
begin
		select count(MANV) as N'Số lượng nhân viên', MADA as N'Mã đề án', TENPHG as N'Mã đề án' from PHONGBAN
		inner join NHANVIEN on NHANVIEN.PHG = PHONGBAN.MAPHG
		inner join DEAN on DEAN.PHONG = PHONGBAN.MAPHG
		where MADA = @MaDa
		group by TENPHG,MADA
end
go
exec bt2_b 1
go

---------------Câu 2 c)Nhập vào @MaDa và @Ddiem_DA (địa điểm đề án), cho biết số lượng nhân viên tham gia đề án có mã đề án là @MaDa và địa điểm đề án là @Ddiem_DA
create proc bt2_c @MaDa int,@Ddiem_DA nvarchar(15) 
as
begin
		select count(MANV) as N'Số lượng nhân viên' , MADA as N'Mã đề án', TENPHG as N'Mã đề án',DDIEM_DA as N'Địa điểm đề án'from PHONGBAN
		inner join NHANVIEN on NHANVIEN.PHG = PHONGBAN.MAPHG
		inner join DEAN on DEAN.PHONG = PHONGBAN.MAPHG
		where MADA = @MaDa  and  DDIEM_DA = @Ddiem_DA 
		group by TENPHG,MADA,DDIEM_DA
end
go
exec bt2_c 3,'TP HCM'
-------------------Câu 2 d)Nhập vào @Trphg (mã trưởng phòng), xuất thông tin các nhân viên có trưởng phòng là @Trphg và các nhân viên này không có thân nhân.
create proc bt2_d @Trphg nvarchar(10) as
begin
select  * from NHANVIEN inner join PHONGBAN ON NHANVIEN.PHG = PHONGBAN.MAPHG
where TRPHG = @Trphg
end
go
exec bt2_d '006'

------------------Câu 2 e)Nhập vào @Manv và @Mapb, kiểm tra nhân viên có mã @Manv có thuộc phòng ban có mã @Mapb hay không
create proc bt2_e @Manv nvarchar(10),@Mapb nvarchar(10) as
begin
if exists (select * from NHANVIEN where MANV = @Manv and PHG = @Mapb)
	print' Có'
else
	print ' Không'
end
go
exec bt2_e '002','4'

