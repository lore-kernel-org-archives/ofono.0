Content-Type: multipart/mixed; boundary="===============4700763994679115080=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/13] voicecall: __ofono_voicecall_send_tone internal api.
Date: Tue, 19 Oct 2010 09:58:30 -0500
Message-ID: <4CBDB216.6080305@gmail.com>
In-Reply-To: <AANLkTimx4b7OR0wqzHv-J7wfbP5JN2m2RL71cVNbe6o8@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4700763994679115080==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> So I gave this some thought now and made an implementation based on
> the __ofono_voicecall_dial api, but I think that this old approach is
> actually working better for us.  There are a couple of scenarios
> (let's consider only atmodem first)
> =

> 1. Send DTMF - Cancel - Send DTMF
> =

> in this case the second Send DTMF is going to return an error from the
> driver (not from core voicecall.c).  I don't think it's a big deal,
> but we could think of something like cancelling the driver .send_tones
> call, because the operation can potentially take a while -- this would
> need a little change in the driver api.

Why would this return an error from the driver? All current drivers will
simply g_at_chat_send the next command, which will get appended to the
queue and executed in turn.

Command cancellation is not something I think will ever work.  Most
modems don't get this part right at all or have weird timing
requirements which are impossible to get right.

> =

> 2. Send DTMF - DBus command arrives,
> =

> Now any DBus command (other than SendTone) will actually be sent to
> the driver and executed.  I think that's the correct thing to do --
> the user needs to be able to end the call at any time.  The tones

This won't really work on any AT modem today.  The ATH will be queued
until after the AT+VTS is executed...

> being emitted should not actually interfere with anything.  The only
> thing we need to do is respond to the STK command with an error if the
> call is terminated before all tones finished being emitted.

Hanging up while tones are active is a valid point though. Perhaps the
core should be sending one tone at a time to make this feasible?

> =

> 3. Modem is doing something and a Send DTMF stk command arrives,
> =

> In this case the DTMFs will be delayed because of command
> serialisation in gatchat / gisi.  Should we return "terminal busy" to
> the card instead?
> =

> What do you think?  What behaviour do we want?

This one is tricky, as we don't really know what the outcome of the
pending operation is.  You also cannot rely on the queuing behavior in
the driver.  Remember, the driver is free to choose the multiplexing
strategy, so nothing is preventing it from putting send_tones onto a
different channel than CHLD/ATH/ATD/ATA.  This is why the core is fairly
adamant about having 1 op outstanding at any one time.

My feeling here is that we should return busy for now and revisit this
decision if it ever becomes a problem.

Regards,
-Denis

--===============4700763994679115080==--

