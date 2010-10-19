Content-Type: multipart/mixed; boundary="===============2081589522576031418=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/13] voicecall: __ofono_voicecall_send_tone internal api.
Date: Tue, 19 Oct 2010 10:59:52 -0500
Message-ID: <4CBDC078.7080909@gmail.com>
In-Reply-To: <AANLkTin-cr8-W-jDOMbFf2WsTYYCZ4eMRUCBU7Vfwc_p@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2081589522576031418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/19/2010 10:34 AM, Andrzej Zaborowski wrote:
> On 19 October 2010 16:58, Denis Kenzior <denkenz@gmail.com> wrote:
>> Hi Andrew,
>>
>>> So I gave this some thought now and made an implementation based on
>>> the __ofono_voicecall_dial api, but I think that this old approach is
>>> actually working better for us.  There are a couple of scenarios
>>> (let's consider only atmodem first)
>>>
>>> 1. Send DTMF - Cancel - Send DTMF
>>>
>>> in this case the second Send DTMF is going to return an error from the
>>> driver (not from core voicecall.c).  I don't think it's a big deal,
>>> but we could think of something like cancelling the driver .send_tones
>>> call, because the operation can potentially take a while -- this would
>>> need a little change in the driver api.
>>
>> Why would this return an error from the driver? All current drivers will
>> simply g_at_chat_send the next command, which will get appended to the
>> queue and executed in turn.
> =

> In case of send_tone, we are always waiting for a timeout and not
> doing anything because +VTS returns immediately.  In the patch 3 I
> sent ([1]) we just check if vc->tr is non-null and this way we know
> that we're already executing a send_tone, so we error out immediately.
> =

> 1. http://lists.ofono.org/pipermail/ofono/2010-October/005065.html
> =


I honestly haven't looked at this patch yet, but it seems to be a bit
crazy to duplicate in all voicecall drivers, which we have many of these
days.  We should really solve this in the core.  About the only thing we
can force drivers to do is return from send_tone when the tone has finished.

I also don't really see relying on the driver to tell the core it is
busy in send_tones as the right thing to do here.

>> This won't really work on any AT modem today.  The ATH will be queued
>> until after the AT+VTS is executed...
> =

> Yes, but again AT+VTS is executed immediately (on some modems anyway)
> and the delay is not significant.

This isn't the case on IFX for example, which delays the OK until all
the tones have been sent.

>> This one is tricky, as we don't really know what the outcome of the
>> pending operation is.  You also cannot rely on the queuing behavior in
>> the driver.  Remember, the driver is free to choose the multiplexing
>> strategy, so nothing is preventing it from putting send_tones onto a
>> different channel than CHLD/ATH/ATD/ATA.  This is why the core is fairly
>> adamant about having 1 op outstanding at any one time.
> =

> In this case I think it doesn't seem so problematic because +VTS
> doesn't occupy the channel for a long time.  So to comply with 102.223
> it seems that all we need to do is:

Honestly I think we should make it mandatory for the send_tone operation
to tell us when it is done.  If it returns earlier than the actual tone
duration the driver has to take care of it.

> =

> * check if at the start of executing SendDTMF we are in a call.
> =

> * if yes, send the tones one after another with delays and let other
> commands run as normal in between,

We can probably check if we have active | held calls here and bail out
early if no calls are active.  Allowing other commands in between still
seems dangerous, but lets try it and see how it works out.

> =

> * once we've waited enough, return success if we're still in a call,
> or failure if we're not in a call anymore.
> =

Otherwise sounds good.

Regards,
-Denis

--===============2081589522576031418==--

