function [BER,BER_th] = proj1_phase1_cbfsk()
 clear all;
 close all;
 num_bit=1e6;                             %Signal length 
 data=round(rand(1,num_bit));         %Generate binary data source
 data_mod=data+j*(~data);                    %Baseband BFSK modulation    
 EbNo_db=-2:10;                            %Signal to Noise Ratio (in dB)
 EbNo=10.^(EbNo_db/10);                      

 for k=1:length(EbNo)                  %Beginning of loop for different SNR
     Error=0;
     Y=awgn(complex(data_mod),EbNo_db(k));
      
     for c=1:num_bit                  %Decision device taking decision and deciding error
        Z(c)=real(Y(c))-imag(Y(c));
        if ((Z(c)>0 && data(c)==0)||(Z(c)<0 && data(c)==1))
            Error=Error+1;
        end
     end              
     BER(k)=Error/num_bit;     %Calculate BER for a particular SNR                                  
 end                                       
 BER_th=(1/2)*erfc(sqrt(EbNo/2));          %analytical BER
 
%plotting
figure(2);
semilogy(EbNo_db,BER,'o','linewidth', 2.5);grid on,hold on;
semilogy(EbNo_db,BER_th,'g');
title('Bit Error Rate verses SNR for Coherent Binary FSK modulation');
xlabel(' SNR(dB)');
ylabel('BER');
legend('Simulated CBFSK','Closed-form CBFSK');
end