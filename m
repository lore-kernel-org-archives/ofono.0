Content-Type: multipart/mixed; boundary="===============5853665586891194888=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [RESEND 3 PATCH 00/13] IPv6 Support
Date: Mon, 21 Mar 2011 10:59:26 +0200
Message-ID: <AANLkTikp5KjrX_p12GhQUOnog9HxaHXmsMfSZ8yAJ9MN@mail.gmail.com>
In-Reply-To: <4D8387CE.3050401@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5853665586891194888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2011/3/18 Denis Kenzior <denkenz@gmail.com>:
> Unfortunately that ship has sailed. =C2=A0Every vendor except Nokia uses =
AT
> command modems, or at least implements a (somewhat) full-featured AT
> backend.

Not quite the way I see things. There are notable exceptions to this,
for example, Qualcomm modems don't use AT commands but a proprietary
protocol.

That said, I think designing the modem driver API based on 27.007 was
a good design decision, but the real test of that decision hasn't
really been done yet. Of course you'll find AT modems mostly a good
fit, and in most cases the other protocols too. But calling it a
raving success without, say, QMI support is a bit premature.

Cheers,
Aki

--===============5853665586891194888==--

