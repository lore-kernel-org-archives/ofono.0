Content-Type: multipart/mixed; boundary="===============7871578824105808320=="
MIME-Version: 1.0
From: Vijay.Nayani@elektrobit.com
Subject: RE: [RFC PATCH 09/20] modem: add preferred ue mode handling
Date: Tue, 12 Apr 2011 14:42:11 +0300
Message-ID: <AA48DD8077D5D945A49BD1782C1140F1EBB217@fioues08.ebgroup.elektrobit.com>
In-Reply-To: <4DA35823.7070803@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7871578824105808320==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


 Hi Dennis,

> -----Original Message-----
> From: Denis Kenzior [mailto:denkenz(a)gmail.com] =

> Sent: 11 April 2011 22:36
> To: ofono(a)ofono.org
> Cc: Nayani Vijay
> Subject: Re: [RFC PATCH 09/20] modem: add preferred ue mode handling
> =

> Hi Vijay,
> =

> > +static const char *preferred_ue_mode_to_string(int mode) {
> > +	switch (mode) {
> > +	case PREFERRED_UE_MODE_PS_DATA_CENTRIC:
> > +		return "PS mode 2";
> > +	case PREFERRED_UE_MODE_CS_PS_VOICE_CENTRIC:
> > +		return "PS/CS mode 1";
> > +	case PREFERRED_UE_MODE_CS_PS_DATA_CENTRIC:
> > +		return "PS/CS mode 2";
> > +	case PREFERRED_UE_MODE_PS_VOICE_CENTRIC:
> > +		return "PS mode 1";
> > +	}
> > +
> > +	return "unknown";
> > +}
> > +
> =

> These values are really not telling anyone anything.  How do =

> you envision the upper layers using this information?
> =


Current preferred mode would show up as part of modem property for EPS
modem on the similar lines of onlne,powered,lockdown..etc.
And also this property gets signalled if preferred mode changes.This is
currently happening during the enabling modem process.
We currently don't have option to set this from user side.

> Regards,
> -Denis
> =


Regards,
Vijay

--===============7871578824105808320==--

