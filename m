Content-Type: multipart/mixed; boundary="===============5464873669896029912=="
MIME-Version: 1.0
From: Kai.Vehmanen@nokia.com
Subject: RE: [PATCH 0/5] Call Counters (2nd)
Date: Sun, 12 Dec 2010 16:46:32 +0100
Message-ID: <725063E4C37388418CDDC5A2C287906A20D09632C1@NOK-EUMSG-03.mgdnok.nokia.com>
In-Reply-To: <1291935199.30085.7.camel@aeonflux.mpl.access-company.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5464873669896029912==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Marcel,

I'll answer to two separates mails (of this thread) in one go:

On 10 Dec 2010, Marcel Holtmann wrote:
> Kai Vehmanen wrote:
>> So whether this code is in oFono or elsewhere, does not matter
>> much (to overall power consumption). The main question is of course
>> how often the counters are synced.
> =

> actually it does matter since you have no extra context switch and in
> addition you not accidentally wake up PA and then ofonod. You have one
> centralized wakeup of one thread.

You cannot do this with one thread wakeup. The real-time parts implementing =

voice data path in pulseaudio (and ones waking up to hw interrupts) need to =

follow soft-realtime practises to maximize execution determinism. I.e. thes=
e =

threads are run with SCHED_FIFO/RR and any calls to possibly-blocking syste=
m =

calls must be avoided (this includes dynamic memory allocation, access to =

file/sokcets, etc, etc). See e.g. JACK audio server project's guidelines fo=
r =

client apps for a good overview of what these limitations mean in practise.

Storing the call counters requires file/socket i/o, so doing this from =

a real-time thread is a big no-no (and if done anyways, would be a likely
cause to audio hickups).

So you need to wake up another thread in any case (e.g. PA has separate
threads for DBus and talking to PA clients). Of course an explicit
wake-up is better than relying on timer slack to coalesce the wakeup
of ofonod and pulseaudio, so I agree using a PA thread is technically
better and more robust way to ensure no extra wakeups occur, but if/when =

implemented properly, waking up ofonod really has no penalty either.

But the above is really a minor issue I think. I think the most
important argument against doing this in PA is (quoting my earlier
reply):

--cut--
- lots of modems still handle all audio and PA will know nothing
   about calls at all with these modems
--ct---

This needs to be done in a component that is tracking calls,
independently of what modem is used.

And then one further comment to a more recent mail in this thread:

On 12 Dec 2010, Marcel Holtmann wrote:
> is actually everybody in agreement here that we talk about actual time
> spent on the phone talking? Denis and myself clearly see it that this is
> a sensible approach to overall call counters.
>
> And if that is the case, then this maps closely to what PA has to track
> anyway.

No, no. Surely what matters are the individual calls, and their
state w.r.t. signaling. And this is what the patches Andras' has sent
are tracking.

PA on the other hand tracks the traffic channel state and that cannot be =

used. E.g. in common real-life cases (handovers), the traffic channel can =

be temporarily disconnected during an active call (PA will see this, but =

it is _not_ visible in either the phone UI nor in billing). For to PA =

to implement call counters, it would have to be extended to track individua=
l =

call state. =


Br,
-- =

Kai Vehmanen


--===============5464873669896029912==--

