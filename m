Content-Type: multipart/mixed; boundary="===============3700571748740395909=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: How to handle pins?
Date: Fri, 23 Apr 2010 17:29:23 +0300
Message-ID: <u2l80fd4e751004230729l8745e56fqc9ab68911ffdbb77@mail.gmail.com>
In-Reply-To: <20100423135657.GB11437@gumpy.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3700571748740395909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/4/23 Daniel Wagner <daniel.wagner@bmw-carit.de>:
>> Anyway it is the issue we need to resolve. So I also copy it to oFono ma=
illist for comments. ;-)
>
> Okay. Is there a proper way to identify a SIM when it is still locked?
> I guess this can only be done by some guessworking.

The EF_ICCID should be always available. It is either an E.118 number
or 10 bytes of opaque data.

-- =

Pekka.Pessi mail at nokia.com

--===============3700571748740395909==--

