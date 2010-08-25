Content-Type: multipart/mixed; boundary="===============7990079995080364510=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: New to OFONO
Date: Wed, 25 Aug 2010 16:02:20 -0500
Message-ID: <4C7584DC.9090601@gmail.com>
In-Reply-To: <003a01cb4496$b3424900$19c6db00$@com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7990079995080364510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

On 08/25/2010 03:47 PM, Keith Collins wrote:
> Hi,
> =

>  =

> =

> I am new to OFONO, but I have 11 years of experience in smartphone
> telephony development.  I have worked on both UMTS and CDMA product
> designs for different mobile operators, handset manufacturers, chipset
> vendors and o/s vendors.  I know the challenges of designing a telephony
> subsystem that will support different chipsets, messaging protocols and
> operator networks/requirements.  I am interested in getting more
> documentation on OFONO, including the APIs for DBUS, Modem Plug-In and
> Utility.  I=E2=80=99d also like to know what functionality gaps exists in=
 either
> UMTS or CDMA so that I could concentrate on some of those areas for my
> code contributions.
> =


Welcome!

The documentation for oFono can be found in the git tree itself under
the doc/ directory.

doc/ofono-paper.txt gives a brief introduction and our design goals and
design philosophy.

doc/coding-style.txt is self explanatory.

doc/*-api.txt is the API documentation for all oFono interfaces.

Other information (somewhat out of date) can be found in the various
oFono presentations on the ofono.org website.

The rest can be obtained by reading the source code, or on the #ofono
IRC channel on freenode.

The gaps for GSM/UMTS are fairly well documented in the TODO file, also
found in git.  The methodology is quite simple, if you are interested in
working on a task, send a patch with the Owner: field set.  This lets
others know that someone is looking into a particular feature and not to
interfere.

If you notice anything missing in the TODO, simply send a patch to the
mailing list.

You will notice that there are no CDMA related tasks in the TODO yet.
CDMA aspects are currently in very early planning stages.  The core team
is still heavily focused on GSM/UMTS.

Regards,
-Denis

--===============7990079995080364510==--

