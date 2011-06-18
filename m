Content-Type: multipart/mixed; boundary="===============7991128158315000328=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: 3G modem fails to setup connection
Date: Sat, 18 Jun 2011 04:14:08 -0500
Message-ID: <4DFC6C60.2070709@gmail.com>
In-Reply-To: <CE59C043D0EC3349B2BF41C0EC72229B12D187CF68@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7991128158315000328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 06/19/2011 09:08 AM, Deng, Ying An wrote:
> Hi,
> =

>  =

> =

> My 3G modem (Huawei E5) fails to setup network connection after long
> time =E2=80=98associating=E2=80=99.
> =

> By trace the debug log, it is found that the PPP is not setup. The
> callback function at_cgdcont_cb() is not ever called, which is set to
> callback function when sending AT command =E2=80=98AT+CGDCONT=3Dcid=E2=80=
=99 in function
> at_gprs_activate_primary();
> =

>  =

> =

> The callback function at_cgdata_cb() is not called, thus the PPP is not
> setup. Do you have seen similiar same issue?
> =

> I paste the debug log with AT commands.
> =


It sounds like the udev detection is telling oFono to use the wrong tty
for the modem device.  It might be using one of the binary ports which
is not replying to AT commands.  You will need to investigate this and
update the udev rule appropriately.

Regards,
-Denis

--===============7991128158315000328==--

