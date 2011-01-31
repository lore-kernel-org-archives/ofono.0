Content-Type: multipart/mixed; boundary="===============6147305657442025145=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] atmodem: implement standard PIN retries
Date: Mon, 31 Jan 2011 14:30:18 +0100
Message-ID: <1296480618.1520.214.camel@aeonflux>
In-Reply-To: <201101311522.05246.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6147305657442025145==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > >  drivers/atmodem/sim.c |   48
> > >  ++++++++++++++++++++++++++++++++++++++++++++++++ 1 files changed, 48
> > >  insertions(+), 0 deletions(-)
> > > =

> > > diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
> > > index 0938998..dfd40f8 100644
> > > --- a/drivers/atmodem/sim.c
> > > +++ b/drivers/atmodem/sim.c
> > > @@ -57,6 +57,7 @@ static const char *cpin_prefix[] =3D { "+CPIN:", NU=
LL };
> > > =

> > >  static const char *clck_prefix[] =3D { "+CLCK:", NULL };
> > >  static const char *huawei_cpin_prefix[] =3D { "^CPIN:", NULL };
> > >  static const char *xpincnt_prefix[] =3D { "+XPINCNT:", NULL };
> > > =

> > > +static const char *cpinr_prefixes[] =3D { "+CPINR:", "+CPINRE:", NUL=
L };
> > =

> > if you are not processing +CPINRE, why bother consuming it in the first
> > place?
> =

> So that they're not misinterpreted as unsolicited responses.

they would be. Do you care?

> > >  static const char *none_prefix[] =3D { NULL };
> > >  =

> > >  static void at_crsm_info_cb(gboolean ok, GAtResult *result, gpointer
> > >  user_data)
> > > =

> =

> > > @@ -577,6 +622,9 @@ static void at_pin_retries_query(struct ofono_sim
> > > *sim,
> > > =

> > >  		break;
> > >  	=

> > >  	default:
> > > +		if (g_at_chat_send(sd->chat, "AT+CPINR", cpinr_prefixes,
> > > +					at_cpinr_cb, cbd, g_free) > 0)
> > > +			return;
> > =

> > since this command is pretty new, don't we need to check if it is
> > supported? Is there any impact not checking it?
> =

> This will just defer the (failure) callback until the ERROR response.

Okay. If there is no impact here I am fine with it.

Regards

Marcel




--===============6147305657442025145==--

