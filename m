Content-Type: multipart/mixed; boundary="===============4009813215699335258=="
MIME-Version: 1.0
From: Zhang, Caiwen <caiwen.zhang@intel.com>
Subject: RE: [PATCH] rilmodem: add cell broadcast message support
Date: Thu, 19 May 2016 03:26:50 +0000
Message-ID: <DA62CA5DDF4CA640AA25B1684E5D1411020B415D@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <573CA324.5040501@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4009813215699335258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > +
> > +static void ril_cbs_set_topics(struct ofono_cbs *cbs, const char *topi=
cs,
> > +					ofono_cbs_set_cb_t cb, void *user_data) {
> > +	struct cbs_data *cd =3D ofono_cbs_get_data(cbs);
> > +	struct cb_data *cbd =3D cb_data_new(cb, user_data, cd);
> > +	int count =3D 0, from, to;
> > +	const char *p =3D topics;
> > +	const char *pto;
> > +	struct parcel rilp;
> > +
> > +	while (p) {
> > +		count++;
> > +		p =3D strchr(p, ',');
> > +		if (p)
> > +			p++;
> > +	}
> > +
> =

> It might be simpler to just use g_strsplit here and free the result after=
 the
> parcel has been built.
> =

Done.

Please have a look.
> > +	p =3D topics;
> > +	if (count > 0) {
> > +		if (atoi(p) =3D=3D 0 && strchr(p, '0') =3D=3D NULL) /* empty string =
*/
> > +			count--;
> > +	}
> =

> The passed in string should not contain any ',' at the very end.  So I'm =
not
> sure if this check is really necessary?
> =


In case of the topics is empty ("").

> > +
> > +	parcel_init(&rilp);
> > +	parcel_w_int32(&rilp, count);
> > +
> > +	while (count > 0) {
> > +		from =3D atoi(p);
> > +		to =3D from;
> > +
> > +		pto =3D strchr(p, '-');
> > +		if (pto)
> > +			to =3D atoi(pto + 1);
> > +
> > +		parcel_w_int32(&rilp, from);
> > +		parcel_w_int32(&rilp, to);
> > +
> > +		parcel_w_int32(&rilp, 0);
> > +		parcel_w_int32(&rilp, 0xFF);
> > +
> > +		parcel_w_int32(&rilp, 1);
> > +
> > +		count--;
> > +		p =3D strchr(p, ',');
> > +		p++;
> > +	}
> > +
> > +	if (g_ril_send(cd->ril,
> RIL_REQUEST_GSM_SET_BROADCAST_SMS_CONFIG, &rilp,
> > +			ril_cbs_set_cb, cbd, g_free) > 0)
> > +		return;

Regards,
Caiwen

--===============4009813215699335258==--

