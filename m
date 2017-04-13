Content-Type: multipart/mixed; boundary="===============0577997658353027439=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 3/3] gemalto: Use sim_state_query for sim detection
Date: Thu, 13 Apr 2017 12:07:30 -0500
Message-ID: <de7469df-d844-762c-3f44-a626e39c023f@gmail.com>
In-Reply-To: <1492070747-7252-4-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0577997658353027439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On 04/13/2017 03:05 AM, Vincent Cesson wrote:
> Populate gemalto_data structure.
> Add sim_state callbacks.
> Fix enable/disable return value.
> ---
>  plugins/gemalto.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++++=
------
>  1 file changed, 80 insertions(+), 9 deletions(-)
>
> diff --git a/plugins/gemalto.c b/plugins/gemalto.c
> index ab0da8f..5473d2f 100644
> --- a/plugins/gemalto.c
> +++ b/plugins/gemalto.c
> @@ -46,10 +46,14 @@
>  #include <drivers/atmodem/atutil.h>
>  #include <drivers/atmodem/vendor.h>
>
> +static const char *none_prefix[] =3D { NULL };
>
>  struct gemalto_data {
>  	GAtChat *app;
>  	GAtChat *mdm;
> +	struct ofono_sim *sim;
> +	gboolean have_sim;
> +	struct at_util_sim_state_query *sim_state_query;
>  };
>
>  static int gemalto_probe(struct ofono_modem *modem)
> @@ -57,9 +61,12 @@ static int gemalto_probe(struct ofono_modem *modem)
>  	struct gemalto_data *data;
>
>  	data =3D g_try_new0(struct gemalto_data, 1);
> +

Strictly speaking you don't need an empty line here. =

doc/coding-style.txt item M1 mentions an exception at the end of the =

relevant section text.

I don't care what style variation you use, but please don't mix style =

fixes with code additions in the same patch.

>  	if (data =3D=3D NULL)
>  		return -ENOMEM;
>
> +	data->sim =3D NULL;
> +

This isn't needed, g_try_new0 already memsets the allocated structure to 0.

>  	ofono_modem_set_data(modem, data);
>
>  	return 0;
> @@ -69,6 +76,8 @@ static void gemalto_remove(struct ofono_modem *modem)
>  {
>  	struct gemalto_data *data =3D ofono_modem_get_data(modem);
>
> +	/* Cleanup potential SIM state polling */
> +	at_util_sim_state_query_free(data->sim_state_query);
>  	ofono_modem_set_data(modem, NULL);
>  	g_free(data);
>  }
> @@ -89,6 +98,7 @@ static GAtChat *open_device(const char *device)
>  	DBG("Opening device %s", device);
>
>  	channel =3D g_at_tty_open(device, NULL);
> +

Again, style fix and not relevant to this commit

>  	if (channel =3D=3D NULL)
>  		return NULL;
>
> @@ -103,6 +113,39 @@ static GAtChat *open_device(const char *device)
>  	return chat;
>  }
>
> +static void sim_state_cb(gboolean present, gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct gemalto_data *data =3D ofono_modem_get_data(modem);
> +
> +	at_util_sim_state_query_free(data->sim_state_query);
> +	data->sim_state_query =3D NULL;
> +
> +	data->have_sim =3D present;
> +	ofono_modem_set_powered(modem, TRUE);
> +}
> +
> +static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_da=
ta)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct gemalto_data *data =3D ofono_modem_get_data(modem);
> +
> +	if (!ok) {
> +		g_at_chat_unref(data->app);
> +		data->app =3D NULL;
> +
> +		g_at_chat_unref(data->mdm);
> +		data->mdm =3D NULL;
> +
> +		ofono_modem_set_powered(modem, FALSE);
> +		return;
> +	}
> +
> +	data->sim_state_query =3D at_util_sim_state_query_new(data->app,
> +						2, 20, sim_state_cb, modem,
> +						NULL);
> +}
> +
>  static int gemalto_enable(struct ofono_modem *modem)
>  {
>  	struct gemalto_data *data =3D ofono_modem_get_data(modem);
> @@ -118,10 +161,12 @@ static int gemalto_enable(struct ofono_modem *modem)
>
>  	/* Open devices */
>  	data->app =3D open_device(app);
> +

See comments about style fixes

>  	if (data->app =3D=3D NULL)
>  		return -EINVAL;
>
>  	data->mdm =3D open_device(mdm);
> +

See comments about style fixes

>  	if (data->mdm =3D=3D NULL) {
>  		g_at_chat_unref(data->app);
>  		data->app =3D NULL;
> @@ -133,7 +178,32 @@ static int gemalto_enable(struct ofono_modem *modem)
>  		g_at_chat_set_debug(data->mdm, gemalto_debug, "Mdm");
>  	}
>
> -	return 0;
> +	g_at_chat_send(data->mdm, "ATE0", none_prefix, NULL, NULL, NULL);
> +	g_at_chat_send(data->app, "ATE0 +CMEE=3D1", none_prefix,
> +			NULL, NULL, NULL);
> +	g_at_chat_send(data->mdm, "AT&C0", none_prefix, NULL, NULL, NULL);
> +	g_at_chat_send(data->app, "AT&C0", none_prefix, NULL, NULL, NULL);
> +
> +	g_at_chat_send(data->app, "AT+CFUN=3D4", none_prefix,
> +			cfun_enable, modem, NULL);
> +
> +	return -EINPROGRESS;
> +}
> +
> +static void gemalto_smso_cb(gboolean ok, GAtResult *result, gpointer use=
r_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct gemalto_data *data =3D ofono_modem_get_data(modem);
> +
> +	DBG("");
> +
> +	g_at_chat_unref(data->mdm);
> +	data->mdm =3D NULL;
> +	g_at_chat_unref(data->app);
> +	data->app =3D NULL;
> +
> +	if (ok)
> +		ofono_modem_set_powered(modem, FALSE);

and if not ok?

>  }
>
>  static int gemalto_disable(struct ofono_modem *modem)
> @@ -142,11 +212,14 @@ static int gemalto_disable(struct ofono_modem *mode=
m)
>
>  	DBG("%p", modem);
>
> -	g_at_chat_send(data->app, "AT^SMSO", NULL, NULL, NULL, NULL);
> +	g_at_chat_cancel_all(data->app);
> +	g_at_chat_unregister_all(data->app);
>
> -	ofono_modem_set_data(modem, NULL);
> +	/* Shutdown the modem */
> +	g_at_chat_send(data->app, "AT^SMSO", none_prefix, gemalto_smso_cb,
> +			modem, NULL);

what does this do?  Also, shouldn't you be issuing some sort of CFUN as =

well here?  There's no guarantee that .set_online will be called first.

>
> -	return 0;
> +	return -EINPROGRESS;
>  }
>
>  static void set_online_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
> @@ -156,11 +229,10 @@ static void set_online_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
>  	struct ofono_error error;
>
>  	decode_at_error(&error, g_at_result_final_response(result));
> -

See comments about style fixes

>  	cb(&error, cbd->data);
>  }
>
> -static void gemalto_set_online(struct ofono_modem *modem, ofono_bool_t o=
nline,
> +static void gemalto_set_online(struct ofono_modem *modem, gboolean onlin=
e,

no, the signature should be ofono_bool_t.  There are no glib types used =

by the oFono driver API (e.g. stuff in include/*)

>  		ofono_modem_online_cb_t cb, void *user_data)
>  {
>  	struct gemalto_data *data =3D ofono_modem_get_data(modem);
> @@ -173,7 +245,6 @@ static void gemalto_set_online(struct ofono_modem *mo=
dem, ofono_bool_t online,
>  		return;
>
>  	CALLBACK_WITH_FAILURE(cb, cbd->data);
> -

See comments about style fixes

>  	g_free(cbd);
>  }
>
> @@ -185,10 +256,10 @@ static void gemalto_pre_sim(struct ofono_modem *mod=
em)
>  	DBG("%p", modem);
>
>  	ofono_devinfo_create(modem, 0, "atmodem", data->app);
> -	sim =3D ofono_sim_create(modem, 0, "atmodem", data->app);
>  	ofono_location_reporting_create(modem, 0, "gemaltomodem", data->app);
> +	sim =3D ofono_sim_create(modem, 0, "atmodem", data->app);
>
> -	if (sim)
> +	if (sim && data->have_sim =3D=3D TRUE)
>  		ofono_sim_inserted_notify(sim, TRUE);
>  }
>
>

Regards,
-Denis

--===============0577997658353027439==--

