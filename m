Content-Type: multipart/mixed; boundary="===============0610264432777147834=="
MIME-Version: 1.0
From: Jomon John <jomon.john@tataelxsi.co.in>
Subject: Re: [pulseaudio-discuss] HFP HF - Reject SCO Issue
Date: Fri, 27 May 2016 19:18:22 +0000
Message-ID: <HK2PR04MB120320665835D1863933DB6DDE420@HK2PR04MB1203.apcprd04.prod.outlook.com>
In-Reply-To: <HK2PR04MB1203BD4DC7B3A78CAA32BA60DE410@HK2PR04MB1203.apcprd04.prod.outlook.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0610264432777147834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

>> Did you load module-bluetooth-discover with headset=3Dofono as argument?
>> Normally this should be sufficient to make it work. When the connection
>> is established,
> Yes, module-bluetooth-discover is loaded, also tried with "ofono" and "au=
to" arguments, but nothing till now.
>> pulseaudio automatically loads loopback modules for the phone. You might
>> have to check if the modules have the correct source / sink.
> Could you please provide further more details regrading the source sink s=
etup.
>> Additionally to observing the log files, you can debug what is going on
>> by using dbus-monitor to see the messages on the dbus.

Thanks, SCO transport is working now, even though i cant hear anything on h=
eadset sco traffic is visible via btmon during phone call.The issues were,

* The build system(Yocto) was not properly enabling the ofono backend for p=
ulseaudio, took some time to identify this.
* Configured default.pa with proper module name name(module-bluez5-discover=
) and arguments
* device, module and card restore modules are causing issues, so disabled i=
t !! =


Currently trying to change volume with alsamixer is giving following messag=
e,

    alsa-plugins-1.0.29/pulse/pulse.c:243:(pulse_connect) PulseAudio: Unabl=
e to connect: Connection refused
    cannot open mixer: Connection refused

~
Best Regards,
John J
--===============0610264432777147834==--

