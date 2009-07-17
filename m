Content-Type: multipart/mixed; boundary="===============7135842914051651833=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problems with voice call.
Date: Fri, 17 Jul 2009 10:48:45 -0500
Message-ID: <200907171048.45878.denkenz@gmail.com>
In-Reply-To: <4A601F65.9020309@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7135842914051651833==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marko,

> Hi Denis,
>
> I'm running the E51 over USB connection. The AT+CFUN=3D1 did not help:
>
> AT+CFUN=3D1
> OK
> AT+CPMS=3D?
> +CPMS: (),(),()
>
> OK

It sounds like the E51 doesn't have a proper AT command set for it to be =

supported by the generic driver.  You can try to investigate whether it sti=
ll =

sends the proper +CMT or +CMTI notifications on sms delivery (see 3GPP 27.0=
05).  =

If it does, then a custom sms driver for E51 could be feasible.

Regards,
-Denis

--===============7135842914051651833==--

