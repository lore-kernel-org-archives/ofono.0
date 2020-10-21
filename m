Content-Type: multipart/mixed; boundary="===============0625456901878649087=="
MIME-Version: 1.0
From: Louis Rannou <louis@enlaps.fr>
Subject: Using GPS on sim7600
Date: Wed, 21 Oct 2020 11:42:47 +0200
Message-ID: <359756dc-4227-db6c-0655-2474a2661871@enlaps.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0625456901878649087==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I am using a sim7600 with its evaluation kit.

To make the GPS work, I need to send the command AT+CGPS=3D1. What I can =

do is just open the AT port and send the command. But maybe it should be =

managed by ofono ? In that case, should I make another plugin, or should =

it be included in location reporting ?

By the way, I have no org.ofono.LocationReporting in my dbus interface.

Thanks,
Louis

--===============0625456901878649087==--

