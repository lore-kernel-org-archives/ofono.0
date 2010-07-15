Content-Type: multipart/mixed; boundary="===============2105195100156998305=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 00/14][RESEND] STK patches without agent
Date: Thu, 15 Jul 2010 15:46:34 -0500
Message-ID: <4C3F73AA.7080603@gmail.com>
In-Reply-To: <AANLkTilVBUkiZnL6OXgkdZMGIflA4uhrnMH89uHzgZkh@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2105195100156998305==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>> All patches in this series have been pushed upstream with some
>> refactoring afterwards.  Please review and make sure I didn't screw
>> something up.
> =

> Thanks, just a small change to remove the seconds =3D=3D 0 check for Set
> Poll Interval.  Seconds can't be 0 or parsing would fail.  The logic
> behind the original code was:
> =

> Try to set the modem property to "seconds".
> If setting fails, then return the previous value (which is actually
> the nearest value we could accept).
> If getting previous value fails (function returns 0) then return 30
> secs, the default value, which also happens to be the nearest we could
> accept.
> =


Thanks for catching this.  Patch has been applied.

Regards,
-Denis

--===============2105195100156998305==--

