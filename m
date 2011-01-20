Content-Type: multipart/mixed; boundary="===============1712407565112793876=="
MIME-Version: 1.0
From: Nicola Mfb <nicola.mfb@gmail.com>
Subject: oFono exits on new voicecall with disconnected system bus
Date: Thu, 20 Jan 2011 15:51:52 +0100
Message-ID: <AANLkTimkw+axiW_5=FiiTeu0AS2C0M74kroGui789mWs@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1712407565112793876==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!
that's happen with oFono 0.38 on freerunner with debian sid on the
first incoming/outgoing call:

ofonod[6232]: drivers/calypsomodem/voicecall.c:cpi_notify() id:1,
msgtype:0, direction:1, mode:0
ofonod[6232]: drivers/calypsomodem/voicecall.c:cpi_notify() Len > 0
ofonod[6232]: drivers/calypsomodem/voicecall.c:cpi_notify() type obtained
ofonod[6232]: drivers/calypsomodem/voicecall.c:cpi_notify()
num:+xxxxxxxxxxxx, type:145
ofonod[6232]: drivers/calypsomodem/voicecall.c:cpi_notify() cause:892800, l=
ine:0
ofonod[6232]: src/voicecall.c:ofono_voicecall_notify() Got a voicecall
event, status: 4, id: 1, number: +xxxxxxxxxxx
ofonod[6232]: src/voicecall.c:ofono_voicecall_notify() Did not find a
call with id: 1
ofonod[6232]: System bus has disconnected!

Sometimes (about 1 of 10) oFono runs fine and survives to multiple voice ca=
lls.

Any suggestion?

Regards

    Niko

--===============1712407565112793876==--

