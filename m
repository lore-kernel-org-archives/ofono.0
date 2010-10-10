Content-Type: multipart/mixed; boundary="===============7853665540119732199=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] isimodem: add some ss error enums
Date: Sun, 10 Oct 2010 06:58:37 -0500
Message-ID: <4CB1AA6D.5060402@gmail.com>
In-Reply-To: <1286453525-30396-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7853665540119732199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> +const char *ss_gsm_error_name(enum ss_gsm_error value)
> +{
> +	switch (value) {
> +	_(SS_GSM_UNKNOWN_SUBSCRIBER);
> +	_(SS_GSM_ILLEGAL_SUBSCRIBER);
> +	_(SS_GSM_BEARER_SERV_NOT_PROVISION);

<snip>

> +
> +const char *ss_other_error_name(enum ss_other_error value)
> +{
> +	switch ((int)value) {
> +		_(SS_SERVICE_BUSY);
> +		_(SS_GSM_MM_RELEASE);
> +		_(SS_GSM_DATA_ERROR);

Can be consistent with switch/case indentation?

<snip>

> +enum ss_other_error {
> +	SS_SERVICE_BUSY =3D			0x00,
> +	SS_GSM_MM_RELEASE =3D			0x01,
> +	SS_GSM_DATA_ERROR =3D			0x02,
> +	SS_GSM_TIMER_EXPIRED =3D			0x03,
> +	SS_GSM_REQUEST_CANCELLED =3D		0x04,
> +	SS_GSM_INDICATE_DEVICE_PASSWORD =3D	0x05,
> +	SS_GSM_ACTIVATION_DATA_LOST =3D		0x09,
> +	SS_GSM_MM_ERROR =3D			0x0B,
> +	SS_GSM_SERVICE_NOT_ON_FDN_LIST =3D	0x0C,
> +	SS_SIMATKCC_REJECTED =3D			0x0D,
> +	SS_SIMATKCC_MODIFIED =3D			0x0E,
> +	SS_CS_INACTIVE =3D			0x0F,
> +	/* SS_GSM_SS_NOT_AVAILABLE =3D		0x12, */
> +	/* SS_GSM_USSD_BUSY =3D			0x48, */

Why are these commented out?

> +};
> +
>  #endif /* __ISIMODEM_SS_H */

Regards,
-Denis

--===============7853665540119732199==--

