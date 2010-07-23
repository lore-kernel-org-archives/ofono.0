Content-Type: multipart/mixed; boundary="===============1861041657695868508=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [patch 01/20] bug.h: Add BUILD_BUG_ON() and friends for
 compile-time assert checking
Date: Fri, 23 Jul 2010 14:57:04 -0700
Message-ID: <1279922224.26204.134.camel@localhost.localdomain>
In-Reply-To: <4C4A0C9D.3030506@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1861041657695868508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-07-23 at 14:41 -0700, Denis Kenzior wrote: =

> Hi Inaky,
> =

> On 07/23/2010 03:59 PM, Inaky Perez-Gonzalez wrote:
> > From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> > =

> > These have been stolen from the Linux kernel source; come pretty handy
> > to make build-time consistency checks and thus avoid run-time
> > surprises.
> > ---
> >  src/bug.h     |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  src/smsutil.c |    1 +
> >  2 files changed, 51 insertions(+), 0 deletions(-)
> >  create mode 100644 src/bug.h
> > =

> =

> First of all, please refer to doc/coding-style.txt Section M5.

Ops, miss, reworked them in the whole patchset

> Second, please actually check that your code passes make distcheck:
> =

>   CCLD   unit/test-idmap
>   CC     unit/test-sms.o
>   CC     src/smsutil.o
> ../src/smsutil.c:40:17: error: bug.h: No such file or directory
> make[2]: *** [src/smsutil.o] Error 1
> make[1]: *** [all] Error 2
> make: *** [distcheck] Error 1

another FAIL. However, I am hitting another one in missing
ofono/types.h, even after having pulled the tip as of today. Is that one
known? Anyway, fixing this one.

> > diff --git a/src/smsutil.c b/src/smsutil.c
> > index e41c041..6c2087a 100644
> > --- a/src/smsutil.c
> > +++ b/src/smsutil.c
> > @@ -37,6 +37,7 @@
> >  #include "util.h"
> >  #include "storage.h"
> >  #include "smsutil.h"
> > +#include "bug.h"
> =

> Why are you including this without actually using it?

It's used in a follow commit -- I mispliced that, sorry. Reworking it
for the next submission.




--===============1861041657695868508==--

