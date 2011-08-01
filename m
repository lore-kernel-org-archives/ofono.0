Content-Type: multipart/mixed; boundary="===============3823081607397558127=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH 1/2] cbs: send topics one by one for ZTE modem.
Date: Mon, 01 Aug 2011 12:12:58 +0200
Message-ID: <1312193580.8920.149.camel@aeonflux>
In-Reply-To: <568DE01DA537804BA73470071BAC288939006036@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3823081607397558127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

> > > +
> > > +	if (send_by_one) {
> > > +		gchar **topic_list =3D NULL;
> > > +		gchar **topic_list_orig =3D NULL;
> > > +
> > > +		topic_list =3D topic_list_orig =3D g_strsplit_set(topics, ",", -1);
> > > +
> > > +		for (; *topic_list; topic_list++) {
> > > +			struct cb_data *cbd =3D cb_data_new(cb, user_data);
> > > +
> > > +			buf =3D g_strdup_printf("AT+CSCB=3D0,\"%s\"", *topic_list);
> > >
> > > -	id =3D g_at_chat_send(data->chat, buf, none_prefix,
> > > +			id =3D g_at_chat_send(data->chat, buf, none_prefix,
> > >  				at_cscb_set_cb, cbd, g_free);
> > =

> > So this is not going to work out as nicely as you might think it would.
> > You keep calling ofono_cbs_set_cb_t callback now for every single topic
> > you send. And also as a result, the D-Bus call returns successful after
> > the first one.
> =

> OK, I see.
> =

> > You need to properly queue this and properly fail and roll back in case
> > of a failure.
> =

> Roll back? You means that if there is a failure in the middle of sending,=
 you want to send AT command to remove the first topics?

at minimum clear all topics again.

> > I addition to that, I would prefer to send as many topics at once as
> > possible. So how many can ZTE set at once?
> =

> I can do some test, but I think that it's not related to topics, but to A=
T command length. And we cannot guaranty to find another model more restric=
tive. Sending one by one seems to be the 'safest' solution.

Please check this. And AT command length limitation would be funny. Not
unlikely, but funny.

And while at it, please check if it is actually capable of handling any
kind of topic ranges properly. You currently only split the topics, but
have no special handling for ranges. So if the modem does not handle
topic ranges, then you have a problem here.

For example if it can only set 10 topics at once, and you give 1-11. Is
this 11 topics and the modem can handle it. Or it can handle only 10
topics and would fail.

Another thing that came to mind, please check that it actually adds the
topics and not just overwrites it. Some manufactures don't read the AT
command specification carefully.

Regards

Marcel



--===============3823081607397558127==--

