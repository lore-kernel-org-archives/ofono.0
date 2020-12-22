Content-Type: multipart/mixed; boundary="===============6651095212953524155=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/5] gemalto: gprs: support automatic context activation
Date: Tue, 22 Dec 2020 10:58:34 -0600
Message-ID: <8e4275be-13f3-33a6-5aa6-1df088ab724a@gmail.com>
In-Reply-To: <20201221200133.522933-4-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6651095212953524155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On 12/21/20 2:01 PM, Sergey Matyukevich wrote:
> From: Sergey Matyukevich <matyukevich@arrival.com>
> =

> Implement read_settings function to get configuration for automatic
> contexts. Fix the issue uncovered by added support for automatic
> context activation: do not use AT+CGACT for the contexts handled
> by AT^SWWAN. As per modem specs, CGACT context can not be reused
> for SWWAN. Though that worked for some reason when automatic
> context was reactivated without proper deactivation.
> ---
>   drivers/gemaltomodem/gprs-context.c | 110 +++++++++++++++-------------
>   1 file changed, 59 insertions(+), 51 deletions(-)
> =

> diff --git a/drivers/gemaltomodem/gprs-context.c b/drivers/gemaltomodem/g=
prs-context.c
> index 322a5f98..680f01ab 100644
> --- a/drivers/gemaltomodem/gprs-context.c
> +++ b/drivers/gemaltomodem/gprs-context.c
> @@ -50,70 +50,61 @@ struct gprs_context_data {
>   	void *cb_data;
>   };
>   =

> -static void cgact_enable_cb(gboolean ok, GAtResult *result,
> -				gpointer user_data)
> +static void set_gprs_context_interface(struct ofono_gprs_context *gc)
>   {
> -	struct ofono_gprs_context *gc =3D user_data;
> -	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
>   	struct ofono_modem *modem;
>   	const char *interface;
> -	char buf[64];
> +
> +	modem =3D ofono_gprs_context_get_modem(gc);
> +	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
> +	ofono_gprs_context_set_interface(gc, interface);
> +}
> +
> +static void swwan_cb(gboolean ok, GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_gprs_context *gc =3D user_data;
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	struct ofono_error error;
>   =

>   	DBG("ok %d", ok);
>   =

>   	if (!ok) {
> -		struct ofono_error error;
> -
> +		ofono_error("Unable to activate context");
> +		ofono_gprs_context_deactivated(gc, gcd->active_context);
>   		gcd->active_context =3D 0;

This seems a bit strange.  Are you signaling success to the core too early

> -
>   		decode_at_error(&error, g_at_result_final_response(result));
>   		gcd->cb(&error, gcd->cb_data);
> -
>   		return;
>   	}
> -
> -	snprintf(buf, sizeof(buf), "AT^SWWAN=3D1,%u", gcd->active_context);
> -	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
> -
> -	modem =3D ofono_gprs_context_get_modem(gc);
> -	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
> -	ofono_gprs_context_set_interface(gc, interface);
> -
> -	/* Use DHCP */
> -	ofono_gprs_context_set_ipv4_address(gc, NULL, 0);
> -
> -	CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);
>   }
>   =

>   static void cgdcont_enable_cb(gboolean ok, GAtResult *result,
> -				gpointer user_data)
> +			gpointer user_data)

nit: This is superfluous and also see doc/coding-style.txt item M4

>   {
>   	struct ofono_gprs_context *gc =3D user_data;
>   	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	struct ofono_error error;
>   	char buf[64];
>   =

>   	DBG("ok %d", ok);
>   =

>   	if (!ok) {
> -		struct ofono_error error;
> -
>   		gcd->active_context =3D 0;
> -
>   		decode_at_error(&error, g_at_result_final_response(result));
>   		gcd->cb(&error, gcd->cb_data);
> -
>   		return;
>   	}
>   =

> -	snprintf(buf, sizeof(buf), "AT+CGACT=3D1,%u", gcd->active_context);
> -
> -	if (g_at_chat_send(gcd->chat, buf, none_prefix,
> -				cgact_enable_cb, gc, NULL) =3D=3D 0)
> -		goto error;
> +	snprintf(buf, sizeof(buf), "AT^SWWAN=3D1,%u", gcd->active_context);
> +	if (g_at_chat_send(gcd->chat, buf, none_prefix, swwan_cb, gc, NULL)) {

Note, this returns > 0 when the command has been queued, not that it has be=
en =

sent or replied to yet...

> +		set_gprs_context_interface(gc);
> +		/* Use DHCP */
> +		ofono_gprs_context_set_ipv4_address(gc, NULL, 0);

If these modems can only do DHCP, then might be cleaner to move the 'Use DH=
CP' =

bits into set_gprs_context_interface.  And maybe rename it to make things =

clearer, if needed.

>   =

> -	return;
> +		CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);

Are you sure you don't want to wait until swwan_cb to return success to the =

core?  AT^SWWAN can still fail...?

> +		return;
> +	}
>   =

> -error:
>   	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
>   }
>   =


<snip>

> @@ -185,17 +170,39 @@ static void gemalto_gprs_deactivate_primary(struct =
ofono_gprs_context *gc,
>   	gcd->cb =3D cb;
>   	gcd->cb_data =3D data;
>   =

> -	snprintf(buf, sizeof(buf), "AT+CGACT=3D0,%u", cid);
> +	snprintf(buf, sizeof(buf), "AT^SWWAN=3D0,%u", gcd->active_context);
>   =

>   	if (g_at_chat_send(gcd->chat, buf, none_prefix,
> -				cgact_disable_cb, gc, NULL) =3D=3D 0)
> -		goto error;
> -
> -	return;
> +				deactivate_cb, gc, NULL))
> +		return;
>   =

> -error:
>   	CALLBACK_WITH_FAILURE(cb, data);
> +}
> +
> +static void gemalto_gprs_read_settings(struct ofono_gprs_context *gc,
> +					unsigned int cid,
> +					ofono_gprs_context_cb_t cb, void *data)
> +{
> +	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
> +	char buf[64];
> +
> +	DBG("cid %u", cid);
> +
> +	gcd->active_context =3D cid;
> +	gcd->cb =3D cb;
> +	gcd->cb_data =3D data;
> +
> +	snprintf(buf, sizeof(buf), "AT^SWWAN=3D1,%u", gcd->active_context);

nit: doc/coding-style.txt item M1

> +	if (g_at_chat_send(gcd->chat, buf, none_prefix, swwan_cb, gc, NULL)) {
> +		set_gprs_context_interface(gc);
> +		/* Use DHCP */
> +		ofono_gprs_context_set_ipv4_address(gc, NULL, 0);
>   =

> +		CALLBACK_WITH_SUCCESS(gcd->cb, gcd->cb_data);

Are you sure you don't want to wait until swwan_cb to return success to the =

core?  I mean AT^SWWAN might still fail...?

I also find it a bit strange that an already-active context needs to go thr=
ough =

the SWWAN dance, but if that's the way the firmware works, OK.   Might be w=
orth =

a comment...?

> +		return;
> +	}
> +
> +	CALLBACK_WITH_FAILURE(gcd->cb, gcd->cb_data);
>   }
>   =

>   static void cgev_notify(GAtResult *result, gpointer user_data)
> @@ -267,6 +274,7 @@ static const struct ofono_gprs_context_driver driver =
=3D {
>   	.remove			=3D gemalto_gprs_context_remove,
>   	.activate_primary	=3D gemalto_gprs_activate_primary,
>   	.deactivate_primary	=3D gemalto_gprs_deactivate_primary,
> +	.read_settings		=3D gemalto_gprs_read_settings,
>   };
>   =

>   void gemalto_gprs_context_init(void)
> =


Regards,
-Denis
--===============6651095212953524155==--

