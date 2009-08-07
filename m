Content-Type: multipart/mixed; boundary="===============5101737078190488252=="
MIME-Version: 1.0
From: Marko Saukko <marko.saukko@gmail.com>
Subject: Re: How to dismiss incoming call?
Date: Fri, 07 Aug 2009 14:36:39 +0300
Message-ID: <4A7C11C7.7030106@gmail.com>
In-Reply-To: <200908061043.34603.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5101737078190488252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

With Nokia E51 AT+CHLD=3D11 returned ERR0R, AT+CHLD=3D0 and ATH returned OK
however they did not have effect to the call. AT+CHUP returned OK and
call was terminated (Caller received busy signal).

RING
AT+CHLD=3D11
ERROR

RING

RING
AT+CHLD=3D0
OK

RING

RING
ATH
OK

RING

RING
AT+CHUP
OK

Regards,
Marko

--===============5101737078190488252==--

