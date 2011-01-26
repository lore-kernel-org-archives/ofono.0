Content-Type: multipart/mixed; boundary="===============5901765482853267400=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/4] Add support for CPHS customer service profile
Date: Wed, 26 Jan 2011 10:50:56 +0100
Message-ID: <1296035456.1520.96.camel@aeonflux>
In-Reply-To: <1296033569-26774-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5901765482853267400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> This series adds support for CPHS CSP PLMN mode into the netreg atom.

one open question here is still if we also have to disallow scanning
when this is set?

So we might wanna update the Scan() and Register() method with the
proper error codes and put a note in there for mode =3D "auto-only".

Regards

Marcel



--===============5901765482853267400==--

