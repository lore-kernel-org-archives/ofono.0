Content-Type: multipart/mixed; boundary="===============8125240332463079178=="
MIME-Version: 1.0
From: Robertino Benis <robertino.benis@intel.com>
Subject: RE: [PATCH v3] ifx: Adding modem selftest for Infineon modem
Date: Thu, 06 Jan 2011 17:42:12 -0800
Message-ID: <1294364532.1848.5.camel@airyz-ub910.intel.com>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C9015A52CE50@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8125240332463079178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> The IFX modem we are targetting implements this with two AT commands.
> =

> > Another question that I did ask is to see some sample results from these
> > test cases in failure and success case.
> =

> Robertino?

I think you meant except form the log, such as this:

ofonod[1342]: Using multiplexer line discipline 29
ofonod[1342]: Master: > ATE0 +CMEE=3D1\r
ofonod[1342]: Master: < ATE0 +CMEE=3D1\r
ofonod[1342]: Master: < \r\nOK\r\n
ofonod[1342]: Master: > at(a)rtc:rtc_gti_test_verify_32khz()\r
ofonod[1342]: Master: < \r\n
ofonod[1342]: Master: < Verification passed\r\nOK\r\n     =


ofonod[1342]: Master: > at(a)vers:device_version_id()\r
ofonod[1342]: Master: < \r\n
ofonod[1342]: Master: < \r\nCHIP ID =3D XG626 ES2\r\nFLASH TYPE =3D
NumonyxM18 NOR\r\nFLASH ID =3D 0x898881\r\nSmartiUE2 =3D 37664\r\nRF PMU =
=3D
10548\r\nPA PMU =3D 40244\r\nRF ASM =3D 0\r\nFEM PA =3D 21812\r\nOK\r\n  =




Simulated Self test Failure

ofonod[1260]: Using multiplexer line discipline 29
ofonod[1260]: Master: > ATE0 +CMEE=3D1\r
ofonod[1260]: Master: < ATE0 +CMEE=3D1\r
ofonod[1260]: Master: < \r\nOK\r\n
ofonod[1260]: Master: > at(a)rtc:rtc_gti_test_verify_32khz()\r
ofonod[1260]: Master: < \r\n
ofonod[1260]: Master: < Verification passed\r\nOK\r\n
ofonod[1260]: Master: > at(a)vers:device_version_id\r
ofonod[1260]: Master: < \r\nERROR\r\n                =

ofonod[1260]: Modem Device Version Test: FAIL        =



> In the patch it is the timeout for the first self test command.
> I understand you are thinking about a potential future patch in which it =
would be
> used as the overall setup timeout, I agree that in that case the name sho=
uld be
> changed accordingly as well, yes.

Do you think we should use overall setup timeout? =


Thanks,
-- r.



--===============8125240332463079178==--

