Content-Type: multipart/mixed; boundary="===============1948574407968190222=="
MIME-Version: 1.0
From: August Mayer <august.mayer@hale.at>
Subject: GPRS re-connect problem
Date: Thu, 21 Jun 2012 12:51:49 +0200
Message-ID: <4FE2FCC5.3010008@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1948574407968190222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

When connecting again to GPRS / PPP, after an Internet connection has =

been closed previously, the connection seems to fail. It looks like the =

ofono_modem serial data channel is completely closed when a PPP =

connection is shut down. I'm using a Telit Modem, which provides several =

serial ports, and am right now using separate serials for the AT chat =

and the data/PPP; for this reason, the AT chat continues working, but =

the data channel is dead.

My question is, is it somehow necessary to re-initialise the modem data =

serial channel after a PPP connection? Or could there be a conceptual =

problem that I have overlooked?

Many thanks & greetings       August


--
Scanned by MailScanner.


--===============1948574407968190222==--

