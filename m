Content-Type: multipart/mixed; boundary="===============1132180967701298123=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH_v6 4/5] emulator: add request/release private network calls
Date: Mon, 30 May 2011 15:25:13 +0200
Message-ID: <4DE39AB9.1020206@linux.intel.com>
In-Reply-To: <4DDCDDF7.2020401@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1132180967701298123==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> I applied this patch, but have done heavy refactoring afterwards.
> Please review all my changes (~20 or so patches intermixed with yours)
> and make sure everything makes sense.  I lightly tested this
> functionality with gsmdial and everything seems to be performing well.
>
> However, please test it really well yourself, use valgrind and try every
> exceptional condition you can think of.
>

I see you have changed the way PPP packets exchange start, that was what =

was missing me.
Now we don't need anymore to copy into emulator structure the PN =

settings as we can directly
pass the values to the PPP stack.
I also forgot to use set_write_done to trigger the resume GAtPPP/suspend =

GAtChat.
It sounds ok to me.

I have tested it with Windows 7 DUN client and everything seems to work.
I have also found a way to test escape sequence from Windows 7 DUN client,
you just have to turn off your bluetooth adapter while you are connected =

to oFono DUN server.
It will send +++ --> ATH0 and turn the adapter off.

Kind regards,
Guillaume


--===============1132180967701298123==--

