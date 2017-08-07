Content-Type: multipart/mixed; boundary="===============8189413809435614262=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] add call-list helper to manage voice call lists
Date: Mon, 07 Aug 2017 12:42:55 -0500
Message-ID: <29b777b7-d952-ad62-3171-6ce718b1ca88@gmail.com>
In-Reply-To: <20170726232355.14601-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8189413809435614262==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 07/26/2017 06:23 PM, Alexander Couzens wrote:
> Many drivers asks the modem for a complete call list of current calls.
> These list of calls can be feeded into call-list which parse the
> list and notify ofono for new calls.
> ---
>
> v2: fix a bug when notify_calls is faster than the dial_callback.
> Improved dial_callback testcase to cover this.
>
>  Makefile.am           |  13 ++-
>  include/call-list.h   |  38 ++++++++
>  src/call-list.c       | 114 ++++++++++++++++++++++++
>  unit/test-call-list.c | 237 ++++++++++++++++++++++++++++++++++++++++++++=
++++++

So this is not in line with our patch submission guidelines.  See HACKING...

>  4 files changed, 399 insertions(+), 3 deletions(-)
>  create mode 100644 include/call-list.h
>  create mode 100644 src/call-list.c
>  create mode 100644 unit/test-call-list.c
>

<snip>

> diff --git a/include/call-list.h b/include/call-list.h
> new file mode 100644
> index 00000000..dbd6ddd6
> --- /dev/null
> +++ b/include/call-list.h
> @@ -0,0 +1,38 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2017 Alexander Couzens <lynxis@fe80.eu>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + */
> +
> +#include <glib.h>
> +

We are not exposing glib into the oFono plugin API.  So the use of =

GSList, etc data structures across driver <-> core boundary is not =

possible.  The reasons are somewhat historic, but essentially non-GLib =

based plugins must be possible.  Also, oFono's use of GLib will be =

replaced by ell [1] in the future.

> +struct ofono_voicecall;
> +struct ofono_phone_number;
> +
> +/*
> + * Can be called by the driver in the dialing callback,
> + * when the new call id already known
> + */
> +void ofono_call_list_dial_callback(struct ofono_voicecall *vc,
> +				   GSList **call_list,
> +				   const struct ofono_phone_number *ph,
> +				   int call_id);
> +
> +/*
> + * Called with a list of known calls e.g. clcc.
> + * Call list will take ownership of all ofono call within the calls.
> + */
> +void ofono_call_list_notify(struct ofono_voicecall *vc,
> +			    GSList **call_list,
> +			    GSList *calls);

I'm still not quite sure what you're trying to solve with these changes? =

  A bit more info on the motivation of the patches in the commit =

description would be helpful...

Regards,
-Denis

[1] https://git.kernel.org/pub/scm/libs/ell/ell.git/

--===============8189413809435614262==--

