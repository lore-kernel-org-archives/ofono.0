Content-Type: multipart/mixed; boundary="===============2514188607708487554=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH] cdmamodem: create vendor.h file.
Date: Mon, 25 Jul 2011 18:58:34 +0200
Message-ID: <1311613119.8920.21.camel@aeonflux>
In-Reply-To: <568DE01DA537804BA73470071BAC288938F4E5AB@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2514188607708487554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

H Bertrand,

> > And from were I am standing, feel free to share the vendor quirks from
> > atmodem/vendor.h. At least until we have the rest figured out.
> =

> Ok, and what about the GENERIC, are we creating one? I don't think that t=
his is a good idea.

the atom driver by default should implement generic behavior. Aka vendor
set to 0. Only quirk behavior should be implemented via this. And that
only if it shares like 95% of the functionality otherwise. If it not
share that much, then just add another atom driver. So clearly no to the
GENERIC thing.

Regards

Marcel



--===============2514188607708487554==--

