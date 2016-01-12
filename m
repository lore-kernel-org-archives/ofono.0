Content-Type: multipart/mixed; boundary="===============2889191851957270114=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Tue, 12 Jan 2016 11:20:39 -0600
Message-ID: <569535E7.3020000@gmail.com>
In-Reply-To: <CADnUhn0zZuV7fCjpTm8HRVjBiONZJV8RKW=rUvyxj-Tmh_bWKg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2889191851957270114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matti,

On 01/12/2016 10:56 AM, matti kaasinen wrote:
> Denis,
>
> 2016-01-12 18:46 GMT+02:00 matti kaasinen <matti.kaasinen@gmail.com
> <mailto:matti.kaasinen@gmail.com>>:
>
>             activate-context
>             =3D>
>             Error activating /huawei_0/context1:
>             org.ofono.Error.NotImplemented:
>             Implementation not provided
>
>
>         There is no gprs context driver provided or it failed to setup.
>         Do you have TUN/TAP in the kernel or kernel module?
>
>     It was not loaded, but I modprobed it now manually and got different
>     error message:
>     Error activating /huawei_1/context1: org.ofono.Error.Failed:
>     Operation failed
>
>
> Ofono log gave now some error messages:
> ..ofonod: drivers/atmodem/gprs-context.c:at_gprs_activate_primary() cid 1
> ..ofonod: Modem: > AT+CGDCONT=3D1,"IP","internet"\r
> ..ofonod: Modem: < \r\nOK\r\n
> ..ofonod: drivers/atmodem/gprs-context.c:at_cgdcont_cb() ok 1
> ..ofonod: Modem: > AT+CGDATA=3D"PPP",1\r
> ..ofonod: Modem: < \r\n+CME ERROR: 50\r\n
> ..ofonod: drivers/atmodem/gprs-context.c:at_cgdata_cb() ok 0
> ..ofonod: Unable to enter data state
> ..ofonod: src/gprs.c:pri_activate_callback() 0x122580
> ..ofonod: src/gprs.c:pri_activate_callback() Activating context failed
> with error: Incorrect parameters
>

Looks like your modem has a newer / different firmware.  in =

plugins/huawei.c, line:
                 gc =3D ofono_gprs_context_create(modem, 0,
                                                 "atmodem", data->modem);

Can you try changing "atmodem" to "huaweimodem" and see if it works =

after that?

Regards,
-Denis

--===============2889191851957270114==--

