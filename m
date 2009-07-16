Content-Type: multipart/mixed; boundary="===============0218417330493038119=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problems with voice call.
Date: Thu, 16 Jul 2009 11:46:27 -0500
Message-ID: <200907161146.28172.denkenz@gmail.com>
In-Reply-To: <20090716174751.ssob1ux42soo4o8o@webmail.welho.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0218417330493038119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Juha,

> I am using Nokia 6021 and there seems to be same problem(I guess):
>
> ofonod[8320]: Response line: +CPMS: ("ME","SM"),("ME","SM"),("MT")

Your problem is a bit different.  CPMS here reports:
mem1: "ME", "SM"
mem2: "ME", "SM"
mem3: "MT"

oFono was confused by "MT" setting.  I've added experimental support for su=
ch =

devices.  Please report back if oFono gets further in the initialization =

process.

Regards,
-Denis

--===============0218417330493038119==--

