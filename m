Content-Type: multipart/mixed; boundary="===============0128732596582829335=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [RFC v0 06/20] hfp_hf_bluez5: Add HFP 1.6 connect implementation
Date: Thu, 14 Mar 2013 14:52:45 -0300
Message-ID: <20130314175245.GA2649@samus>
In-Reply-To: <1363098104-16467-7-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0128732596582829335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 11:21 Tue 12 Mar, Claudio Takahasi wrote:
> This patch implements the HF initiate SCO connection for devices
> compliant with HFP 1.6. HF sends AT+BCC to inform the AG that audio
> connection is required.
> ---
>  plugins/hfp_hf_bluez5.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> =

> diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
> index 0d5d5c7..6c55657 100644
> --- a/plugins/hfp_hf_bluez5.c
> +++ b/plugins/hfp_hf_bluez5.c
> @@ -364,7 +364,18 @@ static struct ofono_handsfree_card_driver card_drive=
r15 =3D {
>  static int card_audio_connect16(const char *remote, const char *local,
>  								void *data)
>  {
> -	return 0;
> +	struct ofono_modem *modem =3D data;
> +	struct hfp *hfp =3D ofono_modem_get_data(modem);
> +	struct hfp_slc_info *info =3D &hfp->info;
> +
> +	if (info->chat =3D=3D NULL)
> +		return -ENOTCONN;
> +
> +	info->chat =3D g_at_chat_ref(info->chat);
> +	g_at_chat_send(info->chat, "AT+BCC", NULL, NULL, info->chat,
> +					(GDestroyNotify) g_at_chat_unref);

Testing with the iPhone, if there's no audio related things happening on
the phone, audio calls for example, the phone responds with an error.

We need to handle this case, we could think of two alternatives:

1. Adding a timeout when the driver returns -EINPROGRESS, if this timeout
expires before the SCO is established we return an error to the caller of t=
he
Connect method;

2. Adding another method to the handsfree-audio.h API, something like:
"ofono_handsfree_audio_card_falied(card, err)" that would signify that the
audio connection attempt failed before its time.

The main advantage of (1) is that we are covered even in the case that
"AT+BCC" succeeds and the remote device doesn't open an SCO channel.


> +
> +	return -EINPROGRESS;
>  }
>  =

>  static struct ofono_handsfree_card_driver card_driver16 =3D {
> -- =

> 1.7.11.7
> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono


Cheers,
-- =

Vinicius

--===============0128732596582829335==--

