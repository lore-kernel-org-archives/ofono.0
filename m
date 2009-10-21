Content-Type: multipart/mixed; boundary="===============2474252981176855281=="
MIME-Version: 1.0
From: Ryan Raasch <ryan.raasch@gmail.com>
Subject: Extend modem.conf
Date: Wed, 21 Oct 2009 10:52:52 +0200
Message-ID: <4ADECBE4.1060500@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2474252981176855281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I was wanting to extend the syntax of the modem.conf file. It is extra =

work to maintain a different plugin file for each generic AT modem with =

a different speed, serial settings.

I'm not sure on the best syntax for this. Maybe below could be a solution.

[generic]
Driver=3Datgen
Device=3D/dev/ttyS0:baud=3D115200:read=3Don:local:on


OR

[generic]
Driver=3Datgen
Device=3D/dev/ttyS0
DeviceOpts=3Dbaud=3D115200:read=3Don:local:on


Any opinions?


Also, shouldn't the "Driver" keyword in the file be named "Plugin" =

instead? It may give a better indication where to read in the source.


Greetings,
Ryan




--===============2474252981176855281==--

