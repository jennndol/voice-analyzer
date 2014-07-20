function [ f1,f2,f3,lpc_coef] = linearpredictivecoding( hamm,fs )
    lpc_coef = lpc(hamm,12);
    rootlpc = roots(lpc_coef);
    rootlpc = rootlpc(imag(rootlpc)>=0);
    angle = atan2(imag(rootlpc),real(rootlpc));
    [F,index] = sort(angle.*(fs/(2*pi)));
    bw = -1/2*(fs/(2*pi))*log(abs(rootlpc(index)));
    n = 1;
    for i = 1:length(F)
        if (F(i) > 90 && bw(i) <400)
            frmnt(n) = F(i);
            n = n+1;
        end
    end
    [~, b]=size(frmnt);
    if b<3 || frmnt(3)==4000 || frmnt(2)==4000
        frmnt(1)=0;
        frmnt(2)=0;
        frmnt(3)=0;
    end
    f1=frmnt(1);
    f2=frmnt(2);
    f3=frmnt(3);
end