Content-Type: multipart/mixed; boundary="===============0615617743442580377=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH 1/2] cbs: send topics one by one for ZTE modem.
Date: Mon, 01 Aug 2011 10:55:21 +0100
Message-ID: <568DE01DA537804BA73470071BAC288939006036@irsmsx503.ger.corp.intel.com>
In-Reply-To: <1312192127.8920.145.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0615617743442580377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> >  drivers/atmodem/cbs.c |   58 +++++++++++++++++++++++++++++++++++++++++=
+----
> --
> >  1 files changed, 50 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/atmodem/cbs.c b/drivers/atmodem/cbs.c
> > index e2e1ca4..4673a77 100644
> > --- a/drivers/atmodem/cbs.c
> > +++ b/drivers/atmodem/cbs.c
> > @@ -109,9 +109,9 @@ static void at_cbs_set_topics(struct ofono_cbs *cbs,
> const char *topics,
> >  				ofono_cbs_set_cb_t cb, void *user_data)
> >  {
> >  	struct cbs_data *data =3D ofono_cbs_get_data(cbs);
> > -	struct cb_data *cbd =3D cb_data_new(cb, user_data);
> >  	char *buf;
> > -	unsigned int id;
> > +	unsigned int id =3D 0;
> > +	gboolean send_by_one =3D FALSE;
> >
> >  	DBG("");
> >
> > @@ -125,6 +125,7 @@ static void at_cbs_set_topics(struct ofono_cbs *cbs,
> const char *topics,
> >  	switch (data->vendor) {
> >  	case OFONO_VENDOR_GOBI:
> >  	case OFONO_VENDOR_QUALCOMM_MSM:
> > +	case OFONO_VENDOR_ZTE:
> >  		g_at_chat_send(data->chat, "AT+CSCB=3D1", none_prefix,
> >  				NULL, NULL, NULL);
> >  		break;
> > @@ -132,17 +133,58 @@ static void at_cbs_set_topics(struct ofono_cbs *c=
bs,
> const char *topics,
> >  		break;
> >  	}
> >
> > -	buf =3D g_strdup_printf("AT+CSCB=3D0,\"%s\"", topics);
> > +	/* Some ZTE modem doesn't support sending a long AT command
> > +	 * so we send topics one by one
> > +	 */
> > +	switch (data->vendor) {
> > +	case OFONO_VENDOR_ZTE:
> > +		send_by_one =3D TRUE;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> =

> so we already have a vendor switch statement a few lines above. Why
> bother introducing another one here?

Ok, I will use the first one.

> > +
> > +	if (send_by_one) {
> > +		gchar **topic_list =3D NULL;
> > +		gchar **topic_list_orig =3D NULL;
> > +
> > +		topic_list =3D topic_list_orig =3D g_strsplit_set(topics, ",", -1);
> > +
> > +		for (; *topic_list; topic_list++) {
> > +			struct cb_data *cbd =3D cb_data_new(cb, user_data);
> > +
> > +			buf =3D g_strdup_printf("AT+CSCB=3D0,\"%s\"", *topic_list);
> >
> > -	id =3D g_at_chat_send(data->chat, buf, none_prefix,
> > +			id =3D g_at_chat_send(data->chat, buf, none_prefix,
> >  				at_cscb_set_cb, cbd, g_free);
> =

> So this is not going to work out as nicely as you might think it would.
> You keep calling ofono_cbs_set_cb_t callback now for every single topic
> you send. And also as a result, the D-Bus call returns successful after
> the first one.

OK, I see.

> You need to properly queue this and properly fail and roll back in case
> of a failure.

Roll back? You means that if there is a failure in the middle of sending, y=
ou want to send AT command to remove the first topics?

> I addition to that, I would prefer to send as many topics at once as
> possible. So how many can ZTE set at once?

I can do some test, but I think that it's not related to topics, but to AT =
command length. And we cannot guaranty to find another model more restricti=
ve. Sending one by one seems to be the 'safest' solution.

Regards,

Bertrand
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


--===============0615617743442580377==--

