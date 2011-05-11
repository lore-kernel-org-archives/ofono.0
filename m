Content-Type: multipart/mixed; boundary="===============5385490446743186138=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Fix a memory leak,
 all dir opened with opendir must be closed with closedir
Date: Wed, 11 May 2011 13:35:27 -0500
Message-ID: <4DCAD6EF.30600@gmail.com>
In-Reply-To: <1305127663-6173-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5385490446743186138==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

On 05/11/2011 10:27 AM, Bertrand Aygon wrote:
> ---
>  plugins/nokia-gpio.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> =

> diff --git a/plugins/nokia-gpio.c b/plugins/nokia-gpio.c
> index 3ddf6e1..57aad8d 100644
> --- a/plugins/nokia-gpio.c
> +++ b/plugins/nokia-gpio.c
> @@ -645,7 +645,6 @@ static int gpio_probe_links(void)
>  	DBG("Using %s: trying to make links to %s", gpiodir, cmtdir);
>  =

>  	if (!dir_exists(cmtdir)) {
> -
>  		if (mkdir(cmtdir, 0755) =3D=3D -1) {
>  			DBG("%s: %s", cmtdir, strerror(errno));
>  			return -(errno =3D ENODEV);

Since this is a style issue, I broke your patch up into two.

> @@ -663,8 +662,10 @@ static int gpio_probe_links(void)
>  		FILE *nf;
>  		size_t len;
>  =

> -		if (d =3D=3D NULL)
> +		if (d =3D=3D NULL) {
> +			(void) closedir(gpio);
>  			return 0;
> +		}
>  =

>  		snprintf(nn, sizeof nn, "%s/%s/name", gpiodir, d->d_name);
>  =

> @@ -701,6 +702,8 @@ static int gpio_probe_links(void)
>  =

>  	DBG("%s: %s", "/sys/class/gpio", strerror(errno));
>  =

> +	(void) closedir(gpio);
> +
>  	return -(errno =3D ENODEV);
>  }
>  =


Patch has been applied with a modified commit message.  Thanks.

Regards,
-Denis

--===============5385490446743186138==--

