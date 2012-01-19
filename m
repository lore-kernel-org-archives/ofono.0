Content-Type: multipart/mixed; boundary="===============1432248138646355498=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: How to start ofono-phonesim in ubuntu-10.04 -reg
Date: Thu, 19 Jan 2012 00:13:33 -0600
Message-ID: <4F17B48D.3040400@gmail.com>
In-Reply-To: <0F68B52D2432864190BC72F760407FE923CF24E757@NDA-HCLT-EVS04.HCLT.CORP.HCL.IN>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1432248138646355498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pranay,

> =

> But it is not displaying anything on the screen.

The gui is not displayed until a connection to the phonesim instance is
established.  In this case using tcp link to port 12345 (just try telnet
localhost 12345 and the gui should show up).

The connection is established by virtue of powering on the phonesim
modem on the ofono side.  E.g. using test/enable-modem script.

Regards,
-Denis

--===============1432248138646355498==--

