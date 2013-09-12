Content-Type: multipart/mixed; boundary="===============1898347226185171955=="
MIME-Version: 1.0
From: Zhang, Caiwen <caiwen.zhang@intel.com>
Subject: RE: [PATCH] Fix modem doesn't auto register to network issue
Date: Thu, 12 Sep 2013 02:48:54 +0000
Message-ID: <DA62CA5DDF4CA640AA25B1684E5D141101D86039@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <5230ABDD.40808@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1898347226185171955==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > Some modem may return registration status whitch is out of the range
> > (0-5). it will cause the modem don't auto register to network when
> > network atom initializes.
> =

> oFono core will not validate values outside what is defined in 27.007.
> If your driver reports such values, then it is an obvious bug in the driv=
er.
> =

> Please fix your modem driver.
> =


(status =3D=3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED ||
		status =3D=3D NETWORK_REGISTRATION_STATUS_DENIED ||
		status =3D=3D NETWORK_REGISTRATION_STATUS_UNKNOWN)

Above checking tries to list the cases that should trigger auto network reg=
istration but for the modems which
extend network registration status may miss some cases.

With the new checking:
		(status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
			status !=3D NETWORK_REGISTRATION_STATUS_SEARCHING &&
			status !=3D NETWORK_REGISTRATION_STATUS_ROAMING))
it tries to exclude the cases that not required to trigger auto network reg=
istration. In this way, it can avoid
above issue.

I am not sure whether other modem has the same issue. This way should be mo=
re make sense.

By the way, it should be better to change the status from "int" to " enum n=
etwork_registration_status" to avoid modem driver pass
in value we don't expect.

Regards,
Caiwen


--===============1898347226185171955==--

