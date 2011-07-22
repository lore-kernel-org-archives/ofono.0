Content-Type: multipart/mixed; boundary="===============7293453966929491634=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] SpeedUp CDMA: querying SIM state during powering on phase.
Date: Fri, 22 Jul 2011 11:33:05 +0200
Message-ID: <1311327186.21109.305.camel@aeonflux>
In-Reply-To: <1311308757-10929-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7293453966929491634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

please do not make up new commit prefixes. Use simple lower case strings
like the modem plugin name, the subdirectory in drivers or for the core
the logical name.

>  plugins/speedupcdma.c |  102 +++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 files changed, 100 insertions(+), 2 deletions(-)
> =

> diff --git a/plugins/speedupcdma.c b/plugins/speedupcdma.c
> index b7e54a1..1dcff88 100644
> --- a/plugins/speedupcdma.c
> +++ b/plugins/speedupcdma.c
> @@ -41,11 +41,25 @@
>  #include <drivers/atmodem/atutil.h>
>  =

>  static const char *none_prefix[] =3D { NULL };
> +static const char *sysinfo_prefix[] =3D { "^SYSINFO:", NULL };
> +
> +enum speedupcdma_sim_state {
> +	SPEEDUPCDMA_SIM_STATE_VALID =3D		1,
> +	SPEEDUPCDMA_SIM_STATE_ROMSIM =3D		240,
> +	SPEEDUPCDMA_SIM_STATE_NOT_EXISTENT =3D	255

Add last , as well. We do this for enum so that if they get extended the
patches look cleaner and not have to reshuffle.
> +};
>  =

>  struct speedupcdma_data {
>  	GAtChat *chat;
> +	enum speedupcdma_sim_state sim_state;
> +	guint sim_poll_timeout;
> +	guint sim_poll_count;
>  };
>  =

> +#define MAX_SIM_POLL_COUNT 5
> +
> +static gboolean query_sim_state(gpointer user_data);
> +
>  static void speedupcdma_debug(const char *str, void *data)
>  {
>  	const char *prefix =3D data;
> @@ -79,6 +93,90 @@ static void speedupcdma_remove(struct ofono_modem *mod=
em)
>  	g_free(data);
>  }
>  =

> +static gboolean notify_sim_state(struct ofono_modem *modem,
> +				enum speedupcdma_sim_state sim_state)
> +{
> +	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("%d", sim_state);
> +
> +	data->sim_state =3D sim_state;
> +
> +	switch (sim_state) {
> +	case SPEEDUPCDMA_SIM_STATE_NOT_EXISTENT:
> +		/* SIM is not ready, try again a bit later */
> +		return TRUE;
> +	case SPEEDUPCDMA_SIM_STATE_VALID:
> +	case SPEEDUPCDMA_SIM_STATE_ROMSIM:
> +		if (data->sim_poll_timeout) {
> +			g_source_remove(data->sim_poll_timeout);
> +			data->sim_poll_timeout =3D 0;
> +		}
> +
> +		ofono_modem_set_powered(modem, TRUE);

Use break; here.

And can you include OFONO_AT_DEBUG traces to show what is going on.

> +
> +		return FALSE;
> +	}
> +
> +	return FALSE;
> +}
> +
> +static void sysinfo_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
> +	gboolean rerun;
> +	gint sim_state;
> +	GAtResultIter iter;
> +
> +	if (!ok)
> +		return;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "^SYSINFO:"))
> +		return;
> +
> +	if (!g_at_result_iter_skip_next(&iter))
> +		return;
> +
> +	if (!g_at_result_iter_skip_next(&iter))
> +		return;
> +
> +	if (!g_at_result_iter_skip_next(&iter))
> +		return;
> +
> +	if (!g_at_result_iter_skip_next(&iter))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &sim_state))
> +		return;
> +
> +	rerun =3D notify_sim_state(modem, (enum speedupcdma_sim_state) sim_stat=
e);
> +
> +	if (rerun && data->sim_poll_count < MAX_SIM_POLL_COUNT) {
> +		data->sim_poll_count++;
> +		data->sim_poll_timeout =3D g_timeout_add_seconds(2,
> +								query_sim_state,
> +								modem);
> +	}
> +}

This logic is copied from the Huawei GSM plugin and there I am not even
sure that it is correct. Please show us AT command traces. Since I do
not think that it is this complicated for CDMA.

The Huawei plugin is a bad example to copy code from.

> +static gboolean query_sim_state(gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct speedupcdma_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("");
> +
> +	data->sim_poll_timeout =3D 0;
> +
> +	g_at_chat_send(data->chat, "AT^SYSINFO", sysinfo_prefix,
> +			sysinfo_cb, modem, NULL);
> +
> +	return FALSE;
> +}
> +
>  static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_da=
ta)
>  {
>  	struct ofono_modem *modem =3D user_data;
> @@ -93,8 +191,6 @@ static void cfun_enable(gboolean ok, GAtResult *result=
, gpointer user_data)
>  		ofono_modem_set_powered(modem, FALSE);
>  		return;
>  	}
> -
> -	ofono_modem_set_powered(modem, TRUE);
>  }
>  =

>  static int speedupcdma_enable(struct ofono_modem *modem)
> @@ -132,6 +228,8 @@ static int speedupcdma_enable(struct ofono_modem *mod=
em)
>  	g_at_chat_send(data->chat, "AT+CFUN=3D1", none_prefix,
>  					cfun_enable, modem, NULL);
>  =

> +	query_sim_state(modem);
> +

This is wrong code. So in case CFUN=3D1 fails, you still go ahead and
query the SIM state. That is rather pointless and might result on
unforseen feedback from the modem.

In addition you do not handle the set_powered in case ^SYSINFO fails or
you have polled max attempts.

Now looking over this. I do not like this at all. Please do not copy any
code from Huawei plugin and write this from scratch based on actual
traces and the documentation.

Regards

Marcel



--===============7293453966929491634==--

