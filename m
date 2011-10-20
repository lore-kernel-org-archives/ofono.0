Content-Type: multipart/mixed; boundary="===============3434652925598248215=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv10 1/9] mbpi: Minor style tweaks
Date: Thu, 20 Oct 2011 12:50:18 -0500
Message-ID: <4EA05F5A.4050802@gmail.com>
In-Reply-To: <1318935905-9087-2-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3434652925598248215==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 10/18/2011 06:04 AM, Oleg Zhurakivskyy wrote:
> ---
>  plugins/mbpi.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> =

> diff --git a/plugins/mbpi.c b/plugins/mbpi.c
> index ecb08eb..c5537d8 100644
> --- a/plugins/mbpi.c
> +++ b/plugins/mbpi.c
> @@ -23,12 +23,13 @@
>  #include <config.h>
>  #endif
>  =

> -#include <string.h>
> -#include <fcntl.h>
> +#include <sys/types.h>
>  #include <sys/mman.h>
>  #include <sys/stat.h>
> -#include <sys/types.h>
> +
> +#include <fcntl.h>
>  #include <errno.h>
> +#include <string.h>
>  #include <unistd.h>
>  =

>  #include <glib.h>

I decided to drop this patch since we really have no rule to separate
sys/ includes from regular ones.  The current style is fine.

Regards,
-Denis

--===============3434652925598248215==--

