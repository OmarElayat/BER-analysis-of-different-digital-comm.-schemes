disp('please wait for the simulation to finish, it might take few seconds');

[BER_1, BER_th_1] = proj1_phase1_bpsk;    % calling bpsk file
disp('BPSK DONE');
[BER_2, BER_th_2] = proj1_phase1_cbfsk;   % calling cbfsk file
disp('CBFSK DONE');
[BER_3, BER_th_3] = proj1_phase1_ncbfsk;  % calling cbfsk file
disp('NCBFSK DONE');

close all;
EbNo_db = -2:10;
%plotting
figure(4);
title('Bit Error Rate verses SNR for different Binary modulations');
semilogy(EbNo_db,BER_2,'o','linewidth', 2.5);grid on,hold on;
semilogy(EbNo_db,BER_th_2,'g');
semilogy(EbNo_db,BER_1,'o','linewidth', 2.5);grid on,hold on;
semilogy(EbNo_db,BER_th_1,'r');
semilogy(EbNo_db,BER_3,'o','linewidth', 2.5);grid on,hold on;
semilogy(EbNo_db,BER_th_3,'c');
xlabel(' SNR(dB)');
ylabel('BER');
legend('Simulated CBFSK','Closed-form CBFSK','Simulated BPSK','Closed-form BPSK','Simulated NCBFSK','Closed-form NCBFSK','Location','SouthWest');