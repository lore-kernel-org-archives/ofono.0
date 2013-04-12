Content-Type: multipart/mixed; boundary="===============6547882925738934833=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/7] include: ofono_handsfree_card_select_codec()
Date: Fri, 12 Apr 2013 18:12:25 -0500
Message-ID: <516894D9.2090807@gmail.com>
In-Reply-To: <1365622677-4824-2-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6547882925738934833==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 04/10/2013 02:37 PM, Vinicius Costa Gomes wrote:
> This will be used by the drivers that a given codec was negotiated
> for a card.
> ---
>   include/handsfree-audio.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
> index 82d1312..2e58c43 100644
> --- a/include/handsfree-audio.h
> +++ b/include/handsfree-audio.h
> @@ -48,6 +48,8 @@ struct ofono_handsfree_card *ofono_handsfree_card_creat=
e(unsigned int vendor,
>   							void *data);
>   int ofono_handsfree_card_register(struct ofono_handsfree_card *card);
>   void ofono_handsfree_card_remove(struct ofono_handsfree_card *card);
> +void ofono_handsfree_card_select_codec(struct ofono_handsfree_card *card,
> +							unsigned char codec);

As mentioned before, lets make this return ofono_bool_t and name it =

'set_codec'.

Also, do we have some idea whether codec ids are limited to 8 bits or =

they can be larger?  My reading of the spec would seem to indicate 8 =

bits maximum.

>
>   ofono_bool_t ofono_handsfree_audio_has_wideband(void);
>

Regards,
-Denis

--===============6547882925738934833==--

