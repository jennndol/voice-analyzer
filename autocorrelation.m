%% fungsi untuk autokorelasi frame sinyal dengan maxlag 20ms
function [ R,f0] = autocorrelation( frame,fs)
    m = round(20  * fs / 1000);
    R = xcorr(frame, m, 'coeff');
    ms2 = round(2  * fs / 1000);
    ms20 = round(20  * fs / 1000); 
    R = R(floor(length(R)/2):end);
    [~,index]=max(R(ms2:ms20));
    T0 = (ms2+index*1)/fs;
    f0 = 1/T0;
end