Content-Type: multipart/mixed; boundary="===============2611694359518179503=="
MIME-Version: 1.0
From: Jomon John <jomon.john@tataelxsi.co.in>
Subject: Re: [pulseaudio-discuss] HFP HF - Reject SCO Issue
Date: Thu, 26 May 2016 18:22:20 +0000
Message-ID: <HK2PR04MB1203BD4DC7B3A78CAA32BA60DE410@HK2PR04MB1203.apcprd04.prod.outlook.com>
In-Reply-To: <5745D33D.40703@chini.tk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2611694359518179503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for the support.

> Did you load module-bluetooth-discover with headset=3Dofono as argument?
> Normally this should be sufficient to make it work. When the connection
> is established,

Yes, module-bluetooth-discover is loaded, also tried with "ofono" and "auto=
" arguments, but nothing till now.

> pulseaudio automatically loads loopback modules for the phone. You might
> have to check if the modules have the correct source / sink.

Could you please provide further more details regrading the source sink set=
up.

> Additionally to observing the log files, you can debug what is going on
> by using dbus-monitor to see the messages on the dbus.

Yup, i will share the logs.

Regards, =

John J
--===============2611694359518179503==--

