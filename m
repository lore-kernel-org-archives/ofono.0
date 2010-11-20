Content-Type: multipart/mixed; boundary="===============1918662878600504845=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: [PATCH] doc: Add Location Services API
Date: Fri, 19 Nov 2010 18:04:29 -0800
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C90157D0B15E@orsmsx508.amr.corp.intel.com>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C90157D0B124@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1918662878600504845==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[Resend without the bottom quote - Damn you Outlook]

Conformance testing per 3GPP 34.109s5.4.1.3 requires that
RESET UE POSITIONING STORED INFO is handled.
Similar for 3GPP RESET MS POSITIONING STORED INFO per 3GPP 44.014s12.

As far as I can see there is no provision for that in commands / XML
defined by 27.007.

Would it make sense to add a ResetStoredInfo signal to the DBUS API for
implementation in a modem specific way?

Cheers,
Waldo


--===============1918662878600504845==--

