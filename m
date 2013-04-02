Content-Type: multipart/mixed; boundary="===============1368526371296856219=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] SIMCOM AT+CNMI quirk
Date: Mon, 01 Apr 2013 21:35:44 -0500
Message-ID: <515A4400.1030805@gmail.com>
In-Reply-To: <1363948578-24128-2-git-send-email-viallard@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1368526371296856219==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anthony,

On 03/22/2013 05:36 AM, Anthony Viallard wrote:
> Add a quirk for AT+CNMI command building.
>
> Use mode=3D1 otherwise it fails (ref. SIM5215_SIM5216_ATC_V1.18.pdf - =C2=
=A76.9)
>

You might want to quote the relevant section in the patch description. =

Otherwise it looks good to me, but I still can't apply it.  Please use =

git send-email.

> --- ofono-1.12.orig/drivers/atmodem/sms.c	2012-04-20 21:06:29.000000000 +=
0200
> +++ ofono-1.12/drivers/atmodem/sms.c	2013-01-21 16:48:44.460627485 +0100
> @@ -805,6 +807,7 @@ static gboolean build_cnmi_string(char *
>   	case OFONO_VENDOR_NOVATEL:
>   	case OFONO_VENDOR_HUAWEI:
>   	case OFONO_VENDOR_ZTE:
> +	case OFONO_VENDOR_SIMCOM:
>   		/* MSM devices advertise support for mode 2, but return an
>   		 * error if we attempt to actually use it. */
>   		mode =3D "1";
>
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

Regards,
-Denis

--===============1368526371296856219==--

