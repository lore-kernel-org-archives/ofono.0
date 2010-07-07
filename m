Content-Type: multipart/mixed; boundary="===============3783957346386395988=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi@remlab.net>
Subject: Re: [PATCH 11/15] emulator: Register mandatory AT command handlers
Date: Wed, 07 Jul 2010 12:48:21 +0200
Message-ID: <174dc33a040610bec69295a72eb488ea@chewa.net>
In-Reply-To: <1278496912-13777-12-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3783957346386395988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed,  7 Jul 2010 18:01:48 +0800, Zhenhua Zhang <zhenhua.zhang@intel.co=
m>
wrote:
> +static void cfun_cb(GAtServerRequestType type, GAtResult *cmd,
> +					gpointer user_data)
> +{
> +	struct ofono_emulator *e =3D user_data;
> +	char buf[50];
> +
> +	switch (type) {
> +	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
> +		ofono_emulator_send_info(e, "+CFUN: (0-1)", TRUE);
> +		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
> +		break;
> +	case G_AT_SERVER_REQUEST_TYPE_QUERY:
> +		snprintf(buf, sizeof(buf), "+CFUN: %d", e->modem_mode);
> +		ofono_emulator_send_info(e, buf, TRUE);
> +		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
> +		break;

Does not make much sense. If mode is 0, the device has functionality
minimum, meaning usually power off or close to that. oFono does not run in
such stage, so it won't be there to answer CFUN: 0.

> +	case G_AT_SERVER_REQUEST_TYPE_SET:
> +	{
> +		GAtResultIter iter;
> +		int mode;
> +
> +		g_at_result_iter_init(&iter, cmd);
> +		g_at_result_iter_next(&iter, "+CFUN=3D");
> +
> +		if (g_at_result_iter_next_number(&iter, &mode) =3D=3D FALSE)
> +			goto error;
> +
> +		if (mode !=3D 0 && mode !=3D 1)
> +			goto error;
> +
> +		DBG("set CFUN to %d", mode);
> +
> +		e->modem_mode =3D mode;
> +		g_timeout_add_seconds(1, send_ok, e);
> +		break;
> +	}

I might be missing something, but it does not look like AT+CFUN=3D0 will
power off the system, which is more or less what it is expected to do.

> +static void cops_cb(GAtServerRequestType type, GAtResult *result,
> +					gpointer user_data)
> +{
> +	struct ofono_emulator *e =3D user_data;
> +	char buf[50];
> +
> +	switch (type) {
> +	case G_AT_SERVER_REQUEST_TYPE_SUPPORT:
> +		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
> +		break;
> +	case G_AT_SERVER_REQUEST_TYPE_QUERY:
> +		snprintf(buf, sizeof(buf), "+COPS: %d", e->modem_cops);
> +		ofono_emulator_send_info(e, buf, TRUE);
> +		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);
> +		break;
> +	case G_AT_SERVER_REQUEST_TYPE_SET:
> +	{
> +		GAtResultIter iter;
> +		int mode;
> +
> +		g_at_result_iter_init(&iter, result);
> +		g_at_result_iter_next(&iter, "+COPS=3D");
> +
> +		if (g_at_result_iter_next_number(&iter, &mode) =3D=3D FALSE)
> +			goto error;
> +
> +		if (mode < 0 || mode > 2)
> +			goto error;
> +
> +		DBG("set GPRS cops status %d", mode);
> +
> +		e->modem_cops =3D mode;
> +		ofono_emulator_send_final(e, G_AT_SERVER_RESULT_OK);

You won't get away with this. You're supposed to register/unregister/etc
from the network here.
Similarly, AT+CGATT is wrong, GPRS should be attached/detached. Yes, that
means you may have to tear down someone else's GPRS context, which may seem
evil.

Last, AT+CPIN should at the very least return PIN READY when appropriate,
if I read the spec right.

-- =

R=C3=A9mi Denis-Courmont
http://www.remlab.net
http://fi.linkedin.com/in/remidenis


--===============3783957346386395988==--

