%%
clear all
clc

%% Frequencies
B = 1000;
fc= 10000;
wc = 2*pi*fc;     % Carrier signal frequency

%% Time
fs = 2*(fc+B)*10;  % Sampling rate
t = linspace(-5,5,10*fs);

%% The Message Signal
m = sinc(B*t);

% Message Signal Plot
nexttile
plot(t,m)
title('The Message Signal m(t)')
xlabel('Time [sec.]')
axis([-0.005 0.005 -0.5 1])
ylabel('m(t)');
grid

%% The carier signals
c_1 = cos(wc*t);
c_2 = sin(wc*t);

%% Modulation

%s = m.*c_1;   %DSB-SC signal

m_h = imag(hilbert(m));
y_LSB = m.*c_1 + m_h.*c_2;
y_USB = m.*c_1 - m_h.*c_2;

% USB Plot
nexttile
p1 = plot(t,y_USB, t,m,':')
p1(1).LineWidth =1;
p1(2).LineWidth =2;
axis([-0.005 0.005 -1 1])

title('The Upper Side Band')
xlabel('Time [sec.]')
ylabel('y_{USB}(t)');
legend('USB','m(t)')
grid

% LSB Plot
nexttile
p2 = plot(t,y_LSB, t,m,':')
p2(1).LineWidth =1;
p2(2).LineWidth =2;

title('The Lower Side Band')
xlabel('Time [sec.]')
axis([-0.005 0.005 -1 1])
ylabel('y_{LSB}(t)');
legend('LSB','m(t)')
grid

% LSB/USB Plot
nexttile
p3 = plot(t,y_LSB, t,y_USB, t,m,':')
p3(1).LineWidth =1;
p3(2).LineWidth =1;
p3(3).LineWidth =2;
xlabel('Time [sec.]')
axis([-0.003 0.003 -1 1])
ylabel('y_{LSB}(t) & y_{USB}(t)');
legend('LSB','USB','m(t)')
grid

%% USB Spectrum
nexttile
[USB_p,w] = periodogram(y_USB,[],fc,fs,'power','centered')
plot(w/1000,10*log10(USB_p))
axis([-100 100 -250 -50])

title('USB Power Spectrum')
xlabel('frequency (KHz)')
ylabel('Power (dB)');
grid minor

% % Using SpectrumAnalyzer for viewing the spectrum of the USB
% USB = y_USB';
% sa_1 = dsp.SpectrumAnalyzer('SampleRate', fs);
% step(sa_1, USB)

%% LSB Spectrum
nexttile
[LSB_p,w] = periodogram(y_LSB,[],fc,fs,'power','centered')
plot(w/1000,10*log10(LSB_p))
axis([-100 100 -250 -50])

title('LSB Power Spectrum')
xlabel('frequency (KHz)')
ylabel('Power (dB)');
grid minor

%% Demodulation

y = y_USB.*c_1;
s_dem = 2*lowpass(y, B/2, fs);

nexttile
plot(t, s_dem,'-r', t, m, '-b')
axis([-0.005 0.005 -0.5 1])
title('Demodulated Signal')
xlabel('Time (sec.)')
ylabel('s_{Dem}(t)');
legend('s_{Dem}(t)','m(t)')
grid

%% Demodulation (Non-synchronized)

%case (1)
f_11 = fc + 0.1*B;
y_11 = y_USB.* cos(2*pi*f_11*t);
s_dem_11 = 2*lowpass(y_11, B/(2*pi), fs);

nexttile
plot(t, s_dem_11,'-r', t, m, '--b')
axis([-0.005 0.005 -0.5 1])
title('Demodulated Signal (Non-synchronized) - Case 1')
xlabel('Time (sec.)')
ylabel('s_{Dem_1}(t)');
legend('s_{Dem_1}(t)','m(t)')
grid

%case (2)
f_12 = fc - 0.1*B;
y_12 = y_USB.* cos(2*pi*f_12*t);
s_dem_12 = 2*lowpass(y_12, B/(2*pi), fs);

nexttile
plot(t, s_dem_12,'-r', t, m, '--b')
axis([-0.005 0.005 -0.5 1])
title('Demodulated Signal (Non-synchronized) - Case 2')
xlabel('Time (sec.)')
ylabel('s_{Dem_2}(t)');
legend('s_{Dem_2}(t)','m(t)')
grid