Content-Type: multipart/mixed; boundary="===============6303922699973067983=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC v4 10/10] emulator: Update supported features
Date: Fri, 06 Apr 2012 12:38:51 -0500
Message-ID: <4F7F2A2B.8070708@gmail.com>
In-Reply-To: <1333718232-8447-11-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6303922699973067983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 04/06/2012 08:17 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> Add ECNR (Echo Cancelation/Noise Reduction) and Inband Ringtone
> capabilities to supported features (+BRSF event)
> ---
>  src/emulator.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> =

> diff --git a/src/emulator.c b/src/emulator.c
> index e7c7d41..371e96c 100644
> --- a/src/emulator.c
> +++ b/src/emulator.c
> @@ -979,6 +979,8 @@ struct ofono_emulator *ofono_emulator_create(struct o=
fono_modem *modem,
>  =

>  	em->type =3D type;
>  	em->l_features |=3D HFP_AG_FEATURE_3WAY;
> +	em->l_features |=3D HFP_AG_FEATURE_ECNR;
> +	em->l_features |=3D HFP_AG_FEATURE_IN_BAND_RING_TONE;
>  	em->l_features |=3D HFP_AG_FEATURE_REJECT_CALL;
>  	em->l_features |=3D HFP_AG_FEATURE_ENHANCED_CALL_STATUS;
>  	em->l_features |=3D HFP_AG_FEATURE_ENHANCED_CALL_CONTROL;

I think it would be better for the features to be modified based on what
command handlers are registered.  E.g. if NREC handler is registered in
ofono_emulator_add_handler then add ECNR to local features, etc.

Regards,
-Denis


--===============6303922699973067983==--

