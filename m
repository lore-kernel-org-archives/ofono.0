Content-Type: multipart/mixed; boundary="===============5206471623137521554=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Gta04-owner] Polling CLCC error handling on Option modem (GTA04)
Date: Wed, 07 Mar 2012 11:09:31 -0800
Message-ID: <1331147371.3392.179.camel@aeonflux>
In-Reply-To: <20120307104746.GA1221@tiny>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5206471623137521554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matthias,

> > > You can always try ignoring CME ERROR 100 and re-try the CLCC poll.
> > > Maybe the modem is in a transitional period (e.g. call being released)
> > > and it can't answer the CLCC properly.  In other words, there's a bug
> > > related to timing of call state changes & CLCC implementation in the
> > > modem firmware.
> > =

> > Yes, it is definitely timing bug. Attached is patch that continues CLCC=
 polling =

> > even after error assuming that CLCC will start working again. It works =
fine for =

> > me (see log below). It would be nice to get this in ofono git.
> > =

> > ofonod[1188]: App: < \r\n+CLCC: 1,1,4,0,0,"+420608828973",145\r\n\r\nOK=
\r\n
> > ofonod[1188]: App: > AT+CLCC\r
> > ofonod[1188]: App: < \r\n+CME ERROR: 100\r\n
> > ofonod[1188]: We are polling CLCC and received an error, retrying...
> > ofonod[1188]: App: > AT+CLCC\r
> > ofonod[1188]: App: < \r\nOK\r\n
> > ofonod[1188]: src/voicecall.c:ofono_voicecall_disconnected() Got discon=
nection =

> > event for id: 1, reason: 2
> =

> I'm wondering if this ofonod log has no timestamps in the log lines? Or
> is this something to be configured?

the output also goes to syslog and there you have timestamps.

Regards

Marcel



--===============5206471623137521554==--

