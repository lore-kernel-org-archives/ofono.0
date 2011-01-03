Content-Type: multipart/mixed; boundary="===============4879509273827502071=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [RFC PATCHv2 1/4] Automatic provisioning of GPRS context settings
Date: Mon, 03 Jan 2011 15:32:02 +0200
Message-ID: <1294061522.3120.1589.camel@tucson>
In-Reply-To: <87hbdqxlk2.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4879509273827502071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

On Mon, 2011-01-03 at 13:40 +0200, ext Kalle Valo wrote:
> If you want to use XML, why not do it properly? XML parsing can't be
> that performance critical. And if it is (to my great surprise), then XML
> is not the correct choise for this.

Many experts would claim proper use of XML means avoiding DTD like the
plague. ;)

> Again, why not use mobile-broadband-provider-info DTD? If there's somethi=
ng
> missing, I'm sure maintainers are willing to extend it. No need to
> reinvent the wheel.

That is a slippery slope. Attempting to standardize here is likely to
make things more complicated in the long run. This is after all an oFono
internal data format that really should avoid any hard dependencies to
external projects.

We are likely to add things like MMS access point information. Is that
relevant for mobile-broadband-provider-info?

Thinking about this more, maybe the best approach is to go with whatever
fits oFono best, keep it private, and come up with the suitable style
sheet magic to be able to reuse the database from m-b-p-info if
necessary.

Cheers,
Aki


--===============4879509273827502071==--

