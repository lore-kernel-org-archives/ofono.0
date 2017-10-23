Content-Type: multipart/mixed; boundary="===============0385593404459640560=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: Query the list of supported <fac>s from the modem
Date: Mon, 23 Oct 2017 14:39:22 -0500
Message-ID: <6f768b28-81a9-05e0-fa37-63e133fa3b2d@gmail.com>
In-Reply-To: <1508781458-17988-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0385593404459640560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 10/23/2017 12:57 PM, Slava Monich wrote:
> Not all modems support all <fac>s (particularly, "PS"), let's be polite
> and not ask them for the ones they don't support.
> ---
>   drivers/atmodem/sim.c | 69 ++++++++++++++++++++++++++++++++++++++++++--=
-------
>   1 file changed, 57 insertions(+), 12 deletions(-)
> =

> diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
> index 6395a04..effce6e 100644
> --- a/drivers/atmodem/sim.c
> +++ b/drivers/atmodem/sim.c
> @@ -52,6 +52,7 @@ struct sim_data {
>   	unsigned int vendor;
>   	guint ready_id;
>   	struct at_util_sim_state_query *sim_state_query;
> +	const char *passwd_fac[OFONO_SIM_PASSWORD_INVALID];

Okay, but why not just make this a bitmap instead?  I think we have like =

15 or 16 SIM passwords, so this could be all of 2 to 4 bytes.  Or use =

idmap...

>   };
>   =

>   static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
> @@ -1439,7 +1440,7 @@ static void at_lock_unlock_cb(gboolean ok, GAtResul=
t *result,
>   	cb(&error, cbd->data);
>   }
>   =

> -static const char *const at_clck_cpwd_fac[] =3D {
> +static const char *const at_clck_cpwd_fac[OFONO_SIM_PASSWORD_INVALID] =
=3D {

Is this really needed?  ARRAY_SIZE should still work...

>   	[OFONO_SIM_PASSWORD_SIM_PIN] =3D "SC",
>   	[OFONO_SIM_PASSWORD_SIM_PIN2] =3D "P2",
>   	[OFONO_SIM_PASSWORD_PHSIM_PIN] =3D "PS",
> @@ -1459,13 +1460,13 @@ static void at_pin_enable(struct ofono_sim *sim,
>   	struct cb_data *cbd =3D cb_data_new(cb, data);
>   	char buf[64];
>   	int ret;
> -	unsigned int len =3D sizeof(at_clck_cpwd_fac) / sizeof(*at_clck_cpwd_fa=
c);
>   =

> -	if (passwd_type >=3D len || at_clck_cpwd_fac[passwd_type] =3D=3D NULL)
> +	if (passwd_type >=3D ARRAY_SIZE(sd->passwd_fac) ||
> +				sd->passwd_fac[passwd_type] =3D=3D NULL)
>   		goto error;
>   =

>   	snprintf(buf, sizeof(buf), "AT+CLCK=3D\"%s\",%i,\"%s\"",
> -			at_clck_cpwd_fac[passwd_type], enable ? 1 : 0, passwd);
> +			sd->passwd_fac[passwd_type], enable ? 1 : 0, passwd);

at_clck_cpwd_fac and passwd_fac contain the same info at a given index =

(if valid).  So this chunk can be omitted.  See using a bitmap above...

>   =

>   	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
>   				at_lock_unlock_cb, cbd, g_free);
> @@ -1490,14 +1491,13 @@ static void at_change_passwd(struct ofono_sim *si=
m,
>   	struct cb_data *cbd =3D cb_data_new(cb, data);
>   	char buf[64];
>   	int ret;
> -	unsigned int len =3D sizeof(at_clck_cpwd_fac) / sizeof(*at_clck_cpwd_fa=
c);
>   =

> -	if (passwd_type >=3D len ||
> -			at_clck_cpwd_fac[passwd_type] =3D=3D NULL)
> +	if (passwd_type >=3D ARRAY_SIZE(sd->passwd_fac) ||
> +			sd->passwd_fac[passwd_type] =3D=3D NULL)
>   		goto error;
>   =

>   	snprintf(buf, sizeof(buf), "AT+CPWD=3D\"%s\",\"%s\",\"%s\"",
> -			at_clck_cpwd_fac[passwd_type], old_passwd, new_passwd);
> +			sd->passwd_fac[passwd_type], old_passwd, new_passwd);
>   =

>   	ret =3D g_at_chat_send(sd->chat, buf, none_prefix,
>   				at_lock_unlock_cb, cbd, g_free);
> @@ -1550,13 +1550,13 @@ static void at_query_clck(struct ofono_sim *sim,
>   	struct sim_data *sd =3D ofono_sim_get_data(sim);
>   	struct cb_data *cbd =3D cb_data_new(cb, data);
>   	char buf[64];
> -	unsigned int len =3D sizeof(at_clck_cpwd_fac) / sizeof(*at_clck_cpwd_fa=
c);
>   =

> -	if (passwd_type >=3D len || at_clck_cpwd_fac[passwd_type] =3D=3D NULL)
> +	if (passwd_type >=3D ARRAY_SIZE(sd->passwd_fac) ||
> +				sd->passwd_fac[passwd_type] =3D=3D NULL)
>   		goto error;
>   =

>   	snprintf(buf, sizeof(buf), "AT+CLCK=3D\"%s\",2",
> -			at_clck_cpwd_fac[passwd_type]);
> +			sd->passwd_fac[passwd_type]);
>   =

>   	if (g_at_chat_send(sd->chat, buf, clck_prefix,
>   				at_lock_status_cb, cbd, g_free) > 0)
> @@ -1568,6 +1568,43 @@ error:
>   	CALLBACK_WITH_FAILURE(cb, -1, data);
>   }
>   =

> +static void at_clck_query_cb(gboolean ok, GAtResult *result, gpointer us=
er)
> +{
> +	struct ofono_sim *sim =3D user;
> +	struct sim_data *sd =3D ofono_sim_get_data(sim);
> +	GAtResultIter iter;
> +	const char *fac;
> +
> +	if (!ok)
> +		goto done;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	/* e.g. +CLCK: ("SC","FD","PN","PU","PP","PC","PF") */
> +	if (!g_at_result_iter_next(&iter, "+CLCK:") ||
> +				!g_at_result_iter_open_list(&iter))
> +		goto done;
> +
> +	memset(sd->passwd_fac, 0, sizeof(sd->passwd_fac));
> +
> +	while (g_at_result_iter_next_string(&iter, &fac)) {
> +		int i;
> +
> +		/* Find it in the list of known <fac>s */
> +		for (i =3D 0; i < ARRAY_SIZE(at_clck_cpwd_fac); i++) {
> +			if (!g_strcmp0(at_clck_cpwd_fac[i], fac)) {
> +				DBG("found %s", fac);
> +				/* at_clck_cpwd_fac[i] is a static string */
> +				sd->passwd_fac[i] =3D at_clck_cpwd_fac[i];

All this can do is set an appropriate bit

> +				break;
> +			}
> +		}
> +	}
> +
> +done:
> +	ofono_sim_register(sim);
> +}
> +
>   static gboolean at_sim_register(gpointer user)
>   {
>   	struct ofono_sim *sim =3D user;
> @@ -1591,7 +1628,15 @@ static int at_sim_probe(struct ofono_sim *sim, uns=
igned int vendor,
>   		g_at_chat_send(sd->chat, "AT*EPEE=3D1", NULL, NULL, NULL, NULL);
>   =

>   	ofono_sim_set_data(sim, sd);
> -	g_idle_add(at_sim_register, sim);
> +
> +	/* The default password -> <fac> map */
> +	memcpy(sd->passwd_fac, at_clck_cpwd_fac, sizeof(sd->passwd_fac));
> +
> +	/* Query supported <fac>s */
> +	if (!g_at_chat_send(sd->chat, "AT+CLCK=3D?", clck_prefix,
> +					at_clck_query_cb, sim, NULL)) {
> +		g_idle_add(at_sim_register, sim);
> +	}

This is a bit weird.  If we fail here just return an error.  Why would =

we proceed trying to initialize the atom driver?

>   =

>   	return 0;
>   }
> =


Regards,
-Denis

--===============0385593404459640560==--

