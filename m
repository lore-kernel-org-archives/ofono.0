Content-Type: multipart/mixed; boundary="===============3193132615313015237=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] TODO: SMS Validity Period
Date: Mon, 31 Jan 2011 13:42:15 +0100
Message-ID: <1296477735.1520.202.camel@aeonflux>
In-Reply-To: <AANLkTim6-DRB76Mqpvi60ja+=+7SsEGY0CyH3Xd7RRFQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3193132615313015237==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > How does a normal user actually know what this means for him and the
> > network he is using? Is the network actually honoring these values at
> > all these days?
> =

> These are not clear to me either, so I don't see the point in exposing
> this setting over the D-Bus interface. I would, however, err on the
> side of flexibility here, and make this a configuration option in
> main.conf (once that support is available in oFono).

we did talk a bit about expected operator defaults especially in the
context of default character set etc. I think Portugal is such an
exception where you have to start out with a proper character set if
your SIM card is originated from there.

Maybe this is another one case where just picking a proper operator
default is better than actually providing any option to change it.

Regards

Marcel



--===============3193132615313015237==--

