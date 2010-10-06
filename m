Content-Type: multipart/mixed; boundary="===============3568070081259779797=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Handling of Fixed Dialing
Date: Wed, 06 Oct 2010 17:29:51 +0200
Message-ID: <1286378991.6145.31.camel@aeonflux>
In-Reply-To: <1286374677-2932-1-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3568070081259779797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

> First patch checks if Fixed Dialing is enabled in the SIM-card
> by reading FD-activated bit from EFsst or EFest. If FDN is enabled, =

> SIM initialization procedure is stopped, and modem will stay in the PRE-S=
IM state. =

> If FD is enabled, this is signaled via DBUS.

don't forget to update the documentation with the new D-Bus property.

Regards

Marcel



--===============3568070081259779797==--

