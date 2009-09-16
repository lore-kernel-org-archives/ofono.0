Content-Type: multipart/mixed; boundary="===============4821393875995871279=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: Bug in sms
Date: Wed, 16 Sep 2009 16:22:49 +0800
Message-ID: <38D9F46DFF92C54980D2F2C1E8EE313001AB9212FC@pdsmsx503.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4821393875995871279==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
	Today I tried oFono with my cell phone, but it crashed when starting up. T=
he problem happens in function at_cmgl_notify() of file drivers/atmodem/sms=
.c. In my case, strlen(hexpdu) =3D=3D 338, but the buffer "pdu" has maximum=
 size of 164. So after decode_hex_own_buf(), some memory was written unexpe=
ctedly. Call for a fix, please.


Regards,
-Yang



--===============4821393875995871279==--

