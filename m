Content-Type: multipart/mixed; boundary="===============4053016698736353898=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/8] Add AT driver for STK atom.
Date: Tue, 20 Apr 2010 16:32:15 -0500
Message-ID: <201004201632.16205.denkenz@gmail.com>
In-Reply-To: <i2kfb249edb1004201403saee6351eqc3df2260e1bff89e@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4053016698736353898==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Well, this is an "if" without "only then" so it doesn't tell us the
> meaning of Le being absent.  Additionally the whole passage is later
> invalidated in 11.2.2.2, so the SIM implementer really has all the
> possible options.

Hmm, I don't interpret it this way.  Le being absent means no response =

expected.  The '00' vs 'FF' is unclear, I agree there.

> =

> > The question really becomes, do we actually want a response and know wh=
at
> > to do with it?
> =

> We only use envelope in CBS data download right now which expects no
> response, we could indicate that in a parameter.

I suggest that we mention the Le confusion in the comment block and take ou=
t =

Le altogether since we can't do anything useful with the response data yet.=
  =

Once we're ready to implement this properly, then we can add Le and figure =
out =

wheter 'FF' or '00' or something else is required.

For a hint of what the response can be used for, see 3GPP 31.124.  It seems =

the response from the SIM has to be set into an RP-ERROR message and given =

back to the network...

Regards,
-Denis

--===============4053016698736353898==--

