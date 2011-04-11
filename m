Content-Type: multipart/mixed; boundary="===============7432933538613064903=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 20/20] modem: Add netreg watch for tech switch
Date: Mon, 11 Apr 2011 14:57:15 -0500
Message-ID: <4DA35D1B.5020709@gmail.com>
In-Reply-To: <1302517218-2147-21-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7432933538613064903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vijay,

> +static void netreg_status_watch(int status, int lac, int ci, int tech,
> +					const char *mcc, const char *mnc,
> +					void *data)
> +{
> +	struct ofono_modem *modem =3D data;
> +
> +	if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
> +			status !=3D NETWORK_REGISTRATION_STATUS_ROAMING)
> +		return;
> +
> +	switch (tech) {
> +	case ACCESS_TECHNOLOGY_EUTRAN:
> +		switch(modem->pref_mode) {
> +		case PREFERRED_UE_MODE_PS_VOICE_CENTRIC:
> +		case PREFERRED_UE_MODE_PS_DATA_CENTRIC:
> +			/* No need to do any switching */
> +			break;
> +		case PREFERRED_UE_MODE_CS_PS_VOICE_CENTRIC:
> +		case PREFERRED_UE_MODE_CS_PS_DATA_CENTRIC:
> +			/*
> +			 * All atoms needs to be created which is
> +			 * already done
> +			 */
> +			break;
> +		}
> +		break;
> +	case ACCESS_TECHNOLOGY_GSM:
> +	case ACCESS_TECHNOLOGY_GSM_COMPACT:
> +	case ACCESS_TECHNOLOGY_UTRAN:
> +	case ACCESS_TECHNOLOGY_GSM_EGPRS:
> +	case ACCESS_TECHNOLOGY_UTRAN_HSDPA:
> +	case ACCESS_TECHNOLOGY_UTRAN_HSUPA:
> +	case ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA:
> +		switch(modem->pref_mode) {
> +		case PREFERRED_UE_MODE_PS_VOICE_CENTRIC:
> +			/* Switch to 3G */
> +			break;
> +		case PREFERRED_UE_MODE_CS_PS_VOICE_CENTRIC:
> +		case PREFERRED_UE_MODE_CS_PS_DATA_CENTRIC:
> +			/*
> +			 * All atoms needs to be created which is already
> +			 * done.
> +			 */
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	}
> +}
> +

So what exactly needs to be done here?

Regards,
-Denis

--===============7432933538613064903==--

