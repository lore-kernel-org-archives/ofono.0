Content-Type: multipart/mixed; boundary="===============5296227353116436213=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] SpeedUp: enable online/offline
Date: Fri, 06 Apr 2012 09:31:47 -0500
Message-ID: <4F7EFE53.7030904@gmail.com>
In-Reply-To: <1333719263-7900-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5296227353116436213==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

On 04/06/2012 08:34 AM, Bertrand Aygon wrote:
> Add speedup_set_online.
> Add a polling mechanism since most speedup dongles failed in couple of AT
> commands following the CFUN=3D1 when they are offline.
> =

> ---
>  plugins/speedup.c |  106 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 106 insertions(+), 0 deletions(-)
> =

> diff --git a/plugins/speedup.c b/plugins/speedup.c
> index ca6ed13..905f462 100644
> --- a/plugins/speedup.c
> +++ b/plugins/speedup.c
> @@ -47,12 +47,16 @@
>  #include <drivers/atmodem/atutil.h>
>  #include <drivers/atmodem/vendor.h>
>  =

> +static const char *creg_prefix[] =3D { "+CREG:", NULL };
>  static const char *none_prefix[] =3D { NULL };
>  =

>  struct speedup_data {
>  	GAtChat *modem;
>  	GAtChat *aux;
>  	gboolean have_sim;
> +	guint online_poll_source;
> +	guint online_poll_count;
> +	struct cb_data *online_cbd;

You need to free these in case the modem is removed when the online
operation is in progress.

>  	struct at_util_sim_state_query *sim_state_query;
>  };
>  =

> @@ -238,6 +242,107 @@ static int speedup_disable(struct ofono_modem *mode=
m)
>  	return -EINPROGRESS;
>  }
>  =

> +static gboolean creg_online_check(gpointer user_data);
> +
> +static void creg_online_cb(gboolean ok, GAtResult *result,
> +						gpointer user_data)
> +{
> +	struct speedup_data *data =3D user_data;
> +	ofono_modem_online_cb_t cb =3D data->online_cbd->cb;
> +
> +	if (ok) {
> +		CALLBACK_WITH_SUCCESS(cb, data->online_cbd->data);
> +		goto done;
> +	}
> +
> +	data->online_poll_count++;
> +
> +	if (data->online_poll_count > 15)
> +		goto failure;
> +
> +	data->online_poll_source =3D g_timeout_add_seconds(2,
> +						creg_online_check, data);
> +	return;
> +
> +failure:
> +	CALLBACK_WITH_FAILURE(cb, data->online_cbd->data);
> +
> +done:
> +	g_free(data->online_cbd);
> +	data->online_cbd =3D NULL;
> +}
> +
> +static gboolean creg_online_check(gpointer user_data)
> +{
> +	struct speedup_data *data =3D user_data;
> +
> +	data->online_poll_source =3D 0;
> +
> +	g_at_chat_send(data->aux, "AT+CREG=3D?", creg_prefix,
> +					creg_online_cb, data, NULL);

Just for my understanding, the modem stops responding to all commands
when CFUN=3D1 is issued, hence you're polling that CREG is supported?

> +
> +	return FALSE;
> +}
> +
> +static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct speedup_data *data =3D ofono_modem_get_data(modem);
> +
> +	if (!ok) {
> +		ofono_modem_online_cb_t cb =3D data->online_cbd->cb;
> +
> +		CALLBACK_WITH_FAILURE(cb, data->online_cbd->data);
> +
> +		g_free(data->online_cbd);
> +		data->online_cbd =3D NULL;
> +		return;
> +	}
> +
> +	data->online_poll_count =3D 0;
> +
> +	creg_online_check(data);
> +}
> +
> +static void set_offline_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_modem_online_cb_t cb =3D cbd->cb;
> +	struct ofono_error error;
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +	cb(&error, cbd->data);
> +}
> +
> +static void speedup_set_online(struct ofono_modem *modem, ofono_bool_t o=
nline,
> +				ofono_modem_online_cb_t cb, void *user_data)
> +{
> +	struct speedup_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("modem %p %s", modem, online ? "online" : "offline");
> +
> +	if (online =3D=3D TRUE) {
> +		data->online_cbd =3D cb_data_new(cb, user_data);
> +
> +		if (g_at_chat_send(data->aux, "AT+CFUN=3D1", none_prefix,
> +					set_online_cb, modem, NULL) > 0)
> +			return;
> +
> +		g_free(data->online_cbd);
> +		data->online_cbd =3D NULL;
> +	} else {
> +		struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +
> +		if (g_at_chat_send(data->aux, "AT+CFUN=3D4",
> +				none_prefix, set_offline_cb, cbd, g_free) > 0)
> +			return;
> +
> +		g_free(cbd);
> +	}
> +
> +	CALLBACK_WITH_FAILURE(cb, user_data);
> +}
> +
>  static void speedup_pre_sim(struct ofono_modem *modem)
>  {
>  	struct speedup_data *data =3D ofono_modem_get_data(modem);
> @@ -292,6 +397,7 @@ static struct ofono_modem_driver speedup_driver =3D {
>  	.remove		=3D speedup_remove,
>  	.enable		=3D speedup_enable,
>  	.disable	=3D speedup_disable,
> +	.set_online	=3D speedup_set_online,
>  	.pre_sim	=3D speedup_pre_sim,
>  	.post_sim	=3D speedup_post_sim,
>  	.post_online	=3D speedup_post_online,

Regards,
-Denis

--===============5296227353116436213==--

