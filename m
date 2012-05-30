Content-Type: multipart/mixed; boundary="===============4256760662609947832=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/6] error-mapping: Add function to map telephony errors
 into ofono error types
Date: Wed, 30 May 2012 00:42:11 -0500
Message-ID: <4FC5B333.1040602@gmail.com>
In-Reply-To: <1338309517-14808-4-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4256760662609947832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 05/29/2012 11:38 AM, Philippe Nunes wrote:
> ---
>   src/error-mapping.c |   77 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   src/error-mapping.h |   25 +++++++++++++++++
>   2 files changed, 102 insertions(+)
>   create mode 100644 src/error-mapping.c
>   create mode 100644 src/error-mapping.h
>
> diff --git a/src/error-mapping.c b/src/error-mapping.c
> new file mode 100644
> index 0000000..2012881
> --- /dev/null
> +++ b/src/error-mapping.c
> @@ -0,0 +1,77 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2012  Intel Corporation. All rights reserved.
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
1  USA
> + *
> + */
> +
> +#ifdef HAVE_CONFIG_H
> +#include<config.h>
> +#endif
> +
> +#define _GNU_SOURCE
> +#include<string.h>
> +#include<errno.h>
> +
> +#include<glib.h>
> +
> +#include<ofono/types.h>
> +#include<gdbus.h>

Is gdbus really necessary?  If it is, then it should be above ofono/types

> +#include "ofono.h"
> +#include "error-mapping.h"
> +
> +struct error_mapping_entry {
> +	int error;
> +	DBusMessage *(*ofono_error_func)(DBusMessage *);
> +};
> +
> +struct error_mapping_entry cme_errors_mapping[] =3D {
> +	{ 3,	__ofono_error_not_allowed },
> +	{ 4,	__ofono_error_not_supported },
> +	{ 16,	__ofono_error_incorrect_password },
> +	{ 30,	__ofono_error_not_registered },
> +	{ 31,	__ofono_error_timed_out },
> +	{ 32,	__ofono_error_access_denied },
> +	{ 50,	__ofono_error_invalid_args },
> +};
> +
> +DBusMessage *telephony_error_to_ofono_err(const struct ofono_error *erro=
r,
> +						DBusMessage *msg)
> +{
> +	struct error_mapping_entry *e;
> +	int maxentries;
> +	int i;
> +
> +	switch (error->type) {
> +	case OFONO_ERROR_TYPE_CME:
> +		e =3D cme_errors_mapping;
> +		maxentries =3D sizeof(cme_errors_mapping) /
> +					sizeof(struct error_mapping_entry);
> +		for (i =3D 0; i<  maxentries; i++)
> +			if (e[i].error =3D=3D error->error)
> +				return e[i].ofono_error_func(msg);
> +		break;
> +	case OFONO_ERROR_TYPE_CMS:
> +		return __ofono_error_failed(msg);
> +	case OFONO_ERROR_TYPE_CEER:
> +		return __ofono_error_failed(msg);
> +	default:
> +		return __ofono_error_failed(msg);
> +	}
> +
> +	return __ofono_error_failed(msg);
> +}

Please move this to dbus.c, it isn't worth creating a brand new file for =

this.

> diff --git a/src/error-mapping.h b/src/error-mapping.h
> new file mode 100644
> index 0000000..9909f9b
> --- /dev/null
> +++ b/src/error-mapping.h
> @@ -0,0 +1,25 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2012  Intel Corporation. All rights reserved.
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
1  USA
> + *
> + */
> +
> +#include<gdbus.h>
> +
> +DBusMessage *telephony_error_to_ofono_err(const struct ofono_error *erro=
r,
> +						DBusMessage *msg);

I don't like the name of this function, it should be prefixed with =

__ofono_error to be in line with the rest of the __ofono_error family. =

Lets go with __ofono_error_from_error.  Syntactically it does appear =

rather unfortunate, but I can't think of anything better right now.

Declare it inside ofono.h as well, there's no need for a header file...

> \ No newline at end of file

Regards,
-Denis

--===============4256760662609947832==--

