Content-Type: multipart/mixed; boundary="===============4557598253127804453=="
MIME-Version: 1.0
From: Vijay.Nayani@elektrobit.com
Subject: RE: [RFC PATCH 20/20] modem: Add netreg watch for tech switch
Date: Tue, 12 Apr 2011 13:19:25 +0300
Message-ID: <AA48DD8077D5D945A49BD1782C1140F1EBB1FE@fioues08.ebgroup.elektrobit.com>
In-Reply-To: <4DA35D1B.5020709@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4557598253127804453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > +		case PREFERRED_UE_MODE_CS_PS_DATA_CENTRIC:
> > +			/*
> > +			 * All atoms needs to be created which is
> > +			 * already done
> > +			 */
> > +			break;
> > +		}
> > +		break;
> > +	case ACCESS_TECHNOLOGY_GSM:
> > +	case ACCESS_TECHNOLOGY_GSM_COMPACT:
> > +	case ACCESS_TECHNOLOGY_UTRAN:
> > +	case ACCESS_TECHNOLOGY_GSM_EGPRS:
> > +	case ACCESS_TECHNOLOGY_UTRAN_HSDPA:
> > +	case ACCESS_TECHNOLOGY_UTRAN_HSUPA:
> > +	case ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA:
> > +		switch(modem->pref_mode) {
> > +		case PREFERRED_UE_MODE_PS_VOICE_CENTRIC:
> > +			/* Switch to 3G */
> > +			break;
> > +		case PREFERRED_UE_MODE_CS_PS_VOICE_CENTRIC:
> > +		case PREFERRED_UE_MODE_CS_PS_DATA_CENTRIC:
> > +			/*
> > +			 * All atoms needs to be created which =

> is already
> > +			 * done.
> > +			 */
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +		break;
> > +	}
> > +}
> > +
> =

> So what exactly needs to be done here?

I see this as sort of placeholder for calling enablers for managing
atoms.
Relevent calls can be made considering access tech and modem operational
mode.
This would come into play as a result of acess technology switch (CSFB
to LTE and viceversa).

Regards,
Vijay
 =


> -----Original Message-----
> From: Denis Kenzior [mailto:denkenz(a)gmail.com] =

> Sent: 11 April 2011 22:57
> To: ofono(a)ofono.org
> Cc: Nayani Vijay
> Subject: Re: [RFC PATCH 20/20] modem: Add netreg watch for tech switch
> =

> Hi Vijay,
> =

> > +static void netreg_status_watch(int status, int lac, int =

> ci, int tech,
> > +					const char *mcc, const =

> char *mnc,
> > +					void *data)
> > +{
> > +	struct ofono_modem *modem =3D data;
> > +
> > +	if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
> > +			status !=3D NETWORK_REGISTRATION_STATUS_ROAMING)
> > +		return;
> > +
> > +	switch (tech) {
> > +	case ACCESS_TECHNOLOGY_EUTRAN:
> > +		switch(modem->pref_mode) {
> > +		case PREFERRED_UE_MODE_PS_VOICE_CENTRIC:
> > +		case PREFERRED_UE_MODE_PS_DATA_CENTRIC:
> > +			/* No need to do any switching */
> > +			break;
> > +		case PREFERRED_UE_MODE_CS_PS_VOICE_CENTRIC:
> > +		case PREFERRED_UE_MODE_CS_PS_DATA_CENTRIC:
> > +			/*
> > +			 * All atoms needs to be created which is
> > +			 * already done
> > +			 */
> > +			break;
> > +		}
> > +		break;
> > +	case ACCESS_TECHNOLOGY_GSM:
> > +	case ACCESS_TECHNOLOGY_GSM_COMPACT:
> > +	case ACCESS_TECHNOLOGY_UTRAN:
> > +	case ACCESS_TECHNOLOGY_GSM_EGPRS:
> > +	case ACCESS_TECHNOLOGY_UTRAN_HSDPA:
> > +	case ACCESS_TECHNOLOGY_UTRAN_HSUPA:
> > +	case ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA:
> > +		switch(modem->pref_mode) {
> > +		case PREFERRED_UE_MODE_PS_VOICE_CENTRIC:
> > +			/* Switch to 3G */
> > +			break;
> > +		case PREFERRED_UE_MODE_CS_PS_VOICE_CENTRIC:
> > +		case PREFERRED_UE_MODE_CS_PS_DATA_CENTRIC:
> > +			/*
> > +			 * All atoms needs to be created which =

> is already
> > +			 * done.
> > +			 */
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +		break;
> > +	}
> > +}
> > +
> =

> So what exactly needs to be done here?
> =

> Regards,
> -Denis
>=20

--===============4557598253127804453==--

