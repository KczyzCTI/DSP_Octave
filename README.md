# DSP_Octave
exercises from dsp lab

# Lab-01
Generate sampled sine wave of specific frequency.
Upsample signal by 2 decades (80 semitones), 
reconstruct(interpolate)

## Solution
Plots generated (also sine wave sampling) are taken from internet (mostly Matlab) forums.
They have been modified for our use case.

Regarding filtering (interpolation) I've used `conv()` function instead of filter
mostly to play around with zero-padding. Moreover this kind of implementation
will be signifficantly easier to port into C/C++.

I also played around with Various kinds of filters. Notably Parks-McClellan & Kaiser window.
While Parks-McClellan offers notably better attenuation, Kaiser has way smaller stopband ripple
and sharper cutoff.

Because in interpolation sharp cutoff matters the most it's no wonder that Kaiser performs way (about 50x) better
than Parks-McClellan. Just one Kaiser window enables us to increase signal frequency 100x.
