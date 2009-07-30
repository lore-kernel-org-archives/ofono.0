Content-Type: multipart/mixed; boundary="===============3361220575603412742=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: sms segment fault with 160 char
Date: Thu, 30 Jul 2009 10:28:09 -0500
Message-ID: <200907301028.09597.denkenz@gmail.com>
In-Reply-To: <B94C62E7C2870743865418621F040C1302053C514F@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3361220575603412742==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> Please see the log of phonesim:
>  AT+CMGS=3D18 :
>
> 0011000B815128010272F40000A70461F1980C :
> +CMGS: 0
> OK

Destination: 158210202..
Content: abcd

> AT+CMGS=3D18 :
>
> 0011000B813118567873F20000A704B2D88C06 :
> +CMGS: 0
> OK
> The content is different, and it should be abcd

Destination: 138165873..
Content: 2134

So I don't understand, you're physically sending two different SMSs here.

>
> In real network:
> Because I use phone as modem so maybe something wrong in at response.
> Whatever it was wrong behavior:
> The number1 target device received two message:
>  1, content: abcd
>  2, content: number1

Again, you're sending two SMSes according to the log.  First with 2 =

recipients, and second with a single one.  This means three SMSes are sent, =

and presumably one of the recipients will get 2 of them.  All three get sen=
t =

eventually.  What is the problem?

Regards,
-Denis

--===============3361220575603412742==--

