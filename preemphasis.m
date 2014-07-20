function [ premph ] = preemphasis( y )
    x = y(1:end);
    a = [1 0.9];
	premph = filter(1,a,x);
end