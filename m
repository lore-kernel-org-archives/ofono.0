Content-Type: multipart/mixed; boundary="===============4144715791197762226=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Method "Register" with signature "oay" doesn't exist
Date: Thu, 12 May 2016 11:11:50 -0500
Message-ID: <5734AB45.8050109@gmail.com>
In-Reply-To: <57349BB6.80003@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4144715791197762226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marco,

 >
> For example: I want to make a call. I need to enable the modem first or
> I can just dial the number?
> It is just an example to explain my difficulties to understand how to
> use ofono!
>

There isn't an in-depth tutorial available unfortunately.  If someone =

wants to contribute it to the project, that would be appreciated.

Modem must be powered & online in order to make calls.

So roughly:

test/enable-modem
test/online-modem
test/dial-number
test/hangup-call

Regards,
-Denis

--===============4144715791197762226==--

