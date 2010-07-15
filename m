Content-Type: multipart/mixed; boundary="===============5036681468271176328=="
MIME-Version: 1.0
From: Nicola Mfb <nicola.mfb@gmail.com>
Subject: Error sending DTMF with calypso
Date: Thu, 15 Jul 2010 04:03:17 +0200
Message-ID: <AANLkTil4AMwD5v6V_SGtSlXyHgpeMpnsgYhlSzz2TjEm@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5036681468271176328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!
I tried SendTones with calypso during an active call but it failed (v0.22):

ofonod[259]: DLC0: > AT\r
ofonod[259]: DLC0: < \r\nOK\r\n
ofonod[259]: DLC0: Finally woke up the modem
ofonod[259]: DLC0: > AT+VTS=3D"1"\r
ofonod[259]: DLC0: < \r\nERROR\r\n
ofonod[259]: src/voicecall.c:generic_callback() command failed with
error: Unknown error type

Am I missing somethings?

    Niko

--===============5036681468271176328==--

