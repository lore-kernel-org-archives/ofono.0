Content-Type: multipart/mixed; boundary="===============3012539551194236107=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 05/19] hfpmodem: Set initial state for inband ringing
Date: Thu, 13 Oct 2011 13:09:37 -0500
Message-ID: <4E972961.40804@gmail.com>
In-Reply-To: <1318422940-14955-6-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3012539551194236107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

On 10/12/2011 07:35 AM, Mikel Astiz wrote:
> According to the HFP specification, inband ringing will be enabled by
> default if the AG supports it. This setting could later be changed by
> the unsolicited result code +BSIR.
> ---
>  drivers/hfpmodem/handsfree.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)

Patch has been applied, however I amended it slightly due to a compiler
error.

> =

> diff --git a/drivers/hfpmodem/handsfree.c b/drivers/hfpmodem/handsfree.c
> index d3b5b44..12a23fc 100644
> --- a/drivers/hfpmodem/handsfree.c
> +++ b/drivers/hfpmodem/handsfree.c
> @@ -44,6 +44,7 @@
>  =

>  struct hf_data {
>  	GAtChat *chat;
> +	unsigned int ag_features;
>  };
>  =

>  static gboolean hfp_handsfree_register(gpointer user_data)
> @@ -52,6 +53,9 @@ static gboolean hfp_handsfree_register(gpointer user_da=
ta)
>  =

>  	ofono_handsfree_register(hf);
>  =

> +	if (hd->ag_features & HFP_AG_FEATURE_IN_BAND_RING_TONE)
> +		ofono_handsfree_set_inband_ringing(hf, TRUE);
> +

I also moved this part to happen before registering in a later commit.
1 less signal emission to worry about ;)

>  	return FALSE;
>  }
>  =

> @@ -64,6 +68,7 @@ static int hfp_handsfree_probe(struct ofono_handsfree *=
hf,
>  	DBG("");
>  	hd =3D g_new0(struct hf_data, 1);
>  	hd->chat =3D g_at_chat_clone(info->chat);
> +	hd->ag_features =3D info->ag_features;
>  =

>  	ofono_handsfree_set_data(hf, hd);
>  =


Regards,
-Denis

--===============3012539551194236107==--

