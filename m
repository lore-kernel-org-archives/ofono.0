Content-Type: multipart/mixed; boundary="===============2452287633347679091=="
MIME-Version: 1.0
From: Zhang, Caiwen <Caiwen.Zhang@windriver.com>
Subject: RE: [PATCH v3] reopen once if open device failed
Date: Fri, 03 Jun 2011 03:46:09 +0000
Message-ID: <0E7E5CACD8E9F248AA009C292CC772A057D33F@ALA-MBA.corp.ad.wrs.com>
In-Reply-To: <4DE7579A.6030009@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2452287633347679091==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> >
> > -	if ((data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
> > -			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) &&
> > -			data->modem !=3D NULL) {
> > +	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
> > +			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) {
> =

> What are you trying to accomplish here?  It sounds like you want to
> separate the logic of creating the NDIS gprs context (which does not
> depend on the modem port being available.)  Is this the case?  If so,
> then you need to submit this as a separate patch...
> =


Yes. NDIS gprs context does not depend on the modem port. don't need
to check data->modem for it.

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

> along with this chunk here, since they are not related to the issue
> you're trying to fix.
> =


OK, I will sent a separate patch for this.

best regards
Caiwen

--===============2452287633347679091==--

