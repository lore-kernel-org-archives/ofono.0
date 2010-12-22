Content-Type: multipart/mixed; boundary="===============2381786049645896077=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [RFC PATCH 2/5 v2] cell-info: Header file for cell-info atom
Date: Wed, 22 Dec 2010 20:45:22 +0200
Message-ID: <1293043522.3120.1422.camel@tucson>
In-Reply-To: <1293010539-9524-3-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2381786049645896077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

On Wed, 2010-12-22 at 11:35 +0200, ext Antti Paila wrote:
> ---
>  include/cell-info.h |  133 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 133 insertions(+), 0 deletions(-)
>  create mode 100644 include/cell-info.h
> =

> diff --git a/include/cell-info.h b/include/cell-info.h
> new file mode 100644
> index 0000000..3941e69
> --- /dev/null
> +++ b/include/cell-info.h
> @@ -0,0 +1,133 @@
> +/*
> + *
> + *  oFono - Open Source Telephony
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
1  USA
> + *
> + */
> +
> +#ifndef __OFONO_CELL_INFO_H
> +#define __OFONO_CELL_INFO_H
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +#include <ofono/types.h>
> +
> +struct ofono_cell_info;
> +
> +#define OFONO_CI_FIELD_UNDEFINED -1001
> +#define OFONO_MAX_NMR_COUNT 15
> +#define OFONO_MAX_MEASURED_CELL_COUNT 32
> +#define OFONO_MAX_MEAS_RES_LIST_COUNT 8
> +
> +
> +enum ofono_cell_type {
> +	OFONO_CELL_TYPE_GERAN,
> +	OFONO_CELL_TYPE_UTRA_FDD
> +};
> +
> +enum UTRA_MEAS_TYPE {
> +	UTRA_MEAS_TYPE_INTER_FREQ,
> +	UTRA_MEAS_TYPE_INTRA_FREQ,
> +};
> +
> +struct gsm {
> +	int lac;
> +	int ci;
> +	int ta;
> +	int no_cells;
> +	struct geran_neigh_cell{
> +		int arfcn;
> +		int bsic;
> +		int rxlev;
> +
> +	} nmr[OFONO_MAX_NMR_COUNT];
> +};
> +
> +struct cell_measured_results {
> +	int ucid;
> +	int sc;
> +	int ecn0;
> +	int rscp;
> +	int pathloss;
> +};
> +
> +struct measured_results_list {
> +	int dl_freq;
> +	int ul_freq;
> +	int rssi;
> +	int no_cells;
> +	struct cell_measured_results cmr[OFONO_MAX_MEASURED_CELL_COUNT];
> +};
> +
> +struct wcdma {
> +	int ucid;
> +	int dl_freq;
> +	int ul_freq;
> +	int sc;
> +	int no_freq;
> +	struct measured_results_list mrl[OFONO_MAX_MEAS_RES_LIST_COUNT];
> +
> +};

Since these things are called GERAN and UTRAN over D-Bus, it would make
sense to use the same naming here instead of struct gsm and struct
wcdma.

> +struct ofono_cell_info_results {
> +	enum ofono_cell_type rat;
> +	int mcc;
> +	int mnc;
> +	union {
> +		struct gsm gsm;
> +		struct wcdma wcdma;
> +	};
> +
> +};
> +
> +
> +typedef void (*ofono_cell_info_query_cb_t)(const struct ofono_error *err=
or,
> +		struct ofono_cell_info_results results, void *data);

The results is a pointer.

> +struct ofono_cell_info_driver {
> +	const char *name;
> +	int (*probe)(struct ofono_cell_info *ci,
> +			unsigned int vendor,
> +			void *data);
> +	void (*remove)(struct ofono_cell_info *ci);
> +	void (*query)(struct ofono_cell_info *ci,
> +			ofono_cell_info_query_cb_t,
> +			void *data);
> +};
> +
> +struct ofono_cell_info *ofono_cell_info_create(struct ofono_modem *modem,
> +					unsigned int vendor,
> +					const char *driver,
> +					void *data);
> +
> +void ofono_cell_info_register(struct ofono_cell_info *ci);
> +void ofono_cell_info_remove(struct ofono_cell_info *ci);
> +int ofono_cell_info_driver_register(struct ofono_cell_info_driver *drive=
r);
> +void ofono_cell_info_driver_unregister(struct ofono_cell_info_driver *dr=
iver);
> +void *ofono_cell_info_get_data(struct ofono_cell_info *ci);
> +void ofono_cell_info_set_data(struct ofono_cell_info *ci, void *cid);
> +void ofono_cell_info_query_cb(const struct ofono_error *error,
> +			struct ofono_cell_info_results results, void *data);

Why is this last one public?

Cheers,
Aki


--===============2381786049645896077==--

