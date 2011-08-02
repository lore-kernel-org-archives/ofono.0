Content-Type: multipart/mixed; boundary="===============7760092121560156693=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH 1/2] cbs: split the topics list for ZTE modem.
Date: Tue, 02 Aug 2011 15:38:08 +0200
Message-ID: <1312292289.8920.171.camel@aeonflux>
In-Reply-To: <568DE01DA537804BA73470071BAC2889390065DF@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7760092121560156693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Betrand,

> > >  	/* For the Qualcomm based devices it is required to clear
> > >  	 * the list of topics first.  Otherwise setting the new
> > > @@ -128,14 +180,40 @@ static void at_cbs_set_topics(struct ofono_cbs
> > *cbs, const char *topics,
> > >  		g_at_chat_send(data->chat, "AT+CSCB=3D1", none_prefix,
> > >  				NULL, NULL, NULL);
> > >  		break;
> > > +	case OFONO_VENDOR_ZTE:
> > > +		data->string_limit =3D 50;
> > > +		g_at_chat_send(data->chat, "AT+CSCB=3D1", none_prefix,
> > > +				NULL, NULL, NULL);
> > > +		break;
> > =

> > Why are we copying the Qualcomm quirk over for ZTE?
> =

> Because previously, ZTE modem is using QUALCOMM vendor for CBS creation.
> So I do not want to change this behaviour.

test it again. I am not even 100% that ZTE needs this behavior if the
limitation was on the command line length. However it might. So please
double check and comment it properly.

Regards

Marcel



--===============7760092121560156693==--

