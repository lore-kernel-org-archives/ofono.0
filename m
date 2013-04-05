Content-Type: multipart/mixed; boundary="===============7732669580828259566=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/5] handsfree-audio: Add function to get the codecs
Date: Fri, 05 Apr 2013 12:32:59 -0500
Message-ID: <515F0ACB.6080408@gmail.com>
In-Reply-To: <1365031481-10467-4-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7732669580828259566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 04/03/2013 06:24 PM, Vinicius Costa Gomes wrote:
> From: Claudio Takahasi<claudio.takahasi@openbossa.org>
>
> This patch adds a new handsfree-audio public function to read the
> available codecs registered by the agent.
> ---
>   include/handsfree-audio.h |  1 +
>   src/handsfree-audio.c     | 13 +++++++++++++
>   2 files changed, 14 insertions(+)

Please split up these two patches according to our patch submission =

guidelines.

>
> diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
> index 49b0605..f8a731f 100644
> --- a/include/handsfree-audio.h
> +++ b/include/handsfree-audio.h
> @@ -48,6 +48,7 @@ struct ofono_handsfree_card *ofono_handsfree_card_creat=
e(unsigned int vendor,
>   							void *data);
>   int ofono_handsfree_card_register(struct ofono_handsfree_card *card);
>   void ofono_handsfree_card_remove(struct ofono_handsfree_card *card);
> +int ofono_handsfree_get_codecs(unsigned char *buffer, int buffer_len);

This is confusing, there is an ofono_handsfree object already and this =

is not related.  Rename this into ofono_handsfree_audio_get_codecs.

>
>   void ofono_handsfree_card_set_data(struct ofono_handsfree_card *card,
>   					void *data);
> diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
> index 3f24a2a..d1a22db 100644
> --- a/src/handsfree-audio.c
> +++ b/src/handsfree-audio.c
> @@ -541,6 +541,19 @@ void ofono_handsfree_card_remove(struct ofono_handsf=
ree_card *card)
>   	g_free(card);
>   }
>
> +int ofono_handsfree_get_codecs(unsigned char *buffer, int buffer_len)
> +{
> +	int len;
> +
> +	if (agent =3D=3D NULL)
> +		return -EIO;
> +
> +	len =3D MIN(buffer_len, agent->codecs_len);
> +	memcpy(buffer, agent->codecs, len);
> +
> +	return len;
> +}
> +

Do we really want to memcpy here or return a const unsigned char array? =

  Also, right now we explicitly only support CVSD and mSBC, so this is =

overkill.

>   static void agent_free(struct agent *agent)
>   {
>   	if (agent->watch>  0)

Regards,
-Denis

--===============7732669580828259566==--

