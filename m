Content-Type: multipart/mixed; boundary="===============4584261045127626577=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH] smsutil: do not hardcode TP-ValidityPeriod
Date: Fri, 17 Dec 2010 15:29:51 +0200
Message-ID: <AANLkTi=145vZAoZwZjJYoZY9mc0_aabmYJywCTjZw0_N@mail.gmail.com>
In-Reply-To: <4D0AB4F0.1040801@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4584261045127626577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2010/12/17 Denis Kenzior <denkenz@gmail.com>:
> Can I get a bit more of an explanation from you as to why the 'absent'
> validity period is better than hardcoding this to 24 hours?

If there is an explicit validity period, it overrides the default
validity period set by operator. I'd rather let operator-set default
validity period.

-- =

Pekka.Pessi mail at nokia.com

--===============4584261045127626577==--

