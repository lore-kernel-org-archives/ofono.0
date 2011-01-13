Content-Type: multipart/mixed; boundary="===============2095414483872199405=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] cdmamodem: Add CDMA devinfo support
Date: Thu, 13 Jan 2011 00:03:45 -0600
Message-ID: <4D2E95C1.40209@gmail.com>
In-Reply-To: <1294782301-8592-3-git-send-email-dara.spieker-doyle@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2095414483872199405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dara,

On 01/11/2011 03:45 PM, Dara Spieker-Doyle wrote:
> ---
>  Makefile.am                   |    3 +-
>  drivers/cdmamodem/cdmamodem.c |    2 +
>  drivers/cdmamodem/cdmamodem.h |    2 +
>  drivers/cdmamodem/devinfo.c   |  169 +++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 175 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/cdmamodem/devinfo.c
> =


Can you please rebase and resubmit this patch?  Further comments below:

> diff --git a/drivers/cdmamodem/cdmamodem.h b/drivers/cdmamodem/cdmamodem.h
> index a5991cf..ef4fad3 100644
> --- a/drivers/cdmamodem/cdmamodem.h
> +++ b/drivers/cdmamodem/cdmamodem.h
> @@ -23,3 +23,5 @@
>  =

>  extern void cdma_at_voicecall_init();
>  extern void cdma_at_voicecall_exit();
> +extern void cdma_at_devinfo_init();
> +extern void cdma_at_devinfo_exit();

Please name this cdma_devinfo_init/exit


<snip>

> +static struct ofono_devinfo_driver driver =3D {
> +	.name 			=3D "cdmamodem",
> +	.probe	 		=3D cdma_at_devinfo_probe,
> +	.remove			=3D cdma_at_devinfo_remove,
> +	.query_manufacturer	=3D cdma_at_query_manufacturer,
> +	.query_model		=3D cdma_at_query_model,
> +	.query_revision		=3D cdma_at_query_revision,
> +	.query_serial		=3D cdma_at_query_serial

Please drop the 'at' from these.  Use cdma_devinfo_probe, etc.

> +};
> +

Regards,
-Denis

--===============2095414483872199405==--

