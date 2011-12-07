Content-Type: multipart/mixed; boundary="===============2797245136742863172=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] TODO: Mark CDMA 1x signal strength reporting task as
 done
Date: Wed, 07 Dec 2011 09:57:19 -0600
Message-ID: <4EDF8CDF.10904@gmail.com>
In-Reply-To: <1323163458-507-2-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2797245136742863172==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 12/06/2011 03:24 AM, Guillaume Zajac wrote:
> ---
>  TODO |    7 -------
>  1 files changed, 0 insertions(+), 7 deletions(-)
> =

> diff --git a/TODO b/TODO
> index 63d28ab..e9a55d3 100644
> --- a/TODO
> +++ b/TODO
> @@ -508,13 +508,6 @@ CDMA Network Acquisition
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  =

>  - Support reporting of the received signal strength indicator (RSSI)
> -  measurement and of the pilot energy ratio (Ec/Io) measurement, for the
> -  currently acquired CDMA network.
> -
> -  Priority: Medium
> -  Complexity: C1
> -

Please split this task in two, right now we are only taking care of the
RSSI bits.

> -- Support reporting of the received signal strength indicator (RSSI)
>    measurement and of the signal to interference-plus-noise ratio (SINR)
>    measurement, for the currently acquired 1xEV-DO data network.
>  =


Regards,
-Denis

--===============2797245136742863172==--

