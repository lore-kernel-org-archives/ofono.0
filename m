Content-Type: multipart/mixed; boundary="===============6154201031120915634=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: RFC: Supporting STK without PDUs
Date: Fri, 10 Sep 2010 23:48:35 +0200
Message-ID: <1284155315.20451.14.camel@aeonflux.t-mobile.de>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C901145B3ED3@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6154201031120915634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

> It looks like the preferred way to handle STK with IFX modems is to use a=
 dedicated mode where the modem handles most of STK commands and only a few=
 remaining commands are passed on to the apps processor for further handlin=
g.

as far as I know, the IFX firmware also supports what they call raw
mode. That mode is purely PDU based. Why just not use that one and let
oFono do the hard work. Seems to be working perfectly fine for MBM, STE
and Calypso based hardware.

Regards

Marcel



--===============6154201031120915634==--

