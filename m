Content-Type: multipart/mixed; boundary="===============7171959168042370026=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 06/12] gatchat: Add possibility to associate a
 diagnostic monitor to the AT-capable port
Date: Thu, 08 Dec 2011 16:13:23 +0200
Message-ID: <1323353603.1965.42.camel@aeonflux>
In-Reply-To: <1323355803-22096-7-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7171959168042370026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

>  gatchat/gatchat.c |   26 ++++++++++++++++++++++++++
>  gatchat/gatchat.h |    4 ++++
>  2 files changed, 30 insertions(+), 0 deletions(-)
> =

> diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
> index 7a0ef35..00e5fa8 100644
> --- a/gatchat/gatchat.c
> +++ b/gatchat/gatchat.c
> @@ -35,6 +35,7 @@
>  #include "ringbuffer.h"
>  #include "gatchat.h"
>  #include "gatio.h"
> +#include "gathdlc.h"
>  =

>  /* #define WRITE_SCHEDULER_DEBUG 1 */
>  =

> @@ -110,6 +111,7 @@ struct _GAtChat {
>  	struct at_chat *parent;
>  	guint group;
>  	GAtChat *slave;
> +	GAtHDLC	*diag_monitor;
>  };

what is this for? I don't see this needed at all. You are not crossing
atom driver implementations anyway.

Regards

Marcel



--===============7171959168042370026==--

