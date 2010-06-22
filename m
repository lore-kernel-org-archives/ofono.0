Content-Type: multipart/mixed; boundary="===============7453419444301836630=="
MIME-Version: 1.0
From: Benoit Monin <benoit.monin@laposte.net>
Subject: Option (hso) modem and PAP
Date: Tue, 22 Jun 2010 09:14:41 +0000
Message-ID: <25118539.98442.1277198076995.JavaMail.www@wwinf8402>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7453419444301836630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi,

I have been trying an Option modem with ofono recently.
It took me a while to establish a connection because the APN
we're using needs a username and password. Apparently Option
swapped the username and password of the AT command AT$QCPDPP.

Also, it seems that some other Option modem uses AT_OPDPP
instead of AT$QCPDPP, see http://www.pharscape.org/Quicksilver.html

I'll send two patches in reply to this message. The first one
adds username and password optional parameters to
test/create-context. And the second one swaps username and
password for hso modem in PAP mode.

Beno=C3=AEt.

--





Une messagerie gratuite, garantie =C3=A0 vie et des services en plus, =C3=
=A7a vous tente ?
Je cr=C3=A9e ma bo=C3=AEte mail www.laposte.net


--===============7453419444301836630==--

