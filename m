Content-Type: multipart/mixed; boundary="===============5980513504072479463=="
MIME-Version: 1.0
From: santaroga76@googlemail.com
Subject: Help/Info needed how to run Ofono with Quectel EC25 (Qualcomm MSM
 9x70)
Date: Wed, 04 Dec 2019 11:14:06 +0000
Message-ID: <20191204111406.2883.76116@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5980513504072479463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I want to use the EC25 with oFono (tested using ofono 1.21 and 1.30). After=
 enabling the modem, unlocking the SIM and putting the modem online it is p=
ossible to send SMS and many other things are working too. The DBus interfa=
ces/objects are available, but there are some few problems I am facing and =
need any help/advice:

1. It is not possible to dial voice call (org.ofono.VoiceCallManager.Dial("=
SOME_NUMBER", "default")) ends up always with "Error.NotImplemented"

2. The "org.ofono.LocationReporting" does not appear at all

These two problems are currently the most serious for our application, plea=
se help (if any).

Thanks a LOT!
--===============5980513504072479463==--

