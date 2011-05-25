Content-Type: multipart/mixed; boundary="===============7180125732354967729=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: ofonod crash on Ericsson F5521GW
Date: Wed, 25 May 2011 04:48:26 -0500
Message-ID: <4DDCD06A.707@gmail.com>
In-Reply-To: <D5AB6E638E5A3E4B8F4406B113A5A19A525B1EFF@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7180125732354967729==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dongxiao,

On 05/27/2011 03:28 AM, Xu, Dongxiao wrote:
> Hi list,
> =

> Recently I am integrating ofono into Yocto project (www.yoctoproject.org)=
 to enable 3G feature, however I met ofonod crash in my environment.
> =

> I simply bisected it and found that ofono after 0.43 had this issue, whil=
e ofono before 0.42 works OK in my part.
> =

> 3G module: Ericsson F5521GW.
> Ofono version: 0.43 and later.
> =

> I attached the crash log, please help to check it out.
> =

> Thanks,
> Dongxiao
> =


I suggest you try the latest release of oFono, 0.43 is pretty old.
Judging by your log this issue should be fixed in later versions.  If
you still encounter the problem, please post a proper backtrace.  Either
by using gdb or running the backtrace through test/backtrace script.

Regards,
-Denis

--===============7180125732354967729==--

