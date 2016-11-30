Content-Type: multipart/mixed; boundary="===============8790976212536903446=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 2/7] netmon: handle
 OFONO_NETMON_INFO_{RSCP|ECN0|RSRQ|RSRP} in D-Bus
Date: Wed, 30 Nov 2016 09:31:45 -0600
Message-ID: <583EF0E1.6010304@gmail.com>
In-Reply-To: <1480509105-17934-3-git-send-email-djalal@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8790976212536903446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Djalal,

On 11/30/2016 06:31 AM, Djalal Harouni wrote:
> Handle the previously added types in D-Bus.
>
> Documentation for these values is in next patch.
> ---
>   src/netmon.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
>

Tweaked the commit description and ...

> diff --git a/src/netmon.c b/src/netmon.c
> index eb18b9c..2a8c524 100644
> --- a/src/netmon.c
> +++ b/src/netmon.c
> @@ -180,6 +180,34 @@ void ofono_netmon_serving_cell_notify(struct ofono_n=
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

The above 2 CELL_INFO_DICT_APPEND lines were > 80 characters.  So I =

amended the patch to fix that.

>   		case OFONO_NETMON_INFO_INVALID:
>   			break;
>   		}
>

Applied, thanks!

Regards,
-Denis

--===============8790976212536903446==--

