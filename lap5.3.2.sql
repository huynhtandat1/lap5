create proc sp_CapNhatPhongBan
	@OldTenPHG nvarchar (15),
	@TENPHG nvarchar(15),
	@MAPHG int,
	@TRPHG nvarchar(15),
	@NG_NHANCHUC date 
as
begin
	update  [dbo].[PHONGBAN]
	set	[TENPHG]=TENPHG,
		[MAPHG]=@MAPHG,
		[TRPHG]=@TRPHG,
		[NG_NHANCHUC]=@NG_NHANCHUC
	where TENPHG = @OldTenPHG;
end;
exec  [dbo].[sp_CapNhatPhongBan] 'CNTT','IT',10,'005','1-2-2021'