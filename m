Content-Type: multipart/mixed; boundary="===============1793048598068059998=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/5] netmon: handle
 OFONO_NETMON_INFO_{RSCP|ECN0|RSRQ|RSRP|OPERATOR} in D-Bus
Date: Tue, 29 Nov 2016 10:49:12 -0600
Message-ID: <583DB188.1020402@gmail.com>
In-Reply-To: <1480082415-30822-3-git-send-email-djalal@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1793048598068059998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Djalal,

On 11/25/2016 08:00 AM, djalal(a)endocode.com wrote:
> From: Djalal Harouni <djalal@endocode.com>
>
> Handle the previously added types in D-Bus.
> ---
>   src/netmon.c | 40 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/src/netmon.c b/src/netmon.c
> index eb18b9c..c87980a 100644
> --- a/src/netmon.c
> +++ b/src/netmon.c
> @@ -78,7 +78,8 @@ void ofono_netmon_serving_cell_notify(struct ofono_netm=
on *netmon,
>   	const char *technology =3D cell_type_to_tech_name(type);
>   	char *mcc =3D NULL;
>   	char *mnc =3D NULL;
> -	int intval;
> +	char *op =3D NULL;
> +	int intval =3D -1;

Why the initializer?  Our rule of thumb is not to initialize in order to =

let the compiler (hopefully) or valgrind catch instances of =

uninitialized variable use (e.g. bugs).

>   	netmon->reply =3D dbus_message_new_method_return(netmon->pending);
>
>   	if (netmon->reply =3D=3D NULL)
> @@ -180,6 +181,43 @@ void ofono_netmon_serving_cell_notify(struct ofono_n=
etmon *netmon,
>   					intval, uint8_t, DBUS_TYPE_BYTE);
>   			break;
>
> +		case OFONO_NETMON_INFO_RSCP:
> +			intval =3D va_arg(arglist, int);
> +
> +			CELL_INFO_DICT_APPEND(&dict, "ReceivedSignalCodePower",
> +					intval, uint8_t, DBUS_TYPE_BYTE);
> +			break;
> +
> +		case OFONO_NETMON_INFO_ECN0:
> +			intval =3D va_arg(arglist, int);
> +
> +			CELL_INFO_DICT_APPEND(&dict, "ReceivedEnergyRatio",
> +					intval, uint8_t, DBUS_TYPE_BYTE);
> +			break;
> +
> +		case OFONO_NETMON_INFO_RSRQ:
> +			intval =3D va_arg(arglist, int);
> +
> +			CELL_INFO_DICT_APPEND(&dict, "ReferenceSignalReceivedQuality",
> +					intval, uint8_t, DBUS_TYPE_BYTE);
> +			break;
> +
> +		case OFONO_NETMON_INFO_RSRP:
> +			intval =3D va_arg(arglist, int);
> +
> +			CELL_INFO_DICT_APPEND(&dict, "ReferenceSignalReceivedPower",
> +					intval, uint8_t, DBUS_TYPE_BYTE);
> +			break;
> +

This looks fine, however there should be a patch documenting these and =

their respective value ranges inside doc/netmon-api.txt.

> +		case OFONO_NETMON_INFO_OPERATOR:
> +			op =3D va_arg(arglist, char *);
> +
> +			if (op && strlen(op))
> +				ofono_dbus_dict_append(&dict, "Operator",
> +						DBUS_TYPE_STRING, &op);
> +
> +			break;
> +
>   		case OFONO_NETMON_INFO_INVALID:
>   			break;
>   		}
>

Regards,
-Denis

--===============1793048598068059998==--

