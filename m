Content-Type: multipart/mixed; boundary="===============3998771770005711666=="
MIME-Version: 1.0
From: Clement Viel <vielclement@gmail.com>
Subject: Re: [PATCH 2/3] sim800: add documentation and modify AUTHORS file
Date: Sat, 03 Nov 2018 00:36:26 +0100
Message-ID: <20181102233626.GB6943@turing>
In-Reply-To: <2552d5a0-6bfc-26c8-14f0-ee93b8ea8f03@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3998771770005711666==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, Nov 01, 2018 at 09:48:24AM -0500, Denis Kenzior wrote:
> Hi Clement,
> =

> On 10/15/2018 12:27 PM, Clement Viel wrote:
> >---
> >  AUTHORS              |  1 +
> =

> Please don't include AUTHORS changes.  One of the maintainers will take c=
are
> of it.
> =

> >  doc/sim800-modem.txt | 11 +++++++++++
> >  2 files changed, 12 insertions(+)
> >  create mode 100644 doc/sim800-modem.txt
> >
> >diff --git a/AUTHORS b/AUTHORS
> >index 2d360e6..a8362c8 100644
> >--- a/AUTHORS
> >+++ b/AUTHORS
> >@@ -138,3 +138,4 @@ Florent Beillonnet <florent.beillonnet@gmail.com>
> >  Martin Hundeb=C3=B8ll <martin@geanix.com>
> >  Julien Tournier <tournier.julien@gmail.com>
> >  Nandini Rebello <nandini.rebello@intel.com>
> >+Clement Viel <vielclement@gmail.com>
> >diff --git a/doc/sim800-modem.txt b/doc/sim800-modem.txt
> >new file mode 100644
> >index 0000000..7220cb8
> >--- /dev/null
> >+++ b/doc/sim800-modem.txt
> >@@ -0,0 +1,11 @@
> >+SIM800 modem usage
> >+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >+
> >+To enable SIM800 module support you need to put the following
> >+udev rule into appropriate file in /{etc,lib}/udev/rules.d:
> >+
> >+KERNEL=3D=3D"ttyS2", ENV{OFONO_DRIVER}=3D"sim800"
> >+
> >+Sim800 driver code is merged with sim900's. So, to add modifications to=
 sim800 driver, sim900.c file must be edited
> >+accordingly.
> >+To differentiate the two modems, developpers must use the "modem_type"
> >field of sim900_data
> typo
> =

> structure.
> >
> =

> Also, we can't have people hand-editing driver code to distinguish between
> one device and another.  You've already went to the trouble of creating a
> separate sim800 driver (which I do not think is the right approach at all=
),
> why not take advantage of that fact with an appropriate probe() function =
or
> something?

These indications were targeting developpers to warn them about the fact th=
at sim800 and sim900 drivers are merged.
I'll remove these lines

> =

> Anyway, I still think you should be querying +CGMM or ATI or whatever to
> figure out the modem model automatically and not rely on the user to set
> this up.

Yep this will be done.

> Regards,
> -Denis

Regards
Clem

--===============3998771770005711666==--

