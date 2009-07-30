Content-Type: multipart/mixed; boundary="===============1918934122796547438=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: sms segment fault with 160 char
Date: Wed, 29 Jul 2009 23:05:58 -0500
Message-ID: <200907292305.58924.denkenz@gmail.com>
In-Reply-To: <B94C62E7C2870743865418621F040C1302053C5096@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1918934122796547438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> Basically the "[ ]' will be encoded as UCS2, but it is 7bit according
> message head in fact. So there were two problem:
> 1, tpdu_len was wrong: the problem was in sms encode

You're wrong.  '[' and ']' are defined in GSM extension table.  And can thu=
s =

still be encoded in GSM 7bit alphabet.

> 2, send more segment had issue.

Please fetch the latest version, this was fixed earlier today.

Regards,
-Denis

--===============1918934122796547438==--

