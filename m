Content-Type: multipart/mixed; boundary="===============4126324044638353487=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] hfp_hf_bluez5: Add audio card .connect() for HFP 1.6
Date: Tue, 09 Apr 2013 14:34:48 -0500
Message-ID: <51646D58.2020008@gmail.com>
In-Reply-To: <1365460863-14645-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4126324044638353487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 04/08/2013 05:40 PM, Vinicius Costa Gomes wrote:
> ---
>   plugins/hfp_hf_bluez5.c | 30 +++++++++++++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)

Patch has been applied.

> +	struct hfp *hfp =3D ofono_handsfree_card_get_data(card);
> +	struct hfp_slc_info *info =3D&hfp->info;
> +
> +	if ((info->hf_features&  HFP_HF_FEATURE_CODEC_NEGOTIATION&&
> +			info->ag_features&  HFP_AG_FEATURE_CODEC_NEGOTIATION)) {

I removed the extra parentheses in a follow on commit.

> +		struct cb_data *cbd =3D cb_data_new(cb, data);
> +
> +		g_at_chat_send(info->chat, "AT+BCC", NULL, bcc_cb, cbd, g_free);
> +		return;
> +	}
> +
> +	/*
> +	 * If any side (remote or local) doesn't support codec negotiation,
> +	 * fallback to direct SCO connection. Calling connect_sco()
> +	 * hands the connection responsibility to the core, so no need
> +	 * to call the callback
> +	 */
> +	ofono_handsfree_card_connect_sco(card);
>   }
>
>   static struct ofono_handsfree_card_driver hfp16_hf_driver =3D {

Regards,
-Denis

--===============4126324044638353487==--

