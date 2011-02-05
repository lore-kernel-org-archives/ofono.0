Content-Type: multipart/mixed; boundary="===============7932923046210494513=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v9] ifx: Adding modem selftest for Infineon modem
Date: Sat, 05 Feb 2011 05:34:32 -0800
Message-ID: <1296912872.1520.413.camel@aeonflux>
In-Reply-To: <8F72E7245587B740B3CF41CCF57DAF3757A4C1BF31@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7932923046210494513==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anand,

> Infineon modem selftest, during ifx_enable().
> Two steps trigger, with timeout. In case one fails, modem will not power =
up.

so I would prefer if you use git send-email and then use linux.intel.com
as your SMTP server.

That way we are sure that Exchange does not mangle the email and more
important does not mess with your email/author information. We have the
rule that it is firstname lastname and not this weird Outlook stuff with
Lastname first.

And now I going to make some last nitpicks on the style.

> ---
>  plugins/ifx.c |   77 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++-
>  1 files changed, 75 insertions(+), 2 deletions(-)
> =

> diff --git a/plugins/ifx.c b/plugins/ifx.c
> index 411c012..18250b0 100644
> --- a/plugins/ifx.c
> +++ b/plugins/ifx.c
> @@ -524,7 +524,7 @@ static gboolean mux_timeout_cb(gpointer user_data)
>  	struct ofono_modem *modem =3D user_data;
>  	struct ifx_data *data =3D ofono_modem_get_data(modem);
>  =

> -	ofono_error("Timeout with multiplexer setup");
> +	ofono_error("Timeout with modem and multiplexer setup");
>  =

>  	data->mux_init_timeout =3D 0;
>  =

> @@ -539,6 +539,68 @@ static gboolean mux_timeout_cb(gpointer user_data)
>  	return FALSE;
>  }
>  =

> +static void dev_ver_selftest_cb(gboolean ok, GAtResult *result,
> +				gpointer user_data)

In general the second line should be at least behind the (. So just add
another tab here.

> +{
> +

Remove this empty line here.

> +	struct ofono_modem *modem =3D user_data;
> +	struct ifx_data *data =3D ofono_modem_get_data(modem);
> +
> +	if (ok)
> +		return;
> +
> +	ofono_error("at(a)vers:device_version_id()-FAILED");
> +
> +	g_at_chat_cancel_all(data->dlcs[AUX_DLC]);

You actually do not need this one. The g_at_chat_unref implies this.

> +
> +	if (data->mux_init_timeout > 0) {
> +		g_source_remove(data->mux_init_timeout);
> +		data->mux_init_timeout =3D 0;
> +	}
> +
> +	if (data->dlcs[AUX_DLC]) {
> +		g_at_chat_unref(data->dlcs[AUX_DLC]);
> +		data->dlcs[AUX_DLC] =3D NULL;
> +	}

You do not need the if check here. The data->dlcs[AUX_DLC] is always
valid in this callback. If not, then there is a big problem.

> +	if (data->device) {
> +		g_io_channel_unref(data->device);
> +		data->device =3D NULL;
> +	}

Same here. Remove the if check. If data->device is not valid you are in
big trouble.

> +
> +	ofono_modem_set_powered(modem, FALSE);
> +}
> +
> +static void rtc_gti_selftest_cb(gboolean ok, GAtResult *result,
> +			gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct ifx_data *data =3D ofono_modem_get_data(modem);
> +
> +	if (ok)
> +		return;
> +
> +	ofono_error("at(a)rtc:rtc_gti_test_verify_32khz()-FAILED");
> +
> +	g_at_chat_cancel_all(data->dlcs[AUX_DLC]);
> +
> +	if (data->mux_init_timeout > 0) {
> +		g_source_remove(data->mux_init_timeout);
> +		data->mux_init_timeout =3D 0;
> +	}
> +
> +	if (data->dlcs[AUX_DLC]) {
> +		g_at_chat_unref(data->dlcs[AUX_DLC]);
> +		data->dlcs[AUX_DLC] =3D NULL;
> +	}
> +
> +	if (data->device) {
> +		g_io_channel_unref(data->device);
> +		data->device =3D NULL;
> +	}
> +
> +	ofono_modem_set_powered(modem, FALSE);
> +}

You need to add an empty line between functions.

And of course everything from the other function applies here as well.

>  static int ifx_enable(struct ofono_modem *modem)
>  {
>  	struct ifx_data *data =3D ofono_modem_get_data(modem);
> @@ -592,12 +654,23 @@ static int ifx_enable(struct ofono_modem *modem)
>  	g_at_chat_send(chat, "ATE0 +CMEE=3D1", NULL,
>  					NULL, NULL, NULL);
>  =

> +	/* Execute Modem Self tests */

So this read better with /* Execute modem self tests */ instead of this
random capitalization of words. Keep it lowercase and simple ;)

> +	g_at_chat_send(chat, "at(a)rtc:rtc_gti_test_verify_32khz()",
> +		NULL, rtc_gti_selftest_cb, modem, NULL);
> +
> +	g_at_chat_send(chat, "at(a)vers:device_version_id()",
> +		NULL, dev_ver_selftest_cb, modem, NULL);
> +
> +	/* Enable  MUX Channels */

This reads better as just /* Enable multiplexer */ and no double spaces
please.

>  	data->frame_size =3D 1509;
>  =

>  	g_at_chat_send(chat, "AT+CMUX=3D0,0,,1509,10,3,30,,", NULL,
>  					mux_setup_cb, modem, NULL);
>  =

> -	data->mux_init_timeout =3D g_timeout_add_seconds(5, mux_timeout_cb,
> +	/* Total Self-test execution time is less than 2s, used 10s
> +	 * to cover both Self-test and Mux setup time
> +	 */

Check the M2 coding style for formatting multi-line comments.

	/*
	 * Total self test execution ... 2 seconds. Use
	 * 10 seconds timeout to cover self tests and multiplexer setup.
	 */

> +	data->mux_init_timeout =3D g_timeout_add_seconds(10, mux_timeout_cb,
>  								modem);
>  =

>  	data->dlcs[AUX_DLC] =3D chat;

Rest looks all fine now. As I said, just some nitpicks.

Regards

Marcel



--===============7932923046210494513==--

