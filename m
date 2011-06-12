Content-Type: multipart/mixed; boundary="===============3877518689657559189=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] linktop: reimplemented linktop plugin based on mbm
Date: Sun, 12 Jun 2011 03:57:42 -0500
Message-ID: <4DF47F86.9030108@gmail.com>
In-Reply-To: <BANLkTikNc_A+B5t1iqvZHAoipPRG04T5kA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3877518689657559189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Amit,

> =

> The windows driver files have some references to ST-Ericsson and the AT
> commands
> looks more like as subset of ST-Ericsson commands then Huawei.
> =

> I have cross check the listed commands
> with http://natisbad.org/E4300/Dell_Wireless_5530_AT_cmd_ref.html and
> found lots of AT*E**** commands which are Ericsson extensions.
>  =


Ok, then forget what I said earlier.  This indeed looks like an MBM clone.

>     Same with radio-settings and voicecall.
> =

> =

> I have tested redio-settings and is required to switch to edge to umts. =

> =


Fair enough.

> The device supports voice call but I am unable to test with
> test-voicecall script ast it fails with =

> `Method "GetCalls" with signature "" on interface
> "org.ofono.VoiceCallManager" doesn't exist` error.
> =

> Looking at windows driver log, the device issues AT*ECAV command
> to initiate voice call like this:
> =

> AT*ECAV: 1,1,1,,,"1503",129

Then you will have to trace why the voicecall atom never registers.  Do
note that unless the linktop supports some way of obtaining audio, we
prefer not to enable the voicecall driver and associated interfaces.
Pretty much every single usb datacard on the market can make calls, but
95% of them do not support audio.

Also, I notice that the device reports support of *ENAP, which is used
for high-speed context activation.  Is the kernel detecting a high-speed
interface (e.g. ethernet) when you insert the linktop device?  Or is
this device only capable of PPP?

Regards,
-Denis

--===============3877518689657559189==--

