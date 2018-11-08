Content-Type: multipart/mixed; boundary="===============6417874531251193392=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] sim800: add udev detection.
Date: Thu, 08 Nov 2018 10:59:30 -0600
Message-ID: <334c45c5-065c-dca1-d4bc-2f7c75cfae8f@gmail.com>
In-Reply-To: <20181107140804.GB2831@turing>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6417874531251193392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Clement,
>>> +	{ "sim800",	setup_serial_modem	}, > I think I must keep this line bec=
ause the udev rule added by the user =

will specify that modem is "OFONO_DRIVER=3Dsim800" so udevng.c must know =

what to do with that.
This is kind of weird that we have a driver line for a modem driver that =

doesn't exist.  We never do things this way.  Why don't you just modify =

the driver instructions to have OFONO_DRIVER=3Dsim900 instead?

Also, we could simply rename the sim900 driver into sim_x00 or =

simcom_serial or something too.  That could make things a bit more clear.

Regards,
-Denis

--===============6417874531251193392==--

