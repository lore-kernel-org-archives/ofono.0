Content-Type: multipart/mixed; boundary="===============1649807643717647218=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: How to handle pins?
Date: Fri, 23 Apr 2010 10:32:58 -0500
Message-ID: <201004231032.58875.denkenz@gmail.com>
In-Reply-To: <20100423152534.GA11782@gumpy.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1649807643717647218==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

> On Fri, Apr 23, 2010 at 04:29:23PM +0200, Pekka Pessi wrote:
> > 2010/4/23 Daniel Wagner <daniel.wagner@bmw-carit.de>:
> > >> Anyway it is the issue we need to resolve. So I also copy it to oFono
> > >> maillist for comments. ;-)
> > >
> > > Okay. Is there a proper way to identify a SIM when it is still locked?
> > > I guess this can only be done by some guessworking.
> >
> > The EF_ICCID should be always available. It is either an E.118 number
> > or 10 bytes of opaque data.
> =

> I have scanned through the ofono code and didn't find any references
> to ICCID. So there is no code reading that information out of the
> sim. Is that right?

oFono does not read the ICCID, it only reads the IMSI which is available af=
ter =

PIN has been unlocked.

> =

> Sorry for my complete ignorance on this topic. I was even unable to
> download the right document from 3gpp.org which describes this part.

3GPP 11.11 or ETSI TS 102.221

Regards,
-Denis

--===============1649807643717647218==--

