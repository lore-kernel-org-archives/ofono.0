Content-Type: multipart/mixed; boundary="===============7591614082298226527=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problem setting up ofono
Date: Thu, 13 Apr 2017 11:53:08 -0500
Message-ID: <b7f6d69a-9f32-0340-ead5-65478821c6cb@gmail.com>
In-Reply-To: <VI1PR1001MB07835B467F7C0E0A51AD4C27C9020@VI1PR1001MB0783.EURPRD10.PROD.OUTLOOK.COM>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7591614082298226527==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

> I've tried running ofonod with the -d flag to get some debug
> information, but I didn't see anything that could help me, since it
> stops printing out anything after the connection succeeds, here's the
> full log: https://pastebin.com/gz2tFK4n

Run ofonod with OFONO_AT_DEBUG=3D1 environment variable set.

e.g.
export OFONO_AT_DEBUG=3D1
ofonod -nd

What version of BlueZ are you using?

Regards,
-Denis

--===============7591614082298226527==--

