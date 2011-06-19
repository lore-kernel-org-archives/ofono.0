Content-Type: multipart/mixed; boundary="===============0385052562436062474=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] emulator: add HFP feature defines
Date: Sun, 19 Jun 2011 06:31:20 -0500
Message-ID: <4DFDDE08.5070600@gmail.com>
In-Reply-To: <1308582828-3806-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0385052562436062474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 06/20/2011 10:13 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> ---
>  include/emulator.h |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
> =

> diff --git a/include/emulator.h b/include/emulator.h
> index 5cd894b..452c59c 100644
> --- a/include/emulator.h
> +++ b/include/emulator.h
> @@ -48,6 +48,25 @@ extern "C" {
>  #define OFONO_EMULATOR_CALLHELD_MULTIPLE 1
>  #define OFONO_EMULATOR_CALLHELD_ON_HOLD 2
>  =

> +/* AG supported features bitmap. Bluetooth HFP 1.5 spec page 77 */
> +#define AG_FEATURE_3WAY 0x1
> +#define AG_FEATURE_ECNR 0x2
> +#define AG_FEATURE_VOICE_RECOG 0x4
> +#define AG_FEATURE_IN_BAND_RING_TONE 0x8
> +#define AG_FEATURE_ATTACH_VOICE_TAG 0x10
> +#define AG_FEATURE_REJECT_CALL 0x20
> +#define AG_FEATURE_ENHANCED_CALL_STATUS 0x40
> +#define AG_FEATURE_ENHANCED_CALL_CONTROL 0x80
> +#define AG_FEATURE_EXTENDED_RES_CODE 0x100
> +
> +#define HF_FEATURE_ECNR 0x1
> +#define HF_FEATURE_3WAY 0x2
> +#define HF_FEATURE_CLIP 0x4
> +#define HF_FEATURE_VOICE_RECOGNITION 0x8
> +#define HF_FEATURE_REMOTE_VOLUME_CONTROL 0x10
> +#define HF_FEATURE_ENHANCED_CALL_STATUS 0x20
> +#define HF_FEATURE_ENHANCED_CALL_CONTROL 0x40
> +

Since you're copying them from hfpmodem.h, I suggest making it official
and not duplicate code.  So I would suggest:

- add
	enum hfp_ag_feature {
		HFP_AG_FEATURE_3WAY =3D	0x1,
		HFP_AG_FEATURE_ECNR =3D	0x2,
		...
	};

	enum hfp_hf_feature {
		...
	};

to include/types.h, remove them from hfpmodem.h and use the new defines.

>  struct ofono_emulator;
>  struct ofono_emulator_request;
>  =


Regards,
-Denis

--===============0385052562436062474==--

