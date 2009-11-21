Content-Type: multipart/mixed; boundary="===============5038051747767354867=="
MIME-Version: 1.0
From: Nicola Mfb <nicola.mfb@gmail.com>
Subject: Re: Palm Pre modem plugin
Date: Sat, 21 Nov 2009 20:47:41 +0100
Message-ID: <359c5480911211147o23607b25q247a19a6f6abee17@mail.gmail.com>
In-Reply-To: <1258827156.22343.26.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5038051747767354867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!
FSO is not only ogsmd, but manages resource handling to save power,
alsa state change for audio routing, networking, hardware led (lights,
vibration), suspending resume, rtc wakeup alarms, pim contacts, music
playing and so on, it's a full featured framework to abstract the
entire smartphone with a nice api.

For that reason it attracts a lot of api consumers that have the
possibility to write code and having it running on all FSO supported
devices without going at a low level to achieve specific machine
tasks.

Add the fact that there are entire linux distros already carrying of
FSO and a lot of application FSO based, (openembedded derived, gentoo,
debian etc.)

As of that I'm able to imagine only few reasons to use ofono instead of fso.
The first may be is ofono may implement some important missing
features, but is nosense becouse is open, so FSO may pickup what they
need (and the contrary).
The second may be that many peoples were bored by the python
implementation, but now FSO2 is going further with vala resulting in c
speed, so this may be minimal.
The third is to experiment, we for example are coding a wrapper daemon
to use oFono or FSO, or oFono and FSO (with the gsmd module disabled).
The forth and worring is that a developer may be *forced* to use
ofono, as the target device has some closed parts necessary for the os
that does not work anymore if you remove ofono and use FSO.

So, instead of discuss oFono vs FSO, I'd like to know what is the long
time strategy and how to address these issues, and of course if I
missed some important points.

Best Regards.

      Niko

--===============5038051747767354867==--

