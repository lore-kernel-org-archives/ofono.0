Content-Type: multipart/mixed; boundary="===============2483066662747035148=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/8] handsfree-audio: Implement
 ofono_handsfree_card_select_codec()
Date: Tue, 09 Apr 2013 20:49:28 -0500
Message-ID: <5164C528.9050505@gmail.com>
In-Reply-To: <1365540343-8394-5-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2483066662747035148==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 04/09/2013 03:45 PM, Vinicius Costa Gomes wrote:
> ---
>   src/handsfree-audio.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
> index 50be691..12d49db 100644
> --- a/src/handsfree-audio.c
> +++ b/src/handsfree-audio.c
> @@ -49,6 +49,7 @@ struct ofono_handsfree_card {
>   	char *local;
>   	char *path;
>   	DBusMessage *msg;
> +	unsigned char selected_codec;
>   	const struct ofono_handsfree_card_driver *driver;
>   	void *driver_data;
>   };
> @@ -535,6 +536,17 @@ void ofono_handsfree_card_remove(struct ofono_handsf=
ree_card *card)
>   	g_free(card);
>   }
>
> +int ofono_handsfree_card_select_codec(struct ofono_handsfree_card *card,
> +							unsigned char codec)
> +{

Actually make this return void.  If the driver is trying to operate on =

an invalid object then the driver is bugged and I want it to crash =

early, not later.

> +	if (card =3D=3D NULL)
> +		return -EINVAL;
> +
> +	card->selected_codec =3D codec;
> +
> +	return 0;
> +}
> +
>   ofono_bool_t ofono_handsfree_audio_has_wideband(void)
>   {
>   	return has_wideband;

Regards,
-Denis

--===============2483066662747035148==--

