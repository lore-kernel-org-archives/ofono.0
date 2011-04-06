Content-Type: multipart/mixed; boundary="===============0749891533752032424=="
MIME-Version: 1.0
From: Li, Zhigang <zhigang.li@intel.com>
Subject: RE: SEGV during offline with IFX modem
Date: Wed, 06 Apr 2011 09:42:25 +0800
Message-ID: <B32E3D5F1713054290B4FF257B89C51A2A4B6536F8@shsmsx502.ccr.corp.intel.com>
In-Reply-To: <20110405125905.37bb4be6@sbryan-MOBL6>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0749891533752032424==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Shane,
With the attached log, I think it's IFX firmware issue. Could you try the n=
ew FW 11-05 or later?

We tried the 0325 image with ofono-0.41.2.2 version, no this issue.

B,R
Zhigang

 =

-----Original Message-----
From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behal=
f Of Shane Bryan
Sent: Wednesday, April 06, 2011 3:59 AM
To: ofono(a)ofono.org
Subject: Re: SEGV during offline with IFX modem

On Tue, 5 Apr 2011 12:50:23 -0700
Shane Bryan <shane.bryan@linux.intel.com> wrote:

> I'm running into a crash (SIGSEGV) when using offline-modem script to =

> set the modem into offline mode.  Is this known behavior?  If so, is =

> there a bugzilla entry someplace for it?
> =

> Backtrace is attached.  Version is 0.41 from MeeGo Trunk RPM package =

> [1]
> =

> I have a core with debug symbols available also, if that would be =

> helpful.
> =

> Shane...
> [1]http://repo.meego.com/MeeGo/builds/trunk/1.1.99.0.20110329.5/repos/
> oss/ia32/packages/i586/ofono-0.41-2.1.i586.rpm

Attaching full log (ofonod -n -d "*") as requested on IRC.

Shane...

--===============0749891533752032424==--

