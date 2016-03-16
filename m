Content-Type: multipart/mixed; boundary="===============8107447300462083051=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 03/11] plugins/ublox: use vendor from structure instead of
 fixed
Date: Wed, 16 Mar 2016 13:20:33 -0500
Message-ID: <56E9A3F1.3070804@gmail.com>
In-Reply-To: <1457970664-20782-4-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8107447300462083051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dragos,

On 03/14/2016 10:50 AM, Dragos Tatulea wrote:
> That's because we need to differentiate between multiple ublox
> devices.
> ---
>   plugins/ublox.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/plugins/ublox.c b/plugins/ublox.c
> index eab4ed4..d930efe 100644
> --- a/plugins/ublox.c
> +++ b/plugins/ublox.c
> @@ -267,8 +267,8 @@ static void ublox_pre_sim(struct ofono_modem *modem)
>
>   	DBG("%p", modem);
>
> -	ofono_devinfo_create(modem, 0, "atmodem", data->aux);
> -	sim =3D ofono_sim_create(modem, OFONO_VENDOR_UBLOX, "atmodem",
> +	ofono_devinfo_create(modem, data->vendor_family, "atmodem", data->aux);

There's no vendor-specific code inside the devinfo driver.  In general, =

unless vendor-specific paths are actually needed, set the vendor field =

to 0.  That makes it easier to know when vendor specific behavior is used.

> +	sim =3D ofono_sim_create(modem, data->vendor_family, "atmodem",
>   					data->aux);
>
>   	if (sim)
> @@ -283,10 +283,10 @@ static void ublox_post_sim(struct ofono_modem *mode=
m)
>
>   	DBG("%p", modem);
>
> -	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_UBLOX, "atmodem",
> +	gprs =3D ofono_gprs_create(modem, data->vendor_family, "atmodem",
>   					data->aux);
> -	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_UBLOX, "atmodem",
> -					data->modem);
> +	gc =3D ofono_gprs_context_create(modem, data->vendor_family, "atmodem",
> +					data->modem ? data->modem : data->aux);
>
>   	if (gprs && gc)
>   		ofono_gprs_add_context(gprs, gc);
> @@ -296,7 +296,7 @@ static void ublox_post_online(struct ofono_modem *mod=
em)
>   {
>   	struct ublox_data *data =3D ofono_modem_get_data(modem);
>
> -	ofono_netreg_create(modem, 0, "atmodem", data->aux);
> +	ofono_netreg_create(modem, data->vendor_family, "atmodem", data->aux);
>   }
>
>   static struct ofono_modem_driver ublox_driver =3D {
>

Applied, thanks.

Regards,
-Denis

--===============8107447300462083051==--

