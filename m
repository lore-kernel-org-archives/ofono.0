Content-Type: multipart/mixed; boundary="===============1626864620985217923=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/5] qmi: add NetworkMonitor interface
Date: Thu, 07 Sep 2017 12:35:59 -0500
Message-ID: <5a3a1951-4182-e403-9cc6-8b9134bfed7f@gmail.com>
In-Reply-To: <20170907121136.13520-5-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1626864620985217923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 09/07/2017 07:11 AM, Jonas Bonn wrote:
> This is a rudimentary implementation that contains technology, RSSI,
> and BitErrorRate, plus RSRQ/RSRP for LTE networks.  More data can be
> added as needed.
> =

> This implementations uses the 'Get Signal Strength' QMI method to retrieve
> the data.  Operator fields (MNC, LAC, etc) can be gotten from the 'Serving
> Cell' method if needed, but since this data is already provided in the
> NetworkRegistration object it doesn't seem necessary to repeat it here
> when an additional communication to the modem is required.
> ---
>   Makefile.am                 |   3 +-
>   doc/networkmonitor-api.txt  |   2 +-

separate patch please

>   drivers/qmimodem/netmon.c   | 285 +++++++++++++++++++++++++++++++++++++=
+++++++
>   drivers/qmimodem/qmimodem.c |   2 +
>   drivers/qmimodem/qmimodem.h |   3 +
>   plugins/gobi.c              |   5 +-

separate patch.  see HACKING, 'Submitting Patches'.

>   6 files changed, 297 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/qmimodem/netmon.c
> =

> diff --git a/Makefile.am b/Makefile.am
> index 658e152..4b68beb 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -233,7 +233,8 @@ builtin_sources +=3D $(qmi_sources) \
>   			drivers/qmimodem/gprs.c \
>   			drivers/qmimodem/gprs-context.c \
>   			drivers/qmimodem/radio-settings.c \
> -			drivers/qmimodem/location-reporting.c
> +			drivers/qmimodem/location-reporting.c \
> +			drivers/qmimodem/netmon.c
>   =

>   builtin_modules +=3D gobi
>   builtin_sources +=3D plugins/gobi.c
> diff --git a/doc/networkmonitor-api.txt b/doc/networkmonitor-api.txt
> index ddace7e..8d73af0 100644
> --- a/doc/networkmonitor-api.txt
> +++ b/doc/networkmonitor-api.txt
> @@ -77,7 +77,7 @@ byte TimingAdvance [optional, gsm]
>   =

>   	Contains the Timing Advance.  Valid range of values is 0-219.
>   =

> -byte Strength [optional, gsm, umts]
> +byte Strength [optional, gsm, umts, lte]
>   =

>   	Contains the signal strength.  Valid values are 0-31.  Refer to <rssi>
>   	in 27.007, Section 8.5.
> diff --git a/drivers/qmimodem/netmon.c b/drivers/qmimodem/netmon.c
> new file mode 100644
> index 0000000..9fef0d4
> --- /dev/null
> +++ b/drivers/qmimodem/netmon.c
> @@ -0,0 +1,285 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
> + *
> + *  Copyright (C) 2017  Jonas Bonn. All rights reserved.
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
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <errno.h>
> +
> +#include <glib.h>
> +
> +#include <ofono/log.h>
> +#include <ofono/modem.h>
> +#include <ofono/netmon.h>
> +
> +//#include "common.h"

??

> +
> +#include "qmi.h"
> +#include "nas.h"
> +
> +#include "qmimodem.h"
> +#include "src/common.h"
> +
> +struct netmon_data {
> +	struct qmi_service *nas;
> +};
> +
> +static void get_rssi_cb(struct qmi_result *result, void *user_data)
> +{
> +	struct cb_data *cbd =3D user_data;
> +	struct ofono_netmon *netmon =3D cbd->user;
> +	ofono_netmon_cb_t cb =3D cbd->cb;
> +	struct {
> +		enum ofono_netmon_cell_type type;
> +		int rssi;
> +		int ber;
> +		int rsrq;
> +		int rsrp;
> +	} props;
> +	uint16_t len;
> +	int16_t rsrp;
> +	const struct {
> +		int8_t value;
> +		int8_t rat;
> +	} __attribute__((__packed__)) *rsrq;
> +	const struct {
> +		uint16_t count;
> +		struct {
> +			uint8_t rssi;
> +			int8_t rat;
> +		} __attribute__((__packed__)) info[0];
> +	} __attribute__((__packed__)) *rssi;
> +	const struct {
> +		uint16_t count;
> +		struct {
> +			uint16_t rate;
> +			int8_t rat;
> +		} __attribute__((__packed__)) info[0];
> +	} __attribute__((__packed__)) *ber;
> +	int i;
> +
> +	DBG("");
> +
> +	if (qmi_result_set_error(result, NULL)) {
> +		CALLBACK_WITH_FAILURE(cb, cbd->data);
> +		return;
> +	}
> +
> +	/* RSSI */
> +	rssi =3D qmi_result_get(result, 0x11, &len);
> +	if (rssi) {
> +		for (i =3D 0; i < rssi->count; i++) {
> +			DBG("RSSI: %hhu on RAT %hhd",
> +				rssi->info[i].rssi,
> +				rssi->info[i].rat);
> +		}
> +
> +		/* Get cell type from RSSI info... it will be the same
> +		 * for all the other entries
> +		 */
> +		props.type =3D qmi_nas_rat_to_tech(rssi->info[0].rat);
> +		switch (rssi->info[0].rat) {
> +		case QMI_NAS_NETWORK_RAT_GSM:
> +			props.type =3D OFONO_NETMON_CELL_TYPE_GSM;
> +			break;
> +		case QMI_NAS_NETWORK_RAT_UMTS:
> +			props.type =3D OFONO_NETMON_CELL_TYPE_UMTS;
> +			break;
> +		case QMI_NAS_NETWORK_RAT_LTE:
> +			props.type =3D OFONO_NETMON_CELL_TYPE_LTE;
> +			break;
> +		default:
> +			props.type =3D OFONO_NETMON_CELL_TYPE_GSM;
> +			break;
> +		}
> +
> +		props.rssi =3D (rssi->info[0].rssi + 113) / 2;
> +		if (props.rssi > 31) props.rssi =3D 31;
> +		if (props.rssi < 0) props.rssi =3D 0;
> +	} else {
> +		props.type =3D QMI_NAS_NETWORK_RAT_GSM;
> +		props.rssi =3D -1;
> +	}
> +
> +	/* Bit error rate */
> +	ber =3D qmi_result_get(result, 0x15, &len);
> +	if (ber) {
> +		for (i =3D 0; i < ber->count; i++) {
> +			DBG("Bit error rate: %hu on RAT %hhd",
> +				ber->info[i].rate,
> +				ber->info[i].rat);
> +		}
> +
> +		props.ber =3D ber->info[0].rate;
> +		if (props.ber > 7)
> +			props.ber =3D -1;
> +	} else {
> +		props.ber =3D -1;
> +	}
> +
> +	/* LTE RSRQ */
> +	rsrq =3D qmi_result_get(result, 0x16, &len);
> +	if (rsrq) {
> +		DBG("RSRQ: %hhd on RAT %hhd",
> +			rsrq->value,
> +			rsrq->rat);
> +
> +		if (rsrq->value =3D=3D 0) {
> +			props.rsrq =3D -1;
> +		} else {
> +			props.rsrq =3D (rsrq->value + 19) * 2;
> +			if (props.rsrq > 34) props.rsrq =3D 34;
> +			if (props.rsrq < 0) props.rsrq =3D 0;
> +		}
> +	} else {
> +		props.rsrq =3D -1;
> +	}
> +
> +	/* LTE RSRP */
> +	if (qmi_result_get_int16(result, 0x18, &rsrp)) {
> +		DBG("Got LTE RSRP: %hd", rsrp);
> +
> +		if (rsrp =3D=3D 0) {
> +			props.rsrp =3D -1;
> +		} else {
> +			props.rsrp =3D rsrp + 140;
> +			if (props.rsrp > 97) props.rsrp =3D 97;
> +			if (props.rsrp < 0) props.rsrp =3D 0;
> +		}
> +	} else {
> +		props.rsrp =3D -1;
> +	}
> +
> +	ofono_netmon_serving_cell_notify(netmon,
> +				props.type,
> +				OFONO_NETMON_INFO_RSSI, props.rssi,
> +				OFONO_NETMON_INFO_BER, props.ber,
> +				OFONO_NETMON_INFO_RSRQ, props.rsrq,
> +				OFONO_NETMON_INFO_RSRP, props.rsrp,
> +				OFONO_NETMON_INFO_INVALID);
> +
> +	CALLBACK_WITH_SUCCESS(cb, cbd->data);
> +}
> +
> +static void qmi_netmon_request_update(struct ofono_netmon *netmon,
> +					ofono_netmon_cb_t cb,
> +					void *user_data)
> +{
> +	struct netmon_data *data =3D ofono_netmon_get_data(netmon);
> +	struct cb_data *cbd =3D cb_data_new(cb, user_data);
> +	struct qmi_param *param;
> +
> +	DBG("");
> +
> +	cbd->user =3D netmon;
> +
> +	param =3D qmi_param_new();
> +	if (!param)
> +		goto out;
> +
> +	/* Request all signal strength items: mask=3D0xff */
> +	qmi_param_append_uint16(param, 0x10, 255);
> +
> +	if (qmi_service_send(data->nas, QMI_NAS_GET_RSSI, param,
> +					get_rssi_cb, cbd, g_free) > 0)
> +		return;
> +
> +	qmi_param_free(param);
> +
> +out:
> +	CALLBACK_WITH_FAILURE(cb, cbd->data);
> +
> +	g_free(cbd);
> +}
> +
> +static void create_nas_cb(struct qmi_service *service, void *user_data)
> +{
> +	struct ofono_netmon *netmon =3D user_data;
> +	struct netmon_data *nmd =3D ofono_netmon_get_data(netmon);
> +
> +	DBG("");
> +
> +	if (!service) {
> +		ofono_error("Failed to request NAS service");
> +		ofono_netmon_remove(netmon);
> +		return;
> +	}
> +
> +	nmd->nas =3D qmi_service_ref(service);
> +
> +	ofono_netmon_register(netmon);
> +}
> +
> +static int qmi_netmon_probe(struct ofono_netmon *netmon,
> +					unsigned int vendor, void *user_data)
> +{
> +	struct qmi_device *device =3D user_data;
> +	struct netmon_data *nmd;
> +
> +	DBG("");
> +
> +	nmd =3D g_new0(struct netmon_data, 1);
> +
> +	ofono_netmon_set_data(netmon, nmd);
> +
> +	qmi_service_create_shared(device, QMI_SERVICE_NAS,
> +					create_nas_cb, netmon, NULL);
> +
> +	return 0;
> +}
> +
> +static void qmi_netmon_remove(struct ofono_netmon *netmon)
> +{
> +	struct netmon_data *nmd =3D ofono_netmon_get_data(netmon);
> +
> +	DBG("");
> +
> +	ofono_netmon_set_data(netmon, NULL);
> +
> +	qmi_service_unregister_all(nmd->nas);
> +
> +	qmi_service_unref(nmd->nas);
> +
> +	g_free(nmd);
> +}
> +
> +static struct ofono_netmon_driver driver =3D {
> +	.name			=3D "qmimodem",
> +	.probe			=3D qmi_netmon_probe,
> +	.remove			=3D qmi_netmon_remove,
> +	.request_update		=3D qmi_netmon_request_update,
> +};
> +
> +void qmi_netmon_init(void)
> +{
> +	ofono_netmon_driver_register(&driver);
> +}
> +
> +void qmi_netmon_exit(void)
> +{
> +	ofono_netmon_driver_unregister(&driver);
> +}
> diff --git a/drivers/qmimodem/qmimodem.c b/drivers/qmimodem/qmimodem.c
> index 959a901..b10ce28 100644
> --- a/drivers/qmimodem/qmimodem.c
> +++ b/drivers/qmimodem/qmimodem.c
> @@ -41,12 +41,14 @@ static int qmimodem_init(void)
>   	qmi_gprs_context_init();
>   	qmi_radio_settings_init();
>   	qmi_location_reporting_init();
> +	qmi_netmon_init();
>   =

>   	return 0;
>   }
>   =

>   static void qmimodem_exit(void)
>   {
> +	qmi_netmon_exit();
>   	qmi_location_reporting_exit();
>   	qmi_radio_settings_exit();
>   	qmi_gprs_context_exit();
> diff --git a/drivers/qmimodem/qmimodem.h b/drivers/qmimodem/qmimodem.h
> index 1fc8682..4b0fad3 100644
> --- a/drivers/qmimodem/qmimodem.h
> +++ b/drivers/qmimodem/qmimodem.h
> @@ -53,3 +53,6 @@ extern void qmi_radio_settings_exit(void);
>   =

>   extern void qmi_location_reporting_init(void);
>   extern void qmi_location_reporting_exit(void);
> +
> +extern void qmi_netmon_init(void);
> +extern void qmi_netmon_exit(void);
> diff --git a/plugins/gobi.c b/plugins/gobi.c
> index a498599..bc2b068 100644
> --- a/plugins/gobi.c
> +++ b/plugins/gobi.c
> @@ -34,6 +34,7 @@
>   #include <ofono/modem.h>
>   #include <ofono/devinfo.h>
>   #include <ofono/netreg.h>
> +#include <ofono/netmon.h>
>   #include <ofono/phonebook.h>
>   #include <ofono/voicecall.h>
>   #include <ofono/sim.h>
> @@ -493,8 +494,10 @@ static void gobi_post_online(struct ofono_modem *mod=
em)
>   =

>   	DBG("%p", modem);
>   =

> -	if (data->features & GOBI_NAS)
> +	if (data->features & GOBI_NAS) {
>   		ofono_netreg_create(modem, 0, "qmimodem", data->device);
> +		ofono_netmon_create(modem, 0, "qmimodem", data->device);
> +	}
>   =

>   	if (data->features & GOBI_VOICE)
>   		ofono_ussd_create(modem, 0, "qmimodem", data->device);
> =


Regards,
-Denis

--===============1626864620985217923==--

