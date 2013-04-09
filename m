Content-Type: multipart/mixed; boundary="===============6006337756861242150=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/6] handsfree-audio: Implement
 ofono_handsfree_audio_has_wideband
Date: Tue, 09 Apr 2013 14:35:58 -0500
Message-ID: <51646D9E.8020300@gmail.com>
In-Reply-To: <1365460863-14645-3-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6006337756861242150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 04/08/2013 05:41 PM, Vinicius Costa Gomes wrote:
> ---
>   src/handsfree-audio.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>

Patch has been applied, thanks.

> diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
> index 3f24a2a..699c8cc 100644
> --- a/src/handsfree-audio.c
> +++ b/src/handsfree-audio.c
> @@ -71,6 +71,7 @@ static int ref_count =3D 0;
>   static GSList *card_list =3D 0;
>   static guint sco_watch =3D 0;
>   static GSList *drivers =3D 0;
> +static ofono_bool_t has_wideband =3D FALSE;
>

Do you want to set this to reflect mSBC presence at some point?

Regards,
-Denis

--===============6006337756861242150==--

