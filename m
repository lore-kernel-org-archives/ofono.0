Content-Type: multipart/mixed; boundary="===============7833475122036999412=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Release 0.18, now with Bluetooth HFP Client profile support
Date: Sat, 13 Feb 2010 00:40:40 -0600
Message-ID: <201002130040.40927.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7833475122036999412==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Everyone,

It is Friday the 13th, but there's nothing scary in the announcement, I =

promise :)

So oFono has had support for HFP Client profile role since late last year, =
but =

it hasn't been properly integrated with BlueZ until now.  Starting with oFo=
no =

release 0.18 oFono fully integrates Bluetooth HFP client with cooperation f=
rom =

BlueZ.  Currently implemented features include:
	- Audio support
	- Simple incoming and outgoing calls
	- Three way calls, call waiting and call hold
	- Multiparty calls
	- Network status reporting
	- Speaker / microphone volume control

This support depends on BlueZ release 4.61 or later and DBus 1.3.  The latt=
er =

is required for file-descriptor passing support.

We have been testing extensively over the last several months, but I'm sure=
 we =

haven't found all the issues.  I'd like everyone interested to give it a tr=
y =

with their mobile phone and let us know what works and what doesn't.

Big thanks to everyone involved in oFono, BlueZ and PulseAudio projects.  I=
n =

particular kudos to Gustavo Padovan and Jo=C3=A3o Paulo Rechi Vita from Pro=
FUSION =

who did much of the integration work in BlueZ and oFono.  Kudos also to =

Zhenhua Zhang from Intel for implementing big chunks of the HFP call state =

flows and for his early prototyping work.

If you're interested in learning more, see http://profusion.mobi/node/21.

Regards,
-Denis

--===============7833475122036999412==--

