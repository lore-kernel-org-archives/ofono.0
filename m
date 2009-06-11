Content-Type: multipart/mixed; boundary="===============6352474169618876293=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: MNC/MCC as string?
Date: Thu, 11 Jun 2009 20:10:27 +0200
Message-ID: <1244743827.27363.53.camel@violet>
In-Reply-To: <a26fd138dc308308288592371b2202e2@localhost>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6352474169618876293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > About the only thing that MCC/MNC is useful for is to display it during
> > manual =

> > operator selection.  =

> =

> That's not true. In fact, I'd say manual operator selection is just about
> the last
> place where the codes should be displayed.
> =

> > MCC/MNC is not helpful at all for countries like U.S. =

> > with 4+ timezones and the same carrier id across all of them.  A countr=
y =

> > property would work just as well for this.  =

> =

> For geolocation help, sure, but there are other places where MNC/MCC are
> used as keys to databases containing operator-specific information, like
> default Internet APN names and such.

shouldn't we just integrate that database into oFono directly or as
something like ofono-info.git that will be installed along with (for
easier updates).

I know we need this database and mobilebroadband-providerinfo or similar
project is doing this already.

Regards

Marcel



--===============6352474169618876293==--

