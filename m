Content-Type: multipart/mixed; boundary="===============0413810321015976260=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] Add gatutil.c to share common APIs with GAtServer
Date: Thu, 14 Jan 2010 09:49:08 -0600
Message-ID: <201001140949.09231.denkenz@gmail.com>
In-Reply-To: <1263207230-22036-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0413810321015976260==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> +gboolean g_at_util_set_io(GIOChannel *io)

Rename this g_at_util_setup_io

> +{
> +	GIOFlags io_flags;
> +
> +	if (g_io_channel_set_encoding(io, NULL, NULL) !=3D
> +			G_IO_STATUS_NORMAL)
> +		return FALSE;
> +
> +	io_flags =3D g_io_channel_get_flags(io);
> +
> +	io_flags |=3D G_IO_FLAG_NONBLOCK;
> +	io_flags |=3D G_IO_FLAG_IS_READABLE;
> +	io_flags |=3D G_IO_FLAG_IS_WRITEABLE;

According to GLib docs the READABLE and WRITEABLE flags are not settable.  =

Don't see the point in setting them anyway, please get rid of this.

> +
> +	if (g_io_channel_set_flags(io, io_flags, NULL) !=3D
> +			G_IO_STATUS_NORMAL)
> +		return FALSE;
> +
> +	g_io_channel_set_close_on_unref(io, TRUE);
> +
> +	return TRUE;
> +}
> +
> diff --git a/gatchat/gatutil.h b/gatchat/gatutil.h
> new file mode 100644
> index 0000000..63bbfff
> --- /dev/null
> +++ b/gatchat/gatutil.h
> @@ -0,0 +1,46 @@
> +/*
> + *
> + *  AT chat library with GLib integration
> + *
> + *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
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
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-130=
1 =

>  USA + *
> + */
> +
> +#ifndef __GATUTIL_H
> +#define __GATUTIL_H
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +#include "gatresult.h"

Get rid of this include

> +
> +typedef void (*GAtResultFunc)(gboolean success, GAtResult *result,
> +				gpointer user_data);
> +typedef void (*GAtNotifyFunc)(GAtResult *result, gpointer user_data);

The GAtNotify and GAtResultFunc should stay in gatchat.h

> +typedef void (*GAtDisconnectFunc)(gpointer user_data);
> +typedef void (*GAtDebugFunc)(const char *str, gpointer user_data);

These don't belong here, create a new file called gat.h and put them there.

Regards,
-Denis

--===============0413810321015976260==--

