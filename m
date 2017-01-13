Content-Type: multipart/mixed; boundary="===============5619611605628590520=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 1/3] plugins: Add Gemalto plugin for Cinterion P-family
Date: Fri, 13 Jan 2017 16:30:36 -0600
Message-ID: <ccbe1a5e-d8bf-e3bf-a89c-8531338b1398@gmail.com>
In-Reply-To: <1484240812-3327-2-git-send-email-vincent.cesson@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5619611605628590520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On 01/12/2017 11:06 AM, Vincent Cesson wrote:
> From: vcesson <vincent.cesson@smile.fr>

Please update your Author info.

>
> Actual cinterion plugin is not compliant with newer Gemalto modems.
> Gemalto plugin is based on cinterion with a custom struct to handle the
> interfaces Application and Modem.

The old cinterion plugin is used for Serial based devices.  So sure, =

this makes sense.

> ---
>  plugins/gemalto.c | 265 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 265 insertions(+)
>  create mode 100644 plugins/gemalto.c
>
> diff --git a/plugins/gemalto.c b/plugins/gemalto.c
> new file mode 100644
> index 0000000..4758f62
> --- /dev/null
> +++ b/plugins/gemalto.c
> @@ -0,0 +1,265 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.

You might want to update the copyright years and add your own to the =

above.  Really up to you though :)

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
> +#include <stdlib.h>
> +
> +#include <glib.h>
> +#include <gatchat.h>
> +#include <gattty.h>
> +
> +#define OFONO_API_SUBJECT_TO_CHANGE
> +#include <ofono/plugin.h>
> +#include <ofono/log.h>
> +#include <ofono/modem.h>
> +#include <ofono/call-barring.h>
> +#include <ofono/call-forwarding.h>
> +#include <ofono/call-meter.h>
> +#include <ofono/call-settings.h>
> +#include <ofono/devinfo.h>
> +#include <ofono/message-waiting.h>
> +#include <ofono/netreg.h>
> +#include <ofono/phonebook.h>
> +#include <ofono/sim.h>
> +#include <ofono/sms.h>
> +#include <ofono/ussd.h>
> +#include <ofono/voicecall.h>
> +
> +#include <drivers/atmodem/atutil.h>
> +
> +#include <ofono/gprs.h>
> +#include <ofono/gprs-context.h>
> +
> +#include <drivers/atmodem/vendor.h>
> +
> +struct gemalto_data {
> +	GAtChat *app;
> +	GAtChat *mdm;
> +	struct ofono_private_config *config;

What's this?  There's no such structure defined, and you should not be =

hijacking the ofono_ prefix for something that is local to a particular =

driver.

> +};
> +

The rest looks just fine to me.

Regards,
-Denis


--===============5619611605628590520==--

