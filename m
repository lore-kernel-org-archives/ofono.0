Content-Type: multipart/mixed; boundary="===============7408542854615872623=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 6/7] handsfree-audio: Set CVSD as default in the card
Date: Fri, 12 Apr 2013 18:14:02 -0500
Message-ID: <5168953A.30200@gmail.com>
In-Reply-To: <1365622677-4824-6-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7408542854615872623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 04/10/2013 02:37 PM, Vinicius Costa Gomes wrote:
> From: Claudio Takahasi<claudio.takahasi@openbossa.org>
>
> If the device doesn't support codec negotiation, the selected codec is
> not being initialized. For this case set CVSD as default.
> ---
>   src/handsfree-audio.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
> index 8fc6f93..a332f68 100644
> --- a/src/handsfree-audio.c
> +++ b/src/handsfree-audio.c
> @@ -342,6 +342,8 @@ struct ofono_handsfree_card *ofono_handsfree_card_cre=
ate(unsigned int vendor,
>
>   	card =3D g_new0(struct ofono_handsfree_card, 1);
>
> +	card->selected_codec =3D HFP_CODEC_CVSD;
> +
>   	card_list =3D g_slist_prepend(card_list, card);
>
>   	for (l =3D drivers; l; l =3D l->next) {

Please merge this patch with 'set_codec' implementation.

Regards,
-Denis

--===============7408542854615872623==--

