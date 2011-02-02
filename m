Content-Type: multipart/mixed; boundary="===============4988377330366508712=="
MIME-Version: 1.0
From: Predon, Frederic <frederic.predon@intel.com>
Subject: RE: [PATCH] ifx: remove setting to offline during modem enable
Date: Wed, 02 Feb 2011 17:41:50 +0000
Message-ID: <8250E4885F9967469CAC3FB5CBA2CE69934F1C5FEF@irsmsx501.ger.corp.intel.com>
In-Reply-To: <1296665720.1520.333.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4988377330366508712==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,


> >  plugins/ifx.c |   21 ++-------------------
> >  1 files changed, 2 insertions(+), 19 deletions(-)
> >
> > diff --git a/plugins/ifx.c b/plugins/ifx.c
> > index 411c012..ae53193 100644
> > --- a/plugins/ifx.c
> > +++ b/plugins/ifx.c
> > @@ -345,23 +345,6 @@ error:
> >  	ofono_modem_set_powered(modem, FALSE);
> >  }
> >
> > -static void cfun_enable(gboolean ok, GAtResult *result, gpointer
> user_data)
> > -{
> > -	struct ofono_modem *modem =3D user_data;
> > -	struct ifx_data *data =3D ofono_modem_get_data(modem);
> > -
> > -	DBG("");
> > -
> > -	if (!ok) {
> > -		shutdown_device(data);
> > -		ofono_modem_set_powered(modem, FALSE);
> > -		return;
> > -	}
> > -
> > -	g_at_chat_send(data->dlcs[AUX_DLC], "AT+XGENDATA", NULL,
> > -					xgendata_query, modem, NULL);
> > -}
> > -
> >  static gboolean dlc_setup(gpointer user_data)
> >  {
> >  	struct ofono_modem *modem =3D user_data;
> > @@ -378,8 +361,8 @@ static gboolean dlc_setup(gpointer user_data)
> >  	g_at_chat_set_slave(data->dlcs[GPRS2_DLC], data-
> >dlcs[NETREG_DLC]);
> >  	g_at_chat_set_slave(data->dlcs[GPRS3_DLC], data-
> >dlcs[NETREG_DLC]);
> >
> > -	g_at_chat_send(data->dlcs[AUX_DLC], "AT+CFUN=3D4", NULL,
> > -					cfun_enable, modem, NULL);
> > +	g_at_chat_send(data->dlcs[AUX_DLC], "AT+XGENDATA", NULL,
> > +					xgendata_query, modem, NULL);
> =

> I toughth we talked about CFUN=3D4 in ifx_disable on IRC. This one is
> needed to bring the modem up in offline mode. I'd rather not remove
> this
> one.

In a ideal world, the CFUN=3D4 in the dlc_setup will not be needed because =
the modem remembers is last state and will remain in offline mode because w=
e have sent CFUN=3D4 in the ifx_disable function.
But, we could have some error cases where we are not able to send this comm=
and anymore because of modem crash or SPI broken, etc..  so we might have t=
o keep the forced CFUN=3D4 in the dlc_setup

Regards

Fred
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============4988377330366508712==--

