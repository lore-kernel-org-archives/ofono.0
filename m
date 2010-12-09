Content-Type: multipart/mixed; boundary="===============5416454755385782691=="
MIME-Version: 1.0
From: Kai.Vehmanen@nokia.com
Subject: RE: [PATCH 0/5] Call Counters (2nd)
Date: Thu, 09 Dec 2010 20:52:22 +0100
Message-ID: <725063E4C37388418CDDC5A2C287906A20D08A1DCE@NOK-EUMSG-03.mgdnok.nokia.com>
In-Reply-To: <1291918228.30085.2.camel@aeonflux.mpl.access-company.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5416454755385782691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Marcel, =


On 09 Dec 2010, Marcel Holtmann wrote:
>> I share the concern for the IO/CPU cost, but I don't think it
>> matters much in which daemon this is done. Especially if some slack
>> is> allowed for the timers (which should be the case), ofonod will be
>> scheduled when the CPU is anyways woken up (e.g. modem/audio interrupts =

>> wake up pulseaudio). =

>
> this is not really true. We can not wakeup ofonod every single second.
> You might wanna start running powertop.

uhm, but I'm not claiming that. I was just stating that moving =

the timers to e.g. pulseaudio in this case won't save much if =

anything (the CPU will be woken up anyways, and the cost between =

scheduling ofonod or a thread from PA, has really no difference
to overall consumption.. the CPU is woken up anyways and roughly
the same code to handle the timer is run).

So whether this code is in oFono or elsewhere, does not matter
much (to overall power consumption). The main question is of course =

how often the counters are synced.

Personally I think the every-10sec interval is too short.
It's also highly system specific when wakeups start to get =

too costly, so picking up one value seems difficult.

br,
-- =

Kai Vehmanen


--===============5416454755385782691==--

