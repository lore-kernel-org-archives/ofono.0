Content-Type: multipart/mixed; boundary="===============2189989083656144054=="
MIME-Version: 1.0
From: Rafael Ignacio Zurita <rafael.zurita@profusion.mobi>
Subject: Re: [PATCH 6/8] plugins: add gps atom to mbm
Date: Mon, 27 Dec 2010 07:17:09 -0300
Message-ID: <20101227101709.GA2781@nodo3>
In-Reply-To: <4D12749D.3090103@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2189989083656144054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, Dec 22, 2010 at 03:58:53PM -0600, Denis Kenzior wrote:
> Hi Rafael,
> =

> >  =

> > -	if (modem_dev =3D=3D NULL || data_dev =3D=3D NULL)
> > +	if (modem_dev =3D=3D NULL || data_dev =3D=3D NULL || gps_dev =3D=3D N=
ULL)
> >  		return -EINVAL;
> =

> I don't think that failing because the gps device isn't set is such a
> good idea.  There might be mbm cards without a gps node.  Let udev
> autodetection handle this part.

Okey.

> >  =

> >  	data->modem_port =3D create_port(modem_dev);
> > @@ -383,6 +389,20 @@ static int mbm_enable(struct ofono_modem *modem)
> >  	if (getenv("OFONO_AT_DEBUG"))
> >  		g_at_chat_set_debug(data->data_port, mbm_debug, "Data: ");
> >  =

> > +	data->gps_port =3D create_port(gps_dev);
> > +	if (data->gps_port =3D=3D NULL) {
> > +		g_at_chat_unref(data->data_port);
> > +		data->data_port =3D NULL;
> > +
> > +		g_at_chat_unref(data->modem_port);
> > +		data->modem_port =3D NULL;
> > +
> > +		return -EIO;
> > +	}
> =

> So from what I understand we have to send AT*E2GPSNPD to the GPS port in
> order to turn it from a regular AT command port into a GPS port.  At
> this point this port is no longer usable for AT commands.  Right?

Yes, you are right. From what I read the only way for freeing this port wou=
ld
be reseting the whole module.

> > +
> > +	if (getenv("OFONO_AT_DEBUG"))
> > +		g_at_chat_set_debug(data->gps_port, mbm_debug, "GPS: ");
> > +
> >  	g_at_chat_set_disconnect_function(data->data_port,
> >  						mbm_disconnect, modem);
> >  =

> > @@ -415,6 +435,9 @@ static void cfun_disable(gboolean ok, GAtResult *re=
sult, gpointer user_data)
> >  	g_at_chat_unref(data->data_port);
> >  	data->data_port =3D NULL;
> >  =

> > +	g_at_chat_unref(data->gps_port);
> > +	data->gps_port =3D NULL;
> > +
> >  	if (ok)
> >  		ofono_modem_set_powered(modem, FALSE);
> >  }
> > @@ -541,6 +564,9 @@ static void mbm_post_online(struct ofono_modem *mod=
em)
> >  					OFONO_GPRS_CONTEXT_TYPE_MMS);
> >  		ofono_gprs_add_context(data->gprs, data->gc);
> >  	}
> > +
> > +	data->gps =3D ofono_gps_create(modem, 0,
> > +					"mbmmodem", data->gps_port);
> =

> If my previous comment is correct, then the gps driver should be running
> on the dev port, not on the gps port.

I will fix this. =


I am working on a new version of this gps task based on your comments and
suggestions. Thanks a lot for the review. =


Rafael

--===============2189989083656144054==--

