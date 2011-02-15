Content-Type: multipart/mixed; boundary="===============4476672497282486245=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] configure: Check for bluez >= 4.30.
Date: Tue, 15 Feb 2011 12:58:37 -0800
Message-ID: <1297803517.2519.8.camel@aeonflux>
In-Reply-To: <1297760152-19815-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4476672497282486245==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Earlier versions lack struct sockaddr_l2::l2_cid and/or
> struct bt_security.
> ---
>  configure.ac |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/configure.ac b/configure.ac
> index 4f0348d..810b9f2 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -184,8 +184,8 @@ AC_ARG_ENABLE(bluetooth, AC_HELP_STRING([--disable-bl=
uetooth],
>  				[disable Bluetooth modem support]),
>  					[enable_bluetooth=3D${enableval}])
>  if (test "${enable_bluetooth}" !=3D "no"); then
> -	PKG_CHECK_MODULES(BLUEZ, bluez, dummy=3Dyes,
> -				AC_MSG_ERROR(Bluetooth library is required))
> +	PKG_CHECK_MODULES(BLUEZ, bluez >=3D 4.30, dummy=3Dyes,
> +			AC_MSG_ERROR(Bluez >=3D 4.30 is required without --disable-bluetooth))

patch has been applied, but I did remove the --disable-bluetooth comment
since that is kinda obvious.

You need to know what you are doing when building the source code. The
decision to have or not have a feature doesn't really depend on if you
installed a library or not.

Regards

Marcel



--===============4476672497282486245==--

