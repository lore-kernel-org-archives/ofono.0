Content-Type: multipart/mixed; boundary="===============4774659977725214155=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] hfpmodem: fix hf features
Date: Fri, 05 Aug 2011 17:09:46 -0500
Message-ID: <4E3C6A2A.9060002@gmail.com>
In-Reply-To: <1312462544-21581-2-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4774659977725214155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 08/04/2011 07:55 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> check audio gateway version and only set right features
> ---
>  drivers/hfpmodem/slc.c |    5 +++++
>  drivers/hfpmodem/slc.h |    1 +
>  2 files changed, 6 insertions(+), 0 deletions(-)
> =

> diff --git a/drivers/hfpmodem/slc.c b/drivers/hfpmodem/slc.c
> index f9eca22..db1c3b9 100644
> --- a/drivers/hfpmodem/slc.c
> +++ b/drivers/hfpmodem/slc.c
> @@ -60,9 +60,14 @@ void hfp_slc_info_init(struct hfp_slc_info *info)
>  	info->hf_features =3D HFP_HF_FEATURE_3WAY;
>  	info->hf_features |=3D HFP_HF_FEATURE_CLIP;
>  	info->hf_features |=3D HFP_HF_FEATURE_REMOTE_VOLUME_CONTROL;
> +
> +	if (info->ag_version < 0x0105)
> +		goto done;
> +
>  	info->hf_features |=3D HFP_HF_FEATURE_ENHANCED_CALL_STATUS;
>  	info->hf_features |=3D HFP_HF_FEATURE_ENHANCED_CALL_CONTROL;
>  =

> +done:
>  	memset(info->cind_val, 0, sizeof(info->cind_val));
>  	memset(info->cind_pos, 0, sizeof(info->cind_pos));
>  }
> diff --git a/drivers/hfpmodem/slc.h b/drivers/hfpmodem/slc.h
> index f37a59c..7f4203f 100644
> --- a/drivers/hfpmodem/slc.h
> +++ b/drivers/hfpmodem/slc.h
> @@ -42,6 +42,7 @@ typedef void (*hfp_slc_cb_t)(void *userdata);
>  =

>  struct hfp_slc_info {
>  	GAtChat *chat;
> +	int ag_version;

I think you can avoid introducing this member if you simply pass the
version into hfp_slc_info_init.

>  	unsigned int ag_features;
>  	unsigned int ag_mpty_features;
>  	unsigned int hf_features;

Regards,
-Denis

--===============4774659977725214155==--

