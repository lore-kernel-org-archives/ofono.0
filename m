Content-Type: multipart/mixed; boundary="===============8737276025026593030=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 07/19] atmodem: ublox: EPS now supported by newer ublox
Date: Thu, 10 Mar 2016 08:29:28 -0600
Message-ID: <56E184C8.4090608@gmail.com>
In-Reply-To: <1457538300-7183-8-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8737276025026593030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dragos,

On 03/09/2016 09:44 AM, Dragos Tatulea wrote:
> Based on UBX-13002752 R33
> ---
>   drivers/atmodem/gprs.c | 4 ----
>   1 file changed, 4 deletions(-)
>

Applying: atmodem: ublox: EPS now supported by newer ublox
error: patch failed: drivers/atmodem/gprs.c:303
error: drivers/atmodem/gprs.c: patch does not apply
Patch failed at 0001 atmodem: ublox: EPS now supported by newer ublox

> diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
> index 5551316..0165253 100644
> --- a/drivers/atmodem/gprs.c
> +++ b/drivers/atmodem/gprs.c
> @@ -303,10 +303,6 @@ static void ublox_ureg_notify(GAtResult *result, gpo=
inter user_data)
>   	case 5:
>   		bearer =3D 4;
>   		break;
> -	case 7:
> -		/* XXX: reserved - assume none. */
> -		bearer =3D 0;
> -		break;

I don't see this code upstream.

>   	case 8:
>   		bearer =3D 1;
>   		break;
>

Regards,
-Denis

--===============8737276025026593030==--

