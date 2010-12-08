Content-Type: multipart/mixed; boundary="===============8626541885899084828=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 0/5] Call Counters (2nd)
Date: Wed, 08 Dec 2010 11:34:40 +0200
Message-ID: <AANLkTinYryk1jdhdVRXh1RXn5CvwrD_A8y2GPBcP0ZsK@mail.gmail.com>
In-Reply-To: <1291798984.4795.146.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8626541885899084828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2010/12/8 Marcel Holtmann <marcel@holtmann.org>:
> so Denis and I talked about this a little bit and I am not fine with
> this at all.

Next time, can you invite me to join your little talk?

> Lets take this one step and please explain to me what your requirements
> and objectives are. I also wanna see a top to bottom from UI down to the
> modem usage of this API.

We need a UI showing total MO and MT call times. They also need to be
able to be reset, if the user so wishes. The data needs to be
reasonably reliable.

> and consuming heavy IO with writing this information to disk. In
> addition to that there is no clear UI usage for the getter API.

What do you mean? Do you mean your iPhone has no such UI?

The reason these are not properties is just because it makes no sense
to update the counters "live". The UI can poll if it so wishes, but
the poll interval is not something we want to decide.

> What are the granularity there. What is the expected user experience
> with this API. I don't see any clear usage model here.
>
> In addition to that, what is the problem with just updating the stats
> after the call has ended?

Because if your battery runs out in the middle of a 4 hour conference
call, your timers are not updated and become worthless. Obviously,
this is a compromise between how reliable the counters are and how
many wakeups and IO we can bear.

Andras has some data on what reasonable reliability here means.

Cheers,
Aki

--===============8626541885899084828==--

