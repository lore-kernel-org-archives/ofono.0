Content-Type: multipart/mixed; boundary="===============8740564592299205174=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] netmon: support cell type LTE
Date: Tue, 21 Jul 2020 08:55:15 -0500
Message-ID: <48cced5a-a5dd-04cd-b942-65f16a2a263a@gmail.com>
In-Reply-To: <20200720084052.8617-1-wjs890204@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8740564592299205174==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi JongSeok,

On 7/20/20 3:40 AM, JongSeok Won wrote:
> ---
>   include/netmon.h |  3 +++
>   src/netmon.c     | 24 +++++++++++++++++++++++-
>   2 files changed, 26 insertions(+), 1 deletion(-)
> =

> diff --git a/include/netmon.h b/include/netmon.h
> index a99d6ca9..53f9d393 100644
> --- a/include/netmon.h
> +++ b/include/netmon.h
> @@ -72,6 +72,9 @@ enum ofono_netmon_info {
>   	OFONO_NETMON_INFO_EARFCN, /* int */
>   	OFONO_NETMON_INFO_EBAND, /* int */
>   	OFONO_NETMON_INFO_CQI, /* int */
> +	OFONO_NETMON_INFO_PCI, /* int */
> +	OFONO_NETMON_INFO_TAC, /* int */
> +	OFONO_NETMON_INFO_SNR, /* int */
>   	OFONO_NETMON_INFO_INVALID,
>   };
>   =

> diff --git a/src/netmon.c b/src/netmon.c
> index 9eacb3ca..320c8425 100644
> --- a/src/netmon.c
> +++ b/src/netmon.c
> @@ -138,7 +138,7 @@ static void netmon_cell_info_dict_append(DBusMessageI=
ter *dict,
>   			intval =3D va_arg(*arglist, int);
>   =

>   			CELL_INFO_DICT_APPEND(dict, "TimingAdvance",
> -					intval, uint8_t, DBUS_TYPE_BYTE);
> +					intval, uint32_t, DBUS_TYPE_UINT32);

This breaks the NetworkMonitor API since the signature for that particular =

property is documented as a 'byte'.  From what I recall this value has a ra=
nge =

of 0..63 ?

>   			break;
>   =

>   		case OFONO_NETMON_INFO_PSC:
> @@ -213,6 +213,28 @@ static void netmon_cell_info_dict_append(DBusMessage=
Iter *dict,
>   					intval, uint8_t, DBUS_TYPE_BYTE);
>   			break;
>   =

> +		case OFONO_NETMON_INFO_PCI:
> +			intval =3D va_arg(*arglist, int);
> +
> +			CELL_INFO_DICT_APPEND(dict, "PhysicalCellId",
> +					intval, uint16_t, DBUS_TYPE_UINT16);
> +			break;
> +
> +		case OFONO_NETMON_INFO_TAC:
> +			intval =3D va_arg(*arglist, int);
> +
> +			CELL_INFO_DICT_APPEND(dict, "TrackingAreaCode",
> +					intval, uint16_t, DBUS_TYPE_UINT16);
> +			break;
> +
> +		case OFONO_NETMON_INFO_SNR:
> +			intval =3D va_arg(*arglist, int);
> +
> +			ofono_dbus_dict_append(dict, "SingalToNoiseRatio",
> +					DBUS_TYPE_INT32, &intval);
> +
> +			break;
> +
>   		case OFONO_NETMON_INFO_INVALID:
>   			break;
>   		}
> =


These should also be documented in doc/networkmonitor-api.txt.

Regards,
-Denis
--===============8740564592299205174==--

