Content-Type: multipart/mixed; boundary="===============9162035160786264205=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gemalto: add PIN retries support
Date: Fri, 03 Nov 2017 13:12:53 -0500
Message-ID: <585b6aab-85e5-0283-0bbb-41849b3534ec@gmail.com>
In-Reply-To: <4e565cf20cfc65f00a382e19803627ce@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9162035160786264205==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gabriel,

On 11/03/2017 07:06 AM, Gabriel LUCAS wrote:
>  From 4157f3e7aa0eb16eec0b1ccf87946ecf53539090 Mon Sep 17 00:00:00 2001
> From: Gabriel Lucas <gabriel.lucas@smile.fr>
> Date: Tue, 24 Oct 2017 11:15:58 +0200
> Subject: [PATCH] gemalto: add PIN retries support
> Signed-off-by: Gabriel Lucas <gabriel.lucas@smile.fr>
> =

> In SimManager, the Retries property isn't used for gemalto modems.
> The at command AT^SPIC is used to get the remaining retries left
> for the current required password type.
> =

> This commit adds the implementation in the SIM driver of the retries
> queries.
> ---
>  =C2=A0drivers/atmodem/sim.c | 45 +++++++++++++++++++++++++++++++++++++++=
++++++
>  =C2=A0plugins/gemalto.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
>  =C2=A02 files changed, 47 insertions(+), 1 deletion(-)

This patch doesn't apply. It looks like whitespace is corrupted, tabs =

switched to spaces, etc.  Are you using Microsoft products by any chance?

> =

> diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
> index 8665274..ce70135 100644
> --- a/drivers/atmodem/sim.c
> +++ b/drivers/atmodem/sim.c
> @@ -70,6 +70,7 @@ static const char *pct_prefix[] =3D { "#PCT:", NULL };
>  =C2=A0static const char *pnnm_prefix[] =3D { "+PNNM:", NULL };
>  =C2=A0static const char *qpinc_prefix[] =3D { "+QPINC:", NULL };
>  =C2=A0static const char *upincnt_prefix[] =3D { "+UPINCNT:", NULL };
> +static const char *spic_prefix[] =3D { "^SPIC:", NULL };
>  =C2=A0static const char *none_prefix[] =3D { NULL };
> =

>  =C2=A0static void at_crsm_info_cb(gboolean ok, GAtResult *result, gpoint=
er =

> user_data)
> @@ -1054,6 +1055,45 @@ error:
>  =C2=A0=C2=A0=C2=A0=C2=A0 CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
>  =C2=A0}
> =

> +static void spic_cb(gboolean ok, GAtResult *result, gpointer user_data)
> +{
> +=C2=A0=C2=A0=C2=A0 struct cb_data *cbd =3D user_data;
> +=C2=A0=C2=A0=C2=A0 struct ofono_sim *sim =3D cbd->user;
> +=C2=A0=C2=A0=C2=A0 ofono_sim_pin_retries_cb_t cb =3D cbd->cb;
> +=C2=A0=C2=A0=C2=A0 const char *final =3D g_at_result_final_response(resu=
lt);
> +=C2=A0=C2=A0=C2=A0 GAtResultIter iter;
> +=C2=A0=C2=A0=C2=A0 struct ofono_error error;
> +=C2=A0=C2=A0=C2=A0 int retries[OFONO_SIM_PASSWORD_INVALID];
> +=C2=A0=C2=A0=C2=A0 size_t i;
> +=C2=A0=C2=A0=C2=A0 int pin_type =3D ofono_sim_get_password_type(sim);
> +
> +=C2=A0=C2=A0=C2=A0 decode_at_error(&error, final);
> +
> +=C2=A0=C2=A0=C2=A0 if (!ok) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cb(&error, NULL, cbd->data);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < OFONO_SIM_PASSWORD_INVALID; i++)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retries[i] =3D -1;
> +
> +=C2=A0=C2=A0=C2=A0 g_at_result_iter_init(&iter, result);
> +
> +=C2=A0=C2=A0=C2=A0 if (!g_at_result_iter_next(&iter, "^SPIC:"))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
> +
> +=C2=A0=C2=A0=C2=A0 if (!g_at_result_iter_next_number(&iter, &retries[pin=
_type]))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
> +
> +=C2=A0=C2=A0=C2=A0 DBG("Retry : %d, type : %d", retries[pin_type], pin_t=
ype);
> +=C2=A0=C2=A0=C2=A0 cb(&error, retries, cbd->data);
> +
> +=C2=A0=C2=A0=C2=A0 return;
> +
> +error:
> +=C2=A0=C2=A0=C2=A0 CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
> +}
> +
>  =C2=A0static void at_pin_retries_query(struct ofono_sim *sim,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_sim_pin_retries_cb_t=
 cb,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *data)
> @@ -1126,6 +1166,11 @@ static void at_pin_retries_query(struct ofono_sim =

> *sim,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 upincnt_cb, cbd, g_free) >=
 0)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 return;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0=C2=A0 case OFONO_VENDOR_CINTERION:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (g_at_chat_send(sd->chat, =
"AT^SPIC", spic_prefix,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spic_cb, cbd, g_free) > 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>  =C2=A0=C2=A0=C2=A0=C2=A0 default:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (g_at_chat_send(sd->=
chat, "AT+CPINR", cpinr_prefixes,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 at_cpinr_cb, cbd, g_free) =
> 0)
> diff --git a/plugins/gemalto.c b/plugins/gemalto.c
> index 45ec0cf..3739d7b 100644
> --- a/plugins/gemalto.c
> +++ b/plugins/gemalto.c
> @@ -420,7 +420,8 @@ static void gemalto_pre_sim(struct ofono_modem *modem)
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0 ofono_devinfo_create(modem, 0, "atmodem", data-=
>app);
>  =C2=A0=C2=A0=C2=A0=C2=A0 ofono_location_reporting_create(modem, 0, "gema=
ltomodem", data->app);
> -=C2=A0=C2=A0=C2=A0 sim =3D ofono_sim_create(modem, 0, "atmodem", data->a=
pp);
> +=C2=A0=C2=A0=C2=A0 sim =3D ofono_sim_create(modem, OFONO_VENDOR_CINTERIO=
N, "atmodem",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->ap=
p);
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0 if (sim && data->have_sim =3D=3D TRUE)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ofono_sim_inserted_noti=
fy(sim, TRUE);

This part should be in a separate commit.  See 'HACKING', 'Submitting =

patches' in ofono git.

Regards,
-Denis

--===============9162035160786264205==--

