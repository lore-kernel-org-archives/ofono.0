Content-Type: multipart/mixed; boundary="===============2295632247993348047=="
MIME-Version: 1.0
From: andrzej zaborowski <balrogg@gmail.com>
Subject: Re: Ofono with Sagem Hilo GPRS
Date: Wed, 02 Jun 2010 00:23:34 +0200
Message-ID: <AANLkTim8qzJju99GdsaokKFg9jFWkYicnadzo_sGuCdt@mail.gmail.com>
In-Reply-To: <201006011713.13937.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2295632247993348047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 2 June 2010 00:13, Denis Kenzior <denkenz@gmail.com> wrote:
>> If the device doesn't have a removable card, and there's a
>> vendor-specific PROACTIVE COMMAND notification then there's no point
>> polling. =C2=A0If the card is removable and modem doesn't support AT+CSI=
M,
>> we can send the status through AT+CRSM instead, maybe
>> atmodem/sim-poll.c should have a quirk for that.
>
> I think we should assume that vendor specific STK notifications and non-
> removable cards are the default, not the other way around.

The problem with the vendor specific notifications is we don't know
what they are (in atgen).  Whereas it costs nothing to talk to the
card directly.  This assumes that the modem will not read the
proactive commands out of the card before us, if we don't tell it to.
We probably would also need to do the profile download for this to
work.  All in all I agree the polling should stay, atleast until it's
done correctly.

Cheers

--===============2295632247993348047==--

