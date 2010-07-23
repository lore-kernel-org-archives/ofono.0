Content-Type: multipart/mixed; boundary="===============4715339451803170128=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [patch 01/20] bug.h: Add BUILD_BUG_ON() and friends for
 compile-time assert checking
Date: Fri, 23 Jul 2010 16:41:49 -0500
Message-ID: <4C4A0C9D.3030506@gmail.com>
In-Reply-To: <893d62f90fda3ee868f97babb7c5063718d8283d.1279918330.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4715339451803170128==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

On 07/23/2010 03:59 PM, Inaky Perez-Gonzalez wrote:
> From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> =

> These have been stolen from the Linux kernel source; come pretty handy
> to make build-time consistency checks and thus avoid run-time
> surprises.
> ---
>  src/bug.h     |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  src/smsutil.c |    1 +
>  2 files changed, 51 insertions(+), 0 deletions(-)
>  create mode 100644 src/bug.h
> =


First of all, please refer to doc/coding-style.txt Section M5.

Second, please actually check that your code passes make distcheck:

  CCLD   unit/test-idmap
  CC     unit/test-sms.o
  CC     src/smsutil.o
../src/smsutil.c:40:17: error: bug.h: No such file or directory
make[2]: *** [src/smsutil.o] Error 1
make[1]: *** [all] Error 2
make: *** [distcheck] Error 1

> diff --git a/src/smsutil.c b/src/smsutil.c
> index e41c041..6c2087a 100644
> --- a/src/smsutil.c
> +++ b/src/smsutil.c
> @@ -37,6 +37,7 @@
>  #include "util.h"
>  #include "storage.h"
>  #include "smsutil.h"
> +#include "bug.h"

Why are you including this without actually using it?

>  =

>  #define uninitialized_var(x) x =3D x
>  =


Regards,
-Denis

--===============4715339451803170128==--

