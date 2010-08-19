Content-Type: multipart/mixed; boundary="===============4047850575034541616=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH 1/3] mbm: fix initial polling for sim
Date: Thu, 19 Aug 2010 17:49:18 +0300
Message-ID: <AANLkTikOtDojsgSLXYbXaC+Riq3O-VuNKdaACm=9c_oY@mail.gmail.com>
In-Reply-To: <AANLkTi=Ax00HcTWahQGKe+N+djKVqrN+FhnoKsKrXwRj@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4047850575034541616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel and Sjur,

> > There seems to be no specific error codes returned when SIM is missing.=
 Poll
> > at least 5 times upon an error and give up after that.
> > ---
> >  plugins/mbm.c |    8 +++-----
> >  1 files changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/plugins/mbm.c b/plugins/mbm.c
> > index 6f71553..bebf5aa 100644
> > --- a/plugins/mbm.c
> > +++ b/plugins/mbm.c
> > @@ -108,10 +108,8 @@ static void simpin_check(gboolean ok, GAtResult *r=
esult, gpointer user_data)
> >
> >     DBG("");
> >
> > -   /* Modem returns +CME ERROR: 10 if SIM is not ready. */
> > -   if (!ok && result->final_or_pdu &&
> > -                   !strcmp(result->final_or_pdu, "+CME ERROR: 10") &&
> > -                   data->cpin_poll_count++ < 5) {
> > +   /* Modem returns an error if SIM is not ready. */
> > +   if (!ok && data->cpin_poll_count++ < 5) {
> >             data->cpin_poll_source =3D
> >                     g_timeout_add_seconds(1, init_simpin_check, modem);
>
> maybe the STE modem is a bit more specific here than the MBM one. Which
> MBM modem did you test this with?

I've been testing with F3507g, branded as Dell 5530.

The existing mbm sim detection logic is based on my earlier tests
without connman. It worked when I manually called test/enable-modem.

When using ofono with connman, the modem gets powered immediately after
it gets configured by kernel. Sometimes mbm seems to be still in the middle=
 of
its initialization when ofono tries to enable it.

--Pekka

-- =

Pekka.Pessi mail at nokia.com

--===============4047850575034541616==--

