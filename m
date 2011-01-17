Content-Type: multipart/mixed; boundary="===============3965654996157153347=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH 1/1] atmodem: add ifx support for pin retries query
Date: Mon, 17 Jan 2011 17:45:08 -0200
Message-ID: <AANLkTikRMh02YxQww1ZxFwSTO6_OkM4=JV-b+COgH+eH@mail.gmail.com>
In-Reply-To: <1295288964-20278-2-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3965654996157153347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka

On Mon, Jan 17, 2011 at 4:29 PM, Jeevaka Badrappan
<jeevaka.badrappan@elektrobit.com> wrote:
> Adds ifx support for the remaining pin retries query
> ---
> =C2=A0drivers/atmodem/sim.c | =C2=A0 83 +++++++++++++++++++++++++++++++++=
++++++---------
> =C2=A01 files changed, 67 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
> index c5f4a44..3f81249 100644
> --- a/drivers/atmodem/sim.c
> +++ b/drivers/atmodem/sim.c
> @@ -56,6 +56,7 @@ static const char *crsm_prefix[] =3D { "+CRSM:", NULL };
> =C2=A0static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
> =C2=A0static const char *clck_prefix[] =3D { "+CLCK:", NULL };
> =C2=A0static const char *huawei_cpin_prefix[] =3D { "^CPIN:", NULL };
> +static const char *xpincnt_prefix[] =3D { "+XPINCNT:", NULL };
> =C2=A0static const char *none_prefix[] =3D { NULL };
>
> =C2=A0static void at_crsm_info_cb(gboolean ok, GAtResult *result, gpointe=
r user_data)
> @@ -522,40 +523,90 @@ error:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CALLBACK_WITH_FAILURE(cb, NULL, cbd->data);
> =C2=A0}
>
> +static void xpincnt_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct cb_data *cbd =3D user_data;
> + =C2=A0 =C2=A0 =C2=A0 ofono_sim_pin_retries_cb_t cb =3D cbd->cb;
> + =C2=A0 =C2=A0 =C2=A0 const char *final =3D g_at_result_final_response(r=
esult);
> + =C2=A0 =C2=A0 =C2=A0 GAtResultIter iter;
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_error error;
> + =C2=A0 =C2=A0 =C2=A0 int retries[OFONO_SIM_PASSWORD_INVALID];
> + =C2=A0 =C2=A0 =C2=A0 size_t i;
> + =C2=A0 =C2=A0 =C2=A0 static enum ofono_sim_password_type password_types=
[] =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFONO_SIM_PASSWORD_SIM=
_PIN,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFONO_SIM_PASSWORD_SIM=
_PIN2,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFONO_SIM_PASSWORD_SIM=
_PUK,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFONO_SIM_PASSWORD_SIM=
_PUK2,
> + =C2=A0 =C2=A0 =C2=A0 };
> +
> + =C2=A0 =C2=A0 =C2=A0 decode_at_error(&error, final);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!ok) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cb(&error, NULL, cbd->=
data);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 g_at_result_iter_init(&iter, result);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!g_at_result_iter_next(&iter, "+XPINCNT:"))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;
> +
> + =C2=A0 =C2=A0 =C2=A0 memset(retries, -1, sizeof(retries));

this happens to work for -1, but bear in mind memset "fills  the
first  n bytes of the memory area". Considering sizeof(int) =3D=3D 4, it
will set each byte to -1, which happens to be -1 considering all 4
bytes too. But imo this is just being lucky.

In my first version I had the same as you and Denis asked me to use a for l=
oop.


<snip>

> =C2=A0static void at_pin_retries_query(struct ofono_sim *sim,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ofono_sim_pin_retries_cb_t cb, void *=
data)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct sim_data *sd =3D ofono_sim_get_data(sim=
);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct cb_data *cbd;
> - =C2=A0 =C2=A0 =C2=A0 int retries[OFONO_SIM_PASSWORD_INVALID];
> - =C2=A0 =C2=A0 =C2=A0 int i;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0DBG("");
>
> - =C2=A0 =C2=A0 =C2=A0 switch (sd->vendor) {
> - =C2=A0 =C2=A0 =C2=A0 case OFONO_VENDOR_HUAWEI:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cbd =3D cb_data_new(cb=
, data);
> + =C2=A0 =C2=A0 =C2=A0 cbd =3D cb_data_new(cb, data);
> + =C2=A0 =C2=A0 =C2=A0 if (cbd =3D=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_FAILURE(=
cb, NULL, data);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 }
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cbd =3D=3D NULL) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 CALLBACK_WITH_FAILURE(cb, NULL, data);
> + =C2=A0 =C2=A0 =C2=A0 switch (sd->vendor) {
> + =C2=A0 =C2=A0 =C2=A0 case OFONO_VENDOR_IFX:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_at_chat_send(sd-=
>chat, "AT+XPINCNT", xpincnt_prefix,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xpincnt_cb, =
cbd, g_free) > 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 case OFONO_VENDOR_HUAWEI:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (g_at_chat_send=
(sd->chat, "AT^CPIN?", huawei_cpin_prefix,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0huawei_cp=
in_cb, cbd, g_free) > 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return;
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(cbd);
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_FAILURE(=
cb, NULL, data);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0default:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for(i =3D 0; i < OFONO=
_SIM_PASSWORD_INVALID; i++)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 retries[i] =3D -1;
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_SUCCESS(=
cb, retries, data);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> + =C2=A0 =C2=A0 =C2=A0 g_free(cbd);
> +
> + =C2=A0 =C2=A0 =C2=A0 CALLBACK_WITH_FAILURE(cb, NULL, data);

If vendor is not huawei nor ifx, why are we bothering to allocate cbd
and free it afterwards without using?

This also changes the semantics to return a failure if it's not
implemented. I'm not against since this version seems to be clearer.
However you might want to change src/sim.c:sim_pin_retries_query_cb()
so it doesn't call ofono_error() in this case.



regards,
Lucas De Marchi

--===============3965654996157153347==--

