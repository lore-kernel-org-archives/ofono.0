Content-Type: multipart/mixed; boundary="===============4171039708854526752=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/2] ussd: Fix speedup ussd encoding
Date: Tue, 10 Apr 2012 23:22:02 +0200
Message-ID: <1334092922.16897.57.camel@aeonflux>
In-Reply-To: <4F83E6DE.7040203@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4171039708854526752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > Speedup dongles encode USSD strings in GSM7
> > packed, so we don't have to pack it ourselves.
> > ---
> >  drivers/atmodem/ussd.c |   13 ++++++++++---
> >  plugins/speedup.c      |    2 +-
> >  2 files changed, 11 insertions(+), 4 deletions(-)
> > =

> =

> Patch looks good, but please split it into two in accordance with our
> patch submission guidelines.  See HACKING document, 'Submitting patches'
> section.

if the modem uses a fixed encoding all the time, would it not be simpler
to just add a specific modem driver for it? Like we did for Huawei and
its binary mode.

Regards

Marcel



--===============4171039708854526752==--

