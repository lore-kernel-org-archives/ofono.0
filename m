Content-Type: multipart/mixed; boundary="===============1702280354215978052=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 06/12] gatchat: Add possibility to associate a
 diagnostic monitor to the AT-capable port
Date: Fri, 09 Dec 2011 06:09:24 -0600
Message-ID: <4EE1FA74.40205@gmail.com>
In-Reply-To: <1323355803-22096-7-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1702280354215978052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 12/08/2011 08:49 AM, Philippe Nunes wrote:
> ---
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
>  =

>  struct terminator_info {
> @@ -1354,6 +1356,30 @@ GAtChat *g_at_chat_get_slave(GAtChat *chat)
>  	return chat->slave;
>  }
>  =

> +GAtHDLC *g_at_chat_associate_diag_monitor(GAtChat *chat, GAtHDLC *diag)
> +{
> +	if (chat =3D=3D NULL)
> +		return NULL;
> +
> +	if (chat->diag_monitor !=3D NULL)
> +		g_at_hdlc_unref(chat->diag_monitor);
> +
> +	if (diag !=3D NULL)
> +		chat->diag_monitor =3D g_at_hdlc_ref(diag);
> +	else
> +		chat->diag_monitor =3D NULL;
> +
> +	return chat->diag_monitor;
> +}
> +
> +GAtHDLC *g_at_chat_get_diag_monitor(GAtChat *chat)
> +{
> +	if (chat =3D=3D NULL)
> +		return NULL;
> +
> +	return chat->diag_monitor;
> +}
> +
>  GIOChannel *g_at_chat_get_channel(GAtChat *chat)
>  {
>  	if (chat =3D=3D NULL || chat->parent->io =3D=3D NULL)
> diff --git a/gatchat/gatchat.h b/gatchat/gatchat.h
> index 367581e..d8863b8 100644
> --- a/gatchat/gatchat.h
> +++ b/gatchat/gatchat.h
> @@ -30,6 +30,7 @@ extern "C" {
>  #include "gatsyntax.h"
>  #include "gatutil.h"
>  #include "gatio.h"
> +#include "gathdlc.h"
>  =

>  struct _GAtChat;
>  =

> @@ -68,6 +69,9 @@ GAtChat *g_at_chat_clone(GAtChat *chat);
>  GAtChat *g_at_chat_set_slave(GAtChat *chat, GAtChat *slave);
>  GAtChat *g_at_chat_get_slave(GAtChat *chat);
>  =

> +GAtHDLC *g_at_chat_associate_diag_monitor(GAtChat *chat, GAtHDLC *diag);
> +GAtHDLC *g_at_chat_get_diag_monitor(GAtChat *chat);

I'm not happy with the naming, can we use something like
g_at_chat_set_slave_qcdm.  GAtChat is not the best example of naming
consistency, but lets try to be consistent whenever we can ;)

> +
>  void g_at_chat_suspend(GAtChat *chat);
>  void g_at_chat_resume(GAtChat *chat);
>  =


Regards,
-Denis

--===============1702280354215978052==--

