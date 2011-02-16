Content-Type: multipart/mixed; boundary="===============8037987950595309852=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] gprs:Add code to handle AT+CGDCONT
Date: Tue, 15 Feb 2011 22:50:16 -0800
Message-ID: <1297839016.2519.14.camel@aeonflux>
In-Reply-To: <4D5B6F6B.9030805@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8037987950595309852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > ---
> >  include/gprs.h |    2 +
> >  src/gprs.c     |   63 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  2 files changed, 65 insertions(+), 0 deletions(-)
> > =

> =

> So I went in a slightly different direction with the emulator API.  Can
> you please have a look?
> =

> Also, I'd really rather hold off trying to implement CGDCONT right now.
>  That piece is quite nasty and generally of lower priority.  I'd like to
> get the emulator a bit more hashed out first and implement the base BT
> DUN & BT HFP profiles.

for the sake of testing, I would be fine with the real basic CGDCONT and
just offering IP and CID 1. And then of course accepting any APN in that
range and rejecting any other command.

Regards

Marcel



--===============8037987950595309852==--

