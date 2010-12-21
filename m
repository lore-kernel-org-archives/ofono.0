Content-Type: multipart/mixed; boundary="===============8950174497670318400=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH 2/2] huawei: fix SIM state notification when locked
Date: Tue, 21 Dec 2010 17:19:37 -0200
Message-ID: <AANLkTikWxKSr2F8ejvcCL6jNoKr_rpyeNRHq9kxiGCDp@mail.gmail.com>
In-Reply-To: <1292881869-13246-2-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8950174497670318400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 20, 2010 at 7:51 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> When SIM is locked, huawei modem does not send any notification about
> SIM state change because it does not differentiate 'invalid' from
> 'locked'.
>
> In order to be able to unlock the sim, this patch forces a notification
> of a valid state after a timeout.
> ---
> =C2=A0plugins/huawei.c | =C2=A0 40 ++++++++++++++++++++++++++++++++++++++=
++
> =C2=A01 files changed, 40 insertions(+), 0 deletions(-)
>
> diff --git a/plugins/huawei.c b/plugins/huawei.c
> index bff1343..7934956 100644
> --- a/plugins/huawei.c
> +++ b/plugins/huawei.c
> @@ -56,6 +56,7 @@
> =C2=A0#include <drivers/atmodem/vendor.h>
>
> =C2=A0static const char *none_prefix[] =3D { NULL };
> +static const char *cpin_prefix[] =3D { "+CPIN:", NULL };
> =C2=A0static const char *sysinfo_prefix[] =3D { "^SYSINFO:", NULL };
> =C2=A0static const char *ussdmode_prefix[] =3D { "^USSDMODE:", NULL };
> =C2=A0static const char *cvoice_prefix[] =3D { "^CVOICE:", NULL };
> @@ -226,6 +227,41 @@ static gboolean notify_sim_state(struct ofono_modem =
*modem,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return FALSE;
> =C2=A0}
>
> +static void cpin_cb(gboolean ok, GAtResult *result, gpointer user_data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_modem *modem =3D user_data;
> + =C2=A0 =C2=A0 =C2=A0 const char *value;
> + =C2=A0 =C2=A0 =C2=A0 GAtResultIter iter;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!ok)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 g_at_result_iter_init(&iter, result);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!g_at_result_iter_next(&iter, "+CPIN:"))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (!g_at_result_iter_next_unquoted_string(&iter, =
&value))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +
> + =C2=A0 =C2=A0 =C2=A0 /* Force notification of SIM ready because it's in=
 a locked state */
> + =C2=A0 =C2=A0 =C2=A0 if (g_str_has_prefix(value, "SIM"))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 notify_sim_state(modem=
, HUAWEI_SIM_STATE_VALID);
> +}

As I talked to Denis through IRC, this can be simplified. We can cheat
here, not doing all this parsing and only relying on "ok" value. I
tested it with Huawei E220. I'll send  another patch.


Lucas De Marchi

--===============8950174497670318400==--

