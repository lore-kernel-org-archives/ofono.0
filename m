Content-Type: multipart/mixed; boundary="===============1736007069006341848=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] hfp: Add Voice Recognition flag to BRSF for HF role
Date: Thu, 05 Dec 2013 03:52:47 -0600
Message-ID: <52A04CEF.7000409@gmail.com>
In-Reply-To: <1386167773-6375-2-git-send-email-andrewx.earl@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1736007069006341848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 12/04/2013 08:36 AM, Andrew Earl wrote:
> ---
>   drivers/hfpmodem/slc.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hfpmodem/slc.c b/drivers/hfpmodem/slc.c
> index 38a9b2e..3a28a26 100644
> --- a/drivers/hfpmodem/slc.c
> +++ b/drivers/hfpmodem/slc.c
> @@ -63,6 +63,7 @@ void hfp_slc_info_init(struct hfp_slc_info *info, guint=
16 version)
>   	info->hf_features |=3D HFP_HF_FEATURE_3WAY;
>   	info->hf_features |=3D HFP_HF_FEATURE_CLIP;
>   	info->hf_features |=3D HFP_HF_FEATURE_REMOTE_VOLUME_CONTROL;
> +        info->hf_features |=3D HFP_HF_FEATURE_VOICE_RECOGNITION;

Please note that we do not use spaces for indentation, only tabs.  I had =

to fix this up for you manually.  Please keep this in mind for future =

submissions.

>
>   	if (version < HFP_VERSION_1_5)
>   		goto done;
>

Patch has been applied, thanks.

Regards,
-Denis

--===============1736007069006341848==--

