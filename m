Content-Type: multipart/mixed; boundary="===============3759058995066188331=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] stkutil: display text attributes as html
Date: Fri, 25 Jun 2010 15:24:39 -0500
Message-ID: <201006251524.40756.denkenz@gmail.com>
In-Reply-To: <1277388032-13901-2-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3759058995066188331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -26,6 +26,7 @@
>  #include <string.h>
>  #include <stdlib.h>
>  #include <stdint.h>
> +#include <stdio.h>

Minor nitpick, but this include is not needed.

> =

>  #include <glib.h>
> =


Regards,
-Denis

--===============3759058995066188331==--

