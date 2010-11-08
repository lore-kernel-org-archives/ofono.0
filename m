Content-Type: multipart/mixed; boundary="===============8884068353650305103=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RfC][PATCH 1/3] stk: API for SMS Point-to-Point download to UICC
Date: Mon, 08 Nov 2010 13:47:24 -0600
Message-ID: <4CD853CC.9030908@gmail.com>
In-Reply-To: <1289151740-9922-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8884068353650305103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 11/07/2010 11:42 AM, Andrzej Zaborowski wrote:
> The callback returns the TP-User-Data element content of the RP-ACK or
> RP-ERROR message, returned by the UICC.
> ---
>  src/ofono.h |    8 ++++++++
>  src/stk.c   |   39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 0 deletions(-)
> =

> +int __ofono_sms_sim_download(struct ofono_stk *stk, const struct sms *ms=
g,
> +				__ofono_sms_sim_download_cb_t cb, void *data)
> +{
> +	struct stk_envelope e;
> +
> +	if (msg->type !=3D SMS_TYPE_DELIVER)
> +		return -EINVAL;
> +
> +	DBG("");
> +
> +	memset(&e, 0, sizeof(e));
> +
> +	e.type =3D STK_ENVELOPE_TYPE_SMS_PP_DOWNLOAD;
> +	e.src =3D STK_DEVICE_IDENTITY_TYPE_NETWORK;
> +
> +	e.sms_pp_download.address.number =3D (char *) msg->sc_addr.address;
> +	e.sms_pp_download.address.ton_npi =3D msg->sc_addr.numbering_plan |
> +		(msg->sc_addr.number_type << 4);
> +	memcpy(&e.sms_pp_download.message, &msg->deliver, sizeof(msg->deliver));
> +
> +	stk->sms_pp_cb =3D cb;
> +	stk->sms_pp_userdata =3D data;

Please note that this has a possibility of overwriting the sms_pp_cb and
sms_pp_userdata if multiple SMS-PP sms messages are received (and
acknowledged) in short succession.

However, I assume you already thought of this and will take care of it
with the async ack task.

Patch has been applied, thanks.

Regards,
-Denis

--===============8884068353650305103==--

