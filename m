Content-Type: multipart/mixed; boundary="===============5207085749377555750=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] plugin: Plugin that finds correspondence between MCC
 and MNC length
Date: Thu, 24 Oct 2013 11:35:00 -0500
Message-ID: <52694C34.1090307@gmail.com>
In-Reply-To: <1382612469-29522-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5207085749377555750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

On 10/24/2013 06:01 AM, Alfonso Sanchez-Beato wrote:
> The implementation searchs in two tables, one of them with some special c=
ases

typo here

> for some operators and the other with the MNC length for a given MCC, as
> recommended by the ITU (http://www.itu.int/pub/T-SP-E.212B).
> ---
>   plugins/mnclength.c | 392 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 392 insertions(+)
>   create mode 100644 plugins/mnclength.c
>
> diff --git a/plugins/mnclength.c b/plugins/mnclength.c
> new file mode 100644
> index 0000000..ee40857
> --- /dev/null
> +++ b/plugins/mnclength.c
> @@ -0,0 +1,392 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
> + *  Copyright (C) 2013  Canonical Ltd.
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
> +#include <config.h>
> +#endif
> +
> +#include <errno.h>
> +#include <string.h>
> +#include <stdlib.h>
> +
> +#include <glib.h>
> +
> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#include <ofono/types.h>
> +#include <ofono/log.h>
> +#include <ofono/plugin.h>
> +#include <ofono/sim-mnclength.h>
> +
> +

No double-empty lines please

> +struct mcc_mnclength {
> +	int mcc;
> +	int mnclength;
> +};
> +

<snip>

> +static int comp_int(const void *key, const void *value)
> +{
> +	int mccmnckey =3D *(int *) key;
> +	int mccmnccurr =3D *(int *) value;
> +
> +	return mccmnckey - mccmnccurr;
> +}
> +
> +static int comp_mcc(const void *key, const void *value)
> +{
> +	int mcc =3D *(int *) key;
> +	struct mcc_mnclength *mccmnc =3D (struct mcc_mnclength *) value;
> +
> +	return mcc - mccmnc->mcc;
> +}
> +
> +static int mnclength_get_mnclength(const char *imsi)
> +{
> +	char mccmnc[OFONO_MAX_MCC_LENGTH + OFONO_MAX_MNC_LENGTH + 1];
> +	size_t nelem_mnclen3 =3D sizeof(codes_mnclen3_db)
> +				/ sizeof(codes_mnclen3_db[0]);
> +	size_t nelem_mccmnc =3D sizeof(mnclen_db)
> +				/ sizeof(mnclen_db[0]);

Please define/use ARRAY_SIZE macro for this to make it clearer whats =

going on.  If there's a glib equivalent, then use that.

> +	int mccmnc_num;
> +	int *mccmnc3_res;
> +	int mcc_num;
> +	struct mcc_mnclength *mccmnc_res;
> +
> +	if (strlen(imsi) < 6)

You might as well use a constant here instead of magic number 6.

> +		return 0;

In general we prefer to return negative errno values on errors.  So in =

this case -EINVAL -> Invalid Input

> +
> +	/* Special case for some operators */
> +	strncpy(mccmnc, imsi, sizeof(mccmnc) - 1);

Why bother with strncpy when you just checked the size?  Just do one or =

the other.

> +	mccmnc[sizeof(mccmnc) - 1] =3D '\0';
> +	errno =3D 0;
> +	mccmnc_num =3D (int) strtol(mccmnc, NULL, 10);
> +

First of all, you probably want strtoul here.  Second of all, please see =

strtoul manpage on how to properly use it.  Hint, the second parameter =

should not be NULL.  Since you already checked for size 6, messing with =

errno is completely unnecessary.

If strtoul conversion fails, you probably want to bail out at this point =

anyway.

> +	if (errno =3D=3D 0) {
> +		mccmnc3_res =3D
> +			bsearch(&mccmnc_num, codes_mnclen3_db, nelem_mnclen3,
> +				sizeof(codes_mnclen3_db[0]), comp_int);

Why don't you use GINT_TO_POINTER here?

> +
> +		if (mccmnc3_res)
> +			return 3;
> +	}
> +
> +	/* General case */
> +	mccmnc[OFONO_MAX_MCC_LENGTH] =3D '\0';
> +	errno =3D 0;
> +	mcc_num =3D (int) strtol(mccmnc, NULL, 10);
> +

Again, see comments above

> +	if (errno =3D=3D 0) {
> +		mccmnc_res =3D
> +			bsearch(&mcc_num, mnclen_db, nelem_mccmnc,
> +				sizeof(mnclen_db[0]), comp_mcc);
> +

And here

> +		if (mccmnc_res)
> +			return mccmnc_res->mnclength;
> +	}
> +
> +	return 0;

And here probably -ENOENT;

> +}
> +
> +static struct ofono_sim_mnclength_driver mnclength_driver =3D {
> +	.name		=3D "MNC length",
> +	.get_mnclength	=3D mnclength_get_mnclength
> +};
> +
> +static int mnclength_init(void)
> +{
> +	return ofono_sim_mnclength_driver_register(&mnclength_driver);
> +}
> +
> +static void mnclength_exit(void)
> +{
> +	ofono_sim_mnclength_driver_unregister(&mnclength_driver);
> +}
> +
> +OFONO_PLUGIN_DEFINE(mnclength, "MNC length Plugin", VERSION,
> +			OFONO_PLUGIN_PRIORITY_DEFAULT,
> +			mnclength_init, mnclength_exit)
>

Regards,
-Denis

--===============5207085749377555750==--

