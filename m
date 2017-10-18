Content-Type: multipart/mixed; boundary="===============0926153652147713949=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] hfpmodem: Send last call dialled request
Date: Wed, 18 Oct 2017 12:48:03 -0500
Message-ID: <dd9254ab-7216-f2cf-4916-9f1ec80ab577@gmail.com>
In-Reply-To: <20171018140427.16143-4-philippe.deswert@nomovok.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0926153652147713949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 10/18/2017 09:04 AM, Philippe De Swert wrote:
> Handle the last call dialled request and send the required AT+BDLN command
> for bluetooth HFP profile.
> ---
>   drivers/hfpmodem/voicecall.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> =

> diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
> index ffdf4b7b..6dc03574 100644
> --- a/drivers/hfpmodem/voicecall.c
> +++ b/drivers/hfpmodem/voicecall.c
> @@ -404,6 +404,27 @@ static void hfp_dial(struct ofono_voicecall *vc,
>   	CALLBACK_WITH_FAILURE(cb, data);
>   }
>   =

> +static void hfp_dial_last(struct ofono_voicecall *vc, ofono_voicecall_cb=
_t cb,
> +			void *data)
> +{
> +	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
> +	struct cb_data *cbd =3D cb_data_new(cb, data);
> +	char buf[256];
> +
> +	cbd->user =3D vc;
> +	snprintf(buf, sizeof(buf), "AT+BLDN");
> +
> +	strcat(buf, ";");

Why not include the ';' in the snprintf?  Also, I don't think this is =

needed?

> +
> +	if (g_at_chat_send(vd->chat, buf, none_prefix,
> +				atd_cb, cbd, g_free) > 0)
> +		return;
> +
> +	g_free(cbd);
> +
> +	CALLBACK_WITH_FAILURE(cb, data);
> +
> +}
>   static void hfp_template(const char *cmd, struct ofono_voicecall *vc,
>   			GAtResultFunc result_cb, unsigned int affected_types,
>   			ofono_voicecall_cb_t cb, void *data)
> @@ -1268,6 +1289,7 @@ static struct ofono_voicecall_driver driver =3D {
>   	.probe			=3D hfp_voicecall_probe,
>   	.remove			=3D hfp_voicecall_remove,
>   	.dial			=3D hfp_dial,
> +	.dial_last		=3D hfp_dial_last,
>   	.answer			=3D hfp_answer,
>   	.hangup_active		=3D hfp_hangup,
>   	.hold_all_active	=3D hfp_hold_all_active,
> =


Regards,
-Denis

--===============0926153652147713949==--

