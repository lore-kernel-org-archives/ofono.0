Content-Type: multipart/mixed; boundary="===============5596031849909235942=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 11/15] emulator: Register mandatory AT command handlers
Date: Wed, 07 Jul 2010 08:12:47 -0300
Message-ID: <1278501167.2789.76.camel@localhost.localdomain>
In-Reply-To: <174dc33a040610bec69295a72eb488ea@chewa.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5596031849909235942==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > +static void cfun_cb(GAtServerRequestType type, GAtResult *cmd,
> > +					gpointer user_data)
> > +{
> > +	struct ofono_emulator *e =3D user_data;
> > +	char buf[50];
> > +
> > +	switch (type) {
> > +	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
> > +		ofono_emulator_send_info(e, "+CFUN: (0-1)", TRUE);
> > +		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
> > +		break;
> > +	case G_AT_SERVER_REQUEST_TYPE_QUERY:
> > +		snprintf(buf, sizeof(buf), "+CFUN: %d", e->modem_mode);
> > +		ofono_emulator_send_info(e, buf, TRUE);
> > +		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
> > +		break;
> =

> Does not make much sense. If mode is 0, the device has functionality
> minimum, meaning usually power off or close to that. oFono does not run in
> such stage, so it won't be there to answer CFUN: 0.

this is actually more fake than real. We are not mapping all commands
1:1 to the real modem. It is mainly to just make some dialers and things
like Windows happy ;)

> > +	case G_AT_SERVER_REQUEST_TYPE_SET:
> > +	{
> > +		GAtResultIter iter;
> > +		int mode;
> > +
> > +		g_at_result_iter_init(&iter, cmd);
> > +		g_at_result_iter_next(&iter, "+CFUN=3D");
> > +
> > +		if (g_at_result_iter_next_number(&iter, &mode) =3D=3D FALSE)
> > +			goto error;
> > +
> > +		if (mode !=3D 0 && mode !=3D 1)
> > +			goto error;
> > +
> > +		DBG("set CFUN to %d", mode);
> > +
> > +		e->modem_mode =3D mode;
> > +		g_timeout_add_seconds(1, send_ok, e);
> > +		break;
> > +	}
> =

> I might be missing something, but it does not look like AT+CFUN=3D0 will
> power off the system, which is more or less what it is expected to do.

Look again, it won't. It is an arbitrary delay for testing. If we would
follow the Bluetooth DUN specification literally, then only the magic
AT*99# syntax would be needed, but there are other commands that are
expected to work. So in most cases we just fake them.

> +static void cops_cb(GAtServerRequestType type, GAtResult *result,
> > +					gpointer user_data)
> > +{
> > +	struct ofono_emulator *e =3D user_data;
> > +	char buf[50];
> > +
> > +	switch (type) {
> > +	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
> > +		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
> > +		break;
> > +	case G_AT_SERVER_REQUEST_TYPE_QUERY:
> > +		snprintf(buf, sizeof(buf), "+COPS: %d", e->modem_cops);
> > +		ofono_emulator_send_info(e, buf, TRUE);
> > +		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
> > +		break;
> > +	case G_AT_SERVER_REQUEST_TYPE_SET:
> > +	{
> > +		GAtResultIter iter;
> > +		int mode;
> > +
> > +		g_at_result_iter_init(&iter, result);
> > +		g_at_result_iter_next(&iter, "+COPS=3D");
> > +
> > +		if (g_at_result_iter_next_number(&iter, &mode) =3D=3D FALSE)
> > +			goto error;
> > +
> > +		if (mode < 0 || mode > 2)
> > +			goto error;
> > +
> > +		DBG("set GPRS cops status %d", mode);
> > +
> > +		e->modem_cops =3D mode;
> > +		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
> =

> You won't get away with this. You're supposed to register/unregister/etc
> from the network here.
> Similarly, AT+CGATT is wrong, GPRS should be attached/detached. Yes, that
> means you may have to tear down someone else's GPRS context, which may se=
em
> evil.

Same here actually. We will fake COPS and CGATT for the client. Compared
to the CFUN code this needs a bit more work since we should return an
error when the real modem is not ready yet or GPRS is not attached.

That said, there has to be done some work for CFUN as well if our modem
is offline. However my take here is to just disable DUN service when the
modems goes offline.

> Last, AT+CPIN should at the very least return PIN READY when appropriate,
> if I read the spec right.

We will fake this again and always return READY here. If the physical
modem is not ready (sim_post state), then we will not provide DUN server
support.

Regards

Marcel



--===============5596031849909235942==--

