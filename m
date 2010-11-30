Content-Type: multipart/mixed; boundary="===============0814189377654395162=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: ConnectionContext creation for LTE PDN Connection.
Date: Tue, 30 Nov 2010 11:59:49 +0100
Message-ID: <1291114789.4795.35.camel@aeonflux>
In-Reply-To: <1291104513.14343.11.camel@Nokia-N900-51-1>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0814189377654395162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

as I mentioned before, please do NOT break threading.

> > why would bringing an interface up interfere? We are doing this right
> > now. Just the IP assignment is done by ConnMan, but the interface
> > up/down status is controlled by oFono or even BlueZ in case of
> > Bluetooth.
> =

> Logically whoever sets the IP parameters should bring the interface admin=
istratively up. This is layer 3.
> =

> oFono does layer 2. It should either create/remove the interface and/or p=
lay with the dormant and/or carrier flags.

If you think we should change the current behavior, then please send
patches for oFono and BlueZ and also ConnMan to fix this.

Regards

Marcel



--===============0814189377654395162==--

