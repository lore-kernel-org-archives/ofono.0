Content-Type: multipart/mixed; boundary="===============7506131488776217550=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/5] phonesim: implement text-telephony atom
Date: Fri, 26 Nov 2010 13:17:21 -0600
Message-ID: <4CF007C1.1000404@gmail.com>
In-Reply-To: <1290706920-24740-4-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7506131488776217550==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 11/25/2010 11:41 AM, Lucas De Marchi wrote:
> ---
>  plugins/phonesim.c |  148 ++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  1 files changed, 144 insertions(+), 4 deletions(-)
> =

> diff --git a/plugins/phonesim.c b/plugins/phonesim.c
> index d2faf42..ec06741 100644
> --- a/plugins/phonesim.c
> +++ b/plugins/phonesim.c
> @@ -46,6 +46,7 @@
>  #include <ofono/call-settings.h>
>  #include <ofono/call-volume.h>
>  #include <ofono/cbs.h>
> +#include <ofono/ctm.h>
>  #include <ofono/devinfo.h>
>  #include <ofono/message-waiting.h>
>  #include <ofono/netreg.h>
> @@ -64,6 +65,7 @@
>  #include <drivers/atmodem/atutil.h>
>  =

>  static const char *none_prefix[] =3D { NULL };
> +static const char *ptty_prefix[] =3D { "+PTTY:", NULL };
>  static int next_iface =3D 0;
>  =

>  struct phonesim_data {
> @@ -78,6 +80,11 @@ struct gprs_context_data {
>  	char *interface;
>  };
>  =

> +struct text_telephony_data {
> +	GAtChat *chat;
> +	char *interface;

You actually do not need the interface string.  That is only used by the
gprs context to return a dummy name to oFono core.  For CTM you can get
away without having the text_telephony_data structure completely.
Simply use GAtChat as the data.

> +};
> +
>  static void at_cgact_up_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
>  {
>  	struct cb_data *cbd =3D user_data;
> @@ -190,12 +197,140 @@ static void phonesim_context_remove(struct ofono_g=
prs_context *gc)
>  	g_free(gcd);
>  }
>  =

> +static int phonesim_tty_probe(struct ofono_ctm *tt,
> +				unsigned int vendor, void *data)
> +{
> +	GAtChat *chat =3D data;
> +	struct text_telephony_data *ttd;
> +
> +	ttd =3D g_try_new0(struct text_telephony_data, 1);
> +	if (!ttd)
> +		return -ENOMEM;
> +
> +	ttd->chat =3D g_at_chat_clone(chat);
> +	ttd->interface =3D g_strdup_printf("dummy%d", next_iface++);
> +
> +	ofono_ctm_set_data(tt, ttd);
> +	ofono_ctm_register(tt);

In general it is not safe to register the atom before returning from
probe.  Some atoms will run initialization operations on the driver once
register is called.  Since probe has not returned, the driver is still
NULL.  See how some of the other drivers handle this.

> +
> +	return 0;
> +}
> +
> +static void phonesim_tty_remove(struct ofono_ctm *tt)
> +{
> +	struct text_telephony_data *ttd =3D ofono_ctm_get_data(tt);
> +
> +	DBG("");
> +
> +	ofono_ctm_set_data(tt, NULL);
> +
> +	g_at_chat_unref(ttd->chat);
> +	g_free(ttd->interface);
> +
> +	g_free(ttd);
> +}
> +
> +static void tty_query_cb(gboolean ok, GAtResult *result, gpointer user_d=
ata)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	struct ofono_error error;
> +	GAtResultIter iter;
> +	ofono_ctm_query_cb_t cb =3D cbd->cb;
> +	int value;
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +
> +	if (!ok) {
> +		cb(&error, -1, cbd->data);
> +		return;
> +	}
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (g_at_result_iter_next(&iter, "+PTTY:") =3D=3D FALSE)
> +		goto error;
> +
> +	if (g_at_result_iter_next_number(&iter, &value) =3D=3D FALSE)
> +		goto error;
> +
> +	cb(&error, value, cbd->data);
> +
> +	return;
> +
> +error:
> +
> +	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
> +}
> +
> +static void phonesim_tty_query(struct ofono_ctm *tt,
> +				ofono_ctm_query_cb_t cb, void *data)
> +{
> +	struct text_telephony_data *ttd =3D ofono_ctm_get_data(tt);
> +	struct cb_data *cbd =3D cb_data_new(cb, data);
> +
> +	DBG("");
> +
> +	if (!cbd)
> +		goto error;
> +
> +	if (g_at_chat_send(ttd->chat, "AT+PTTY?", ptty_prefix,
> +				tty_query_cb, cbd, g_free) > 0)
> +		return;
> +
> +error:
> +	g_free(cbd);
> +
> +	CALLBACK_WITH_FAILURE(cb, 0, data);
> +}
> +
> +static void tty_set_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_ctm_set_cb_t cb =3D cbd->cb;
> +	struct ofono_error error;
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +	cb(&error, cbd->data);
> +}
> +
> +static void phonesim_tty_set(struct ofono_ctm *tt, int enable,
> +				ofono_ctm_set_cb_t cb, void *data)
> +{
> +	struct text_telephony_data *ttd =3D ofono_ctm_get_data(tt);
> +	struct cb_data *cbd =3D cb_data_new(cb, data);
> +	char buf[12];

Please give a bit more room for error in the buffer, if someone tweaks
this we can get into buffer overrun situation.

> +
> +	DBG("");
> +
> +	if (!cbd)
> +		goto error;
> +
> +	enable =3D !!enable;

As mentioned on IRC, this is not really necessary

> +	snprintf(buf, sizeof(buf), "AT+PTTY=3D%d", enable);
> +
> +	if (g_at_chat_send(ttd->chat, buf, none_prefix,
> +					tty_set_cb, cbd, g_free) > 0)
> +		return;
> +
> +error:
> +	CALLBACK_WITH_FAILURE(cb, data);
> +	g_free(cbd);
> +}
> +
>  static struct ofono_gprs_context_driver context_driver =3D {
> +	.name                   =3D "phonesim",
> +	.probe                  =3D phonesim_context_probe,
> +	.remove                 =3D phonesim_context_remove,
> +	.activate_primary       =3D phonesim_activate_primary,
> +	.deactivate_primary     =3D phonesim_deactivate_primary,
> +};
> +
> +static struct ofono_ctm_driver tty_driver =3D {
>  	.name			=3D "phonesim",
> -	.probe			=3D phonesim_context_probe,
> -	.remove			=3D phonesim_context_remove,
> -	.activate_primary	=3D phonesim_activate_primary,
> -	.deactivate_primary	=3D phonesim_deactivate_primary,
> +	.probe			=3D phonesim_tty_probe,
> +	.remove			=3D phonesim_tty_remove,
> +	.query_tty		=3D phonesim_tty_query,
> +	.set_tty		=3D phonesim_tty_set,
>  };
>  =

>  static int phonesim_probe(struct ofono_modem *modem)
> @@ -465,6 +600,7 @@ static void phonesim_post_sim(struct ofono_modem *mod=
em)
>  =

>  	DBG("%p", modem);
>  =

> +	ofono_ctm_create(modem, 0, "phonesim", data->chat);
>  	ofono_phonebook_create(modem, 0, "atmodem", data->chat);
>  =

>  	if (!data->calypso)
> @@ -630,6 +766,8 @@ static int phonesim_init(void)
>  =

>  	ofono_gprs_context_driver_register(&context_driver);
>  =

> +	ofono_ctm_driver_register(&tty_driver);
> +
>  	parse_config(CONFIGDIR "/phonesim.conf");
>  =

>  	return 0;
> @@ -648,6 +786,8 @@ static void phonesim_exit(void)
>  	g_slist_free(modem_list);
>  	modem_list =3D NULL;
>  =

> +	ofono_ctm_driver_unregister(&tty_driver);
> +
>  	ofono_gprs_context_driver_unregister(&context_driver);
>  =

>  	ofono_modem_driver_unregister(&phonesim_driver);

Otherwise, looks good.

Regards,
-Denis

--===============7506131488776217550==--

