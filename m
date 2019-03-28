Content-Type: multipart/mixed; boundary="===============3247694704953383998=="
MIME-Version: 1.0
From: Borwankar, Antara <antara.borwankar@intel.com>
Subject: RE: [PATCH 5/6] xmm7modem: handling of dual sim single active feature
Date: Thu, 28 Mar 2019 11:58:27 +0000
Message-ID: <9BCC1739A7EADA4790E1FFF4123FB3268BAECC19@BGSMSX101.gar.corp.intel.com>
In-Reply-To: <de1aaa43-c1a2-bc4f-90c1-3210048dde10@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3247694704953383998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

+CSUS Set command directs the MT to select the SIM/UICC card installed in t=
he indicated card
slot in all future actions that require the use of SIM/UICC.

While,

+XCMSCSC command is used to configure the mode settings for a SIM. It is us=
ed to set the
active SIM in case of single SIM(SSIM) configuration or to set the data pre=
ferred SIM in
case of multi SIM(MSIM) configuration. It is also used to configure the pow=
er options for
SSIM or MSIM.

Description of <power_options> is given below
XCMSCSC <power_options>
Integer Type; Indicates power options on slot.
0: keep the other slot powered off.
1: keep both slots powered.

For dual sim use case we will need both slots powered.

Although +CSUS will switch the SIM it won't perform a SIM configuration rem=
ap.
So we cannot use AT+CSUS command for DSSA use case.

Regards, =

Antara

-----Original Message-----
From: Denis Kenzior [mailto:denkenz(a)gmail.com] =

Sent: Thursday, March 28, 2019 8:01 AM
To: Borwankar, Antara <antara.borwankar@intel.com>; ofono(a)ofono.org
Subject: Re: [PATCH 5/6] xmm7modem: handling of dual sim single active feat=
ure

Hi Antara,

On 03/27/2019 07:11 AM, Antara Borwankar wrote:
> Handled DSSA use case for xmm7modem. Added driver function to switch =

> between available card slots for SIM.
> =

> Only one SIM will be active at a given time. On calling this function =

> the active SIM will be removed and the card slot made inactive and SIM =

> in the other card slot will be made active.
> =

> Use case is similar to a SIM swap/change where one SIM is replaced =

> another SIM in the same slot.
> ---
>   drivers/atmodem/sim.c | 80 ++++++++++++++++++++++++++++++++++++++++++++=
++++++-
>   1 file changed, 79 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c index =

> 5f66a09..88e3898 100644
> --- a/drivers/atmodem/sim.c
> +++ b/drivers/atmodem/sim.c
> @@ -75,6 +75,7 @@ static const char *cuad_prefix[] =3D { "+CUAD:", NULL };
>   static const char *ccho_prefix[] =3D { "+CCHO:", NULL };
>   static const char *crla_prefix[] =3D { "+CRLA:", NULL };
>   static const char *cgla_prefix[] =3D { "+CGLA:", NULL };
> +static const char *csus_prefix[] =3D { "+CSUS:", NULL};
>   static const char *none_prefix[] =3D { NULL };
>   =

>   static void append_file_path(char *buf, const unsigned char *path, =

> @@ -1160,6 +1161,7 @@ static void at_pin_retries_query(struct ofono_sim *=
sim,
>   	DBG("");
>   =

>   	switch (sd->vendor) {
> +	case OFONO_VENDOR_XMM:
>   	case OFONO_VENDOR_IFX:
>   		if (g_at_chat_send(sd->chat, "AT+XPINCNT", xpincnt_prefix,
>   					xpincnt_cb, cbd, g_free) > 0)
> @@ -1920,6 +1922,41 @@ static void at_logical_access(struct ofono_sim *si=
m, int session_id,
>   	CALLBACK_WITH_FAILURE(cb, NULL, 0, data);
>   }
>   =

> +static void at_csus_query_cb(gboolean ok, GAtResult *result, gpointer =

> +user) {
> +	struct ofono_sim *sim =3D user;
> +	struct sim_data *sd =3D ofono_sim_get_data(sim);
> +	GAtResultIter iter;
> +	int num_slots;
> +
> +	if (!ok)
> +		goto done;
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+CSUS:"))
> +		goto done;
> +
> +	/* Set num slots */
> +	g_at_result_iter_next_number(&iter, &num_slots);
> +
> +	ofono_sim_set_card_slot_num(sim, num_slots);
> +
> +	/* SIM1 slot will be active by default */
> +	ofono_sim_set_active_card_slot_num(sim, 1);

Why not just run 'AT+CSUS?' and make sure that we get the info fresh from t=
he modem.

> +
> +	/* enable reporting of MSIM remap status information
> +	   and enable automatic acceptance of MSIM Remap
> +	   acknowledgement. */
> +	g_at_chat_send(sd->chat, "AT+XCMSRS=3D2", none_prefix,
> +					NULL, NULL, NULL);
> +
> +done:
> +	/* Query supported <fac>s */
> +	g_at_chat_send(sd->chat, "AT+CLCK=3D?", clck_prefix,
> +				at_clck_query_cb, sim, NULL);
> +}
> +
>   static int at_sim_probe(struct ofono_sim *sim, unsigned int vendor,
>   				void *data)
>   {
> @@ -1938,6 +1975,10 @@ static int at_sim_probe(struct ofono_sim *sim, uns=
igned int vendor,
>   		if (at_clck_cpwd_fac[i])
>   			sd->passwd_type_mask |=3D (1 << i);
>   =

> +	if (sd->vendor =3D=3D OFONO_VENDOR_XMM)
> +		return g_at_chat_send(sd->chat, "AT+CSUS=3D?", csus_prefix,
> +			at_csus_query_cb, sim, NULL) ? 0 : -1;
> +

Given that this is a standard command, do you really want to hide it behind=
 VENDOR_XMM?

>   	/* Query supported <fac>s */
>   	return g_at_chat_send(sd->chat, "AT+CLCK=3D?", clck_prefix,
>   				at_clck_query_cb, sim, NULL) ? 0 : -1; @@ -1957,6 +1998,42 @@ =

> static void at_sim_remove(struct ofono_sim *sim)
>   	g_free(sd);
>   }
>   =

> +static void at_set_active_sim_cb(gboolean ok, GAtResult *result,

Since this is a vendor command response, name it after the vendor command i=
ssues.  E.g. something like xcmscsc_cb

> +		gpointer user_data)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	ofono_sim_active_slot_change_cb_t cb =3D cbd->cb;
> +	struct ofono_error error;
> +
> +	decode_at_error(&error, g_at_result_final_response(result));
> +
> +	if (cb)
> +		cb(&error, cbd->data);
> +}
> +
> +static void at_set_active_sim(struct ofono_sim *sim, unsigned int index,
> +			ofono_sim_active_slot_change_cb_t cb, void *data) {
> +	struct sim_data *sd =3D ofono_sim_get_data(sim);
> +	struct cb_data *cbd =3D cb_data_new(cb, data);
> +	char cmd[43];
> +
> +	/* AT+XCMSCSC=3D[<n>][,<mode>,<slot_id>,<power_options>]

doc/coding-style.txt item M2

> +	   <n> Enable +XCMSCSCI URC reporting,
> +	   <mode> single sim modem (SSIM),
> +	   <slot_id> Indicates SIM slot id,
> +	   <power_options> keep both slots powered.	*/

What does keeping both slots powered do?

> +	snprintf(cmd, sizeof(cmd), "AT+XCMSCSC=3D1,0,%u,1", index);

Can we use AT+CSUS=3Dfoo here?

Also, you really need to make sure that this callback will still do the rig=
ht thing when vendor !=3D XMM_VENDOR.  So that means returning a not suppor=
ted error code for vendors other than XMM_VENDOR, or better yet falling bac=
k to AT+CSUS (if probed successfully as part of the at_sim_probe sequence)

> +
> +	if (g_at_chat_send(sd->chat, cmd, none_prefix, at_set_active_sim_cb,
> +			cbd, g_free) > 0)
> +		return;
> +
> +	g_free(cbd);
> +
> +	CALLBACK_WITH_FAILURE(cb, data);
> +}
> +
>   static const struct ofono_sim_driver driver =3D {
>   	.name			=3D "atmodem",
>   	.probe			=3D at_sim_probe,
> @@ -1982,7 +2059,8 @@ static const struct ofono_sim_driver driver =3D {
>   	.session_read_binary	=3D at_session_read_binary,
>   	.session_read_record	=3D at_session_read_record,
>   	.session_read_info	=3D at_session_read_info,
> -	.logical_access		=3D at_logical_access
> +	.logical_access		=3D at_logical_access,
> +	.set_active_sim		=3D at_set_active_sim
>   };
>   =

>   static const struct ofono_sim_driver driver_noef =3D {
> =


Regards,
-Denis

--===============3247694704953383998==--

