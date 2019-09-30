Content-Type: multipart/mixed; boundary="===============6622377828616105565=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] atmodem: CGDCONT handling for cid 0
Date: Mon, 30 Sep 2019 10:22:29 +0200
Message-ID: <20190930082229.GA28314@amd>
In-Reply-To: <1569566792-2914-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6622377828616105565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri 2019-09-27 12:16:32, Antara Borwankar wrote:
> Added handling for cid 0 in +CGDCONT callback.
> ---
>  drivers/atmodem/gprs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
> index 16f4927..defbba0 100644
> --- a/drivers/atmodem/gprs.c
> +++ b/drivers/atmodem/gprs.c
> @@ -240,7 +240,7 @@ static void at_cgdcont_read_cb(gboolean ok, GAtResult=
 *result,
>  		return;
>  	}
>  =

> -	cids =3D l_uintset_new(activated_cid);
> +	cids =3D l_uintset_new_from_range(0,activated_cid);
>  =


For consistency, it should probably be "(0, activated_cid);".

>  	l_uintset_put(cids, activated_cid);
>

Best regards,
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============6622377828616105565==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsMlJ1MFVBQ2drUU1PZndhcFhiK3ZKblhBQ2d3RFdPSGh4ZmlYODN2bGpjaTVPeFplQmgK
U2Q0QW5BcGppSkdJWm9uSnRIOG1ZYkpwVlV5TFlVRkIKPW1Lc3MKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============6622377828616105565==--

