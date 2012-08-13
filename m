Content-Type: multipart/mixed; boundary="===============8229112436059001865=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/8] netreg: adapt CMER and CIEV for telit
Date: Mon, 13 Aug 2012 11:25:25 -0500
Message-ID: <50292A75.3040005@gmail.com>
In-Reply-To: <1344864218-23167-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8229112436059001865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

On 08/13/2012 08:23 AM, Christopher Vogl wrote:
> Telit uses a 2 to enable indicator event reporting and
> indicators in a +CIEV URC are identified by strings, not numbers.

Yikes, can you include a sample AT trace?  It sounds like something is =

going terribly wrong with CIEVs.

> ---
>   drivers/atmodem/network-registration.c |   46 +++++++++++++++++++++++++=
-------
>   1 files changed, 36 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/net=
work-registration.c
> index 3d09913..7083efe 100644
> --- a/drivers/atmodem/network-registration.c
> +++ b/drivers/atmodem/network-registration.c
> @@ -54,6 +54,7 @@ struct netreg_data {
>   	GAtChat *chat;
>   	char mcc[OFONO_MAX_MCC_LENGTH + 1];
>   	char mnc[OFONO_MAX_MNC_LENGTH + 1];
> +	const char *signal_identifier;
>   	int signal_index; /* If strength is reported via CIND */
>   	int signal_min; /* min strength reported via CIND */
>   	int signal_max; /* max strength reported via CIND */
> @@ -734,6 +735,7 @@ static void ciev_notify(GAtResult *result, gpointer u=
ser_data)
>   	struct ofono_netreg *netreg =3D user_data;
>   	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
>   	int strength, ind;
> +	const char *ind_str;
>   	GAtResultIter iter;
>
>   	g_at_result_iter_init(&iter, result);
> @@ -741,11 +743,23 @@ static void ciev_notify(GAtResult *result, gpointer=
 user_data)
>   	if (!g_at_result_iter_next(&iter, "+CIEV:"))
>   		return;
>
> -	if (!g_at_result_iter_next_number(&iter,&ind))
> -		return;
> +	/*
> +	 * Telit uses strings to identify indicators.
> +	 */
> +	if (nd->vendor =3D=3D OFONO_VENDOR_TELIT) {
> +		if (!g_at_result_iter_next_unquoted_string(&iter,&ind_str))
> +			return;
>
> -	if (ind !=3D nd->signal_index)
> -		return;
> +		if (!g_str_equal(nd->signal_identifier, ind_str))
> +			return;
> +	}
> +	else {
> +		if (!g_at_result_iter_next_number(&iter,&ind))
> +			return;
> +		=

> +		if (ind !=3D nd->signal_index)
> +			return;
> +	}

If Telit is indeed this broken, then likely you can simply create a =

telit version of this function.  Then you can skip storing =

nd->signal_identifier and the like.  It would also make things much more =

readable.

>
>   	if (!g_at_result_iter_next_number(&iter,&strength))
>   		return;
> @@ -754,6 +768,8 @@ static void ciev_notify(GAtResult *result, gpointer u=
ser_data)
>   		strength =3D -1;
>   	else
>   		strength =3D (strength * 100) / (nd->signal_max - nd->signal_min);
> +	=

> +	DBG("Strength: %d", strength);

This might belong in a separate patch.

>
>   	ofono_netreg_strength_notify(netreg, strength);
>   }
> @@ -1401,12 +1417,12 @@ static void cind_support_cb(gboolean ok, GAtResul=
t *result, gpointer user_data)
>   	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
>   	GAtResultIter iter;
>   	const char *str;
> -	char *signal_identifier =3D "signal";
> +	const char *cmd;
>   	int index;
>   	int min =3D 0;
>   	int max =3D 0;
>   	int tmp_min, tmp_max, invalid;
> -
> +	=

>   	if (!ok)
>   		goto error;
>
> @@ -1422,8 +1438,10 @@ static void cind_support_cb(gboolean ok, GAtResult=
 *result, gpointer user_data)
>   	 */
>   	if (nd->vendor =3D=3D OFONO_VENDOR_TELIT) {
>   		g_at_result_iter_open_list(&iter);
> -		signal_identifier =3D "rssi";
> +		nd->signal_identifier =3D "rssi";
>   	}
> +	else
> +		nd->signal_identifier =3D "signal";
>
>   	while (g_at_result_iter_open_list(&iter)) {
>   		/* Reset invalid default value for every token */
> @@ -1449,7 +1467,7 @@ static void cind_support_cb(gboolean ok, GAtResult =
*result, gpointer user_data)
>   		if (!g_at_result_iter_close_list(&iter))
>   			goto error;
>
> -		if (g_str_equal(signal_identifier, str) =3D=3D TRUE) {
> +		if (g_str_equal(nd->signal_identifier, str) =3D=3D TRUE) {
>   			nd->signal_index =3D index;
>   			nd->signal_min =3D min;
>   			nd->signal_max =3D max;
> @@ -1464,8 +1482,16 @@ static void cind_support_cb(gboolean ok, GAtResult=
 *result, gpointer user_data)
>
>   	if (nd->signal_index =3D=3D 0)
>   		goto error;
> -
> -	g_at_chat_send(nd->chat, "AT+CMER=3D3,0,0,1", NULL,
> +	=

> +	/*
> +	 * Telit uses a 2 to enable indicator event reporting, 1 is undefined.
> +	 */
> +	if (nd->vendor =3D=3D OFONO_VENDOR_TELIT)
> +		cmd =3D "AT+CMER=3D3,0,0,2";
> +	else
> +		cmd =3D "AT+CMER=3D3,0,0,1";
> +	=

> +	g_at_chat_send(nd->chat, cmd, NULL,

This looks fine, but we might be better off with something similar to =

how the CNMI string is being built in drivers/atmodem/sms.c.  E.g. query =

which CMER modes are supported and select these intelligently.

>   			NULL, NULL, NULL);
>   	g_at_chat_register(nd->chat, "+CIEV:",
>   				ciev_notify, FALSE, netreg, NULL);

Regards,
-Denis

--===============8229112436059001865==--

