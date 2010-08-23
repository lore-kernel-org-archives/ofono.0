Content-Type: multipart/mixed; boundary="===============3459176208367065191=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCHv2 2/2] mbm: retry modem init
Date: Mon, 23 Aug 2010 19:31:27 +0300
Message-ID: <AANLkTi=pp_mqxT5hU7X2RwfMRO2vT9oGV=eMvAECS8Em@mail.gmail.com>
In-Reply-To: <1282574096.23399.243.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3459176208367065191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,
> don't you think we should leave the EMRDY notifier in the mbm_enable
> callback. I don't think it is a good idea to register more than one of
> these.

I think it is registered only once? Ooops...

> Can the AT&F line really fail? Or can we just assume that one will just
> work fine and not try to send it again.

Oh yes, it will. With connmand I get this kind of AT debug trace about
4 times of 5:

ofonod[3729]: Modem: > AT&F E0 V1 X4 &C1 +CMEE=3D1\r
ofonod[3729]: Modem: < AT&F E0 V1 X4 &C1 +CMEE=3D1\r\r\nNO CARRIER\r\n
ofonod[3729]: Modem: > AT*E2CFUN=3D1\r
ofonod[3729]: Modem: < AT*E2CFUN=3D1\r\r\nERROR\r\n
ofonod[3729]: Modem: > AT*EMRDY?\r
ofonod[3729]: Modem: < AT*EMRDY?\r\r\nERROR\r\n
ofonod[3729]: plugins/mbm.c:emrdy_query() 0
ofonod[3729]: Modem: > AT+CFUN?\r
ofonod[3729]: Modem: < AT+CFUN?\r
ofonod[3729]: Modem: < \r\n+CFUN: 4\r\n\r\nOK\r\n
ofonod[3729]: plugins/mbm.c:cfun_query() 1
ofonod[3729]: Modem: > AT+CFUN=3D1\r
ofonod[3729]: Modem: < AT+CFUN=3D1\r
ofonod[3729]: Modem: < \r\nOK\r\n
ofonod[3729]: plugins/mbm.c:cfun_enable()
ofonod[3729]: Modem: > AT+CPIN?\r
ofonod[3729]: Modem: < AT+CPIN?\r
ofonod[3729]: Modem: < \r\nERROR\r\n

-- =

Pekka.Pessi mail@nokia.com

--===============3459176208367065191==--

