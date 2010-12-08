Content-Type: multipart/mixed; boundary="===============4497973558746870361=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/4]simutil: Changes to prepare for isimodem2.5
Date: Wed, 08 Dec 2010 16:30:12 +0100
Message-ID: <1291822212.4795.177.camel@aeonflux>
In-Reply-To: <1291797276-20511-1-git-send-email-jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4497973558746870361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jessica,

> updates in src/simutil.h
> Adding some sim file id and sim dir id mostly related to phonebook usim/s=
im.

please write a proper commit message here. The subject is not acceptable
since it misleads what this patch is doing.

Also "updates in src/..." comments are not really useful. We have the
diffstat for this.

> ---
>  src/simutil.h |   21 +++++++++++++++++++++
>  1 files changed, 21 insertions(+), 0 deletions(-)
> =

> diff --git a/src/simutil.h b/src/simutil.h
> index 92b2e0f..bc53255 100644
> --- a/src/simutil.h
> +++ b/src/simutil.h
> @@ -19,6 +19,8 @@
>   *
>   */
>  =

> +#include "types.h"
> +

What is this include for? Please remove it.

>  enum sim_fileid {
>  	SIM_EFPL_FILEID =3D 0x2f05,
>  	SIM_EF_ICCID_FILEID =3D 0x2fe2,
> @@ -49,6 +51,25 @@ enum sim_fileid {
>  	SIM_EFCBMIR_FILEID =3D 0x6f50,
>  	SIM_EFCBMI_FILEID =3D 0x6f45,
>  	SIM_EFCBMID_FILEID =3D 0x6f48,
> +	SIM_EFSMSP_FILEID =3D 0x6f42,
> +	SIM_EFIMSI_FILEID =3D 0x6F07,
> +
> +	/* Phonebook (USIM) */
> +	SIM_EFPBR_FILEID =3D 0x4f30,
> +	SIM_EFPSC_FILEID =3D 0x4F22,
> +	SIM_EFCC_FILEID =3D 0x4F23,
> +	SIM_EFPUID_FILEID =3D 0x4F24,
> +	/* Phonebook (SIM) */
> +	SIM_EFADN_SIM_FILEID =3D 0x6F3A,
> +	SIM_EFEXT1_SIM_FILEID =3D 0x6F4A,
> +};

So please be consistent with lower-case hex encoding. So 0x6f07 etc.

Also we should keep this information sorted. I know there is a sorting
bug in there that needs to be fixed as well.

And while at it, you could be the one that makes this enum finally
compliant to our coding style. This is one of our old left-overs that we
have get fixed. We just never got around to it. Are you up for such a
task?

So you could just fix the coding style in one patch, fix the sorting in
another and then add the new values.

> +enum sim_dirid {
> +	MF_FILEID =3D 0x3F00,
> +	DFTELECOM_FILEID =3D 0x7F10,
> +	DFGSM_FILEID =3D 0x7F20,
> +	DFPHONEBOOK_FILEID =3D 0x5F3A,
> +	DFMULTIMEDIA_FILEID =3D 0x5F3B
>  };

Please use a proper SIM_* prefix here and you can just put them into the
sim_fileid enum. However this should be a separate patch to get a clear
commit history of the changes.

Regards

Marcel



--===============4497973558746870361==--

