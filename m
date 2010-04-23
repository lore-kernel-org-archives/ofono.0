Content-Type: multipart/mixed; boundary="===============1411776782778826055=="
MIME-Version: 1.0
From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: Re: How to handle pins?
Date: Fri, 23 Apr 2010 17:25:34 +0200
Message-ID: <20100423152534.GA11782@gumpy.localdomain>
In-Reply-To: <u2l80fd4e751004230729l8745e56fqc9ab68911ffdbb77@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1411776782778826055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 23, 2010 at 04:29:23PM +0200, Pekka Pessi wrote:
> 2010/4/23 Daniel Wagner <daniel.wagner@bmw-carit.de>:
> >> Anyway it is the issue we need to resolve. So I also copy it to oFono =
maillist for comments. ;-)
> >
> > Okay. Is there a proper way to identify a SIM when it is still locked?
> > I guess this can only be done by some guessworking.
> =

> The EF_ICCID should be always available. It is either an E.118 number
> or 10 bytes of opaque data.

I have scanned through the ofono code and didn't find any references
to ICCID. So there is no code reading that information out of the
sim. Is that right? =


Sorry for my complete ignorance on this topic. I was even unable to
download the right document from 3gpp.org which describes this part.

daniel

--===============1411776782778826055==--

