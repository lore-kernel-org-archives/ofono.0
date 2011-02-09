Content-Type: multipart/mixed; boundary="===============9132354552794989312=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [sim-ready-nofify-v5 PATCH 2/3] atmodem/sim: use
 ofono_sim_ready_notify
Date: Wed, 09 Feb 2011 16:09:53 -0600
Message-ID: <4D5310B1.8010007@gmail.com>
In-Reply-To: <1297168379-16400-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9132354552794989312==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 02/08/2011 06:32 AM, Pekka.Pessi(a)nokia.com wrote:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> Schedule a call to ofono_sim_ready_notify after pin code query returns
> SIM READY.
> =

> Vendor quirks:
> - IFX: register unsolicated +XSIM result code
> - MBM: register unsolicated *EPEV result code
> ---
>  drivers/atmodem/sim.c |  166 ++++++++++++++++++++++++++++++++++---------=
-----
>  1 files changed, 117 insertions(+), 49 deletions(-)
> =

> diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
> index d9c0d8d..666edbe 100644
> --- a/drivers/atmodem/sim.c
> +++ b/drivers/atmodem/sim.c
> @@ -46,10 +46,14 @@
>  =

>  #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>  =

> +#define READY_TIMEOUT		5000
> +
>  struct sim_data {
>  	GAtChat *chat;
>  	unsigned int vendor;
>  	guint ready_id;
> +	guint ready_source;
> +	ofono_bool_t ready;
>  };
>  =

>  static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
> @@ -679,10 +683,55 @@ static void at_pin_retries_query(struct ofono_sim *=
sim,
>  	CALLBACK_WITH_FAILURE(cb, NULL, data);
>  }
>  =

> +static void ready_unregister_and_notify(struct ofono_sim *sim)
> +{
> +	struct sim_data *sd =3D ofono_sim_get_data(sim);
> +
> +	DBG("");
> +
> +	if (sd->ready_source > 0) {
> +		g_source_remove(sd->ready_source);
> +		sd->ready_source =3D 0;
> +	}
> +
> +	ofono_sim_ready_notify(sim);
> +}
> +
> +static gboolean ready_timeout(gpointer user_data)
> +{
> +	struct ofono_sim *sim =3D user_data;
> +	struct sim_data *sd =3D ofono_sim_get_data(sim);
> +
> +	DBG("");
> +
> +	sd->ready_source =3D 0;
> +
> +	ofono_sim_ready_notify(sim);
> +
> +	return FALSE;
> +}
> +
> +static void at_wait_for_ready(struct ofono_sim *sim)
> +{
> +	struct sim_data *sd =3D ofono_sim_get_data(sim);
> +	guint timeout;
> +
> +	if (sd->ready_source > 0)
> +		return;
> +
> +	if (!sd->ready && sd->ready_id > 0)
> +		timeout =3D READY_TIMEOUT;
> +	else
> +		timeout =3D 0;
> +
> +	sd->ready_source =3D g_timeout_add(timeout, ready_timeout, sim);
> +}
> +
>  static void at_cpin_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
>  {
>  	struct cb_data *cbd =3D user_data;
> -	struct sim_data *sd =3D ofono_sim_get_data(cbd->user);
> +	struct ofono_sim *sim =3D cbd->user;
> +	struct sim_data *sd =3D ofono_sim_get_data(sim);
>  	GAtResultIter iter;
>  	ofono_sim_passwd_cb_t cb =3D cbd->cb;
>  	struct ofono_error error;
> @@ -729,6 +778,11 @@ static void at_cpin_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
>  		return;
>  	}
>  =

> +	if (pin_type =3D=3D OFONO_SIM_PASSWORD_NONE)
> +		at_wait_for_ready(sim);
> +	else
> +		sd->ready =3D FALSE;
> +

So all this logic seems to work by luck.  oFono roughly does this:
pin_query:
send AT+CPIN?
if READY then set waiting_for_pin to none, and wait in
ofono_sim_ready_notify
if PIN then set waiting_for_pin to the pin, and wait in
ofono_sim_ready_notify

ofono_sim_ready_notify:
if waiting_for_pin is none proceed with initialization
otherwise go back to pin_query

Here's a log of this running on IFX:
ofonod[521]: Aux: > AT+CPIN?\r
ofonod[521]: Aux: < \r\n+CPIN: SIM PIN\r\n
ofonod[521]: Aux: < \r\nOK\r\n
ofonod[521]: drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: SIM PIN
....
ofonod[521]: Aux: > AT+CPIN=3D"0000"\r
ofonod[521]: Aux: < \r\nOK\r\n
ofonod[521]: Aux: > AT+CPIN?\r
ofonod[521]: Aux: < \r\n+CME ERROR: 14\r\n
ofonod[521]: Querying PIN authentication state failed
....
ofonod[521]: Aux: < \r\n+XSIM: 7\r\n
ofonod[521]: drivers/atmodem/sim.c:at_xsim_notify()
ofonod[521]: drivers/atmodem/sim.c:ready_unregister_and_notify()
ofonod[521]: src/sim.c:ofono_sim_ready_notify()
ofonod[521]: plugins/ifx.c:xsim_notify() state 7
ofonod[521]: Aux: > AT+CPIN?\r
ofonod[521]: Aux: < \r\n+CPIN: READY\r\n
ofonod[521]: Aux: < \r\nOK\r\n
ofonod[521]: drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: READY
ofonod[521]: drivers/atmodem/sim.c:at_pin_retries_query()
ofonod[521]: drivers/atmodem/sim.c:ready_timeout()
ofonod[521]: src/sim.c:ofono_sim_ready_notify()

As you can see, we are in fact calling ofono_sim_ready_notify twice in
short succession.  The only reason we're not stuck for 5 seconds the
second time around is that the xsim notification function sets ready to
TRUE.  This is all pretty convoluted.  I don't really like this@all.

Another case to consider is a cold boot quirked modem, PIN disabled.  We
are highly likely to receive XSIM way before we even query the PIN.  So
ready is false, ready_id is > 0 and we end up waiting for 5 seconds here
for no good reason.

>  	DBG("crsm_pin_cb: %s", pin_required);
>  =

>  	cb(&error, pin_type, cbd->data);
> @@ -753,13 +807,13 @@ static void at_pin_query(struct ofono_sim *sim, ofo=
no_sim_passwd_cb_t cb,
>  =

>  static void at_xsim_notify(GAtResult *result, gpointer user_data)
>  {
> -	struct cb_data *cbd =3D user_data;
> -	struct sim_data *sd =3D cbd->user;
> -	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
> -	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_NO_ERROR };
> +	struct ofono_sim *sim =3D user_data;
> +	struct sim_data *sd =3D ofono_sim_get_data(sim);
>  	GAtResultIter iter;
>  	int state;
>  =

> +	DBG("");
> +
>  	g_at_result_iter_init(&iter, result);
>  =

>  	if (!g_at_result_iter_next(&iter, "+XSIM:"))
> @@ -776,65 +830,40 @@ static void at_xsim_notify(GAtResult *result, gpoin=
ter user_data)
>  		return;
>  	}
>  =

> -	cb(&error, cbd->data);
> +	sd->ready =3D TRUE;
>  =

> -	g_at_chat_unregister(sd->chat, sd->ready_id);
> -	sd->ready_id =3D 0;
> +	if (sd->ready_source > 0)
> +		ready_unregister_and_notify(sim);
>  }
>  =

>  static void at_epev_notify(GAtResult *result, gpointer user_data)
>  {
> -	struct cb_data *cbd =3D user_data;
> -	struct sim_data *sd =3D cbd->user;
> -	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
> -	struct ofono_error error =3D { .type =3D OFONO_ERROR_TYPE_NO_ERROR };
> +	struct ofono_sim *sim =3D user_data;
> +	struct sim_data *sd =3D ofono_sim_get_data(sim);
>  =

> -	cb(&error, cbd->data);
> +	DBG("");
>  =

> -	g_at_chat_unregister(sd->chat, sd->ready_id);
> -	sd->ready_id =3D 0;
> +	sd->ready =3D TRUE;
> +
> +	if (sd->ready_source > 0)
> +		ready_unregister_and_notify(sim);
>  }
>  =

>  static void at_pin_send_cb(gboolean ok, GAtResult *result,
>  				gpointer user_data)
>  {
>  	struct cb_data *cbd =3D user_data;
> -	struct sim_data *sd =3D cbd->user;
> +	struct ofono_sim *sim =3D cbd->user;
> +	struct sim_data *sd =3D ofono_sim_get_data(sim);
>  	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
>  	struct ofono_error error;
>  =

> -	decode_at_error(&error, g_at_result_final_response(result));
> +	if (ok && sd->ready_id)
> +		at_wait_for_ready(sim);

Did you intend if (ok && sd_ready_id =3D=3D 0) here?

Otherwise I don't see how non-quirked modems ever signal sim_ready or
why you would want to start a timer if you know a notification is coming
anyway.

>  =

> -	if (!ok)
> -		goto done;
> -
> -	switch (sd->vendor) {
> -	case OFONO_VENDOR_IFX:
> -		/*
> -		 * On the IFX modem, AT+CPIN? can return READY too
> -		 * early and so use +XSIM notification to detect
> -		 * the ready state of the SIM.
> -		 */
> -		sd->ready_id =3D g_at_chat_register(sd->chat, "+XSIM",
> -							at_xsim_notify,
> -							FALSE, cbd, g_free);
> -		return;
> -	case OFONO_VENDOR_MBM:
> -		/*
> -		 * On the MBM modem, AT+CPIN? keeps returning SIM PIN
> -		 * for a moment after successful AT+CPIN=3D"..", but then
> -		 * sends *EPEV when that changes.
> -		 */
> -		sd->ready_id =3D g_at_chat_register(sd->chat, "*EPEV",
> -							at_epev_notify,
> -							FALSE, cbd, g_free);
> -		return;
> -	}
> +	decode_at_error(&error, g_at_result_final_response(result));
>  =

> -done:
>  	cb(&error, cbd->data);
> -
> -	g_free(cbd);
>  }
>  =

>  static void at_pin_send(struct ofono_sim *sim, const char *passwd,
> @@ -845,12 +874,14 @@ static void at_pin_send(struct ofono_sim *sim, cons=
t char *passwd,
>  	char buf[64];
>  	int ret;
>  =

> -	cbd->user =3D sd;
> +	cbd->user =3D sim;
> +
> +	sd->ready =3D FALSE;
>  =

>  	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\"", passwd);
>  =

>  	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
> -				at_pin_send_cb, cbd, NULL);
> +				at_pin_send_cb, cbd, g_free);
>  =

>  	memset(buf, 0, sizeof(buf));
>  =

> @@ -871,12 +902,14 @@ static void at_pin_send_puk(struct ofono_sim *sim, =
const char *puk,
>  	char buf[64];
>  	int ret;
>  =

> -	cbd->user =3D sd;
> +	cbd->user =3D sim;
> +
> +	sd->ready =3D FALSE;
>  =

>  	snprintf(buf, sizeof(buf), "AT+CPIN=3D\"%s\",\"%s\"", puk, passwd);
>  =

>  	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
> -				at_pin_send_cb, cbd, NULL);
> +				at_pin_send_cb, cbd, g_free);
>  =

>  	memset(buf, 0, sizeof(buf));
>  =

> @@ -1038,6 +1071,35 @@ static gboolean at_sim_register(gpointer user)
>  	return FALSE;
>  }
>  =

> +static void at_register_ready(struct ofono_sim *sim)
> +{
> +	struct sim_data *sd =3D ofono_sim_get_data(sim);
> +
> +	switch (sd->vendor) {
> +	case OFONO_VENDOR_IFX:
> +		/*
> +		 * On the IFX modem, AT+CPIN? can return READY too
> +		 * early and so use +XSIM notification to detect
> +		 * the ready state of the SIM.
> +		 */
> +		sd->ready_id =3D g_at_chat_register(sd->chat, "+XSIM",
> +							at_xsim_notify,
> +							FALSE, sim, NULL);
> +		break;
> +
> +	case OFONO_VENDOR_MBM:
> +		/*
> +		 * On the MBM modem, AT+CPIN? keeps returning SIM PIN
> +		 * for a moment after successful AT+CPIN=3D"..", but then
> +		 * sends *EPEV when that changes.
> +		 */
> +		sd->ready_id =3D g_at_chat_register(sd->chat, "*EPEV",
> +							at_epev_notify,
> +							FALSE, sim, NULL);
> +		break;
> +	}
> +}
> +
>  static int at_sim_probe(struct ofono_sim *sim, unsigned int vendor,
>  				void *data)
>  {
> @@ -1060,6 +1122,9 @@ static int at_sim_probe(struct ofono_sim *sim, unsi=
gned int vendor,
>  	}
>  =

>  	ofono_sim_set_data(sim, sd);
> +
> +	at_register_ready(sim);
> +
>  	g_idle_add(at_sim_register, sim);
>  =

>  	return 0;
> @@ -1071,6 +1136,9 @@ static void at_sim_remove(struct ofono_sim *sim)
>  =

>  	ofono_sim_set_data(sim, NULL);
>  =

> +	if (sd->ready_source > 0)
> +		g_source_remove(sd->ready_source);
> +
>  	g_at_chat_unref(sd->chat);
>  	g_free(sd);
>  }

Regards,
-Denis

--===============9132354552794989312==--

