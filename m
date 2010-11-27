Content-Type: multipart/mixed; boundary="===============1692964272505224514=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] phonesim: implement ctm atom
Date: Sat, 27 Nov 2010 12:00:33 -0600
Message-ID: <4CF14741.8060906@gmail.com>
In-Reply-To: <1290818641-16269-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1692964272505224514==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 11/26/2010 06:44 PM, Lucas De Marchi wrote:
> ---
>  plugins/phonesim.c |  140 ++++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  1 files changed, 136 insertions(+), 4 deletions(-)
> =

> diff --git a/plugins/phonesim.c b/plugins/phonesim.c
> index d2faf42..be2f931 100644
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
> @@ -190,12 +192,137 @@ static void phonesim_context_remove(struct ofono_g=
prs_context *gc)
>  	g_free(gcd);
>  }
>  =

> +static void phonesim_ctm_support_cb(gboolean ok, GAtResult *result,
> +					gpointer user_data)
> +{
> +	struct ofono_ctm *ctm =3D user_data;
> +
> +	if (!ok)
> +		return;

You might want to remove the atom here as well so it doesn't take up space.

> +
> +	ofono_ctm_register(ctm);
> +}
> +
> +static int phonesim_ctm_probe(struct ofono_ctm *ctm,
> +				unsigned int vendor, void *data)
> +{
> +	GAtChat *chat =3D data;
> +
> +	ofono_ctm_set_data(ctm, chat);

You actually need to clone the chat here, see the other drivers for
details.  This is used to remove all pending commands from the chat when
the atom is removed.

> +
> +	g_at_chat_send(chat, "AT+PTTY=3D?", ptty_prefix, phonesim_ctm_support_c=
b,
> +			ctm, NULL);
> +
> +	return 0;
> +}
> +
> +static void phonesim_ctm_remove(struct ofono_ctm *ctm)
> +{
> +	DBG("");
> +

You also need to unref the chat here

> +	ofono_ctm_set_data(ctm, NULL);
> +}
> +
> +static void ctm_query_cb(gboolean ok, GAtResult *result, gpointer user_d=
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
> +static void phonesim_ctm_query(struct ofono_ctm *ctm,
> +				ofono_ctm_query_cb_t cb, void *data)
> +{
> +	GAtChat *chat =3D ofono_ctm_get_data(ctm);
> +	struct cb_data *cbd =3D cb_data_new(cb, data);
> +
> +	DBG("");
> +
> +	if (!cbd)
> +		goto error;
> +
> +	if (g_at_chat_send(chat, "AT+PTTY?", ptty_prefix,
> +				ctm_query_cb, cbd, g_free) > 0)
> +		return;
> +
> +error:
> +	g_free(cbd);
> +
> +	CALLBACK_WITH_FAILURE(cb, 0, data);
> +}
> +
> +static void ctm_set_cb(gboolean ok, GAtResult *result, gpointer user_dat=
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
> +static void phonesim_ctm_set(struct ofono_ctm *ctm, ofono_bool_t enable,
> +				ofono_ctm_set_cb_t cb, void *data)
> +{
> +	GAtChat *chat =3D ofono_ctm_get_data(ctm);
> +	struct cb_data *cbd =3D cb_data_new(cb, data);
> +	char buf[20];
> +
> +	DBG("");
> +
> +	if (!cbd)
> +		goto error;
> +
> +	snprintf(buf, sizeof(buf), "AT+PTTY=3D%d", enable);
> +
> +	if (g_at_chat_send(chat, buf, none_prefix,
> +				ctm_set_cb, cbd, g_free) > 0)
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
> +static struct ofono_ctm_driver ctm_driver =3D {
>  	.name			=3D "phonesim",
> -	.probe			=3D phonesim_context_probe,
> -	.remove			=3D phonesim_context_remove,
> -	.activate_primary	=3D phonesim_activate_primary,
> -	.deactivate_primary	=3D phonesim_deactivate_primary,
> +	.probe			=3D phonesim_ctm_probe,
> +	.remove			=3D phonesim_ctm_remove,
> +	.query_tty		=3D phonesim_ctm_query,
> +	.set_tty		=3D phonesim_ctm_set,
>  };
>  =

>  static int phonesim_probe(struct ofono_modem *modem)
> @@ -465,6 +592,7 @@ static void phonesim_post_sim(struct ofono_modem *mod=
em)
>  =

>  	DBG("%p", modem);
>  =

> +	ofono_ctm_create(modem, 0, "phonesim", data->chat);
>  	ofono_phonebook_create(modem, 0, "atmodem", data->chat);
>  =

>  	if (!data->calypso)
> @@ -630,6 +758,8 @@ static int phonesim_init(void)
>  =

>  	ofono_gprs_context_driver_register(&context_driver);
>  =

> +	ofono_ctm_driver_register(&ctm_driver);
> +
>  	parse_config(CONFIGDIR "/phonesim.conf");
>  =

>  	return 0;
> @@ -648,6 +778,8 @@ static void phonesim_exit(void)
>  	g_slist_free(modem_list);
>  	modem_list =3D NULL;
>  =

> +	ofono_ctm_driver_unregister(&ctm_driver);
> +
>  	ofono_gprs_context_driver_unregister(&context_driver);
>  =

>  	ofono_modem_driver_unregister(&phonesim_driver);

Otherwise looks good.  Can you also send a patch marking this task as done?

Regards,
-Denis

--===============1692964272505224514==--

