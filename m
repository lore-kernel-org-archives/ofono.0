Content-Type: multipart/mixed; boundary="===============6219651501685381853=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC sim-authenticate PATCH 2/3] Added
 doc/sim-authentication-api.txt.
Date: Mon, 03 Jan 2011 12:54:41 -0800
Message-ID: <1294088081.5852.26.camel@aeonflux>
In-Reply-To: <AANLkTim5TYs7h-iXg3v4AJu-GeOm8=kqFVWYu58Hc+3v@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6219651501685381853==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> >> The EAP applications on SIM should be handled separately. The
> >> EapSimAuthenticate and EapAkaAuthenticate do not require a special EAP
> >> application on SIM, but they use ordinary cellular authentication.
> >> ---
> >>  doc/sim-authentication-api.txt |   66 +++++++++++++++++++++++++++++++=
+++++++++
> >>  1 files changed, 66 insertions(+), 0 deletions(-)
> >>  create mode 100644 doc/sim-authentication-api.txt
> >>
> >> diff --git a/doc/sim-authentication-api.txt b/doc/sim-authentication-a=
pi.txt
> >> new file mode 100644
> >> index 0000000..9a033bf
> >> --- /dev/null
> >> +++ b/doc/sim-authentication-api.txt
> >> @@ -0,0 +1,66 @@
> >> +SimAuthentication hierarchy
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >> +
> >> +Service              org.ofono
> >> +Interface    org.ofono.SimAuthentication
> >> +Object path  [variable prefix]/{modem0,modem1,...}
> >> +
> >> +Methods              byte{array} EapSimAuthenticate(array{byte} rand)
> >> +
> >> +                     Executes the SIM authentication algorithm for
> >> +                     RFC 4186 EAP SIM authentication method.
> >> +
> >> +                     The input parameter is RAND, a 16-byte array.
> >> +                     In case of successful authentication operation
> >> +                     the SRES parameter is returned as a 4-byte array.
> >> +
> >> +                     Possible Errors: [service].Error.InvalidArguments
> >> +                                      [service].Error.NotImplemented
> >> +
> >> +             dict EapAkaAuthenticate(array{byte} rand, array{byte} au=
tn)
> >
> > so I would rather have an interface where you can discover the supported
> > authentication applications on the SIM card and then have one interface
> > to execute them.
> =

> > The application using this interface needs somehow to know what methods
> > are available and not do some try and error execution.
> =

> Do you have something like this in your mind?
> =

> Methods		dict Authenticate(string appl, array{byte} RAND, array{byte} AUT=
N)
> =

> 			In case of successful SIM authentication the
> 			returned dictionary contains following item:
> 			=

> 			byte{array} "SRES" - SRES parameter
> =

> 			In case of successful AKA authentication the
> 			returned dictionary contains following items:
> =

> 			byte{array} "RES" - AKA RES parameter
> =

> 			byte{array} "CK" - AKA Ciphering key
> =

> 			byte{array} "IK" - AKA Integrity key
> =

> 			In case of unsuccessful authentication the
> 			returned dictionary contain following item:
> =

> 			byte{array} "AUTS" - AKA AUTS parameter
> 						=

> 			Possible Errors: [service].Error.InvalidArguments
> 				 	 [service].Error.NotImplemented
> =

> Properties	array{string} Applications [readwrite]
> =

> 			Contains the list of supported authentication
> 			applications. The possible values are:
> 				 "EAP-SIM" - GSM SIM authentication for EAP
> 				 "EAP-AKA" - AKA authentication for EAP
> 				 "IMS-AKA" - AKA authentication for IMS
> 				 "GBA" - GBA authentication

yep, that is similar to what I was thinking about. Andrew is currently
looking on how to do SIM application discovery. So I like to get his
input on this as well.

On AT command modems, we are pretty much tight into SIM application
discover and execution of authentication methods. At least when reading
the specification. I have not yet tested this since right now we are not
even bothering with SIM application details inside oFono at all.

For WISPr 2.0 and 802.1x we will need to make this work as well.

> > The EAP SIM is a subset of any proper AKA mechanism, but that should be
> > fine as well. Just having an empty AUTN array seems fine to me.
> =

> I'll see how GBA will fit to the architecture. According to the ISI
> modem spec it might be straightforward.

Is there a public specification for GBA by any chance?

Regards

Marcel



--===============6219651501685381853==--

