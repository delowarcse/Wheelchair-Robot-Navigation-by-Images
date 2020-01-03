function academic_ctrl(speed, steer)

if speed < 0
    spdsig = sprintf('-%03d', abs(speed));
else
    spdsig = sprintf('+%03d', abs(speed));
end

if steer < 0
    strsig = sprintf('-%03d', abs(steer));
else
    strsig = sprintf('+%03d', abs(steer));
end

rs232cj2_jw(uint8(['@CD',spdsig,strsig,13,10]));
% pause(0.05)