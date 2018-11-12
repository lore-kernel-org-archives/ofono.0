Content-Type: multipart/mixed; boundary="===============4173083529043305637=="
MIME-Version: 1.0
From: Clement Viel <vielclement@gmail.com>
Subject: Re: [PATCH 3/3] sim800: add udev detection.
Date: Mon, 12 Nov 2018 15:16:48 +0100
Message-ID: <20181112141648.GA5978@turing>
In-Reply-To: <334c45c5-065c-dca1-d4bc-2f7c75cfae8f@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4173083529043305637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 08, 2018 at 10:59:30AM -0600, Denis Kenzior wrote:

Hi Denis,

> Hi Clement,
> >>>+	{ "sim800",	setup_serial_modem	}, > I think I must keep this line
> >>>because the udev rule added by the user
> will specify that modem is "OFONO_DRIVER=3Dsim800" so udevng.c must know =
what
> to do with that.
> This is kind of weird that we have a driver line for a modem driver that
> doesn't exist.  We never do things this way.  Why don't you just modify t=
he
> driver instructions to have OFONO_DRIVER=3Dsim900 instead?
> =

I agree with you, I was thinking the sim800 must be mentioned to avoid conf=
using
doc/sim900.txt to mention that sim800 is supported by this driver. Then, ke=
ep in
the users.

> Also, we could simply rename the sim900 driver into sim_x00 or simcom_ser=
ial
> or something too.  That could make things a bit more clear.

I think we can keep that in mind for further development.

> =

> Regards,
> -Denis

Just tell me whether I should add mention of sim800 in sim900.txt or rename=
 sim900.txt
in simcom.txt to mention the two drivers. Then I'll upload the patchset wit=
h doc in it.

Regards
Clement

--===============4173083529043305637==--

