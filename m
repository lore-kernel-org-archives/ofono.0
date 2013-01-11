Content-Type: multipart/mixed; boundary="===============0240499207418037660=="
MIME-Version: 1.0
From: Cornel Spinu <cornel.spinu@gmail.com>
Subject: AT command to modem via ofono from 3rd party
Date: Fri, 11 Jan 2013 12:08:57 +0200
Message-ID: <50EFE4B9.6050305@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0240499207418037660==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I'm using an cinterion modem, and I wanna send AT commands directly to =

the app port from a 3rd party application.
I am considering exposing my own method on dBus. The problem is that =

from the dbus layer, I do not have access to the low-level part.
As far as I noticed, the only place I have access to the modem and app =

port, is in plugins/ . The fact that I wanna expose a new method
on org.ofono.Modem, which is in src/modem.c , I do not see a way how I =

can connect those two. I'm looking for any suggestions if
anyone can help.

Thank you,
Cornel Spinu

--===============0240499207418037660==--

