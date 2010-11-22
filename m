Content-Type: multipart/mixed; boundary="===============7807117280329327026=="
MIME-Version: 1.0
From: Simon LETHBRIDGE <simon.lethbridge@stericsson.com>
Subject: RE: [PATCH] doc: Add Location Services API
Date: Mon, 22 Nov 2010 15:04:01 +0100
Message-ID: <B4268AAFAFA3E244B5B0641D5914917048BCA9CCCA@EXDCVYMBSTM006.EQ1STM.local>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C90157D0B15E@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7807117280329327026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: Bastian, Waldo [mailto:waldo.bastian(a)intel.com]
> Sent: 20 November 2010 02:04
> To: ofono(a)ofono.org; Simon LETHBRIDGE
> Cc: Sjur BRENDELAND
> Subject: RE: [PATCH] doc: Add Location Services API
> =



> =

> Conformance testing per 3GPP 34.109s5.4.1.3 requires that
> RESET UE POSITIONING STORED INFO is handled.
> Similar for 3GPP RESET MS POSITIONING STORED INFO per 3GPP 44.014s12.
> =

> As far as I can see there is no provision for that in commands / XML
> defined by 27.007.
> =

> Would it make sense to add a ResetStoredInfo signal to the DBUS API for
> implementation in a modem specific way?
> =


You are correct, this will need to be added to the API.

Regards,

Simon

--===============7807117280329327026==--

