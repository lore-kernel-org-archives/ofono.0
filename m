Content-Type: multipart/mixed; boundary="===============1268527909046569808=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/5] doc: Add documentation for 'forced-mode'
Date: Tue, 18 Jan 2011 21:50:16 +0100
Message-ID: <1295383816.3873.230.camel@aeonflux>
In-Reply-To: <AANLkTi=tE+scJG8r4Qn6BuB3To-2o_MtDDaXBGX2faxM@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1268527909046569808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > And while thinking about this, now I have another question. If this flag
> > is set on the SIM card, are you allowed to deregister from the network?
> =

> I suppose so. However, you know how I feel about Deregister() to begin
> with. I think with the Online property, it simply serves no purpose.
> Or is there an actual use case for intentionally leaving RF active
> while in limited service only?

this is actually a good question. Do we still need the Deregister()
since we have Online property now.

I personally don't remember that we discussed this after we pushed the
Online support and fixed up the majority of the modem drivers.

Regards

Marcel



--===============1268527909046569808==--

