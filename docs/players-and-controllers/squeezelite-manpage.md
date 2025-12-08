---
layout: default
title: squeezelite(1) manpage
hide:
  - toc
---

# squeezelite(1) - Lightweight headless Squeezebox emulator

Debian Project, 2025-10-10

```
squeezelite [options]
```

<a name="description"></a>

# Description

**Squeezelite**
is a small headless Logitech Squeezebox emulator. It is aimed at supporting high
quality audio including USB DAC based output at multiple sample rates.

The player is controlled using, and media is streamed from, a Lyrion Music
Server instance running somewhere on the local network.

<a name="options"></a>

# Options

This program supports the following options:

* **-?**  
  Show a summary of the available command-line options.
* **-s &lt;server&gt;[:&lt;port&gt;]**  
  Connect to the specified Lyrion Music Server, otherwise uses automatic
  discovery to find server on the local network. This option should only be needed
  if automatic discovery does not work, or the server is not on the local network
  segment (e.g. behind a router).
* **-o &lt;output device&gt;**  
  Specify the audio output device; the default value is
  _default_.
  Use the
  **-l**
  option to list available output devices.
  _-_
  can be used to output raw samples to standard output.
* **-l**  
  List available audio output devices to stdout and exit. These device names can
  be passed to the
  **-o**
  option in order to select a particular device or configuration to use for audio
  playback.
* **-a &lt;params&gt;**  
  Specify parameters used when opening an audio output device.

For ALSA, the format
**&lt;b&gt;:&lt;p&gt;:&lt;f&gt;:&lt;m&gt;:&lt;d&gt;**
is used where
**&lt;b&gt;**
is the buffer time in milliseconds (values less than 500) or size in bytes (default
_40_ms);
**&lt;p&gt;**
is the period count (values less than 50) or size in bytes (default
_4_ periods);
**&lt;f&gt;**
is the sample format (possible values:
_16_, _24_, _24_3_ or _32_);
**&lt;m&gt;**
is whether to use mmap (possible values:
_0_ or _1_).
**&lt;d&gt;**
open ALSA output device twice. (possible values:
_0_ or _1_).

For Linux PortAudio, the value
**&lt;l&gt;**
is simply the target latency in milliseconds.

For MacOS,
**&lt;l&gt;:&lt;r&gt;**
**&lt;l&gt;**
is target latency in milliseconds.
**&lt;r&gt;**
open device in Pro Mode or Play Nice (respective values:
_0_ or _1_).

For Windows,
**&lt;l&gt;:&lt;e&gt;**
**&lt;l&gt;**
is target latency in milliseconds.
**&lt;e&gt;**
use exclusive mode for WASAPI (possible values:
_0_ or _1_).

When the output is sent to standard output, the value can be
_16_, _24_ or _32_,
which denotes the sample size in bits. Little Endian only.

* **-b &lt;stream&gt;:&lt;output&gt;**  
  Specify internal stream and output buffer sizes in kilobytes. Default is 2048:3445.
* **-c &lt;codec1&gt;,...**  
  Restrict codecs to those specified, otherwise load all available codecs. Use
  **squeezelite -?**
  to obtain the list of codecs built into **squeezelite**.
* **-C &lt;timeout&gt;**  
  Close the output device after
  **&lt;timeout&gt;**
  seconds of the player being idle; the default is to always keep the device open
  as long as the payer is "on".
* **-d &lt;category&gt;=&lt;level&gt;**  
  Set logging level. Categories are:
  _all_, _slimproto_, _stream_, _decode_, _output_ or _ir_.
  Levels can be:
  _info_, _debug_ or _sdebug_.
  The option can be repeated to set different log levels for different categories.
* **-e &lt;codec1&gt;,...**  
  Explicitly exclude native support of one or more codecs. See also
  **-c**,
  above.
* **-f &lt;logfile&gt;**  
  Send logging output to a log file instead of standard output or standard error.
* **-G &lt;GPIO Chip&gt;:&lt;GPIO#&gt;:&lt;H/L&gt;**  
  Specify the kernel gpio chip number.
  Specify the GPIO Line# to use for Amp Power Relay and if the output
  should be Active High or Low. This cannot be used with the **-S** option.
* **-i [&lt;filename&gt;]**  
  Enable LIRC remote control support. If the optional
  **&lt;filename&gt;**
  is not provided,
  _~/.lircrc_
  is used instead.
* **-m &lt;mac addr&gt;**  
  Override the player's MAC address. The format must be colon-delimited
  hexadecimal, for example: ab:cd:ef:12:34:56. This is usually automatically
  detected, and should not need to be provided in most circumstances.
* **-M &lt;modelname&gt;**  
  Override the player's hardware model name. The default value is
  _SqueezeLite_.
* **-n &lt;name&gt;**  
  Set the player name. This name is used by the Lyrion Music Server to refer to
  the player by name. This option is mutually exclusive with
  **-N**.
* **-N &lt;filename&gt;**  
  Allow the server to set the player's name. The player name is stored in the file
  pointed to by
  **&lt;filename&gt;**
  so that it can persist between restarts. This option is mutually exclusive with
  **-n**.
* **-O &lt;mixer device&gt;**  
  Specify mixer device, defaults to **&lt;output device&gt;**.
  \.
* **-p &lt;priority&gt;**  
  Set real time priority of output thread (1-99; default
  _45_).
  Not applicable when using PortAudio.
* **-P &lt;filename&gt;**  
  Write the process ID (PID) number to the given
  **&lt;filename&gt;**.
  This may be useful when running **squeezelite** as a daemon.
* **-r &lt;rates&gt;[:&lt;delay&gt;]**  
  Specify sample rates supported by the output device; this is required if the
  output device is switched off when **squeezelite** is started. The format is
  either a single maximum sample rate, a range of sample rates in the format
  _&lt;min&gt;_-_&lt;max&gt;_,
  or a comma-separated list of available rates. Delay is an optional time to wait
  when switching sample rates between tracks, in milliseconds.
* **-S &lt;power script&gt;**  
  Absolute path to script to launch on power commands from LMS. This
  cannot be used with the **-G** option.
* **-u|-R [params]**  
  Enable upsampling of played audio. The argument is optional; see
  **RESAMPLING**
  (below) for more information. The options
  **-u** and **-R**
  are synonymous.
* **-D [delay][:format]**  
  Output device supports DSD over PCM (DoP) or native.
  **delay** to add when switching between PCM and DSD in milliseconds (optional).
  **format** dop (default), u8, u16le, u16be, u32le or u32be as required by attached DAC.
* **-v**  
  Enable visualiser support. This creates a shared memory segment that contains
  some of the audio being played, so that an external visualiser can read and
  process this to create visualisations.
* **-W**  
  Read wave and aiff format from header, ignoring server parameters.
* **-L**  
  List available volume controls for the output device. Only applicable when
  using ALSA output.
* **-U &lt;control&gt;**  
  Unmute the given ALSA
  **&lt;control&gt;**
  at daemon startup and set it to full volume. Use software volume adjustment for
  playback. This option is mutually exclusive with the **-V** option. Only
  applicable when using ALSA output.
* **-V &lt;control&gt;**  
  Use the given ALSA
  **&lt;control&gt;**
  for volume adjustment during playback. This prevents the use of software volume
  control within **squeezelite**. This option is mutually exclusive with the
  **-U** option. If neither **-U** nor **-V** options are provided,
  no ALSA controls are adjusted while running **squeezelite** and software
  volume control is used instead. Only applicable when using ALSA output.
* **-X**  
  Use linear volume adjustments instead of in terms of dB (only for
  hardware volume control).
* **-z**  
  Cause **squeezelite** to run as a daemon. That is, it detaches itself from the
  terminal and runs in the background.
* **-Z &lt;rate&gt;**  
  Report rate to server in helo as the maximum sample rate we can support.
* **-t**  
  Display version and license information.

<a name="resampling"></a>

# Resampling

Audio can be resampled or upsampled before being sent to the output device. This
can be enabled simply by passing the **-u** option to **squeezelite**, but
further configuration can be given as an argument to the option.

Resampling is performed using the SoX Resampler library; the documentation for
that library and the SoX _rate_ effect many be helpful when configuring
upsampling for **squeezelite**.

The format of the argument is
**&lt;recipe&gt;:&lt;flags&gt;:&lt;attenuation&gt;:&lt;precision&gt;:&lt;passband_end&gt;:&lt;stopband_start&gt;:&lt;phase_response&gt;**

<a name="recipe"></a>

### recipe

This part of the argument string is made up of a number of single-character
flags: **[v|h|m|l|q][L|I|M][s][E|X]**. The default value is **hL**.

* _v_, _h_, _m_, _l_ or _q_  
  are mutually exclusive and correspond to very high, high, medium, low or quick
  quality.
* _L_, _I_ or _M_  
  correspond to linear, intermediate or minimum phase.
* _s_  
  changes resampling bandwidth from the default 95% (based on the 3dB point) to
  99%.
* _E_  
  exception - avoids resampling if the output device supports the playback sample
  rate natively.
* _X_  
  resamples to the maximum sample rate for the output device ("asynchronous"
  resampling).
* **Examples**  
  **-u vLs**
  would use very high quality setting, linear phase filter and steep cut-off.  
  **-u hM**
  would specify high quality, with the minimum phase filter.  
  **-u hMX**
  would specify high quality, with the minimum phase filter and async upsampling
  to max device rate.

<a name="flags"></a>

### flags

The second optional argument to **-u** allows the user to specify the
following arguments (taken from the _soxr.h_ header file), in hex:

    #define SOXR_ROLLOFF_SMALL     0u  /* <= 0.01 dB */
    #define SOXR_ROLLOFF_MEDIUM    1u  /* <= 0.35 dB */
    #define SOXR_ROLLOFF_NONE      2u  /* For Chebyshev bandwidth. */
    
    #define SOXR_MAINTAIN_3DB_PT   4u  /* Reserved for internal use. */
    #define SOXR_HI_PREC_CLOCK     8u  /* Increase 'irrational' ratio accuracy. */
    #define SOXR_DOUBLE_PRECISION 16u  /* Use D.P. calcs even if precision <= 20. */
    #define SOXR_VR               32u  /* Experimental, variable-rate resampling. */

* **Examples**  
  **-u :2**
  would specify **SOXR\_ROLLOFF\_NONE**.

**NB:** In the example above the first option, **&lt;quality&gt;**, has not been
specified so would default to **hL**. Therefore, specifying **-u :2** is
equivalent to having specified **-u hL:2**.

<a name="attenuation"></a>

### attenuation

Internally, data is passed to the SoX resample process as 32 bit integers and
output from the SoX resample process as 32 bit integers. Why does this matter?
There is the possibility that integer samples, once resampled may be clipped
(i.e. exceed the maximum value). By default, if you do not specify an
**attenuation** value, it will default to -1db. A value of _0_ on the
command line, i.e. **-u ::0** will disable the default -1db attenuation being
applied.

**NB:** Clipped samples will be logged. Keep an eye on the log file.

* **Examples**  
  **-u ::6**
  specifies to apply -6db (ie. halve the volume) prior to the resampling process.

<a name="precision"></a>

### precision

The internal 'bit' precision used in the re-sampling calculations (ie. quality).

**NB:** HQ = 20, VHQ = 28.

* **Examples**  
  **-u :::28**
  specifies 28-bit precision.

<a name="passband_end"></a>

### passband_end

A percentage value between 0 and 100, where 100 is the Nyquist frequency. The
default if not explicitly set is _91.3_.

* **Examples**  
  **-u ::::98**
  specifies passband ends at 98 percent of the Nyquist frequency.

<a name="stopband_start"></a>

### stopband_start

A percentage value between 0 and 100, where 100 is the Nyquist frequency. The
default if not explicitly set is _100_.

* **Examples**  
  **-u :::::100**
  specifies that the stopband starts at the Nyquist frequency.

<a name="phase_response"></a>

### phase_response

A value between 0-100, where _0_ is equivalent to the recipe _M_ flag
for minimum phase, _25_ is equivalent to the recipe _I_ flag for
intermediate phase and _50_ is equivalent to the recipe _L_ flag for
linear phase.

* **Examples**  
  **-u ::::::50**
  specifies linear phase.

<a name="see-also"></a>

# See Also


* https://wiki.lyrion.org/index.php/Squeezelite  
* https://docs.picoreplayer.org/components/squeezelite  
* https://lyrion.org/  
