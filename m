Content-Type: multipart/mixed; boundary="===============3203632980581999502=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 5/5] cell-info: Documentation
Date: Mon, 03 Jan 2011 12:42:27 -0800
Message-ID: <1294087347.5852.18.camel@aeonflux>
In-Reply-To: <AANLkTinQbeL8XubiBW+UpjYfm+F8Co-BDe-oNUShM71k@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3203632980581999502==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> >> What is the reason behind a{sv}aa{sv} here? Wouldn't it be simpler to
> >> just go with aa{sv} and declare that the first dict is always the
> >> current serving cell? Are the information from the current cell really
> >> that different than from the neighbors?
> >
> > The rationale is that this is the format OMA-TS-ULP-V2_0-20100816-C and
> > 3GPP RRC define for user plane location. Also, all modems don't provide
> > the same information for serving and neighbor cells; e.g. isimodem
> > follows the above mentioned specs. I believe that for location purposes
> > the information included in the a{sv} part is not needed for neighbors.
> > Hence making the structure flat would not really make things simpler.
> =

> I originally suggested a{sv}aa{sv}, but I don't see a problem this
> being just a flat aa{sv}. The keys in dicts can always be different,
> and if the documentation clearly states that the first dict is always
> meta-data, followed by the actual neighbor measurements, it'll work
> just the same.

so the position engine would need the details that you provide in the
current serving cell. And just following network registration is not
good enough here?

Also the information from the current serving cell are really different
from the neighbor cell information?

Regards

Marcel



--===============3203632980581999502==--

