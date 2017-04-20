Content-Type: multipart/mixed; boundary="===============7825004825673954866=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH qmi lte v4 5/6] qmi: add LTE atom driver
Date: Thu, 20 Apr 2017 12:03:03 -0500
Message-ID: <7e28374d-0e0f-76fc-5140-4f246fd837be@gmail.com>
In-Reply-To: <20170418075052.23980-5-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7825004825673954866==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 04/18/2017 02:50 AM, Jonas Bonn wrote:
> This patch adds the boilerplate for an LTE atom for QMI modems.
>
> This atom is supposed to set the APN that the default bearer uses
> to connect to the network.  The part that is missing currently is
> actually writing the APN into the modem's default profile.
>
> In many cases, however, the network does not actually require a
> correct APN in order to connect to the network so it's moot whether
> or not this atom actually completes its task!  For now, thus, this
> atom just emits a warning so that this can be fully implemented
> when there's a network that cares about the APN to test against.
>
> For completeness, what is supposed to happen is that this atom
> is supposed to call "Modify Profile" on the "default" profile,
> setting the APN.  The default profile should probably be queried
> because it can be set to something other than profile number one (1).
> Once configured, the default profile settings are used when the
> modem connects to the network; for this reason, the LTE atom needs
> to be instantiated in post_sim, before the modem is set online.
> ---
>  Makefile.am                 |   1 +
>  drivers/qmimodem/lte.c      | 143 ++++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/qmimodem/qmimodem.c |   2 +
>  drivers/qmimodem/qmimodem.h |   3 +
>  4 files changed, 149 insertions(+)
>  create mode 100644 drivers/qmimodem/lte.c
>
> diff --git a/Makefile.am b/Makefile.am
> index c894496..60c205a 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -232,6 +232,7 @@ builtin_sources +=3D $(qmi_sources) \
>  			drivers/qmimodem/ussd.c \
>  			drivers/qmimodem/gprs.c \
>  			drivers/qmimodem/gprs-context.c \
> +			drivers/qmimodem/lte.c \
>  			drivers/qmimodem/radio-settings.c \
>  			drivers/qmimodem/location-reporting.c
>
> diff --git a/drivers/qmimodem/lte.c b/drivers/qmimodem/lte.c
> new file mode 100644
> index 0000000..e131b47
> --- /dev/null
> +++ b/drivers/qmimodem/lte.c
> @@ -0,0 +1,143 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2017  Jonas Bonn. All rights reserved.
> + *  Copyright (C) 2017  South Pole Consulting AB. All rights reserved.
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
> +#ifdef HAVE_CONFIG_H
> +#include <config.h>
> +#endif
> +
> +#define _GNU_SOURCE
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <errno.h>
> +
> +#include <glib.h>
> +
> +#include <ofono/modem.h>
> +#include <ofono/gprs-context.h>
> +#include <ofono/log.h>
> +#include <ofono/lte.h>
> +
> +#include "qmi.h"
> +#include "wds.h"
> +
> +#include "qmimodem.h"
> +
> +struct lte_data {
> +	struct qmi_service *wds;
> +	char* apn;
> +};
> +
> +static void qmimodem_lte_set_default_attach_info(const struct ofono_lte =
*lte,
> +			const struct ofono_lte_default_attach_info *info,
> +			ofono_lte_cb_t cb, void *data)
> +{
> +	struct lte_data *ldd =3D ofono_lte_get_data(lte);
> +
> +	DBG("LTE config with APN: %s", info->apn);
> +
> +	g_free(ldd->apn);
> +
> +	if (strlen(info->apn) > 0)
> +		ldd->apn =3D g_strdup(info->apn);
> +	else
> +		ldd->apn =3D NULL;
> +

Why do you want to store the APN inside the driver data?

> +	/*
> +	 * FIXME: The above is not sufficient.  The APN needs to be set
> +	 * to the 'default' profile so that the modem uses it when
> +	 * connecting the default bearer.
> +	 */
> +	ofono_warn("LTE APN needs to be written to default profile");
> +
> +	CALLBACK_WITH_SUCCESS(cb, data);
> +}
> +
> +static void create_wds_cb(struct qmi_service *service, void *user_data)
> +{
> +	struct ofono_lte *lte =3D user_data;
> +	struct lte_data *data =3D ofono_lte_get_data(lte);
> +
> +	DBG("");
> +
> +	if (!service) {
> +		ofono_error("Failed to request WDS service");
> +		ofono_lte_remove(lte);
> +		return;
> +	}
> +
> +	data->wds =3D qmi_service_ref(service);
> +
> +	ofono_lte_register(lte);
> +}
> +
> +static int qmimodem_lte_probe(struct ofono_lte *lte, void *data)
> +{
> +	struct qmi_device *device =3D data;
> +	struct lte_data *ldd;
> +
> +	DBG("qmimodem lte probe");
> +
> +	ldd =3D g_try_new0(struct lte_data, 1);
> +	if (!ldd)
> +		return -ENOMEM;
> +
> +	ofono_lte_set_data(lte, ldd);
> +
> +	qmi_service_create(device, QMI_SERVICE_WDS,
> +					create_wds_cb, lte, NULL);
> +

So I talked to Marcel about this and it seems a QMI service cannot be =

created multiple times for the same device.  So I think this should fail =

and you should be using qmi_service_create_shared instead.

> +	return 0;
> +}
> +
> +static void qmimodem_lte_remove(struct ofono_lte *lte)
> +{
> +	struct lte_data *ldd =3D ofono_lte_get_data(lte);
> +
> +	DBG("");
> +
> +	ofono_lte_set_data(lte, NULL);
> +
> +	qmi_service_unregister_all(ldd->wds);
> +
> +	qmi_service_unref(ldd->wds);
> +
> +	g_free(ldd->apn);
> +
> +	g_free(ldd);
> +}
> +

The rest looks fine.

Regards,
-Denis


--===============7825004825673954866==--

