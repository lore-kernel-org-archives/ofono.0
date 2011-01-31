Content-Type: multipart/mixed; boundary="===============9169844658859109464=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH] atmodem: implement standard PIN retries
Date: Mon, 31 Jan 2011 15:22:04 +0200
Message-ID: <201101311522.05246.remi.denis-courmont@nokia.com>
In-Reply-To: <1296478790.1520.212.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9169844658859109464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Monday 31 January 2011 14:59:50 ext Marcel Holtmann, you wrote:
> Hi Remi,
> =

> >  drivers/atmodem/sim.c |   48
> >  ++++++++++++++++++++++++++++++++++++++++++++++++ 1 files changed, 48
> >  insertions(+), 0 deletions(-)
> > =

> > diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
> > index 0938998..dfd40f8 100644
> > --- a/drivers/atmodem/sim.c
> > +++ b/drivers/atmodem/sim.c
> > @@ -57,6 +57,7 @@ static const char *cpin_prefix[] =3D { "+CPIN:", NULL=
 };
> > =

> >  static const char *clck_prefix[] =3D { "+CLCK:", NULL };
> >  static const char *huawei_cpin_prefix[] =3D { "^CPIN:", NULL };
> >  static const char *xpincnt_prefix[] =3D { "+XPINCNT:", NULL };
> > =

> > +static const char *cpinr_prefixes[] =3D { "+CPINR:", "+CPINRE:", NULL =
};
> =

> if you are not processing +CPINRE, why bother consuming it in the first
> place?

So that they're not misinterpreted as unsolicited responses.

> >  static const char *none_prefix[] =3D { NULL };
> >  =

> >  static void at_crsm_info_cb(gboolean ok, GAtResult *result, gpointer
> >  user_data)
> > =


> > @@ -577,6 +622,9 @@ static void at_pin_retries_query(struct ofono_sim
> > *sim,
> > =

> >  		break;
> >  	=

> >  	default:
> > +		if (g_at_chat_send(sd->chat, "AT+CPINR", cpinr_prefixes,
> > +					at_cpinr_cb, cbd, g_free) > 0)
> > +			return;
> =

> since this command is pretty new, don't we need to check if it is
> supported? Is there any impact not checking it?

This will just defer the (failure) callback until the ERROR response.

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============9169844658859109464==--

