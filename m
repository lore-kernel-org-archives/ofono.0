Content-Type: multipart/mixed; boundary="===============7882145856126689507=="
MIME-Version: 1.0
From: Xu, Dongxiao <dongxiao.xu@intel.com>
Subject: RE: ofonod crash on Ericsson F5521GW
Date: Wed, 29 Jun 2011 10:53:50 +0800
Message-ID: <D5AB6E638E5A3E4B8F4406B113A5A19A12D6B85846@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4DE51ABD.3020508@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7882145856126689507==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> -----Original Message-----
> From: Denis Kenzior [mailto:denkenz(a)gmail.com]
> Sent: Wednesday, June 01, 2011 12:44 AM
> To: Xu, Dongxiao
> Cc: ofono(a)ofono.org
> Subject: Re: ofonod crash on Ericsson F5521GW
> =

> Hi Dongxiao,
> =

> >>
> >> I suggest you try the latest release of oFono, 0.43 is pretty old.
> >> Judging by your log this issue should be fixed in later versions.  If
> >> you still encounter the problem, please post a proper backtrace.
> >> Either by using gdb or running the backtrace through test/backtrace sc=
ript.
> >
> > Latest ofono-0.48 also has the same problem. Here I attached a more
> detailed crash log.
> >
> =

> At least the GError warning should be fixed by commit d99ca17.  If you ha=
ve
> other crashes, please report back.  You still need to provide a proper gdb
> trace or run the log through the test/backtrace script.

Sorry for the late confirmation.

This issue should have been fixed by your commit d99ca17, since ofono-0.50 =
could work well with Ericsson F5521GW modem.

Thanks,
Dongxiao

> =

> Regards,
> -Denis

--===============7882145856126689507==--

