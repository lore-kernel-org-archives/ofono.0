Content-Type: multipart/mixed; boundary="===============0400388484638197405=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 1/3] Add multi calls support for HFP voicecall driver
Date: Thu, 12 Nov 2009 10:49:47 +0800
Message-ID: <0463F45F3606F4428ED35AC8C709F92E089CA6A4EF@pdsmsx502.ccr.corp.intel.com>
In-Reply-To: <200911111921.17039.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0400388484638197405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Denis Kenzior wrote:
> Hi Zhenhua,
> =

>> +static void reset_to_single_call(struct voicecall_data *vd) {
>> +       struct ofono_call *oc =3D vd->calls->data;
>> +
>> +       vd->call =3D oc;
>> +       vd->cind_val[HFP_INDICATOR_CALL] =3D 1;
>> +
>> +       if (oc->direction =3D=3D 1)
>> +               vd->cind_val[HFP_INDICATOR_CALLSETUP] =3D 1; +      =

>> else +               vd->cind_val[HFP_INDICATOR_CALLSETUP] =3D 3; }
>> +
> =

> I don't see how this is supposed to work.  What if the last
> call is a held call?

Don't see any problem if it is a held call. Still can hang up correctly.
What's the problem you have see.

>> +		if (c) {
>> +			nc =3D c->data;
>> +
>> +			if (memcmp(nc, oc, sizeof(struct ofono_call))) { +				oc->status
>> =3D nc->status; +
>> +				/* If phone does not support
> multiparty call,
>> +				 * there will have only one
> active call at one
>> +				 * time. +CHUP only hang up
> current active call.
>> +				 */
>> +				if (oc->status =3D=3D CALL_STATUS_ACTIVE)
>> +					vd->call =3D oc;
> =

> Lets not set this silly variable anymore.  It has way too many
> meanings and uses throughout the code (most of which can be
> easily simplified) for the logic to be understandable.

As discussed on IRC, I will rename vd->call to vd->active. But the src/voic=
ecall.c
has the similar variable in struct ofono_voicecall too.

>> +static void hfp_hold_all_active(struct ofono_voicecall *vc,
>> +				ofono_voicecall_cb_t cb, void *data) {
>> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc); +
>> +	if (check_mpty_feature(vc, AG_CHLD_2, cb, data)) {
>> +		hfp_template("AT+CHLD=3D2", vc, generic_cb, 0, cb, data); +
>> +		/* Some phones fail to send response back after CHLD=3D2.
>> +		 * But if we have another dialing out call, we should hold
>> +		 * +CLCC until AG creates the new call.
>> +		 */
>> +		vd->clcc_source =3D g_timeout_add(POLL_CLCC_INTERVAL,
>> +						poll_clcc, vc);
> =

> This comment makes no sense.  If the phone doesn't respond
> after CHLD=3D2 the parser is stuck and we're not sending CLCC out
> anyway. =


I will update the comments. It means phone should send update notification
Like callheld=3D1. But some phones doesn't send CIEV update.

>> +static void hfp_set_udub(struct ofono_voicecall *vc,
>> +				ofono_voicecall_cb_t cb, void *data) {
>> +	unsigned int incoming_or_waiting =3D (1 << 4) | (1 << 5);
>> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
>> +	struct ofono_call *call =3D vd->call;
>> +	struct release_id_req *req;
>> +
>> +	if (vd->ag_mpty_features & AG_CHLD_0)
>> +		hfp_template("AT+CHLD=3D0", vc, generic_cb, incoming_or_waiting,
>> +					cb, data); +	else {
>> +		req =3D g_try_new0(struct release_id_req, 1);
>> +
>> +		if (!req || !call) {
>> +			CALLBACK_WITH_FAILURE(cb, data);
>> +			return;
>> +		}
>> +
>> +		req->vc =3D vc;
>> +		req->cb =3D cb;
>> +		req->data =3D data;
>> +		req->id =3D call->id;
>> +
>> +		g_at_chat_send(vd->chat, "AT+CHUP", none_prefix,
>> +					release_id_cb, req, g_free);
>> +	}
> =

> The core is quite specifically asking to set UDUB, not to
> hangup the call.  If this is not supported, then we should say
> so.  Please get rid of this.

Ok. Remove it and report errors.

>> +}
>> +
>> +static void hfp_release_all_active(struct ofono_voicecall *vc,
>> +					ofono_voicecall_cb_t
> cb, void *data) {
>> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc); +
>> +	if (check_mpty_feature(vc, AG_CHLD_1, cb, data)) {
>> +		hfp_template("AT+CHLD=3D1", vc, generic_cb, 0x1, cb, data); +
>> +		vd->clcc_source =3D
> g_timeout_add(POLL_CLCC_INTERVAL, poll_clcc,
>> +						vc);
> =

> Why are we scheduling the CLCC before the CHLD returned?  We
> should wait until CHLD fails or succeeds.

It doesn't matter if we have 1 extra CLCC even if CHLD=3D1 is failed. Anywa=
y,
I will move it into generic_cb.

>> +static void hfp_release_specific(struct ofono_voicecall *vc, int id,
>> +				ofono_voicecall_cb_t cb, void *data) {
>> +	if (vd->ag_features & AG_FEATURE_ENHANCED_CALL_CONTROL) {
>> +		sprintf(buf, "AT+CHLD=3D1%d", id);
> =

> Should we be checking CHLD_1X feature?

You mean checking CHLD_1X instead of enhanced_call_control? In theoriy,
They are the same. I don't think the phone has CHLD_1X without CHLD=3D2X.
;-)

>> +
>> +		g_at_chat_send(vd->chat, buf, none_prefix,
>> +					release_id_cb, req, g_free);
>> +	} else if (id =3D=3D (int) vd->call->id)
>> +		g_at_chat_send(vd->chat, "AT+CHUP", none_prefix,
>> +					release_id_cb, req, g_free);
> =

> In the case of a single active call we already send a CHUP.
> Is this really necessary here?

It could be 3-way calls and phone only support CHLD=3D0, 1 and 2.
So we cannot use CHLD=3D1x call. If it is 3-way call, we support release
either active call or held call.

>> +	else
>> +		/* If the call is held, swap and then release it */
>> +		g_at_chat_send(vd->chat, "AT+CHLD=3D2", none_prefix,
>> +					swap_hold_cb, req, NULL);
> =

> This breaks if the held call is a mpty call, since the entire
> mpty call is released.  You also can't do this if a waiting
> call exists.
>

If it is mpty call, phone have already support CHLD=3D1x. Otherwise, it
could not use CHLD=3D3 to create mpty call. So this case should never
happen.

> =

> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

Regards,
Zhenhua


--===============0400388484638197405==--

