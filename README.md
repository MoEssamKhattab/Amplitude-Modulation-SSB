# Single Sideband (SSB) Amplitude Modulation
A MATLAB code to generate a single side band (SSB) signal using the SSB Hilbert method (phase shift method); implementing the suitable demodulator (Coherent Demodulation) to extract the original message signal from the SSB, either the USB or the LSB. 

## Requirements

1. Generate the message signal $m(t)$, shown in Fig. 1, where $B = 1 KHz$ and plot it,
$$m(t) = {sinc(B\pi) = {\sin(\pi Bt) \over \pi Bt}}$$
![m(t)](https://user-images.githubusercontent.com/95503706/230794178-d6f396e6-593a-4f1d-963c-143b1e373e1d.png "Fig. 1")
*Fig. 1*

2. Generate the modulated signal, $s_2(t)$, using the SSB modulator shown in Fig. 2, where the carrier wave has $1 Volt$ amplitude and $10 KHz$ frequency.
![SSB_Modulator](https://user-images.githubusercontent.com/95503706/230795016-5a1a22ee-927e-4565-8a89-073c5bc6b175.png "Fig. 2")
*Fig. 2*

3. Plot the USB output, the LSB output and the spectrum of the modulated signal in both cases.

4. Implement a suitable demodulator to extract m(t) from s(t).

5. Investigate the output of the previous steps if the generator carrier wasn’t perfectly synchronized as in the following cases,
    * Local carrier frequency at the receiver is $f_1 = f_c + 0.1B$.
    * Local carrier frequency at the receiver is $f_1 = f_c - 0.1B$.
