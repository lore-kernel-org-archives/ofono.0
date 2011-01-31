Content-Type: multipart/mixed; boundary="===============5474136584499272668=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH] TODO: SMS Validity Period
Date: Mon, 31 Jan 2011 13:23:47 +0200
Message-ID: <AANLkTim6-DRB76Mqpvi60ja+=+7SsEGY0CyH3Xd7RRFQ@mail.gmail.com>
In-Reply-To: <1296469912.1520.199.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5474136584499272668==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2011/1/31 Marcel Holtmann <marcel@holtmann.org>:
> How does a normal user actually know what this means for him and the
> network he is using? Is the network actually honoring these values at
> all these days?

These are not clear to me either, so I don't see the point in exposing
this setting over the D-Bus interface. I would, however, err on the
side of flexibility here, and make this a configuration option in
main.conf (once that support is available in oFono).

Cheers,
Aki

--===============5474136584499272668==--

