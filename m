Content-Type: multipart/mixed; boundary="===============0374414840993534513=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v0 09/10] handsfree-audio: Add function to get hfp version
Date: Fri, 01 Mar 2013 13:40:31 -0600
Message-ID: <5131042F.7030208@gmail.com>
In-Reply-To: <1362077572-28049-10-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0374414840993534513==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 02/28/2013 12:52 PM, Claudio Takahasi wrote:
> This patch adds a new function to read the local supported Handsfree
> Profile version.
> ---
>   include/handsfree-audio.h | 1 +
>   src/handsfree-audio.c     | 5 +++++
>   2 files changed, 6 insertions(+)
>
> diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
> index c5403c7..96597c2 100644
> --- a/include/handsfree-audio.h
> +++ b/include/handsfree-audio.h
> @@ -34,6 +34,7 @@ struct ofono_handsfree_card *ofono_handsfree_card_creat=
e(const char *remote,
>   							const char *local);
>   int ofono_handsfree_card_register(struct ofono_handsfree_card *card);
>   void ofono_handsfree_card_remove(struct ofono_handsfree_card *card);
> +enum hfp_version ofono_handsfree_get_version();
>

I'd like to avoid such details in the card functionality.

Are our possible scenarios the following?

1. SCO defer in kernel, CVSD mSBC supported
2. SCO defer not in kernel, CVSD mSBC supported
3. SCO defer in kernel, CVSD supported
4. SCO defer not in kernel, CVSD supported

If so, can we always advertise HFP 1.6, but only declare support for =

CVSD in case 2?

>   void ofono_handsfree_audio_ref(void);
>   void ofono_handsfree_audio_unref(void);
> diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
> index d0ccf29..955c6ef 100644
> --- a/src/handsfree-audio.c
> +++ b/src/handsfree-audio.c
> @@ -363,6 +363,11 @@ void ofono_handsfree_card_remove(struct ofono_handsf=
ree_card *card)
>   	g_free(card);
>   }
>
> +enum hfp_version ofono_handsfree_get_version()
> +{
> +	return local_hfp_version;
> +}
> +
>   static void agent_free(struct agent *agent)
>   {
>   	if (agent->watch>  0)

Regards,
-Denis

--===============0374414840993534513==--

