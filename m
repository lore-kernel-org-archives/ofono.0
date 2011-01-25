Content-Type: multipart/mixed; boundary="===============3042957029246873520=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: check if lock is locked after code input attempt
Date: Tue, 25 Jan 2011 14:09:25 -0600
Message-ID: <4D3F2DF5.7060408@gmail.com>
In-Reply-To: <1295969667.21031.209.camel@jussi-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3042957029246873520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

On 01/25/2011 09:34 AM, Jussi Kangas wrote:
> =

> Hi, Denis.
> =

>> So I'm mostly happy with this approach except that ofono_modem_reset is
>> too big of a hammer to use here.  We need something that drops us back
>> to pre-sim state without having to re-power on the device (which is what
>> reset does).
>>
>> Can you try using sim_inserted / sim_removed or maybe even be smarter
>> and do 90% of what sim removal does but without affecting information
>> which is already read.  So things like EFiccid, EFpl/EFlp, EFecc, etc.
>>
>> Regards,
>> -Denis
> =

> Dropping back to pre_sim is easy if I just call modem_change_state
> directly and not through ofono_modem_reset. Problem with that approach
> is how to come back to online state after PUK has been given without
> effort from client. Calling of ofono_modem_set_powered from
> ofono_modem_reset enables the situation where Ofono comes back online by
> itself after unblocking the pin. =

> =

> Original solution made by Marit did pretty much what u sound to be
> looking for now. In original solution ofono get's network "denied" state
> but all the APIs stay up since modem does not go to PRE_SIM state. But
> if client goes and tries to retrieve something from network or sim it
> get's error. And when PUK was given system went back online nicely and
> without any extra pushing from client side. =

> =

> So why PRE_SIM state? I suppose you are worried that user goes under
> different cell or network during denied state and ofono does not read
> all changed information? Or ofono client reads some cached information
> totally unaware that it's not online anymore? I haven't gone walking
> around with this thing to see how well it get's the new info when it
> returns from denied state to online in different network or cell so
> there might something.

My main concern here is that we do not expose functionality that is
actually not available.  That confuses the applications.  It might also
be that your SIM PUK state is semi-permanent (e.g. you don't know the
PUK, and being on hold with your operator makes you shudder)

So we should simply remove all the atoms that are not relevant and
'forget' all the information that is not available if the SIM PIN is not
known.

> =

> Playing with sim inserted sim removed states is plain wrong to me: What
> we have here has nothing to do with sim's presence. I have to
> investigate the sim remove functionality more before I can say for sure
> if there is something that could be reused. =


I agree that sim_inserted is not quite the right approach.  Re-using
parts of it would definitely be the right direction.

Regards,
-Denis

--===============3042957029246873520==--

