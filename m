Content-Type: multipart/mixed; boundary="===============7165749060517544436=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [SMS D-Bus 02/23] util.h: Add BUILD_BUG_ON() and friends for
 compile-time assert checking
Date: Mon, 28 Jun 2010 12:01:43 -0500
Message-ID: <201006281201.43560.denkenz@gmail.com>
In-Reply-To: <bae960413a408d22e3f6818ae710d051a99a1425.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7165749060517544436==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

> From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> =

> These have been stolen from the Linux kernel source; come pretty handy
> to make build-time consistency checks and thus avoid run-time
> surprises.
> ---
>  src/util.h |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
> =


This stuff really doesn't belong in util.h.  That file is ancient and if I =
were =

to do it again, I'd rename it into textutil.h or gsmutil.h.  I only really =

want to keep text conversions there.

I suggest putting this stuff into include/bug.h per Marcel's earlier email.

Regards,
-Denis

--===============7165749060517544436==--

