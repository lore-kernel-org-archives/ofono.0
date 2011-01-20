Content-Type: multipart/mixed; boundary="===============0468215309491796362=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: oFono exits on new voicecall with disconnected system bus
Date: Thu, 20 Jan 2011 15:55:51 +0100
Message-ID: <1295535351.3873.294.camel@aeonflux>
In-Reply-To: <AANLkTimkw+axiW_5=FiiTeu0AS2C0M74kroGui789mWs@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0468215309491796362==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicola,

> that's happen with oFono 0.38 on freerunner with debian sid on the
> first incoming/outgoing call:
> =

> ofonod[6232]: drivers/calypsomodem/voicecall.c:cpi_notify() id:1,
> msgtype:0, direction:1, mode:0
> ofonod[6232]: drivers/calypsomodem/voicecall.c:cpi_notify() Len > 0
> ofonod[6232]: drivers/calypsomodem/voicecall.c:cpi_notify() type obtained
> ofonod[6232]: drivers/calypsomodem/voicecall.c:cpi_notify()
> num:+xxxxxxxxxxxx, type:145
> ofonod[6232]: drivers/calypsomodem/voicecall.c:cpi_notify() cause:892800,=
 line:0
> ofonod[6232]: src/voicecall.c:ofono_voicecall_notify() Got a voicecall
> event, status: 4, id: 1, number: +xxxxxxxxxxx
> ofonod[6232]: src/voicecall.c:ofono_voicecall_notify() Did not find a
> call with id: 1
> ofonod[6232]: System bus has disconnected!

this happens if something in a D-Bus message is corrupted and the D-Bus
daemon complains. The result is that it kicks us off the bus.

You need to track down which D-Bus API call causes this. Wild assumption
is that it is either a wrong message parameter or an invalid object
path.

Regards

Marcel



--===============0468215309491796362==--

