Content-Type: multipart/mixed; boundary="===============0845775528663840033=="
MIME-Version: 1.0
From: Clement Viel <vielclement@gmail.com>
Subject: Re: [PATCH 3/3] sim800: add udev detection.
Date: Wed, 07 Nov 2018 15:08:04 +0100
Message-ID: <20181107140804.GB2831@turing>
In-Reply-To: <c0e9bf5f-1d09-bc59-2306-b820e72382e9@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0845775528663840033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 07, 2018 at 03:02:54PM +0100, Jonas Bonn wrote:
> =

> =

> On 07/11/2018 15:00, Clement Viel wrote:
> >---
> >  plugins/udevng.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> >diff --git a/plugins/udevng.c b/plugins/udevng.c
> >index ff6e1fc..d0a849d 100644
> >--- a/plugins/udevng.c
> >+++ b/plugins/udevng.c
> >@@ -1308,6 +1308,7 @@ static struct {
> >  	{ "calypso",	setup_serial_modem	},
> >  	{ "cinterion",	setup_serial_modem	},
> >  	{ "nokiacdma",	setup_serial_modem	},
> >+	{ "sim800",	setup_serial_modem	},
> =

> Right... that's much simpler.  And given that you are extending the sim900
> driver to handle the sim800 model, you don't need the above line either.
> =

> /Jonas
> =

> >  	{ "sim900",	setup_serial_modem	},
> >  	{ "wavecom",	setup_wavecom		},
> >  	{ "tc65",	setup_tc65		},
> >
I think I must keep this line because the udev rule added by the user will =
specify that modem is "OFONO_DRIVER=3Dsim800" so udevng.c must know what to=
 do with that.

--===============0845775528663840033==--

