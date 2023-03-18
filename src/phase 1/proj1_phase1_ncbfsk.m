function [BER,BER_th] = proj1_phase1_ncbfsk()
    clear all;
    close all;
    M = 2;         % Modulation order
    k = log2(M);   % Bits per symbol
    Fs = 16;       % Sample rate (Hz)
    nsamp = 8;     % Number of samples per symbol
    freqsep = 10;  % Frequency separation (Hz)
    EbNo_db = -2:10;      % Eb/No (dB)
    EbNo=10.^(EbNo_db/10);
    data = randi([0 M-1],1e6,1);
    txsig = fskmod(data,M,freqsep,nsamp,Fs);
    
    for c =1:length(EbNo)
        num = 0;
        rxSig  = awgn(txsig,EbNo(c)+10*log10(k)-10*log10(nsamp),'measured',[],'dB');
        %rxSig =  awgn(complex(txsig),EbNo_db(c));
        dataOut = fskdemod(rxSig,M,freqsep,nsamp,Fs);
        [num,BER(c)] = biterr(data,dataOut);
    end
    %BER_th=(1/2)*exp(-0.5*EbNo);          %Calculate analytical BER
    BER_th = berawgn(EbNo,'fsk',M,'noncoherent');
    
    %plotting
    figure(3);
    semilogy(EbNo_db,BER,'o','linewidth', 2.5);grid on,hold on;
    semilogy(EbNo_db,BER_th,'g');
    title('Bit Error Rate verses SNR for Non-Coherent Binary FSK modulation');
    xlabel(' SNR(dB)');
    ylabel('BER');
    legend('Simulated NCBFSK','Closed-form NCBFSK');
end
