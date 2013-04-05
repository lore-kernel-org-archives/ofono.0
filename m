Content-Type: multipart/mixed; boundary="===============2513936079634841207=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/5] hfp_hf_bluez5: Add audio card .connect() for HFP 1.6
Date: Fri, 05 Apr 2013 12:22:26 -0500
Message-ID: <515F0852.4050407@gmail.com>
In-Reply-To: <1365031481-10467-2-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2513936079634841207==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 04/03/2013 06:24 PM, Vinicius Costa Gomes wrote:
> ---
>   plugins/hfp_hf_bluez5.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
> index a6cc156..4c8f412 100644
> --- a/plugins/hfp_hf_bluez5.c
> +++ b/plugins/hfp_hf_bluez5.c
> @@ -67,6 +67,8 @@ struct hfp {
>   	struct hfp_slc_info info;
>   	DBusMessage *msg;
>   	struct ofono_handsfree_card *card;
> +	ofono_handsfree_card_connect_cb_t cb;
> +	void *user_data;

Please use the cb_data_new mechanism instead of storing this here.

>   };
>
>   static GDBusClient *bluez =3D NULL;
> @@ -324,11 +326,48 @@ static void hfp16_card_remove(struct ofono_handsfre=
e_card *card)
>
>   }
>
> +static void bcc_cb(gboolean ok, GAtResult *result, gpointer user_data)
> +{
> +	struct hfp *hfp =3D user_data;
> +	struct hfp_slc_info *info =3D&hfp->info;
> +
> +	if (ok)
> +		CALLBACK_WITH_SUCCESS(hfp->cb, hfp->user_data);
> +	else
> +		CALLBACK_WITH_FAILURE(hfp->cb, hfp->user_data);

Please use decode_at_error instead.

e.g. decode_at_error(&error, g_at_result_final_response(result));
callback(&error, ...);

> +
> +	g_at_chat_unref(info->chat);

No need to reference count the g_at_chat.  This is just needless overhead.

> +}
> +
>   static void hfp16_card_connect(struct ofono_handsfree_card *card,
>   					ofono_handsfree_card_connect_cb_t cb,
>   					void *data)
>   {
> -	CALLBACK_WITH_FAILURE(cb, data);
> +	struct hfp *hfp =3D ofono_handsfree_card_get_data(card);
> +	struct hfp_slc_info *info =3D&hfp->info;
> +
> +	if (info->chat =3D=3D NULL) {
> +		CALLBACK_WITH_FAILURE(cb, data);
> +		return;
> +	}

Can this case even happen?

> +
> +	if (!(info->hf_features&  HFP_HF_FEATURE_CODEC_NEGOTIATION&&
> +			info->ag_features&  HFP_AG_FEATURE_CODEC_NEGOTIATION)) {
> +		/*
> +		 * If both sides don't support codec negotiation,
> +		 * fallback to direct SCO connection. Calling
> +		 * connect_sco() hands the connection responsability
> +		 * to the core, so no need to call the callback
> +		 */
> +		ofono_handsfree_card_connect_sco(card);
> +		return;
> +	}

Can we reverse this logic to make it more readable?

e.g. if (HF has CodecNegotiation and AG has CodecNegotiation) {
	send BCC;
	return;
}

> +
> +	info->chat =3D g_at_chat_ref(info->chat);

No need to take a reference.  Remove this part

> +	hfp->cb =3D cb;
> +	hfp->user_data =3D data;
> +

Use the cb_data_new mechanism here

> +	g_at_chat_send(info->chat, "AT+BCC", NULL, bcc_cb, hfp, NULL);

And make sure to set the destroy callback.  There are examples of this =

throughout the drivers/atmodem/* and drivers/hfpmodem/*.

>   }
>
>   static struct ofono_handsfree_card_driver hfp16_hf_driver =3D {

Regards,
-Denis

--===============2513936079634841207==--

