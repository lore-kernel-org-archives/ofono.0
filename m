Content-Type: multipart/mixed; boundary="===============5569785919881888637=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 1/2] isimodem: fix problems in call state reporting
Date: Thu, 03 Feb 2011 15:01:52 +0200
Message-ID: <AANLkTi=ySjasQQNScdzmaQSqkScwXYqmCn=LNQOF2+K+@mail.gmail.com>
In-Reply-To: <1296598930-3093-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5569785919881888637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

2011/2/2  <Pekka.Pessi@nokia.com>:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
>
> Do not report early incoming calls.
>
> Report "disconnected" state separately.
>
> Call ofono_voicecall_disconnected() only after call id is released.
> ---
> =C2=A0drivers/isimodem/voicecall.c | =C2=A0 84 ++++++++++++++++++++++++++=
++++------------
> =C2=A01 files changed, 60 insertions(+), 24 deletions(-)

Patch has been pushed. Thanks!

Cheers,
Aki

--===============5569785919881888637==--

