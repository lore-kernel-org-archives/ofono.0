Content-Type: multipart/mixed; boundary="===============1716359208659076832=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: Re: [PATCH] doc: Add Location Services API
Date: Fri, 26 Nov 2010 18:11:59 +0200
Message-ID: <201011261811.59836.remi.denis-courmont@nokia.com>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C90157D0B124@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1716359208659076832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Saturday 20 November 2010 03:01:03 ext Bastian, Waldo, you wrote:
> Conformance testing per 3GPP 34.109s5.4.1.3 requires that
> RESET UE POSITIONING STORED INFO is handled.
> Similar for 3GPP RESET MS POSITIONING STORED INFO per 3GPP 44.014s12.
> =

> As far as I can see there is no provision for that in commands / XML
> defined by 27.007.
> =

> Would it make sense to add a ResetStoredInfo signal to the DBUS API for
> implementation in a modem specific way?

Yes. There are no standard commands for that and it is very much needed for =

conformance testing.

However, I would have thought that this was an issue between the automatic =

test equipment and the (Linux) positioning engine. In this case, what busin=
ess =

does oFono and the modem have there? Do some modems also cache some GPS-
related data?

-- =

R=C3=A9mi Denis-Courmont
Nokia Devices R&D, Maemo Software, Helsinki

--===============1716359208659076832==--

