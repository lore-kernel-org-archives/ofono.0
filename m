Content-Type: multipart/mixed; boundary="===============8981628000337386710=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] handsfree-audio: Fix missing card index increment
Date: Tue, 26 Feb 2013 15:48:11 -0600
Message-ID: <512D2D9B.7030801@gmail.com>
In-Reply-To: <1361914963-24197-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8981628000337386710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 02/26/2013 03:42 PM, Claudio Takahasi wrote:
> ---
>   src/handsfree-audio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
> index db65971..acd08e4 100644
> --- a/src/handsfree-audio.c
> +++ b/src/handsfree-audio.c
> @@ -165,7 +165,7 @@ int ofono_handsfree_card_register(struct ofono_handsf=
ree_card *card)
>   	if (card =3D=3D NULL)
>   		return -EINVAL;
>
> -	snprintf(path, sizeof(path), "/card_%d", next_card_id);
> +	snprintf(path, sizeof(path), "/card_%d", next_card_id++);
>
>   	if (!g_dbus_register_interface(ofono_dbus_get_connection(), path,
>   					HFP_AUDIO_CARD_INTERFACE,

Darn, I had to forget something :)

My own fix pushed that is a little bit more paranoid.

Regards,
-Denis

--===============8981628000337386710==--

