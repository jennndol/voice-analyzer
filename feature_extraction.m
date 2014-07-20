function [f0,f1,f2,f3,allf0,allf1,allf2,allf3] = feature_extraction(x, fs)
    %% Inisialisasi
    len_sig = length(x);
    N = 30;
    M = 20;
    nsampel = round(N  * fs / 1000); % merubah dari milidetik ke nomor segmen
    noverlap = round(M * fs / 1000); % merubah dari milidetik ke nomor segmen
    %% Melakukan Frame Blocking, Hamming Window, Autokorelasi, serta
    %% Mendeteksi pitch dan formant pada setiap frame
    index = 1; i = 1;
    while (index+nsampel < len_sig)
        frame = x(index:index+nsampel-1);
        hamm = frame.*hamming(length(frame));
        [sframe(:,i),shammingwindow(:,i)] = frameblocking(frame,hamm);
        [R(:,i),allf0(:,i)] = autocorrelation( hamm,fs);
        [allf1(:,i),allf2(:,i),allf3(:,i),lpc_coef(:,i)] = linearpredictivecoding( hamm,fs );
        index = index + (nsampel - noverlap);
        i = i + 1;
    end
    %% mengambil nilai rata-rata frekuensi pitch dan formant pada setiap frame
    f0=mean(allf0(allf0~=0));
    f1=mean(allf1(allf1~=0));
    f2=mean(allf2(allf2~=0));
    f3=mean(allf3(allf3~=0));
end