Content-Type: multipart/mixed; boundary="===============8289666999443775882=="
MIME-Version: 1.0
From: Matthias Apitz <guru@unixarea.de>
Subject: Re: [Gta04-owner] Polling CLCC error handling on Option modem (GTA04)
Date: Wed, 07 Mar 2012 10:48:07 +0000
Message-ID: <20120307104746.GA1221@tiny>
In-Reply-To: <201203071136.24508.psonek2@seznam.cz>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8289666999443775882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

El d=C3=ADa Wednesday, March 07, 2012 a las 11:36:24AM +0100, Radek Polak e=
scribi=C3=B3:

> On Monday 05 March 2012 20:26:29 Denis Kenzior wrote:
> =

> > You can always try ignoring CME ERROR 100 and re-try the CLCC poll.
> > Maybe the modem is in a transitional period (e.g. call being released)
> > and it can't answer the CLCC properly.  In other words, there's a bug
> > related to timing of call state changes & CLCC implementation in the
> > modem firmware.
> =

> Yes, it is definitely timing bug. Attached is patch that continues CLCC p=
olling =

> even after error assuming that CLCC will start working again. It works fi=
ne for =

> me (see log below). It would be nice to get this in ofono git.
> =

> ofonod[1188]: App: < \r\n+CLCC: 1,1,4,0,0,"+420608828973",145\r\n\r\nOK\r=
\n
> ofonod[1188]: App: > AT+CLCC\r
> ofonod[1188]: App: < \r\n+CME ERROR: 100\r\n
> ofonod[1188]: We are polling CLCC and received an error, retrying...
> ofonod[1188]: App: > AT+CLCC\r
> ofonod[1188]: App: < \r\nOK\r\n
> ofonod[1188]: src/voicecall.c:ofono_voicecall_disconnected() Got disconne=
ction =

> event for id: 1, reason: 2

I'm wondering if this ofonod log has no timestamps in the log lines? Or
is this something to be configured?

	matthias
-- =

Matthias Apitz
e <guru@unixarea.de> - w http://www.unixarea.de/
UNIX since V7 on PDP-11, UNIX on mainframe since ESER 1055 (IBM /370)
UNIX on x86 since SVR4.2 UnixWare 2.1.2, FreeBSD since 2.2.5

--===============8289666999443775882==--

