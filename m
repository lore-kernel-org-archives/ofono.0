Content-Type: multipart/mixed; boundary="===============5004348024215969793=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/5 v3] Cell-info: Header file for Neighbor cell info
Date: Mon, 07 Feb 2011 11:30:12 -0800
Message-ID: <1297107012.1520.446.camel@aeonflux>
In-Reply-To: <1294833919-1510-3-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5004348024215969793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

> +#define OFONO_CI_FIELD_TA_UNDEFINED 0xFF
> +#define OFONO_CI_FIELD_UCID_UNDEFINED 0xFFFFFFFF
> +#define OFONO_CI_FIELD_ECN0_UNDEFINED 0xFF
> +#define OFONO_CI_FIELD_RSCP_UNDEFINED -127
> +#define OFONO_CI_FIELD_PATHLOSS_UNDEFINED 0xFF
> +#define OFONO_CI_FIELD_FREQ_UNDEFINED 0xFFFF
> +
> +#define OFONO_MAX_NMR_COUNT 15
> +#define OFONO_MAX_MEASURED_CELL_COUNT 32
> +#define OFONO_MAX_MEAS_RES_LIST_COUNT 8
> +
> +enum ofono_cell_type {
> +	OFONO_CELL_TYPE_GERAN,
> +	OFONO_CELL_TYPE_UTRAN_FDD
> +};

anything we have to keep in mind for LTE here? Or does LTE not matter
for neighbor cell info?

Regards

Marcel



--===============5004348024215969793==--

