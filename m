Content-Type: multipart/mixed; boundary="===============5574390259951229866=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH v2 09/10] ublox: extend LTE driver
Date: Wed, 13 Mar 2019 21:32:01 +0100
Message-ID: <f6f3b6f7-70da-3d4d-a0a6-b26a5c1aa940@norrbonn.se>
In-Reply-To: <20190313202324.16369-9-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5574390259951229866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 13/03/2019 21:23, Jonas Bonn wrote:
> There are a couple of semi-independent changes here:
> =

> * use the 'vendor' parameter to pass the modem 'model'
> * support TOBY L4 modem which uses a fixed CID for configuring the EPS
> default bearer
> * add the setup of authentication parameters that was recently added to
> the atmodem LTE driver
> ---
>   drivers/ubloxmodem/lte.c | 101 ++++++++++++++++++++++++++++++++++-----
>   1 file changed, 89 insertions(+), 12 deletions(-)
> =

> diff --git a/drivers/ubloxmodem/lte.c b/drivers/ubloxmodem/lte.c
> index 34397dfe..e0f419b6 100644
> --- a/drivers/ubloxmodem/lte.c
> +++ b/drivers/ubloxmodem/lte.c
> @@ -39,24 +39,85 @@
>   =

>   #include "ubloxmodem.h"
>   =

> -static const char *ucgdflt_prefix[] =3D { "+UCGDFLT:", NULL };
> +static const char * const none_prefix[] =3D { NULL };

Same here, the const on the pointer here is no good.

/Jonas

--===============5574390259951229866==--

