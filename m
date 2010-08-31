Content-Type: multipart/mixed; boundary="===============6083245706446570471=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH v2] Add CDMA extension tasks
Date: Tue, 31 Aug 2010 08:43:35 -0400
Message-ID: <1283258615.7452.18.camel@localhost.localdomain>
In-Reply-To: <D87B22B1FE8C0F479CA9BEAD6C25AAE8056A7655@ism-mail03.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6083245706446570471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

> > > +CDMA/EVDO
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =

> > so Denis and I are still discussing some basic details on how to
> handle
> > CDMA the right way. Especially in case you only have text SMS and
> > non-pdu based SIM Toolkit. I give you an update soon.
> > =

> =

> Is there any update? =


nothing substantial right now. If the modem manufactures only give you
text SMS and non-PDU STK, then we have some serious problems. oFono's
internal core talks only PDUs. You would have to do multiple level of
conversions to get oFono work with your hardware.

Personally I think the interface of your CDMA hardware is broken and
should not be used at all. The fact that nobody got text SMS into any
kind of consistent state and every single firmware out there has a
different bug is a huge problem for us. oFono has to work with every
single piece of hardware.

I thought that the pure binary interfaces like ISI are a challenge, but
that is nothing compared to what you are facing :(

Regards

Marcel



--===============6083245706446570471==--

