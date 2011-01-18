Content-Type: multipart/mixed; boundary="===============5645749502229036701=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 3/5] doc: Add documentation for 'forced-mode'
Date: Tue, 18 Jan 2011 22:35:56 +0200
Message-ID: <AANLkTi=tE+scJG8r4Qn6BuB3To-2o_MtDDaXBGX2faxM@mail.gmail.com>
In-Reply-To: <1295382667.3873.227.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5645749502229036701==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2011/1/18 Marcel Holtmann <marcel@holtmann.org>:
> And while thinking about this, now I have another question. If this flag
> is set on the SIM card, are you allowed to deregister from the network?

I suppose so. However, you know how I feel about Deregister() to begin
with. I think with the Online property, it simply serves no purpose.
Or is there an actual use case for intentionally leaving RF active
while in limited service only?

For sure, you're allowed to take the device offline.

Cheers,
Aki

--===============5645749502229036701==--

