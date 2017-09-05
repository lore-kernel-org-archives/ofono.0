Content-Type: multipart/mixed; boundary="===============7903011481432469344=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH][v2] common.c: move strlen(apn) check into is_valid_apn()
Date: Tue, 05 Sep 2017 10:42:18 -0500
Message-ID: <a6f10c3f-42a4-1462-f500-77dd77cbbe89@gmail.com>
In-Reply-To: <20170905142721.28780-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7903011481432469344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 09/05/2017 09:27 AM, Alexander Couzens wrote:
> ---
>   src/common.c | 8 ++++++++
>   src/gprs.c   | 9 ---------
>   src/lte.c    | 3 ---
>   3 files changed, 8 insertions(+), 12 deletions(-)
> =

> diff --git a/src/common.c b/src/common.c
> index 17d1d58a0be3..46b59223272e 100644
> --- a/src/common.c
> +++ b/src/common.c
> @@ -31,8 +31,10 @@
>   =

>   #include <ofono/types.h>
>   #include "common.h"
> +#include "gprs-context.h"
>   #include "util.h"
>   =

> +
>   struct error_entry {
>   	int error;
>   	const char *str;

I squashed the above spurious empty line and applied this patch.  Thanks.

Regards,
-Denis


--===============7903011481432469344==--

