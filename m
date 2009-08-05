Content-Type: multipart/mixed; boundary="===============8571400490967438331=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: light test report for ofono v0.2
Date: Thu, 06 Aug 2009 00:09:45 +0800
Message-ID: <38D9F46DFF92C54980D2F2C1E8EE313001A7604D4E@pdsmsx503.ccr.corp.intel.com>
In-Reply-To: <E2263E4A5B2284449EEBD0AAB751098402CE04E009@PDSMSX501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8571400490967438331==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

>4) timeout when reading records at the first time
Reading records from SIM card requires more time than default timeout of D-=
Bus, so you will get timeout error when you invoke the method via D-Bus for=
 the first time. The result will be cached once oFono gets all the records,=
 thus you may get the records very quickly for the second, third, .., time.
I will try to update the test case to retrieve the records in an asynchrono=
us way.

Regards,
-Yang

--===============8571400490967438331==--

