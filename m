Content-Type: multipart/mixed; boundary="===============8561072060099957925=="
MIME-Version: 1.0
From: Zhang, Caiwen <Caiwen.Zhang@windriver.com>
Subject: RE: Add CDMA/EVDO into TODO
Date: Tue, 03 Aug 2010 11:49:35 +0200
Message-ID: <D87B22B1FE8C0F479CA9BEAD6C25AAE805424D07@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <1280813419.12579.78.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8561072060099957925==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel(a)holtmann.org]
> Sent: Tuesday, August 03, 2010 1:30 PM
> To: ofono(a)ofono.org
> Cc: Zhang, Caiwen; Schoppa, Chris
> Subject: Re: Add CDMA/EVDO into TODO
> =

> Hi Penghuo,
> =

> I am not fully against submitting patches as attachments, but if you do
> expect reviews, then we do prefer inline patches. I would advise to
> start using git send-email for patch submission.
> =

> > From 9af61f4d2546ff28a8b1ed9546c41f5f3c945f5a Mon Sep 17 00:00:00
> 2001
> > From: Pengzhuo wang <pengzhuo.wang0@windriver.com>
> > Date: Tue, 3 Aug 2010 19:53:32 +0800
> > Subject: [PATCH] Update TODO to add CDMA/EVDO support
> >
> > ---
> >  TODO |   25 +++++++++++++++++++++++++
> >  1 files changed, 25 insertions(+), 0 deletions(-)
> >
> > diff --git a/TODO b/TODO
> > index 5221324..b9130d3 100644
> > --- a/TODO
> > +++ b/TODO
> > @@ -567,3 +567,28 @@ Miscellaneous
> >
> >    Priority: High
> >    Complexity: C1
> > +
> > +CDMA/EVDO
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +- Extend modem interface with a 'Type' property to indicate the
> modem
> > type.
> > +
> > +  Priority: High
> > +  Complexity: C1
> =

> We need to discuss this with Denis. Either we do it here on the mailing
> list or on #ofono IRC channel on Freenode.
> =

> > +- Disable CDMA unsupport feature for CDMA modem. Include USSD,
> > supplementary services,
> > +  SSN, PDP context.
> > +
> > +  Priority: High
> > +  Complexity: C2
> =

> Actually this is not a TODO item. That is a modem plugin specific
> detail. If your modem (CDMA or not) doesn't supports such features,
> then
> don't enable the atoms for it.
> =

> So I say that this already supported ;)
> =


I do agree, besides, some atoms such as call-barring, call-setting ...
Need do a little change, we need to disable the USSD watch and SSN watch et=
c.

> > +- Add call forwarding, call waiting, network registration
> > implementation for CDMA.
> > +
> > +  Priority: High
> > +  Complexity: C4
> =

> This is more like add CDMA specific atom drivers for netreg etc. That
> these are CDMA specific is more a minor detail.
> =

> I like to hear Denis comment on his, but first guess would be that this
> should be done as drivers/cdmamodem/...
> =

These features in CDMA are very different from that in GSM. Call forwarding=
 and call waiting
are achieved by dial a specified number(feature code). In CDMA system, the =
modem =

will always auto register network, but in GSM system, there are different r=
egister modes,
and can scan neighbor networks. =


So we would like implement them in separate files such as cdma_call-forward=
ing.c ...
But not base on current implementation.

> > +- Change radio setting, SIM manager, SMS manager, voice call manager,
> > Data Connection
> > +  Manager to make them support both GSM and CDMA
> > +
> > +  Priority: High
> > +  Complexity: C8
> =

> I think you have to be a bit more specific here. Maybe it is a good
> idea
> to split them into separate items.
> =

> Regards
> =

> Marcel
> =


Yes, we do agree. We will do it. =


Generally, before do any change, we will sent out the proposed solution,
and collect the suggestion first.


Best regard,

Caiwen =






--===============8561072060099957925==--

