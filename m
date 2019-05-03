Content-Type: multipart/mixed; boundary="===============5697306109310838902=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Makefile.am : Fix compilation with ell
Date: Fri, 03 May 2019 10:19:07 -0500
Message-ID: <78b61c6a-2388-477c-735e-2f88920c3b3b@gmail.com>
In-Reply-To: <20190503095953.26994-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5697306109310838902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 05/03/2019 04:59 AM, Philippe De Swert wrote:
> Fix compilation issue with newer ell, which seems to have some
> extra timeout handling.
> =

>    CC       ell/main.lo
> ell/main.c:44:21: fatal error: timeout.h: No such file or directory
>   #include "timeout.h"
>                       ^
> compilation terminated.
> make[1]: *** [Makefile:4068: ell/main.lo] Error 1
> make: *** [Makefile:2357: all] Error 2
> ---
>   Makefile.am | 2 ++
>   1 file changed, 2 insertions(+)

Applied, thanks.

Regards,
-Denis


--===============5697306109310838902==--

