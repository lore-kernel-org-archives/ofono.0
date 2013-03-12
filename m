Content-Type: multipart/mixed; boundary="===============6607614126786096972=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [RFC v0 10/20] hfpmodem: Send AT+BAC with the supported codecs
Date: Tue, 12 Mar 2013 14:44:01 -0300
Message-ID: <20130312174401.GA19904@echo>
In-Reply-To: <1363098104-16467-11-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6607614126786096972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 11:21 Tue 12 Mar, Claudio Takahasi wrote:
> From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> =

> Before, the AT+BAC command was being sent with fixed information,
> now we send the command (that inform the AG of the codecs supported by
> the HF) with the codecs supported by the registered Handsfree Audio
> Agent.
> ---
>  drivers/hfpmodem/slc.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/hfpmodem/slc.c b/drivers/hfpmodem/slc.c
> index 646befa..b9b687b 100644
> --- a/drivers/hfpmodem/slc.c
> +++ b/drivers/hfpmodem/slc.c
> @@ -34,6 +34,7 @@
>  #include <ofono/log.h>
>  #include <ofono/modem.h>
>  #include <ofono/emulator.h>
> +#include <ofono/handsfree-audio.h>
>  =

>  #include <drivers/atmodem/atutil.h>
>  =

> @@ -305,9 +306,27 @@ static void brsf_cb(gboolean ok, GAtResult *result, =
gpointer user_data)
>  	if (info->ag_features & HFP_AG_FEATURE_CODEC_NEGOTIATION &&
>  			info->hf_features & HFP_HF_FEATURE_CODEC_NEGOTIATION) {
>  =

> +		unsigned char codecs[8];
> +		GString *str;
> +		int i, len;
> +
> +		len =3D ofono_handsfree_get_codecs(codecs, sizeof(codecs));
> +		if (len < 0)

This should read "if (len <=3D 0)". Will fix it in the next round.

> +			goto error;
> +
> +		str =3D g_string_new("AT+BAC=3D");
> +
> +		for (i =3D 0; i < (len - 1); i++)
> +			g_string_append_printf(str, "%d,", codecs[i]);
> +
> +		g_string_append_printf(str, "%d", codecs[i]);
> +
>  		slc_establish_data_ref(sed);
> -		g_at_chat_send(info->chat, "AT+BAC=3D1", NULL, bac_cb, sed,
> +		g_at_chat_send(info->chat, str->str, NULL, bac_cb, sed,
>  						slc_establish_data_unref);
> +
> +		g_string_free(str, TRUE);
> +
>  		return;
>  	}
>  =

> -- =

> 1.7.11.7
> =



Cheers,
-- =

Vinicius

--===============6607614126786096972==--

