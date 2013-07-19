Content-Type: multipart/mixed; boundary="===============2252781113018645063=="
MIME-Version: 1.0
From: Viallard Anthony <viallard@syscom-instruments.com>
Subject: SIMCOM support
Date: Fri, 19 Jul 2013 15:33:13 +0200
Message-ID: <51E94019.7060604@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2252781113018645063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello folks,

I cleaned my work on the SIMCOM plugin according to Denis' suggestions =

and add some new quirks. The patches will follow this mail.

Moreover, I have two new questions:

  - In my patches, I had to add a function in src/network.c to be able =

to report a new network technology. I was surprised that the function =

didn't exist. Maybe there are an other mecanism which I didn't see to =

change the network technology and send the dbus signal ?
  - I see in mail sent by Jesper Larsen a patch about configuration of =

the serial port. The patch adds the option "Read" to "on". I didn't =

understand the behaviour of this option. What do this option make ?

Have a good holidays,

Regards,
Anthony V.

-- =

-----------------------------------------
Viallard Anthony    (+41 024 455 24 82)
[ Embedded System | Software Designer ]
-----------------------------------------
   Syscom Instruments SA
   Rue de l'industrie 21
   1450     Sainte-Croix
-----------------------------------------

--===============2252781113018645063==--

