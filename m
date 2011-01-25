Content-Type: multipart/mixed; boundary="===============8234625529462366252=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/1] simutil: EF Fileid additions USIM and SIM Phonebook
 isimodem2.5
Date: Tue, 25 Jan 2011 13:20:08 +0100
Message-ID: <1295958008.1520.33.camel@aeonflux>
In-Reply-To: <1295957372-28677-1-git-send-email-jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8234625529462366252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jessica,

> Adding EF Fileids for USIM and SIM Phonebook.
> Also, adding some general fileids for building paths.
> =

> Needed for isimodem2.5 patches planned to follow shortly.
> =

> =

> Best Regards,
> Jessica

as an exercise, please save this email and then run "git am" and "git
log" afterwards ;)

So you need to keep the body part of the email without things like
standard conversation phrases. Since we need to clean them up manually
after applying the patch.

> ---

Extra comments that are for the reviewer and not the git commit message
have to go here.

So I would put the comment here for isimodem2.5 and not in the subject
or the body message since it is only vague related to isimodem2.5 in the
end.

>  src/simutil.h |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> =

> diff --git a/src/simutil.h b/src/simutil.h
> index 95bc18f..17a9f30 100644
> --- a/src/simutil.h
> +++ b/src/simutil.h
> @@ -25,8 +25,16 @@
>  enum sim_fileid {
>  	SIM_EFPL_FILEID =3D			0x2F05,
>  	SIM_EF_ICCID_FILEID =3D			0x2FE2,
> +	SIM_MF_FILEID =3D				0x3F00,
>  	SIM_EFIMG_FILEID =3D			0x4F20,
> +	SIM_EFPSC_FILEID =3D			0x4F22,
> +	SIM_EFCC_FILEID =3D			0x4F23,
> +	SIM_EFPUID_FILEID =3D			0x4F24,
> +	SIM_EFPBR_FILEID =3D			0x4F30,
> +	SIM_DFPHONEBOOK_FILEID =3D		0x5F3A,
> +	SIM_DFMULTIMEDIA_FILEID =3D		0x5F3B,
>  	SIM_EFLI_FILEID =3D			0x6F05,
> +	SIM_EFIMSI_FILEID =3D			0x6F07,
>  	SIM_EF_CPHS_MWIS_FILEID =3D		0x6F11,
>  	SIM_EF_CPHS_CFF_FILEID =3D		0x6F13,
>  	SIM_EF_CPHS_INFORMATION_FILEID =3D	0x6F16,
> @@ -35,10 +43,12 @@ enum sim_fileid {
>  	SIM_EFSST_FILEID =3D			0x6F38, /* same as EFust */
>  	SIM_EFADN_FILEID =3D			0x6F3A,
>  	SIM_EFMSISDN_FILEID =3D			0x6F40,
> +	SIM_EFSMSP_FILEID =3D			0x6F42,
>  	SIM_EFCBMI_FILEID =3D			0x6F45,
>  	SIM_EFSPN_FILEID =3D			0x6F46,
>  	SIM_EFCBMID_FILEID =3D			0x6F48,
>  	SIM_EFSDN_FILEID =3D			0x6F49,
> +	SIM_EFEXT1_FILEID =3D			0x6F4A,
>  	SIM_EFBDN_FILEID =3D			0x6F4D,
>  	SIM_EFCBMIR_FILEID =3D			0x6F50,
>  	SIM_EFEST_FILEID =3D			0x6F56,
> @@ -52,6 +62,9 @@ enum sim_fileid {
>  	SIM_EFMWIS_FILEID =3D			0x6FCA,
>  	SIM_EFCFIS_FILEID =3D			0x6FCB,
>  	SIM_EFSPDI_FILEID =3D			0x6FCD,
> +	SIM_DFTELECOM_FILEID =3D			0x7F10,
> +	SIM_DFGSM_FILEID =3D			0x7F20,
> +

Scrap the extra empty line here.
>  };
>  =


Regards

Marcel



--===============8234625529462366252==--

