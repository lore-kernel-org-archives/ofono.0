Content-Type: multipart/mixed; boundary="===============5646414654140366140=="
MIME-Version: 1.0
From: Xu, Martin <martin.xu@intel.com>
Subject: RE: [PATCH 1/1] emit settings signal before active signal
Date: Mon, 23 Nov 2009 13:06:11 +0800
Message-ID: <9F0C1DB20AFA954FA1DA05309350433D8C09E071@pdsmsx503.ccr.corp.intel.com>
In-Reply-To: <1258827261.22343.28.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5646414654140366140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel:
> -----Original Message-----
> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beh=
alf
> Of Marcel Holtmann
> Sent: Sunday, November 22, 2009 2:14 AM
> To: ofono(a)ofono.org
> Subject: Re: [PATCH 1/1] emit settings signal before active signal
> =

> Hi Martin
> =

> > ---
> >  src/gprs.c |   13 +++++++------
> >  1 files changed, 7 insertions(+), 6 deletions(-)
> =

> quick question on why? I did remember that Denis and I talked about on
> IRC, but I forgot what our conclusion on the order of these two signals
> was. We should really document this. Do you remember? And please prepare
> a patch that also puts a comment about this in the API documentation.
I can find below log

(2:02:38 AM) holtmann: Not sure if we need the Settings empty, but for comp=
letion it makes sense.
(2:03:05 AM) holtmann: We might wanna emit the Settings empty before Activa=
ted false, so that ConnMan can clean up the interface before it goes away.
(2:03:27 AM) denkenz: What's the difference?
(2:03:54 AM) denkenz: strictly speaking we shouldn't even bother for empty =
settings
(2:04:05 AM) denkenz: useless signal anyway
(2:04:13 AM) holtmann: Yeah. Just easier for some code path in ConnMan.
 (2:04:49 AM) denkenz: holtmann: ok, that's simple enough anyway

I cannot find the conclusion on active TRUE order. But I think it should th=
e same with active FALSE. =

So ConnMan can setup interface before set network connected.

--===============5646414654140366140==--

