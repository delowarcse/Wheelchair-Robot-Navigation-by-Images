function academic_init(COM)
rs232cj2_jw(COM,38400,8,2,0,0);
rs232cj2_jw(uint8(['@CA',13,10]));
pause(0.15);
data=char(rs232cj2_jw([]));
fprintf('\n%s\n',data)

