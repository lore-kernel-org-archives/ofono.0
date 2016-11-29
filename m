Content-Type: multipart/mixed; boundary="===============1320841693983944677=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] netmon: add
 OFONO_NETMON_INFO_{RSCP|ECN0|RSRQ|RSRP|OPERATOR}
Date: Tue, 29 Nov 2016 10:43:02 -0600
Message-ID: <583DB016.1050603@gmail.com>
In-Reply-To: <1480082415-30822-2-git-send-email-djalal@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1320841693983944677==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Djalal,

On 11/25/2016 08:00 AM, djalal(a)endocode.com wrote:
> From: Djalal Harouni <djalal@endocode.com>
>
> Add more ofono netmon info types that will be served through the netmon
> interface. The main user of this now will be the ublox modem.
>
> RSCP: Received Signal Code Power
> ECN0: Received Energy Ratio
> RSRQ: Reference Signal Received Quality
> RSRP: Reference Signal Received Power
> OPERATOR: the operator
>
> Patches using these types to follow.
> ---
>   include/netmon.h | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/include/netmon.h b/include/netmon.h
> index ec8a2e1..abde225 100644
> --- a/include/netmon.h
> +++ b/include/netmon.h
> @@ -59,6 +59,11 @@ enum ofono_netmon_info {
>   	OFONO_NETMON_INFO_RSSI, /* int */
>   	OFONO_NETMON_INFO_TIMING_ADVANCE, /* int */
>   	OFONO_NETMON_INFO_PSC, /* int */
> +	OFONO_NETMON_INFO_RSCP, /* int */
> +	OFONO_NETMON_INFO_ECN0, /* int */
> +	OFONO_NETMON_INFO_RSRQ, /* int */
> +	OFONO_NETMON_INFO_RSRP, /* int */
> +	OFONO_NETMON_INFO_OPERATOR, /* char *, up to 24 digits */

MCC & MNC are not enough?  This API is intended for various location =

services which hardly care about the text representation of the =

operator.  They'd rather know the lac & ci, and possibly the mcc & mnc.

I'm not sure if its worth including this as it is likely just coming =

from an MCCMNC database in the modem and this info is available via =

NetworkRegistration anyway.

>   	OFONO_NETMON_INFO_INVALID,
>   };
>
>

Regards,
-Denis

--===============1320841693983944677==--

