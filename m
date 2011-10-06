Content-Type: multipart/mixed; boundary="===============4567617696213945008=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: AT commands not being parsed correctly from Samsung Wave HFP
Date: Thu, 06 Oct 2011 13:02:28 -0500
Message-ID: <4E8DED34.5030906@gmail.com>
In-Reply-To: <4E8DE92E.30902@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4567617696213945008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

> ofonod[12078]: > AT+CLCC\r
> ofonod[12078]: < \r\n\r\nOK\r\n\r\n
> =

> =


There is an extra set of \r\n at the end of the OK and the gsmv1 syntax
parser used by the hfp_hf plugin is quite strict.

> It seems that, after the last line, no other AT commands are parsed
> correctly. Any ideas of what's wrong?

Try using the permissive syntax parser.

Regards,
-Denis

--===============4567617696213945008==--

