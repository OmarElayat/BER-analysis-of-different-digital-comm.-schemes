function [BER,BER_th] = proj1_phase1_bpsk()
    clear all;
    close all;
    num_bits=1e6;                                      %Number of bits or symbols
    data = round(rand(1,num_bits));                %conversion of data for BPSK modulation
    data_mod = 2*data-1;                %conversion of data for BPSK modulation
    EbNo_db=-2:10;                              %Range of EbNo in dB
    EbNo = 10.^(EbNo_db/10);
    
    for k=1:length(EbNo_db) %BER (error/bit) calculation for different SNR
        y=awgn(complex(data_mod),EbNo_db(k));
        error=0;
        for c=1:1:num_bits
            if (y(c)>0&&data(c)==0)||(y(c)<0&&data(c)==1)%logic acording to BPSK
                error=error+1;
            end
        end
        error=error/num_bits; %Calculate error/bit
        BER(k)=error;
    end
    BER_th=(1/2)*erfc(sqrt(EbNo));
    
    %plotting
    figure(1);
    semilogy(EbNo_db,BER,'o','linewidth', 2.5);grid on,hold on;
    semilogy(EbNo_db,BER_th,'r');
    title('Bit Error Rate verses SNR for Binary PSK modulation');
    xlabel('SNR(dB)');
    ylabel('BER');
    legend('Simulated BPSK','Closed-form BPSK');
end
