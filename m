Content-Type: multipart/mixed; boundary="===============3708963767282861404=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: Re: [PATCH 1/1] qmi: support SMS receive on Quectel EC21
Date: Mon, 16 Oct 2017 16:07:00 +0200
Message-ID: <20171016160638.237f89f2@lazus.yip>
In-Reply-To: <20171016122048.2405-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3708963767282861404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

I'm working on Gobi2000 sms support atm and having the same problem.

> +	} else {
> +		/* The Quectel EC21, at least, does not provide the
> +		 * message data in the event notification, so a 'raw
> read'
> +		 * needs to be issued in order to query the message
> itself
> +		 */
> +		struct qmi_param *param;
> +
> +		param =3D qmi_param_new();
> +		if (!param)
> +			return;
> +
> +		/* Message memory storage ID */
> +		qmi_param_append(param, 0x01, sizeof(*notify),
> notify);
> +		/* The 'message mode' parameter is documented as
> optional,
> +		 * but the Quectel EC21 errors out with error 17
> (missing
> +		 * argument) if it is not provided... we default to
> 3GPP
> +		 * here because that's what works for me and it's
> not clear
> +		 * how to actually query what this should be
> otherwise...
> +		 */
> +		/* Message mode */
> +		qmi_param_append_uint8(param, 0x10,
> +				QMI_WMS_MESSAGE_MODE_GSMWCDMA);
> +
> +		if (qmi_service_send(data->wms, QMI_WMS_RAW_READ,
> param,
> +					raw_read_cb, sms, NULL) > 0)
> +			return;
> +
> +		qmi_param_free(param);
>  	}

Could you create a raw read request function? For the Gobi2000 I'll
need the same function on powering to clean up the whole storage.

Best,
Alexander
-- =

Alexander Couzens

mail: lynxis(a)fe80.eu
jabber: lynxis(a)fe80.eu
mobile: +4915123277221
gpg: 390D CF78 8BF9 AA50 4F8F  F1E2 C29E 9DA6 A0DF 8604

--===============3708963767282861404==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.sig"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSXpCQUVCQ2dBZEZpRUVPUTNQZUl2NXFs
QlBqL0hpd3A2ZHBxRGZoZ1FGQWxua3ZRUUFDZ2tRd3A2ZHBxRGYKaGdSMVZBLytPbEwrU1lyOTBM
MXJETTMwN2ZiR1hhV2JxemFsRVNpdUlYZ3ptUzFMNVgvb2lZd3NwWHZRSlpCUgpyVFZYMU9RTnNi
WHFHRGR4amNveWx4dzJwMjM2WnkyclF6bi91ZEs1Z0I2WTVwSlpvSDZTZzJuaUgyS2xwSlhWClFB
RUFEbFBJdU5nY3o1TzdxTHNvYnRlMm11WWh5dUhFeW96aGtla0hpQ2cvZjVYME9RWWlRbUtWcUxp
QTFNb04KNUNtdERRbVhHbzJFazRmMXBVK055RXlBQUtUbGtpTUF0endCMWpmM2JKZ3RJZTgxZlds
eityK3FvRWVKQ0RZdwpYK2xMeTdJZ2l3N2RWNkpCa0J3V09aaVh5WEw2elNPK1dwK1Z3dUZyM2hQ
Y1ZFdGhJN1RtSzRKWWR5WUEvbTN1Cjh2c3ZzNnhHVFNkS1h3YS80Z1Y4NC9vT3ovbFJBSER6SGtJ
ZG1wWXo5cVIzUHV2ZVhHR1ZtQ0NnTzVISEo3Z2gKRDFTMkEyQTBFdldVNkZuRWJTRnYxYmdTMUhl
SzMraGZTMHlYcTZXYjJjWEJ4SGc2Yk94eHNGcE1jZTdsQjRpVwp3aGYzVEJtR2MzTTdHa2orVFlz
SklFVmlLamNaZENadkJNRmhESHVkNnU1ZW5CZ2JXYXFIREJHdUlZWDIwTC8rCjJRazlGYVdoa3lU
dVNna3lmVnR1K1g4N1BJaUx5RnZURFZvQ2M4QWZZNm1ERGYyQUI0NUVmQlc0UTI0Tm9ocmsKSlUw
TWdjbzB5OFRPR29Pb1pRRWdHT1dCeUxZd3A2bW1HQnh4c00veGlSaE1PdmdjVkp4TVF3bHkzSGF2
cEM4bwptaGxZeGcrbkE5NklYSnBDMlVrcTFoUlRYaWthdmUzK0s3b0RmeTdhVXlHTXBiS0NCWDg9
Cj1TQmhTCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============3708963767282861404==--

