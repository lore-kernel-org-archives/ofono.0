Content-Type: multipart/mixed; boundary="===============8839290443968985053=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: [PATCH] ifx: adding Infineon modem self test
Date: Sun, 12 Dec 2010 17:30:11 -0800
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C90159DEB2FF@orsmsx508.amr.corp.intel.com>
In-Reply-To: <1292114148.30085.51.camel@aeonflux.mpl.access-company.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8839290443968985053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> > The conclusion was that these two test commands should be issued from t=
he AP to ensure that the modem is functioning properly.
> =

> I am not aware of the conclusion. My understanding is still that the
> modem firmware is suppose to do its selftests all by itself.

It does not.

> So what is the reasoning behind doing these selftests from the host.

It makes it easier for the host to record diagnostics / error codes this wa=
y. At the moment this is limited to recording it in the log file, as oFono =
doesn't provide a good way for reporting back error conditions when powerin=
g up a modem fails.

Cheers,
Waldo

--===============8839290443968985053==--

