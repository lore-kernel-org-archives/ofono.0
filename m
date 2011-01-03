Content-Type: multipart/mixed; boundary="===============8577156335588674626=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [RFC sim-authenticate PATCH 2/3] Added
 doc/sim-authentication-api.txt.
Date: Mon, 03 Jan 2011 22:49:51 +0200
Message-ID: <AANLkTim5TYs7h-iXg3v4AJu-GeOm8=kqFVWYu58Hc+3v@mail.gmail.com>
In-Reply-To: <1294086143.5852.4.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8577156335588674626==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2011/1/3 Marcel Holtmann <marcel@holtmann.org>:
>> The EAP applications on SIM should be handled separately. The
>> EapSimAuthenticate and EapAkaAuthenticate do not require a special EAP
>> application on SIM, but they use ordinary cellular authentication.
>> ---
>> =C2=A0doc/sim-authentication-api.txt | =C2=A0 66 +++++++++++++++++++++++=
+++++++++++++++++
>> =C2=A01 files changed, 66 insertions(+), 0 deletions(-)
>> =C2=A0create mode 100644 doc/sim-authentication-api.txt
>>
>> diff --git a/doc/sim-authentication-api.txt b/doc/sim-authentication-api=
.txt
>> new file mode 100644
>> index 0000000..9a033bf
>> --- /dev/null
>> +++ b/doc/sim-authentication-api.txt
>> @@ -0,0 +1,66 @@
>> +SimAuthentication hierarchy
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>> +
>> +Service =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0org.ofono
>> +Interface =C2=A0 =C2=A0org.ofono.SimAuthentication
>> +Object path =C2=A0[variable prefix]/{modem0,modem1,...}
>> +
>> +Methods =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0byte{array} Eap=
SimAuthenticate(array{byte} rand)
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
Executes the SIM authentication algorithm for
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
RFC 4186 EAP SIM authentication method.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
The input parameter is RAND, a 16-byte array.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
In case of successful authentication operation
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
the SRES parameter is returned as a 4-byte array.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
Possible Errors: [service].Error.InvalidArguments
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[service].Err=
or.NotImplemented
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dict EapAkaAuthenticate(arra=
y{byte} rand, array{byte} autn)
>
> so I would rather have an interface where you can discover the supported
> authentication applications on the SIM card and then have one interface
> to execute them.

> The application using this interface needs somehow to know what methods
> are available and not do some try and error execution.

Do you have something like this in your mind?

Methods		dict Authenticate(string appl, array{byte} RAND, array{byte} AUTN)

			In case of successful SIM authentication the
			returned dictionary contains following item:
			=

			byte{array} "SRES" - SRES parameter

			In case of successful AKA authentication the
			returned dictionary contains following items:

			byte{array} "RES" - AKA RES parameter

			byte{array} "CK" - AKA Ciphering key

			byte{array} "IK" - AKA Integrity key

			In case of unsuccessful authentication the
			returned dictionary contain following item:

			byte{array} "AUTS" - AKA AUTS parameter
						=

			Possible Errors: [service].Error.InvalidArguments
				 	 [service].Error.NotImplemented

Properties	array{string} Applications [readwrite]

			Contains the list of supported authentication
			applications. The possible values are:
				 "EAP-SIM" - GSM SIM authentication for EAP
				 "EAP-AKA" - AKA authentication for EAP
				 "IMS-AKA" - AKA authentication for IMS
				 "GBA" - GBA authentication

> The EAP SIM is a subset of any proper AKA mechanism, but that should be
> fine as well. Just having an empty AUTN array seems fine to me.

I'll see how GBA will fit to the architecture. According to the ISI
modem spec it might be straightforward.

-- =

Pekka.Pessi mail at nokia.com

--===============8577156335588674626==--

