Content-Type: multipart/mixed; boundary="===============4978755056782100969=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: SIM PIN unlock
Date: Mon, 26 Oct 2009 11:06:42 -0500
Message-ID: <200910261106.42520.denkenz@gmail.com>
In-Reply-To: <4AE59D28.3090304@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4978755056782100969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

> Hello,
>
> I have noticed a difference of ofono on startup. If the PIN number is
> not required, the daemon never gets past CRSM query, and the remaining
> interfaces are not added.

This works fine for other devices.  I would enable at command debugging (ex=
port =

OFONO_AT_DEBUG=3D1) and watch for any signs of breakage.  The MC75 is known=
 to =

have a very bad AT command implementation that might be confusing the AT =

parser.

Regards,
-Denis

--===============4978755056782100969==--

