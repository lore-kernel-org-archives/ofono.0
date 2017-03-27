Content-Type: multipart/mixed; boundary="===============7087880137804264070=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: telit - re-attach gprs automatically
Date: Sun, 26 Mar 2017 22:50:52 -0500
Message-ID: <4c89c35c-a1ab-cf33-2633-c1a1a6e5aac6@gmail.com>
In-Reply-To: <1490635091-28928-1-git-send-email-lnowak.tyco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7087880137804264070==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On 03/27/2017 12:18 PM, Lukasz Nowak wrote:
> From: Lukasz Nowak <lnowak@tycoint.com>
>
> Telit AT modem firmware (tested with UE910-EUR) generates
> +CGREG: 0\r\n\r\n+CGEV: NW DETACH
> after a context is de-activated and ppp connection closed.
> Then, after a random amount of time (observed from a few seconds
> to a few hours), an unsolicited +CGREG: 1 arrives.
> Attempt to fix the problem, by sending AT+CGATT=3D1 once.
> This does not re-activate the context, but if a network connection
> is still correct, will generate an immediate +CGREG: 1.
> ---
>  drivers/atmodem/gprs.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
> index 7ea9f00..ba8646c 100644
> --- a/drivers/atmodem/gprs.c
> +++ b/drivers/atmodem/gprs.c
> @@ -50,6 +50,7 @@ struct gprs_data {
>  	GAtChat *chat;
>  	unsigned int vendor;
>  	unsigned int last_auto_context_id;
> +	gboolean network_detach_retry;

This variable makes no sense.  telit_try_reattach or something.

>  };
>
>  static void at_cgatt_cb(gboolean ok, GAtResult *result, gpointer user_da=
ta)
> @@ -194,6 +195,28 @@ static void cgreg_notify(GAtResult *result, gpointer=
 user_data)
>  				NULL, NULL, NULL, gd->vendor) =3D=3D FALSE)
>  		return;
>
> +	DBG("status=3D%d vendor=3D%d retry=3D%d", status, gd->vendor, gd->netwo=
rk_detach_retry);
> +
> +	/*
> +	 * Telit AT modem firmware (tested with UE910-EUR) generates
> +	 * +CGREG: 0\r\n\r\n+CGEV: NW DETACH
> +	 * after a context is de-activated and ppp connection closed.
> +	 * Then, after a random amount of time (observed from a few seconds
> +	 * to a few hours), an unsolicited +CGREG: 1 arrives.
> +	 * Attempt to fix the problem, by sending AT+CGATT=3D1 once.
> +	 * This does not re-activate the context, but if a network connection
> +	 * is still correct, will generate an immediate +CGREG: 1.
> +	 */
> +	if (gd->vendor =3D=3D OFONO_VENDOR_TELIT &&
> +		!status && !gd->network_detach_retry) {

doc/coding-style.txt item M4

Also, this should probably be done only in the case that the driver has =

been attached.  E.g. .set_attached was last called with attached=3D1

> +		DBG("Trying to re-attach gprs network");
> +		gd->network_detach_retry =3D TRUE;
> +		g_at_chat_send(gd->chat, "AT+CGATT=3D1", none_prefix,
> +				NULL, NULL, NULL);
> +		return;
> +	}
> +	gd->network_detach_retry =3D FALSE;
> +

doc/coding-style.txt item M1

Also, this belongs in an if-block for the TELIT vendor.

e.g.

if (vendor =3D=3D TELIT) {
	if (status ...) {

	}

	gd->telit_attach_retry =3D ...
}

>  	ofono_gprs_status_notify(gprs, status);
>  }
>
> @@ -214,6 +237,10 @@ static void cgev_notify(GAtResult *result, gpointer =
user_data)
>
>  	if (g_str_equal(event, "NW DETACH") ||
>  			g_str_equal(event, "ME DETACH")) {
> +
> +		if (gd->vendor =3D=3D OFONO_VENDOR_TELIT &&
> +				gd->network_detach_retry)
> +			return;

doc/coding-style.txt item M1.

>  		ofono_gprs_detached_notify(gprs);
>  		return;
>  	} else if (g_str_has_prefix(event, "ME PDN ACT")) {
>

Regards,
-Denis

--===============7087880137804264070==--

