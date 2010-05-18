Content-Type: multipart/mixed; boundary="===============7038376454373541501=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Unable to use DataConnectionManager
Date: Tue, 18 May 2010 03:59:55 -0500
Message-ID: <201005180359.56658.denkenz@gmail.com>
In-Reply-To: <24A9345B397CD24AA76A4E82E2379565317D9CFEBE@XCHTS.tmt.telital.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7038376454373541501==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniele,

> Hello,
> =

> I'm trying to make Ofono work with Telit modules using the atmodem driver.
>  I succeeded in using all the features but the DataConnectionManager.
> =

> When I list the interfaces of the modem org.ofono.DataConnectionManager is
>  missing. Using debug print I put, it seems that the probe function for t=
he
>  gprs interface is never called.
> =

> Is there something I should enable for using gprs capabilities?

Since telit devices have not been properly integrated yet I assume you're =

using the atgen driver, correct?

The atgen driver would need generic PPP context support to enable GPRS =

properly.  This is something that is not quite ready in oFono today.  This =
is =

why the atgen driver does not enable support for GPRS.

If you want you can try to enable this in the atgen driver and try it out, =
but =

the code is still highly experimental.

Regards,
-Denis

--===============7038376454373541501==--

