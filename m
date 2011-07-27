Content-Type: multipart/mixed; boundary="===============4117979416616934816=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/4] speedup: Create SIM atom with SpeedUp vendor to
 handle proprietary commands
Date: Wed, 27 Jul 2011 16:15:02 +0200
Message-ID: <1311776102.8920.67.camel@aeonflux>
In-Reply-To: <1311351329-1241-3-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4117979416616934816==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

>  drivers/atmodem/sim.c |    1 +
>  plugins/speedup.c     |    2 +-
>  2 files changed, 2 insertions(+), 1 deletions(-)
> =

> diff --git a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
> index 2690ab4..a4a09f5 100644
> --- a/drivers/atmodem/sim.c
> +++ b/drivers/atmodem/sim.c
> @@ -151,6 +151,7 @@ static void at_sim_read_info(struct ofono_sim *sim, i=
nt fileid,
>  	case OFONO_VENDOR_HUAWEI:
>  	case OFONO_VENDOR_SIERRA:
>  	case OFONO_VENDOR_QUALCOMM_MSM:
> +	case OFONO_VENDOR_SPEEDUP:

sort this one before the QUALCOMM_MSM quirk.

>  		strcat(buf, ",0,0,255"); /* Maximum possible length */
>  		break;
>  	}
> diff --git a/plugins/speedup.c b/plugins/speedup.c
> index 23ba173..9302dcc 100644
> --- a/plugins/speedup.c
> +++ b/plugins/speedup.c
> @@ -330,7 +330,7 @@ static void speedup_pre_sim(struct ofono_modem *modem)
>  	DBG("%p", modem);
>  =

>  	ofono_devinfo_create(modem, 0, "atmodem", data->aux);
> -	sim =3D ofono_sim_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
> +	sim =3D ofono_sim_create(modem, OFONO_VENDOR_SPEEDUP,
>  				"atmodem", data->aux);

And patch does not apply anymore. Please send me an updated one.

Regards

Marcel



--===============4117979416616934816==--

