Content-Type: multipart/mixed; boundary="===============6491907688091461595=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH] ifx: remove setting to offline during modem enable
Date: Wed, 02 Feb 2011 19:07:48 +0100
Message-ID: <1296670068.1520.335.camel@aeonflux>
In-Reply-To: <8250E4885F9967469CAC3FB5CBA2CE69934F1C5FEF@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6491907688091461595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fred,

> > >  plugins/ifx.c |   21 ++-------------------
> > >  1 files changed, 2 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/plugins/ifx.c b/plugins/ifx.c
> > > index 411c012..ae53193 100644
> > > --- a/plugins/ifx.c
> > > +++ b/plugins/ifx.c
> > > @@ -345,23 +345,6 @@ error:
> > >  	ofono_modem_set_powered(modem, FALSE);
> > >  }
> > >
> > > -static void cfun_enable(gboolean ok, GAtResult *result, gpointer
> > user_data)
> > > -{
> > > -	struct ofono_modem *modem =3D user_data;
> > > -	struct ifx_data *data =3D ofono_modem_get_data(modem);
> > > -
> > > -	DBG("");
> > > -
> > > -	if (!ok) {
> > > -		shutdown_device(data);
> > > -		ofono_modem_set_powered(modem, FALSE);
> > > -		return;
> > > -	}
> > > -
> > > -	g_at_chat_send(data->dlcs[AUX_DLC], "AT+XGENDATA", NULL,
> > > -					xgendata_query, modem, NULL);
> > > -}
> > > -
> > >  static gboolean dlc_setup(gpointer user_data)
> > >  {
> > >  	struct ofono_modem *modem =3D user_data;
> > > @@ -378,8 +361,8 @@ static gboolean dlc_setup(gpointer user_data)
> > >  	g_at_chat_set_slave(data->dlcs[GPRS2_DLC], data-
> > >dlcs[NETREG_DLC]);
> > >  	g_at_chat_set_slave(data->dlcs[GPRS3_DLC], data-
> > >dlcs[NETREG_DLC]);
> > >
> > > -	g_at_chat_send(data->dlcs[AUX_DLC], "AT+CFUN=3D4", NULL,
> > > -					cfun_enable, modem, NULL);
> > > +	g_at_chat_send(data->dlcs[AUX_DLC], "AT+XGENDATA", NULL,
> > > +					xgendata_query, modem, NULL);
> > =

> > I toughth we talked about CFUN=3D4 in ifx_disable on IRC. This one is
> > needed to bring the modem up in offline mode. I'd rather not remove
> > this
> > one.
> =

> In a ideal world, the CFUN=3D4 in the dlc_setup will not be needed becaus=
e the modem remembers is last state and will remain in offline mode because=
 we have sent CFUN=3D4 in the ifx_disable function.
> But, we could have some error cases where we are not able to send this co=
mmand anymore because of modem crash or SPI broken, etc..  so we might have=
 to keep the forced CFUN=3D4 in the dlc_setup

I agree. I do wanna keep the CFUN=3D4 in ifx_enable() to make the sure the
modem is in init state and offline.

Jeevaka and I discussed on IRC, or at least what I thought we
discussed ;), using CFUN=3D0 in ifx_disable().

Regards

Marcel




--===============6491907688091461595==--

