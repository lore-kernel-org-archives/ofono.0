Content-Type: multipart/mixed; boundary="===============3522136991530718849=="
MIME-Version: 1.0
From: Xu, Martin <martin.xu@intel.com>
Subject: RE: patch to fix BMC #13679 Huawei EM770: ofonod crash when
 disable/enable 3G technology
Date: Fri, 04 Mar 2011 14:53:33 +0800
Message-ID: <FC2FB65B4D919844ADE4BE3C2BB739AD36CFDF94@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4D6F25A7.503@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3522136991530718849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis:

> >  	struct ofono_gprs *gprs;
> >  	struct ofono_gprs_context *gc;
> >  	gboolean voice;
> > +	gboolean online;
> =

> I don't think you really need this one, you can use the presence of gprs
> atom instead.
Gprs atom is not reliable here. Because gprs will be flushed when entering =
offline mode
> =

> >  	gboolean ndis;
> >  	guint sim_poll_timeout;
> >  	guint sim_poll_count;
> > @@ -97,6 +98,7 @@ static int huawei_probe(struct ofono_modem *modem)
> >  	if (data =3D=3D NULL)
> >  		return -ENOMEM;
> >
> > +	data->online =3D FALSE;
> >  	ofono_modem_set_data(modem, data);
> >
> >  	return 0;
> > @@ -111,6 +113,11 @@ static void huawei_remove(struct ofono_modem
> *modem)
> >  	ofono_modem_set_data(modem, NULL);
> >
> >  	if (data->modem)
> > +		/*
> > +		 * huawei_disconnect should not be called when the chat
> > +		 * is closed initiatively
> > +		 */
> > +		g_at_chat_set_disconnect_function(data->modem, NULL, NULL);
> >  		g_at_chat_unref(data->modem);
> =

> Are you missing some parentheses around the if statement now?
> =

> Setting the disconnect function here seems fishy.  We automatically set
> it to NULL when GAtIO is unref-ed.  Seems to me g_at_chat_unref should
> be enough.
You are quite right. =

> =

> >
> >  	g_at_chat_unref(data->pcui);
> > @@ -470,10 +477,7 @@ static void huawei_disconnect(gpointer user_data)
> >  	struct ofono_modem *modem =3D user_data;
> >  	struct huawei_data *data =3D ofono_modem_get_data(modem);
> >
> > -	DBG("");
> > -
> > -	if (data->gc)
> > -		ofono_gprs_context_remove(data->gc);
> > +	DBG("data->online %d", data->online);
> >
> >  	g_at_chat_unref(data->modem);
> >  	data->modem =3D NULL;
> > @@ -485,6 +489,13 @@ static void huawei_disconnect(gpointer user_data)
> >  	g_at_chat_set_disconnect_function(data->modem,
> >  						huawei_disconnect, modem);
> >
> > +	/* reopen GPRS context channel only at online state */
> > +	if (data->online =3D=3D FALSE)
> > +		return;
> > +
> > +	if (data->gc)
> > +		ofono_gprs_context_remove(data->gc);
> > +
> >  	if (data->sim_state =3D=3D HUAWEI_SIM_STATE_VALID ||
> >  			data->sim_state =3D=3D HUAWEI_SIM_STATE_INVALID_CS) {
> >  		ofono_info("Reopened GPRS context channel");
> > @@ -515,6 +526,11 @@ static int huawei_enable(struct ofono_modem
> *modem)
> >
> >  	data->pcui =3D open_device(modem, "Pcui", "PCUI: ");
> >  	if (data->pcui =3D=3D NULL) {
> > +		/*
> > +		 * huawei_disconnect should not be called when the chat
> > +		 * is closed initiatively
> > +		 */
> > +		g_at_chat_set_disconnect_function(data->modem, NULL, NULL);
> >  		g_at_chat_unref(data->modem);
> >  		data->modem =3D NULL;
> >  		return -EIO;
> > @@ -564,6 +580,11 @@ static int huawei_disable(struct ofono_modem
> *modem)
> >  	if (data->modem) {
> >  		g_at_chat_cancel_all(data->modem);
> >  		g_at_chat_unregister_all(data->modem);
> > +		/*
> > +		 * huawei_disconnect should not be called when the chat
> > +		 * is closed initiatively
> > +		 */
> > +		g_at_chat_set_disconnect_function(data->modem, NULL, NULL);
> >  		g_at_chat_unref(data->modem);
> >  		data->modem =3D NULL;
> >  	}
> > @@ -579,15 +600,27 @@ static int huawei_disable(struct ofono_modem
> *modem)
> >  	return -EINPROGRESS;
> >  }
> >
> > +struct huawei_cb_data {
> > +	struct cb_data *cbd;
> > +	ofono_bool_t online;
> > +	struct ofono_modem *modem;
> > +};
> > +
> >  static void set_online_cb(gboolean ok, GAtResult *result, gpointer
> user_data)
> >  {
> > -	struct cb_data *cbd =3D user_data;
> > -	ofono_modem_online_cb_t cb =3D cbd->cb;
> > +	struct huawei_cb_data *online_cbd =3D user_data;
> > +	ofono_modem_online_cb_t cb =3D online_cbd->cbd->cb;
> > +	struct huawei_data *data =3D
> ofono_modem_get_data(online_cbd->modem);
> >
> > -	if (ok)
> > -		CALLBACK_WITH_SUCCESS(cb, cbd->data);
> > +	if (ok) {
> > +		data->online =3D online_cbd->online;
> > +
> > +		CALLBACK_WITH_SUCCESS(cb, online_cbd->cbd->data);
> > +
> > +		g_free(online_cbd);
> > +	}
> >  	else
> > -		CALLBACK_WITH_FAILURE(cb, cbd->data);
> > +		CALLBACK_WITH_FAILURE(cb, online_cbd->cbd->data);
> >  }
> =

> All of this can be better accomplished by using two separate callbacks.
>  One for online and one for offline.
agree

> =

> I suspect all you need to do is unref data->modem, set data->gc and
> data->gprs to NULL in the offline callback prior to calling back into
> the core.
Logically, call back only needs to set offline states
It is Huawei_disconnect's duty to decide the operation. =

In theory, Huawei_disconnect may be called at any situation when io error h=
appens.
(I observed two place, one is at ppp_disconnect the other is at offline mod=
e CFUN=3D5.)
So the function must take action according to the states. =

I will resent the updated patch

--===============3522136991530718849==--

