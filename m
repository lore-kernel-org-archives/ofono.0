Content-Type: multipart/mixed; boundary="===============8004051626725104325=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH v5 2/4] Detect SARA R4 QMI device
Date: Wed, 12 May 2021 11:18:32 +0200
Message-ID: <8b92ea25-6073-3f08-7ed7-f15e3bbf454a@norrbonn.se>
In-Reply-To: <20210512074053.6718-3-jupiter.hce@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8004051626725104325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add vendor tag for uBlox SARA R4 modems.

This device is actually a Qualcomm part so it doesn't fall under the =

uBlox category of devices, at all.

/Jonas

On 12/05/2021 09:40, Bing Jupiter wrote:
> ---
>   drivers/atmodem/vendor.h | 1 +
>   1 file changed, 1 insertion(+)
> =

> diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
> index 82284e44..38613679 100644
> --- a/drivers/atmodem/vendor.h
> +++ b/drivers/atmodem/vendor.h
> @@ -48,6 +48,7 @@ enum ofono_vendor {
>   	OFONO_VENDOR_QUECTEL_EC2X,
>   	OFONO_VENDOR_QUECTEL_SERIAL,
>   	OFONO_VENDOR_UBLOX,
> +    OFONO_VENDOR_UBLOX_SARA_R4,
>   	OFONO_VENDOR_XMM,
>   	OFONO_VENDOR_GEMALTO,
>   };
>=20
--===============8004051626725104325==--

