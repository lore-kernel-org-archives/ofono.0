Content-Type: multipart/mixed; boundary="===============3096852881973299548=="
MIME-Version: 1.0
From: Frederic Danis <frederic.danis@linux.intel.com>
Subject: Re: [PATCH v0 01/15] handsfree-audio: Add card driver
Date: Wed, 13 Mar 2013 17:53:56 +0100
Message-ID: <5140AF24.1000604@linux.intel.com>
In-Reply-To: <1363092133-1092-2-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3096852881973299548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Claudio,

On 12/03/2013 13:41, Claudio Takahasi wrote:
> This patch adds a new handsfree audio driver abstration to allow
> implementing the connect callbacks and other potential functions
> specific of each HFP profile version. This approach also avoids
> including dependency of hfpmodem in handsfree-audio, keeping the service
> level handling inside the hfp_hf_bluez5 only.
> ---
>   include/handsfree-audio.h | 11 +++++++++++
>   src/handsfree-audio.c     | 34 ++++++++++++++++++++++++++++++++++
>   2 files changed, 45 insertions(+)
>
> diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
> index c5403c7..69f5a8e 100644
> --- a/include/handsfree-audio.h
> +++ b/include/handsfree-audio.h
> @@ -30,6 +30,17 @@ extern "C" {
>
>   struct ofono_handsfree_card;
>
> +struct ofono_handsfree_card_driver {
> +	int (*probe) (struct ofono_handsfree_card *card, void *data);
> +	void (*remove) (struct ofono_handsfree_card *card);
> +	int (*audio_connect) (const char *remote, const char *local);
> +};

If I understand correctly this will be used by both hfp_hf_bluez5 and =

hfp_ag_bluez5.
As connection process are not the same for HF and AG roles in HFP 1.6 =

handsfree-audio will need a way to discriminate drivers related to each =

of them.
You may add something like profile UUID to this struct.

Regards

Fred

-- =

Frederic Danis                            Open Source Technology Center
frederic.danis(a)intel.com                              Intel Corporation


--===============3096852881973299548==--

