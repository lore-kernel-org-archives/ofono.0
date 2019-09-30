Content-Type: multipart/mixed; boundary="===============6327859439610777044=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ublox: netreg: Also subscribe to UREG URC's
Date: Mon, 30 Sep 2019 12:00:13 -0500
Message-ID: <f41b0ba9-30f9-0533-7ba7-081e8fa5979e@gmail.com>
In-Reply-To: <20190929193953.23524-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6327859439610777044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 9/29/19 2:39 PM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> It turns out that both L2xx and L4xx modems are a bit
> buggy when it comes to send CREG URC's when the tech changes.
> Try to overcome this by subscribing to both UREG and CREG,
> and poll the other when any of the URC's are received.
> Protect from doing simultanious polls though.

nit: typo, simultaneous

Also, this patch doesn't apply?

denkenz(a)localhost ~/ofono-master $ git am --3way ~/merge/\[PATCH\]\ =

ublox\:\ netreg\:\ Also\ subscribe\ to\ UREG\ URC\'s.eml
Applying: ublox: netreg: Also subscribe to UREG URC's
Using index info to reconstruct a base tree...
error: patch failed: drivers/ubloxmodem/network-registration.c:47
error: drivers/ubloxmodem/network-registration.c: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.
Patch failed at 0001 ublox: netreg: Also subscribe to UREG URC's
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

> ---
>   drivers/ubloxmodem/network-registration.c | 198 ++++++++++++++++------
>   1 file changed, 148 insertions(+), 50 deletions(-)
> =

> diff --git a/drivers/ubloxmodem/network-registration.c b/drivers/ubloxmod=
em/network-registration.c
> index 69af4644..ad905fb3 100644
> --- a/drivers/ubloxmodem/network-registration.c
> +++ b/drivers/ubloxmodem/network-registration.c
> @@ -47,11 +47,15 @@
>   static const char *none_prefix[] =3D { NULL };
>   static const char *cmer_prefix[] =3D { "+CMER:", NULL };
>   static const char *ureg_prefix[] =3D { "+UREG:", NULL };
> +static const char *creg_prefix[] =3D { "+CREG:", NULL };
> +
> +#define UBLOX_UPDATING_STATUS 0x01
>   =

>   struct netreg_data {
>   	struct at_netreg_data at_data;
>   =

>   	const struct ublox_model *model;
> +	int flags;

Nowadays we prefer to use bool foo : 1 notation to manipulate bit fields.

So maybe something like:

bool updating_status : 1;

>   };
>   =

>   struct tech_query {
> @@ -213,13 +217,72 @@ static void ctze_notify(GAtResult *result, gpointer=
 user_data)
>   	ofono_netreg_time_notify(netreg, &nd->time);
>   }
>   =

> -static void ublox_query_tech_cb(gboolean ok, GAtResult *result,
> +static int ublox_ureg_state_to_tech(int state)
> +{
> +	switch (state) {
> +	case 1:
> +		return ACCESS_TECHNOLOGY_GSM;
> +	case 2:
> +		return ACCESS_TECHNOLOGY_GSM_EGPRS;
> +	case 3:
> +		return ACCESS_TECHNOLOGY_UTRAN;
> +	case 4:
> +		return ACCESS_TECHNOLOGY_UTRAN_HSDPA;
> +	case 5:
> +		return ACCESS_TECHNOLOGY_UTRAN_HSUPA;
> +	case 6:
> +		return ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA;
> +	case 7:
> +		return ACCESS_TECHNOLOGY_EUTRAN;
> +	case 8:
> +		return ACCESS_TECHNOLOGY_GSM;
> +	case 9:
> +		return ACCESS_TECHNOLOGY_GSM_EGPRS;
> +	default:
> +		/* Not registered for PS (0) or something unknown (>9)... */
> +		return -1;
> +	}
> +}
> +
> +static gboolean is_registered(int status)
> +{
> +	return status =3D=3D NETWORK_REGISTRATION_STATUS_REGISTERED ||
> +		status =3D=3D NETWORK_REGISTRATION_STATUS_ROAMING;
> +}
> +
> +static void ublox_creg_cb(gboolean ok, GAtResult *result,
> +				gpointer user_data)
> +{
> +	struct tech_query *tq =3D user_data;
> +	struct netreg_data *nd =3D ofono_netreg_get_data(tq->netreg);
> +	int status, lac, ci, tech;

One variable declaration per line please.

> +
> +	nd->flags &=3D ~UBLOX_UPDATING_STATUS;
> +
> +	if (!ok)
> +		return;
> +
> +	if (at_util_parse_reg(result, "+CREG:", NULL, &status,
> +				&lac, &ci, &tech, OFONO_VENDOR_GENERIC) =3D=3D FALSE)
> +		return;
> +
> +	/* The query provided a tech, use that */
> +	if (is_registered(status) && tq->tech !=3D -1)
> +		tech =3D tq->tech;
> +
> +	ofono_netreg_status_notify(tq->netreg, status, lac, ci, tech);
> +}
> +
> +static void ublox_ureg_cb(gboolean ok, GAtResult *result,
>   							gpointer user_data)
>   {
>   	struct tech_query *tq =3D user_data;
> +	struct netreg_data *nd =3D ofono_netreg_get_data(tq->netreg);
>   	GAtResultIter iter;
>   	gint enabled, state;
> -	int tech =3D -1;
> +	int tech =3D tq->tech;
> +
> +	nd->flags &=3D ~UBLOX_UPDATING_STATUS;
>   =

>   	if (!ok)
>   		goto error;

<snip>

> +static void ureg_notify(GAtResult *result, gpointer user_data)
> +{
> +	struct ofono_netreg *netreg =3D user_data;
> +	int state;
> +	struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
> +	struct tech_query *tq;
> +	GAtResultIter iter;
> +
> +	if (nd->flags & UBLOX_UPDATING_STATUS)
> +		return;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+UREG:"))
> +		return;
> +
> +	if (!g_at_result_iter_next_number(&iter, &state))
> +		return;
> +
> +	tq =3D g_new0(struct tech_query, 1);
> +
> +	tq->tech =3D ublox_ureg_state_to_tech(state);
> +	tq->netreg =3D netreg;
> +
> +	if (g_at_chat_send(nd->at_data.chat, "AT+CREG?", creg_prefix,
> +			ublox_creg_cb, tq, g_free) > 0) {
> +		nd->flags |=3D UBLOX_UPDATING_STATUS;
> +		return;
> +	}
> +
> +	g_free(tq);
> +}
> +

So it seems to me you're firing off a CREG? when UREG unsolicited comes =

in but also firing off UREG? when CREG unsolicited comes in.

Briefly looking at some random ublox docs via google, I understand that =

UREG was meant to tell you what Packet Switching technology was active. =

One can still be connected to Voice Circuit Switched service with no PS =

active.  So I'm not entirely sure whether the two can be assumed to be =

related the way you do it here...?

I really see nothing that can go wrong in being paranoid and re-querying =

CREG/UREG, so I'm ok taking this up.  Just wondering whether you'll end =

up fixing this again later.

Regards,
-Denis
--===============6327859439610777044==--

