Content-Type: multipart/mixed; boundary="===============7949297753641454156=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] netmon: adding get function for neighbouring cell
 information
Date: Thu, 30 May 2019 11:32:55 -0500
Message-ID: <19b3b1ad-bd38-ab47-98cc-d20a20e2e3cb@gmail.com>
In-Reply-To: <1559208088-3510-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7949297753641454156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 05/30/2019 04:21 AM, Antara Borwankar wrote:
> Added declaration of functions and structures required for getting
> neighbouring cell information.
> ---
>   include/netmon.h | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> =

> diff --git a/include/netmon.h b/include/netmon.h
> index c8fcafa..8847b82 100644
> --- a/include/netmon.h
> +++ b/include/netmon.h
> @@ -43,6 +43,8 @@ struct ofono_netmon_driver {
>   					unsigned int enable,
>   					unsigned int period,
>   					ofono_netmon_cb_t cb, void *data);
> +	void (*neighbouring_cell_update)(struct ofono_netmon *netmon,
> +					ofono_netmon_cb_t cb, void *data);
>   };
>   =

>   enum ofono_netmon_cell_type {
> @@ -73,6 +75,28 @@ enum ofono_netmon_info {
>   	OFONO_NETMON_INFO_INVALID,
>   };
>   =

> +struct ofono_netmon_neighbouring_cell
> +{
> +	enum ofono_netmon_cell_type cell_type;
> +	int mcc;
> +	int mnc;
> +	int cell_id;
> +	union {
> +		struct lte_cell {
> +			int rsrq;
> +			int rsrp;
> +		} lte;
> +		struct umts_cell {
> +			int rscp;
> +			int ecno;
> +		} umts;
> +		struct gsm_cell {
> +			int rssi;
> +			int ber;
> +		} gsm;
> +	} cell_meas;
> +};
> +

The reason we came up with the ofono_netmon_serving_cell_notify vararg =

syntax was exactly to avoid having to define such a structure...  Can we =

use something similar to that here as well?

>   /*
>    * Examples:
>    * ofono_netmon_serving_cell_notify(netmon, OFONO_NETMON_CELL_TYPE_GSM,
> @@ -104,6 +128,9 @@ void ofono_netmon_set_data(struct ofono_netmon *netmo=
n, void *data);
>   =

>   void *ofono_netmon_get_data(struct ofono_netmon *netmon);
>   =

> +void ofono_netmon_neighbouring_cell_notify(struct ofono_netmon *netmon,
> +					void *cell_list);
> +

This is another problem we have to address.  We cannot use glib or ell =

types in the public API.

It has been about two years now since we last talked about this API with =

Nishanth (I think?), so my memory is a bit fuzzy.  But from what I =

remember we decided to use the ofono_netmon_serving_cell_notify with the =

intent of adding ofono_netmon_neighbor_cell_notify with the same basic =

syntax in the future.  That way the driver could update both the serving =

cell and the neighbor cell info in the same operation (as that is how =

XMM and other vendors do it).

The intent was to have the core invoke request_update and have the =

driver generate updates on both the serving cell (via =

ofono_netmon_serving_cell_notify) and neighbor cells, with the info =

going to the agent and/or added onto the reply of the D-Bus method call. =

  Only the serving cell part was implemented back then as that was the =

only bits you guys needed.

>   #ifdef __cplusplus
>   }
>   #endif
> =


Regards,
-Denis

--===============7949297753641454156==--

