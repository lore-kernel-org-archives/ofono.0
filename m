Content-Type: multipart/mixed; boundary="===============8867763180097372455=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 01/13] voicecall: __ofono_voicecall_send_tone internal api.
Date: Tue, 19 Oct 2010 17:34:43 +0200
Message-ID: <AANLkTin-cr8-W-jDOMbFf2WsTYYCZ4eMRUCBU7Vfwc_p@mail.gmail.com>
In-Reply-To: <4CBDB216.6080305@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8867763180097372455==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 19 October 2010 16:58, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Andrew,
>
>> So I gave this some thought now and made an implementation based on
>> the __ofono_voicecall_dial api, but I think that this old approach is
>> actually working better for us. =C2=A0There are a couple of scenarios
>> (let's consider only atmodem first)
>>
>> 1. Send DTMF - Cancel - Send DTMF
>>
>> in this case the second Send DTMF is going to return an error from the
>> driver (not from core voicecall.c). =C2=A0I don't think it's a big deal,
>> but we could think of something like cancelling the driver .send_tones
>> call, because the operation can potentially take a while -- this would
>> need a little change in the driver api.
>
> Why would this return an error from the driver? All current drivers will
> simply g_at_chat_send the next command, which will get appended to the
> queue and executed in turn.

In case of send_tone, we are always waiting for a timeout and not
doing anything because +VTS returns immediately.  In the patch 3 I
sent ([1]) we just check if vc->tr is non-null and this way we know
that we're already executing a send_tone, so we error out immediately.

1. http://lists.ofono.org/pipermail/ofono/2010-October/005065.html

>
> Command cancellation is not something I think will ever work. =C2=A0Most
> modems don't get this part right at all or have weird timing
> requirements which are impossible to get right.

Yes, but in this case we don't need to cancel an AT command, so
send_tone would be a special case.

>
>>
>> 2. Send DTMF - DBus command arrives,
>>
>> Now any DBus command (other than SendTone) will actually be sent to
>> the driver and executed. =C2=A0I think that's the correct thing to do --
>> the user needs to be able to end the call at any time. =C2=A0The tones
>
> This won't really work on any AT modem today. =C2=A0The ATH will be queued
> until after the AT+VTS is executed...

Yes, but again AT+VTS is executed immediately (on some modems anyway)
and the delay is not significant.

>
>> being emitted should not actually interfere with anything. =C2=A0The only
>> thing we need to do is respond to the STK command with an error if the
>> call is terminated before all tones finished being emitted.
>
> Hanging up while tones are active is a valid point though. Perhaps the
> core should be sending one tone at a time to make this feasible?

Either the core or the driver I guess (the initial patchset did all
the delays handling in the core, assuming that the driver->send_tone
returns immediately, and in the latest patches the delay was
implemented in atmodem according to some discussion we had on IRC,
though it was a while ago because I had some time off)

>
>>
>> 3. Modem is doing something and a Send DTMF stk command arrives,
>>
>> In this case the DTMFs will be delayed because of command
>> serialisation in gatchat / gisi. =C2=A0Should we return "terminal busy" =
to
>> the card instead?
>>
>> What do you think? =C2=A0What behaviour do we want?
>
> This one is tricky, as we don't really know what the outcome of the
> pending operation is. =C2=A0You also cannot rely on the queuing behavior =
in
> the driver. =C2=A0Remember, the driver is free to choose the multiplexing
> strategy, so nothing is preventing it from putting send_tones onto a
> different channel than CHLD/ATH/ATD/ATA. =C2=A0This is why the core is fa=
irly
> adamant about having 1 op outstanding at any one time.

In this case I think it doesn't seem so problematic because +VTS
doesn't occupy the channel for a long time.  So to comply with 102.223
it seems that all we need to do is:

* check if at the start of executing SendDTMF we are in a call.

* if yes, send the tones one after another with delays and let other
commands run as normal in between,

* once we've waited enough, return success if we're still in a call,
or failure if we're not in a call anymore.

What are your thoughts on this?

Best regards

--===============8867763180097372455==--

