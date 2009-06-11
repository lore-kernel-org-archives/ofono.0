Content-Type: multipart/mixed; boundary="===============3761793738812526119=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: MNC/MCC as string?
Date: Thu, 11 Jun 2009 13:24:16 -0500
Message-ID: <200906111324.16685.denkenz@gmail.com>
In-Reply-To: <a26fd138dc308308288592371b2202e2@localhost>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3761793738812526119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Aki,

On Thursday 11 June 2009 13:00:48 Aki Niemi wrote:
> On Thu, 11 Jun 2009 09:32:38 -0500, Denis Kenzior <denkenz@gmail.com>
>
> wrote:
> > About the only thing that MCC/MNC is useful for is to display it during
> > manual
> > operator selection.
>
> That's not true. In fact, I'd say manual operator selection is just about
> the last
> place where the codes should be displayed.

The point is MCCMNC is not something the user should realy be exposed to.  =
It =

is useful to dis-ambiguate the carrier by Country when you're in a border =

area, but that is about it. Country property can do this just as well.

>
> > MCC/MNC is not helpful at all for countries like U.S.
> > with 4+ timezones and the same carrier id across all of them.  A country
> > property would work just as well for this.
>
> For geolocation help, sure, but there are other places where MNC/MCC are
> used as keys to databases containing operator-specific information, like
> default Internet APN names and such.
>

Then lets design this into oFono instead of exposing an obscure attribute.

Regards,
-Denis

--===============3761793738812526119==--

