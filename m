Content-Type: multipart/mixed; boundary="===============8497510792460746068=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv3 2/4] doc: add documentaion for Quectel hardware API
Date: Mon, 22 Jul 2019 10:46:50 +0200
Message-ID: <20190722084650.GA28727@amd>
In-Reply-To: <dcd72f4b-668e-6f35-64e6-38df68498f23@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8497510792460746068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!


> >+Hardware hierarchy
> >+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >+
> >+Service		org.ofono
> >+Interface	org.ofono.quectel.Hardware
> >+Object path	/{device0,device1,...}
> >+
> >+Methods		array{string,variant} GetProperties
> >+
> >+			Returns hardware properties for the modem object. See
> >+			the properties section for available properties.
> >+
> >+Properties	int32 Voltage [readonly]
> >+
> >+			Integer with the modem supply voltage in mV.
> >+
> >+		int32 ChargeStatus [readonly,optional]
> >+
> >+			Integer with one of either:
> >+
> >+			0: Modem is not charging
> >+			1: Modem is charging
> >+			2: Charging is finished
> >+
> >+			This property is available on UC15
> >+
> >+		int32 ChargeLevel [readonly,optional]
> >+
> >+			Integer representing the battery charge level in
> >+			percent (from 0 to 100).
> >+
> >+			This property is available on UC15
> >+

Maybe more resolution than percent would be useful? From 0 to 1000?

Best regards,
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============8497510792460746068==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsMDFkL29BQ2drUU1PZndhcFhiK3ZLUXBRQ2dwVW1kTG5YSC90enNtU3A3b0hrUmQ4RWQK
Y1M4QW4xcUhzb2gvaHVid3NQRFVmcSt4WUErUHZyMncKPXZJMzYKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============8497510792460746068==--

