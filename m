Content-Type: multipart/mixed; boundary="===============1979781033877575737=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: How to handle pins?
Date: Fri, 23 Apr 2010 17:33:58 +0200
Message-ID: <1272036838.22838.87.camel@localhost.localdomain>
In-Reply-To: <20100423152534.GA11782@gumpy.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1979781033877575737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

> > >> Anyway it is the issue we need to resolve. So I also copy it to oFon=
o maillist for comments. ;-)
> > >
> > > Okay. Is there a proper way to identify a SIM when it is still locked?
> > > I guess this can only be done by some guessworking.
> > =

> > The EF_ICCID should be always available. It is either an E.118 number
> > or 10 bytes of opaque data.
> =

> I have scanned through the ofono code and didn't find any references
> to ICCID. So there is no code reading that information out of the
> sim. Is that right? =


maybe we are just missing that information. Feel free to read these
details from the SIM card. Having the ICCID available is not a bad idea
since some providers use these as identification codes. At least it
happened to me once reading the ICCID from the iPhone menu was enough to
prove that it is my SIM card.

Regards

Marcel



--===============1979781033877575737==--

