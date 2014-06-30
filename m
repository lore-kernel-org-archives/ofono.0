Content-Type: multipart/mixed; boundary="===============6134240634153559577=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] atmodem: add vendor u-blox
Date: Mon, 30 Jun 2014 14:04:42 -0500
Message-ID: <53B1B4CA.5000704@gmail.com>
In-Reply-To: <1403807298-14588-2-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6134240634153559577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philip,

On 06/26/2014 01:28 PM, Philip Paeps wrote:
> ---
>  drivers/atmodem/vendor.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
> index bf2b38a..de3c455 100644
> --- a/drivers/atmodem/vendor.h
> +++ b/drivers/atmodem/vendor.h
> @@ -42,5 +42,6 @@ enum ofono_vendor {
>  	OFONO_VENDOR_SIMCOM_SIM900,
>  	OFONO_VENDOR_ICERA,
>  	OFONO_VENDOR_WAVECOM_Q2XXX,
> -	OFONO_VENDOR_ALCATEL
> +	OFONO_VENDOR_ALCATEL,
> +	OFONO_VENDOR_UBLOX

This was a booboo from earlier, but please always add a comma when
adding enumeration entries.  Even if the entry is the last one.

>  };
> =


Patch has been applied after a 3-way merge.

Regards,
-Denis

--===============6134240634153559577==--

