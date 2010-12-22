Content-Type: multipart/mixed; boundary="===============6020201236425018058=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [RFC PATCH 1/5 v2] cell-info: Atom for ECID info of neighb cells
Date: Wed, 22 Dec 2010 20:45:05 +0200
Message-ID: <1293043505.3120.1421.camel@tucson>
In-Reply-To: <1293010539-9524-2-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6020201236425018058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

On Wed, 2010-12-22 at 11:35 +0200, ext Antti Paila wrote:
> ---
>  src/cell-info.c |  484 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 484 insertions(+), 0 deletions(-)
>  create mode 100644 src/cell-info.c
> =

> diff --git a/src/cell-info.c b/src/cell-info.c
> new file mode 100644
> index 0000000..2289ce1
> --- /dev/null
> +++ b/src/cell-info.c
> @@ -0,0 +1,484 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.

Use Nokia copyright statement here.

> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <string.h>
> +#include <stdio.h>
> +#include <errno.h>
> +
> +#include <glib.h>
> +#include <gdbus.h>
> +#include <sys/time.h>
> +
> +#include "ofono.h"
> +
> +#include "common.h"
> +#include "util.h"
> +#include "ofono/cell-info.h"

This can't be the first patch in the set since the file included here is
only added in the second patch.

Cheers,
Aki


--===============6020201236425018058==--

