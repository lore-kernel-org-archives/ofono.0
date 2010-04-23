Content-Type: multipart/mixed; boundary="===============4020244852052413560=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Option GTM 382
Date: Fri, 23 Apr 2010 09:54:05 -0500
Message-ID: <201004230954.06488.denkenz@gmail.com>
In-Reply-To: <m2x35f991da1004230635z9bbcc219q44f1bce09ed8a420@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4020244852052413560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Teemu,

> Is Option GTM 382 supported? The module works with Ubuntu's own
> connection manager, but list-modems script doesn't return anything.

This modem is in the HSO family, so should be supported by oFono.  Can you =

edit plugins/ofono.rules (see the Option Globetrotter rules) to add the =

product ID of this modem and see if it is detected?

Regards,
-Denis

--===============4020244852052413560==--

