Content-Type: multipart/mixed; boundary="===============8282068906345971300=="
MIME-Version: 1.0
From: Tommi Kenakkala <tommi.kenakkala@tieto.com>
Subject: Re: ofono Digest, Vol 74, Issue 6
Date: Thu, 18 Jun 2015 15:11:33 +0300
Message-ID: <5582B575.6040100@tieto.com>
In-Reply-To: <mailman.1.1434481201.32187.ofono@ofono.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8282068906345971300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On 16.06.2015 22:00, ofono-request(a)ofono.org wrote:
> Date: Tue, 16 Jun 2015 11:53:33 -0500 From: Denis Kenzior
> <denkenz@gmail.com> To: ofono(a)ofono.org Subject: Re: ofono Digest, Vol

> Today LockedPins is emitted only as a result of locking or unlocking the
> PIN.  We can certainly look into emitting it when PinRequired is
> emitted.  Do you already have a patch for this handy?
Sure, coming up.

> Yes, this sounds like a bug.  We should always emit PinRequired on
> pin-enabled hotswaps.
Proposal sent

>> >OFONO_SIM_PASSWORD_INVALID was used because at startup it's the initial
> Actually, it isn't.  OFONO_SIM_PASSWORD_NONE is the initial value.
True. I incorrectly recalled value would be "0" which is what the struct =

is initialised to.

>> >Logs about use-case: remove & insert a pin-required usim card.
(...)
>> >There's an additional __ofono_sim_recheck_pin call seen here after
>> >ofono_sim_inserted_notify from driver to core trigger a password query.
>> >Now when I look at it I'm not sure if it's still needed, but
>> >nevertheless even if it's removed monitor-ofono does not show
>> >"LockedPins" or "PinRequired" being emitted
>> >(logs and code analysis confirm that).
...
>> >src/sim.c:__ofono_sim_recheck_pin()
> ??? This seems wrong.  Are you running upstream?  We should not be
> querying the PIN until after we read EFpl
...
 > Regards,
 > -Denis

Like I wrote the logs show an additional __ofono_sim_recheck_pin call =

but that's besides the point, the property signalling problem is still =

valid in upstream even when the extra __ofono_sim_recheck_pin is  removed.

Just FYI, it is there because upstream EFpl reading triggers password =

query, but sometimes at that time modem returns still an old value. As a =

workaround the driver needs to poke "core" ofono to re-query when it's =

updated. But let's not focus to that, we're not upstreaming that :)

Let's continue the discussion in the patch thread,
thanks
-- =

Tommi

--===============8282068906345971300==--

