Content-Type: multipart/mixed; boundary="===============3666587236023623145=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: Ofono CF states not always correct
Date: Tue, 18 Jan 2011 23:08:34 +0200
Message-ID: <AANLkTinjZLt2=Od7ysOv9mwCVSVg9QCftNQnqetfDHK1@mail.gmail.com>
In-Reply-To: <4D35B83E.8060609@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3666587236023623145==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

HI Denis,

2011/1/18 Denis Kenzior <denkenz@gmail.com>:
> Ok, so I'm convinced we're not handling this properly. =C2=A0Based on your
> testing and my own independent testing setting the Unconditional CF rule
> does indeed 'hide' all other rules so they appear inactive.
>
> So do you care to come up with a patch fixing this? =C2=A0Briefly thinking
> about this I believe we can implement option 2 from your earlier email.

I've yet to see a network which sends forwardingFeatureList for
conditional CFs if unconditional CF is active, they just tell that the
unconditional CFs are, uh, quiescent.

Try your self, do you get anything sensible from *#67# if you have CFU
active? (Like after step #4 above?)

> =C2=A0I'd rather play some tricks and not clear the cache unless really
> necessary.

I just don't see any option but clearing the cache. Of course, we can
optimize by the fact that CFU makes  conditional CFs
inactive/quiescent.

-- =

Pekka.Pessi mail at nokia.com

--===============3666587236023623145==--

