Content-Type: multipart/mixed; boundary="===============5484672099190744948=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: problem sim status
Date: Mon, 31 Mar 2014 10:30:35 -0500
Message-ID: <53398A1B.3070706@gmail.com>
In-Reply-To: <lh6i7p$lls$1@ger.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5484672099190744948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On 03/29/2014 08:35 AM, Eric BOUXIROT wrote:
>> Simply query the model/whichever numbers as part of your initialization
>> procedure.  e.g. run AT+FOO for the information that you need.  See how
>> the huawei plugin uses AT+ATI for example.
> =

> ok !
> =

> here the patch i used to support Sierra Wireless SL808x series modem.
> *add retries for +CPIN waiting SIM is ready
> *add +CPINC to get PIN retry count
> *add OFONO_VENDOR_SIERRA_SL808X vendor for theses specifics Sierra models.
> *change to new vendor automaticaly at modem_enable using +CGMM to get mod=
em model
> =

> I mean it can be added in next release of ofono ?

Please break up your patches and submit them using git send-email.
Refer to HACKING document inside ofono's git tree for more details.
Browse previous patch submissions for ample examples of how we like our
patches to be structured.

Your patches should probably look roughly like this:

1. drivers/atmodem/vendor.h changes
2. drivers/atmodem/sim.c changes
3. drivers/swmodem/gprs-context.c changes
4. plugins/sierra.c changes

<snip>

> diff -uprN a/drivers/swmodem/gprs-context.c b/drivers/swmodem/gprs-contex=
t.c
> --- a/drivers/swmodem/gprs-context.c	2012-07-02 09:55:34.000000000 +0200
> +++ b/drivers/swmodem/gprs-context.c	2014-03-28 17:47:26.338306480 +0100
> @@ -41,6 +41,7 @@
>  #include "gattty.h"
> =

>  #include "swmodem.h"
> +#include <drivers/atmodem/vendor.h>
> =

>  static const char *none_prefix[] =3D { NULL };
> =

> @@ -49,6 +50,7 @@ struct gprs_context_data {
>  	unsigned int active_context;
>  	ofono_gprs_context_cb_t cb;
>  	void *cb_data;
> +	unsigned int vendor;
>  };
> =

>  static void at_scact_down_cb(gboolean ok, GAtResult *result,
> @@ -100,8 +102,10 @@ static void at_scact_up_cb(gboolean ok,
>  	snprintf(buf, sizeof(buf), "AT!SCPADDR=3D%u", gcd->active_context);
>  	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
> =

> -	snprintf(buf, sizeof(buf), "AT+CGCONTRDP=3D%u", gcd->active_context);
> -	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
> +	if (gcd->vendor =3D=3D OFONO_VENDOR_SIERRA) {
> +		snprintf(buf, sizeof(buf), "AT+CGCONTRDP=3D%u", gcd->active_context);
> +		g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
> +	}

I'm confused why you need this change.  The CGCONTRDP command has no
effect, so it is safe to leave it in there even if it fails.

> =

>  	modem =3D ofono_gprs_context_get_modem(gc);
>  	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
> @@ -227,6 +231,7 @@ static int sw_gprs_context_probe(struct
>  		return -ENOMEM;
> =

>  	gcd->chat =3D g_at_chat_clone(chat);
> +	gcd->vendor =3D vendor;
> =

>  	ofono_gprs_context_set_data(gc, gcd);
> =

> diff -uprN a/plugins/sierra.c b/plugins/sierra.c
> --- a/plugins/sierra.c	2013-11-08 08:37:52.000000000 +0100
> +++ b/plugins/sierra.c	2014-03-29 13:51:24.419037337 +0100
> @@ -48,6 +48,8 @@ static const char *none_prefix[] =3D { NUL
> =

>  struct sierra_data {
>  	GAtChat *modem;
> +	enum ofono_vendor vendor;
> +	struct at_util_sim_state_query *sim_state_query;
>  };
> =

>  static void sierra_debug(const char *str, void *user_data)
> @@ -119,6 +121,17 @@ static GAtChat *open_device(struct ofono
>  	return chat;
>  }
> =

> +static void sim_state_cb(gboolean present, gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct sierra_data *data =3D ofono_modem_get_data(modem);
> +
> +	at_util_sim_state_query_free(data->sim_state_query);
> +	data->sim_state_query =3D NULL;

You don't set whether the SIM is present or not.  Isn't this what you want?

> +
> +	ofono_modem_set_powered(modem, TRUE);
> +}
> +
>  static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_da=
ta)
>  {
>  	struct ofono_modem *modem =3D user_data;
> @@ -129,9 +142,44 @@ static void cfun_enable(gboolean ok, GAt
>  	if (!ok) {
>  		g_at_chat_unref(data->modem);
>  		data->modem =3D NULL;
> +
> +		if (data->vendor =3D=3D OFONO_VENDOR_SIERRA_SL808X)
> +			ofono_modem_set_powered(modem, FALSE);
>  	}
> =

> -	ofono_modem_set_powered(modem, ok);
> +	if (data->vendor =3D=3D OFONO_VENDOR_SIERRA_SL808X)
> +		data->sim_state_query =3D at_util_sim_state_query_new(data->modem,
> +						2, 20, sim_state_cb, modem,
> +						NULL);
> +	else
> +		ofono_modem_set_powered(modem, ok);
> +}
> +
> +static void get_model(gboolean ok, GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_modem *modem =3D user_data;
> +	struct sierra_data *data =3D ofono_modem_get_data(modem);
> +	struct ofono_error error;
> +	const char *attr;
> +	enum ofono_vendor vendor =3D 0;
> +
> +	DBG("");
> +
> +	data->vendor=3DOFONO_VENDOR_SIERRA;

This is not according to our coding style.

> +	decode_at_error(&error, g_at_result_final_response(result));
> +
> +	if (!ok)
> +		goto done;
> +
> +	if (at_util_parse_attr(result, "", &attr) =3D=3D TRUE)
> +		if (!strncmp(attr,"SL808",5)) {
> +			data->vendor=3DOFONO_VENDOR_SIERRA_SL808X;
> +			DBG("Modem is SL808X series");
> +		}

Again, fix the coding style here.

It would be better to rewrite this piece as:

if (at_util_parse_attr(...) =3D=3D FALSE)
	goto done;

if (!strncmp(...)) {
	....
}

> +
> +done:
> +	g_at_chat_send(data->modem, "AT+CFUN=3D4", none_prefix,
> +					cfun_enable, modem, NULL);
>  }
> =

>  static int sierra_enable(struct ofono_modem *modem)
> @@ -148,8 +196,7 @@ static int sierra_enable(struct ofono_mo
>  	/* This is separate because it is not supported by all modems. */
>  	g_at_chat_send(data->modem, "AT+CMEE=3D1", NULL, NULL, NULL, NULL);
> =

> -	g_at_chat_send(data->modem, "AT+CFUN=3D4", none_prefix,
> -					cfun_enable, modem, NULL);
> +	g_at_chat_send(data->modem, "AT+CGMM", NULL, get_model, modem, NULL);
> =

>  	return -EINPROGRESS;
>  }
> @@ -219,7 +266,7 @@ static void sierra_pre_sim(struct ofono_
>  	DBG("%p", modem);
> =

>  	ofono_devinfo_create(modem, 0, "atmodem", data->modem);
> -	sim =3D ofono_sim_create(modem, OFONO_VENDOR_SIERRA,
> +	sim =3D ofono_sim_create(modem, data->vendor,
>  					"atmodem", data->modem);
> =

>  	if (sim)
> @@ -237,7 +284,7 @@ static void sierra_post_sim(struct ofono
>  	ofono_phonebook_create(modem, 0, "atmodem", data->modem);
> =

>  	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->modem);
> -	gc =3D ofono_gprs_context_create(modem, 0, "swmodem", data->modem);
> +	gc =3D ofono_gprs_context_create(modem, data->vendor, "swmodem", data->=
modem);
> =

>  	if (gprs && gc)
>  		ofono_gprs_add_context(gprs, gc);
> =


Regards,
-Denis


--===============5484672099190744948==--

