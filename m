Content-Type: multipart/mixed; boundary="===============2534079818176206529=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH 1/2] huaweimodem: Add support for radio settings
Date: Tue, 30 Nov 2010 16:35:29 -0200
Message-ID: <AANLkTikL7mFngYAauci24LyMf=6RJjt9r--77wjNTmry@mail.gmail.com>
In-Reply-To: <1291141506-25024-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2534079818176206529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 30, 2010 at 4:25 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> diff --git a/drivers/huaweimodem/radio-settings.c b/drivers/huaweimodem/r=
adio-settings.c
> new file mode 100644
> index 0000000..7f0b223
> --- /dev/null
> +++ b/drivers/huaweimodem/radio-settings.c
> @@ -0,0 +1,212 @@
> +/*
> + *
> + * =C2=A0oFono - Open Source Telephony
> + *
> + * =C2=A0Copyright (C) 2010 =C2=A0Intel Corporation. All rights reserved.
> + *
> + * =C2=A0This program is free software; you can redistribute it and/or m=
odify
> + * =C2=A0it under the terms of the GNU General Public License version 2 =
as
> + * =C2=A0published by the Free Software Foundation.
> + *
> + * =C2=A0This program is distributed in the hope that it will be useful,
> + * =C2=A0but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * =C2=A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =C2=A0See =
the
> + * =C2=A0GNU General Public License for more details.
> + *
> + * =C2=A0You should have received a copy of the GNU General Public Licen=
se
> + * =C2=A0along with this program; if not, write to the Free Software
> + * =C2=A0Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA =C2=
=A002110-1301 =C2=A0USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define _GNU_SOURCE
> +#include <string.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <errno.h>
> +
> +#include <glib.h>
> +
> +#include <ofono/log.h>
> +#include <ofono/modem.h>
> +#include <ofono/radio-settings.h>
> +
> +#include "gatchat.h"
> +#include "gatresult.h"
> +
> +#include "huaweimodem.h"
> +
> +static const char *none_prefix[] =3D { NULL };
> +static const char *xrat_prefix[] =3D { "^SYSCFG:", NULL };
> +
> +struct radio_settings_data {
> + =C2=A0 =C2=A0 =C2=A0 GAtChat *chat;
> +};

I left chat inside a radio_settings_data struct because I plan to
extend it in a follow up patch, when this one is accepted and I finish
my tests with Frequency Band Selection.


Marcel, sorry... I've made a "git commit -c" in one commit of yours
(to re-use the commit message), so this actually came with your name.

I'll send again this patch



regards,

Lucas De Marchi

--===============2534079818176206529==--

