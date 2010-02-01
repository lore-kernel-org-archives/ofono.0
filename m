Content-Type: multipart/mixed; boundary="===============1389584641179760079=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH 2/2] Fix: Check if interface exists before creating it.
Date: Mon, 01 Feb 2010 13:40:04 -0800
Message-ID: <1265060404.31341.58.camel@localhost.localdomain>
In-Reply-To: <61D8D34BB13CFE408D154529C120E079032A1F20@eseldmw101.eemea.ericsson.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1389584641179760079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> >> diff --git a/drivers/stemodem/gprs-context.c
> >> b/drivers/stemodem/gprs-context.c index c178fb6..79e697b 100644
> >> --- a/drivers/stemodem/gprs-context.c
> >> +++ b/drivers/stemodem/gprs-context.c
> >> @@ -187,9 +187,11 @@ static gboolean caif_if_create(const char
> >>  	*interface, unsigned int connid)  		return FALSE; }
> >> =

> >> -	if (ioctl(s, SIOCCAIFNETNEW, &ifr) < 0) {
> >> -		ofono_debug("Failed to create IP interface for CAIF");
> >> -		return FALSE;
> >> +	if (ioctl(s, SIOCGIFINDEX, &ifr) !=3D 0) {
> >> +		if (ioctl(s, SIOCCAIFNETNEW, &ifr) < 0) {
> >> +			ofono_debug("Failed to create IP interface for CAIF");
> >> +			return FALSE; +		}
> >>  	}
> >> =

> >>  	return TRUE;
> > =

> > just doing it like this would be better:
> > =

> > 	/* Check if interface exists */
> > 	if (ioctl(s, SIOCGIFINDEX, &ifr) =3D=3D 0)
> > 		return TRUE;
> > =

> > 	if (ioctl(s, SIOCCAIFNETNEW, &ifr) < 0) {
> > 		...
> > 		return FALSE;
> > 	}
> > =

> > 	return TRUE;
> > =

> > We are not a big fan complicated if clauses if they can be avoid with
> > a simple goto or just a return. =

> > =

> > Also I think we need to check errno value here. Since potentially the
> > ioctl can fail for other reasons. And maybe extending CAIF with a
> > proper way of checking for an existing interface might be better.  =

> =

> Do you have anything particular in mind here? =

> Maybe CAIF could simply return EEXIST from SIOCCAIFNETNEW if the interface
> already exists? In this case we could return TRUE anyway.

if it isn't that doing already, then it should be doing it. And yes,
just returning TRUE in that case seems fine to me.

Regards

Marcel



--===============1389584641179760079==--

