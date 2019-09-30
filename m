Content-Type: multipart/mixed; boundary="===============7884786329530547012=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: CGDCONT handling for cid 0
Date: Mon, 30 Sep 2019 11:15:36 -0500
Message-ID: <5e3296f9-e8c1-617d-23f2-b7b5573e229b@gmail.com>
In-Reply-To: <1569566792-2914-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7884786329530547012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 9/27/19 1:46 AM, Antara Borwankar wrote:
> Added handling for cid 0 in +CGDCONT callback.
> ---
>   drivers/atmodem/gprs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/drivers/atmodem/gprs.c b/drivers/atmodem/gprs.c
> index 16f4927..defbba0 100644
> --- a/drivers/atmodem/gprs.c
> +++ b/drivers/atmodem/gprs.c
> @@ -240,7 +240,7 @@ static void at_cgdcont_read_cb(gboolean ok, GAtResult=
 *result,
>   		return;
>   	}
>   =

> -	cids =3D l_uintset_new(activated_cid);
> +	cids =3D l_uintset_new_from_range(0,activated_cid);

Applied with a silent amend to put a space between ',' and 2nd argument.

>   =

>   	l_uintset_put(cids, activated_cid);
>   =

> =


Regards,
-Denis
--===============7884786329530547012==--

