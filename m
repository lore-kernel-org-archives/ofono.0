Content-Type: multipart/mixed; boundary="===============1214019724915384544=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH 1/1] emit settings signal before active signal
Date: Mon, 23 Nov 2009 09:09:03 +0100
Message-ID: <1258963743.2993.15.camel@violet>
In-Reply-To: <9F0C1DB20AFA954FA1DA05309350433D8C09E071@pdsmsx503.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1214019724915384544==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

> > > ---
> > >  src/gprs.c |   13 +++++++------
> > >  1 files changed, 7 insertions(+), 6 deletions(-)
> > =

> > quick question on why? I did remember that Denis and I talked about on
> > IRC, but I forgot what our conclusion on the order of these two signals
> > was. We should really document this. Do you remember? And please prepare
> > a patch that also puts a comment about this in the API documentation.
> I can find below log
> =

> (2:02:38 AM) holtmann: Not sure if we need the Settings empty, but for co=
mpletion it makes sense.
> (2:03:05 AM) holtmann: We might wanna emit the Settings empty before Acti=
vated false, so that ConnMan can clean up the interface before it goes away.
> (2:03:27 AM) denkenz: What's the difference?
> (2:03:54 AM) denkenz: strictly speaking we shouldn't even bother for empt=
y settings
> (2:04:05 AM) denkenz: useless signal anyway
> (2:04:13 AM) holtmann: Yeah. Just easier for some code path in ConnMan.
>  (2:04:49 AM) denkenz: holtmann: ok, that's simple enough anyway
> =

> I cannot find the conclusion on active TRUE order. But I think it should =
the same with active FALSE. =

> So ConnMan can setup interface before set network connected.

sounds good enough for me. Patch has been applied.

However please submit a patch that updates the documentation with the
details about the signal order.

Regards

Marcel



--===============1214019724915384544==--

