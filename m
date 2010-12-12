Content-Type: multipart/mixed; boundary="===============6539265713606771500=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH] ifx: adding Infineon modem self test
Date: Sun, 12 Dec 2010 01:35:47 +0100
Message-ID: <1292114148.30085.51.camel@aeonflux.mpl.access-company.com>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C90159DEB23A@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6539265713606771500==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

> > > Adding Infineon modem selftest to the plugin. It executes couple of AT
> > > commands, and based on the responses,  it continues with ifx modem
> > > enabling or powers the modem down.
> > =

> > didn't we conclude that the modem should do all these by itself? My
> > understanding is that the modem executes these. And not that we have to
> > trigger them.
> =

> The conclusion was that these two test commands should be issued from the=
 AP to ensure that the modem is functioning properly.

I am not aware of the conclusion. My understanding is still that the
modem firmware is suppose to do its selftests all by itself.

So what is the reasoning behind doing these selftests from the host.
Right now I am failing to see the benefit of these.

Regards

Marcel



--===============6539265713606771500==--

