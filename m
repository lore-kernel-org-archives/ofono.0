Content-Type: multipart/mixed; boundary="===============0168075925208054849=="
MIME-Version: 1.0
From: Lars Poeschel <poeschel@lemonage.de>
Subject: Re: [PATCH 1/5] Add a vendor OFONO_VENDOR_QUECTEL_EC2X
Date: Tue, 11 Aug 2020 13:38:43 +0200
Message-ID: <20200811113843.cpc3r5frlhaeialg@lem-wkst-02.lemonage>
In-Reply-To: <62d7c37e-8cb9-3929-67aa-bf25de21d663@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0168075925208054849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2020 at 11:09:19AM -0500, Denis Kenzior wrote:
> Hi Lars,
> =

> On 8/4/20 7:38 AM, poeschel(a)lemonage.de wrote:
> > From: Lars Poeschel <poeschel@lemonage.de>
> > =

> > The distinction between OFONO_VENDOR_QUECTEL and
> > OFONO_VENDOR_QUECTEL_SERIAL does not suffice for EC21/EC25 in some
> > places, so introduce and use a new vendor:
> > OFONO_VENDOR_QUECTEL_EC2X
> > ---
> >   drivers/atmodem/lte.c       | 2 +-
> >   drivers/atmodem/sim.c       | 1 +
> >   drivers/atmodem/sms.c       | 2 ++
> >   drivers/atmodem/vendor.h    | 1 +
> >   drivers/atmodem/voicecall.c | 3 ++-
> >   plugins/quectel.c           | 2 +-
> >   6 files changed, 8 insertions(+), 3 deletions(-)
> > =

> =

> This doesn't apply:
> denkenz(a)localhost ~/ofono-master $ git am --3way ~/merge/\[PATCH\ 1_5\]\
> Add\ a\ vendor\ OFONO_VENDOR_QUECTEL_EC2X.eml
> Applying: Add a vendor OFONO_VENDOR_QUECTEL_EC2X
> error: sha1 information is lacking or useless (drivers/atmodem/lte.c).
> error: could not build fake ancestor
> Patch failed at 0001 Add a vendor OFONO_VENDOR_QUECTEL_EC2X
> =

> The chunk in drivers/atmodem/lte.c doesn't look like upstream code at all.

I am sorry. I started working on a lte context issue with this quectel
modem, but I am not sure I understood everything right. (This modem does
not support context ID zero.) So I decided to not submit this. I send
the remaining three patches as V2 rebased on master shortly.

Regards,
Lars
--===============0168075925208054849==--

