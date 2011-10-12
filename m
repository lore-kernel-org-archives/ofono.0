Content-Type: multipart/mixed; boundary="===============5408753682518954446=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv9 01/16] mbpi: Remove unused includes
Date: Wed, 12 Oct 2011 16:30:48 -0500
Message-ID: <4E960708.3080101@gmail.com>
In-Reply-To: <1317820719-23609-2-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5408753682518954446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 10/05/2011 08:18 AM, Oleg Zhurakivskyy wrote:
> ---
>  plugins/mbpi.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> =

> diff --git a/plugins/mbpi.c b/plugins/mbpi.c
> index 683ce03..91c1ce0 100644
> --- a/plugins/mbpi.c
> +++ b/plugins/mbpi.c
> @@ -23,12 +23,12 @@
>  #include <config.h>
>  #endif
>  =

> -#include <string.h>
> -#include <fcntl.h>
>  #include <sys/mman.h>
>  #include <sys/stat.h>
> -#include <sys/types.h>

Unfortunately sys/types.h is required for the open system call.  Please
refer to 'man 2 open' for details.

> +
> +#include <fcntl.h>
>  #include <errno.h>
> +#include <string.h>
>  #include <unistd.h>
>  =

>  #include <glib.h>

Regards,
-Denis

--===============5408753682518954446==--

