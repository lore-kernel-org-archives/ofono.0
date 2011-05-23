Content-Type: multipart/mixed; boundary="===============1402801442276653180=="
MIME-Version: 1.0
From: Zhang, Caiwen <Caiwen.Zhang@windriver.com>
Subject: RE: [PATCH v2] reopen once if open device failed
Date: Mon, 23 May 2011 02:49:19 +0000
Message-ID: <0E7E5CACD8E9F248AA009C292CC772A057C5F4@ALA-MBA.corp.ad.wrs.com>
In-Reply-To: <1305899589.2681.4.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1402801442276653180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> >
> > (2) Fix Huawei NDIS modem gprs doesn't work issue
> =

> what does this comment mean. We should just not try the NDIS part of
> Huawei until I get clear specs on how to use the NDIS port. Even the
> basic AT^DHCP handling of this is unreliable.
> =


I find this issue when I get a Huawei EM820W modem. I see according current
Implementation, gprs atom and context will not be created, because if NDIS
is supported, no device opened for data transmission. Please refer to funct=
ion =

huawei_enable() and post_online().

I don't have specs about how to use NDIS too. Here I just simply correct th=
is
Issue.

> >
> > -	if ((data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
> > -			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) &&
> > -			data->modem !=3D NULL) {
> > +	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
> > +			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) {
> =

> Why this change?

As above comment, because data->modem will always be NULL for modems suppor=
t NDIS.

> =

> >  		data->gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_HUAWEI,
> >  						"atmodem", data->pcui);
> >
> >  		if (data->ndis =3D=3D TRUE)
> >  			data->gc =3D ofono_gprs_context_create(modem, 0,
> >  						"huaweimodem", data->pcui);
> > -		else
> > +		else if (data->modem !=3D NULL)
> >  			data->gc =3D ofono_gprs_context_create(modem, 0,
> >  						"atmodem", data->modem);
> >
> =

> I do not understand this change.
> =


data->modem may be NULL, due to open device fail. =


Best regards
Caiwen


--===============1402801442276653180==--

