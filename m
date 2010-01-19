Content-Type: multipart/mixed; boundary="===============0804362252801030139=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC v2 3/7] STE-plugin: STE modem driver definition
Date: Tue, 19 Jan 2010 11:21:55 -0800
Message-ID: <1263928915.5591.181.camel@localhost.localdomain>
In-Reply-To: <1263917513-6756-4-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0804362252801030139==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> Updates after review: Removed overriding of functions.
> ---

<snip>

> +
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#include <glib.h>
> +#include <gatchat.h>

What are these two includes for?

> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#include <ofono/plugin.h>
> +#include <ofono/types.h>

Why do you need the ofono/types.h include. Seems like some leftovers.

> +#include "stemodem.h"
> +
> +static int stemodem_init(void)
> +{
> +	ste_voicecall_init();
> +	ste_gprs_context_init();
> +
> +	return 0;
> +}

As I explained in the introductory reply. You have to keep the order
properly. So this patch either has to come last or the modem init needs
to be empty. You don't have the voicecall or GPRS init function merged
at this point.

If you wanna merge the stemodem.c and the configure option at some
point, I am perfectly fine with that. Just make it an empty stub here so
we are not breaking git bisect.

Together with the other two patches, I would apply that right away.

Regards

Marcel



--===============0804362252801030139==--

