Content-Type: multipart/mixed; boundary="===============5837814797261478773=="
MIME-Version: 1.0
From: Clement Viel <vielclement@gmail.com>
Subject: Re: [PATCH 3/3] sim800: adding documentation to inform about the udev
 rule the user must add
Date: Wed, 19 Sep 2018 21:25:02 +0200
Message-ID: <20180919192501.GA3536@turing>
In-Reply-To: <bc5638ae-f6f3-2a2a-9af2-3d9bf0405a3e@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5837814797261478773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 19, 2018 at 11:43:49AM -0500, Denis Kenzior wrote:
> Hi,
> =

> On 09/18/2018 03:36 PM, Cl=C3=A9mentViel wrote:
> >From: clem <vielclement@gmail.com>
> =

> Can you fix your Author information (see AUTHORS for an example). Otherwi=
se
> I cannot take these...

Yep, I'll do it the right way

> =

> >
> >---
> >  doc/sim800-modem.txt | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >  create mode 100644 doc/sim800-modem.txt
> >
> >diff --git a/doc/sim800-modem.txt b/doc/sim800-modem.txt
> >new file mode 100644
> >index 0000000..6731879
> >--- /dev/null
> >+++ b/doc/sim800-modem.txt
> >@@ -0,0 +1,7 @@
> >+SIM800 modem usage
> >+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >+
> >+To enable SIM900 module support you need to put the following
> >+udev rule into appropriate file in /{etc,lib}/udev/rules.d:
> >+
> >+KERNEL=3D=3D"ttyUSB0", ENV{OFONO_DRIVER}=3D"sim800"
> >
> =

> So sim800 is a serial device right?  I take it you're running it from a
> serial converter here?

Yes, there is a converter. I let "ttyUSB0" as the starter kit provided by S=
imCom comes with a converter.

> =



> Regards,
> -Denis

--===============5837814797261478773==--

