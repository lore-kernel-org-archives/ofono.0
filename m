Content-Type: multipart/mixed; boundary="===============2195614093944520512=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: add EUTRAN tech for creg read status
Date: Thu, 27 Sep 2018 07:36:15 -0500
Message-ID: <59e96a82-2c0d-7b84-6bf5-601a12cd2af2@gmail.com>
In-Reply-To: <1538047196-11843-1-git-send-email-anirudh.gargi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2195614093944520512==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anirudh,

On 09/27/2018 06:19 AM, Anirudh Gargi wrote:
> Add handling for CREG's status to get the technology type. CREG
> notify URC does not need additional handling as 'AcT' is mapped
> one-on-one to tech.
> ---
>   drivers/atmodem/network-registration.c | 4 ++++
>   1 file changed, 4 insertions(+)
> =

> diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/net=
work-registration.c
> index 0854cd1..789397e 100644
> --- a/drivers/atmodem/network-registration.c
> +++ b/drivers/atmodem/network-registration.c
> @@ -228,6 +228,10 @@ static void at_creg_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
>   	if ((status =3D=3D 1 || status =3D=3D 5) && (tech =3D=3D -1))
>   		tech =3D nd->tech;
>   =

> +	/* 6-10 is EUTRAN, with 8 being emergency bearer case */
> +	if((status > 5) && (tech =3D=3D -1))

No parentheses are needed here.  Also I fixed the missing space after =

'if' and applied this patch.

> +		tech =3D ACCESS_TECHNOLOGY_EUTRAN;
> +
>   	cb(&error, status, lac, ci, tech, cbd->data);
>   }
>   =

> =


Regards,
-denis

--===============2195614093944520512==--

