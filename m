Content-Type: multipart/mixed; boundary="===============5134227986092911346=="
MIME-Version: 1.0
From: Aygon, Bertrand <bertrand.aygon@intel.com>
Subject: RE: [PATCH 1/2] cbs: split the topics list for ZTE modem.
Date: Tue, 02 Aug 2011 15:29:06 +0100
Message-ID: <568DE01DA537804BA73470071BAC28893900664F@irsmsx503.ger.corp.intel.com>
In-Reply-To: <1312292289.8920.171.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5134227986092911346==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> > > >  	/* For the Qualcomm based devices it is required to clear
> > > >  	 * the list of topics first.  Otherwise setting the new
> > > > @@ -128,14 +180,40 @@ static void at_cbs_set_topics(struct
> ofono_cbs
> > > *cbs, const char *topics,
> > > >  		g_at_chat_send(data->chat, "AT+CSCB=3D1", none_prefix,
> > > >  				NULL, NULL, NULL);
> > > >  		break;
> > > > +	case OFONO_VENDOR_ZTE:
> > > > +		data->string_limit =3D 50;
> > > > +		g_at_chat_send(data->chat, "AT+CSCB=3D1", none_prefix,
> > > > +				NULL, NULL, NULL);
> > > > +		break;
> > >
> > > Why are we copying the Qualcomm quirk over for ZTE?
> >
> > Because previously, ZTE modem is using QUALCOMM vendor for CBS
> creation.
> > So I do not want to change this behaviour.
> =

> test it again. I am not even 100% that ZTE needs this behavior if the
> limitation was on the command line length. However it might. So please
> double check and comment it properly.


Ok, so ZTE require the CSCB=3D1 in case the topic is already set:

at+cscb=3D1
OK
AT+CSCB=3D0,"2000,3000,4000,5000,6000,7000,8000,9000,10000"

OK
at+cscb?
+CSCB: 0, "10000,9000,8000,7000,6000,5000,4000,3000,2000",""

OK
AT+CSCB=3D0,"2000,3000,4000,5000,6000,7000,8000,9000,10000"

+CMS ERROR: 302

Regards,

Bertrand
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


--===============5134227986092911346==--

