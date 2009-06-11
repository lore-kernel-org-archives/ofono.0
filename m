Content-Type: multipart/mixed; boundary="===============7636865810768046474=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: MNC/MCC as string?
Date: Thu, 11 Jun 2009 22:35:58 +0200
Message-ID: <1244752558.27363.69.camel@violet>
In-Reply-To: <a661a52193386f37e83d540de4099e6a@localhost>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7636865810768046474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> >> For geolocation help, sure, but there are other places where MNC/MCC a=
re
> >> used as keys to databases containing operator-specific information, li=
ke
> >> default Internet APN names and such.
> > =

> > shouldn't we just integrate that database into oFono directly or as
> > something like ofono-info.git that will be installed along with (for
> > easier updates).
> =

> This particular database of default APN names, maybe, although I think it=
's
> really oFono users like Connman that should integrate with that
> information. =

> =

> However, this wouldn't be the only database ever, so we would still need a
> way to reliably identify a specific operator.

I agree that there might be at some point a need for it, but what I
question is the need for it right now. Do we have direct users in
userspace that can make use of this information? Giving them directly to
the user makes no sense.

Regards

Marcel



--===============7636865810768046474==--

