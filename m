Content-Type: multipart/mixed; boundary="===============8586512330154153218=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/11] In drivers/atmodem/sms.c:at_cmgl_cpms_cb() there is
 a temporary fix for Siemens TC65. If AT+CMGL=4 is sent to TC65,
 the AT command queue jams.
Date: Fri, 28 May 2010 11:48:28 -0500
Message-ID: <201005281148.28869.denkenz@gmail.com>
In-Reply-To: <1274957690-4893-1-git-send-email-pasi.miettinen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8586512330154153218==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pasi,

> From: Pasi Miettinen <pasi.miettinen@ixonos.com>
> =

> ---
>  drivers/atmodem/sms.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> =


Please keep the header to less than 50 characters.  Include the meat of the =

description in the commit description itself or the comment in the code.

> diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
> index 8049df6..27de77b 100644
> --- a/drivers/atmodem/sms.c
> +++ b/drivers/atmodem/sms.c
> @@ -544,6 +544,10 @@ static void at_cmgl_cb(gboolean ok, GAtResult *resul=
t,
>  gpointer user_data)
> =

>  static void at_cmgl_cpms_cb(gboolean ok, GAtResult *result, gpointer
>  user_data) {
> +
> +	DBG("PASS AT+CMGL=3D4!!!");
> +	return;
> +

Please use the vendor quirks facility.  See drivers/atmodem/vendor.h and th=
e =

various uses of it in plugins/ and drivers/atmodem.  You might have to crea=
te =

a proper modem driver for the TC65.

Regards,
-Denis

--===============8586512330154153218==--

