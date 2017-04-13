Content-Type: multipart/mixed; boundary="===============5126051196029580178=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/8] lte: activate default bearer on network registration
Date: Thu, 13 Apr 2017 10:14:23 -0500
Message-ID: <1a742fa1-e303-3810-60ae-18a5c1bf1770@gmail.com>
In-Reply-To: <02fc8ecc-c8d9-94cc-6eef-a1e9d83742ad@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5126051196029580178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

>> Alright, I'm going to explain my understanding of how this works:
>>
>> When the QMI modem registers to an LTE network, it negotiates a
>> default bearer using the "default settings".  The default settings are
>> taken from the QMI WDS "default profile" which is presumably profile 1
>> by default.
>>
>> Even though the network registration has taken place and the bearer is
>> in place, the QMI modem doesn't bring up the network interface.
>> Calling "get current settings" at this point gives you nothing.
>>
>> At this point, you need to bring up the network interface by calling
>> "Start network".  Start network takes a bunch of parameters but these
>> parameters are all ignored since the bearer is already set up.
>>

Sounds like some 'creative thinking' from Qualcomm guys ;)  But so far =

this makes sense.  The parameters are already set in stone.  For QMI, =

the .read_settings method should be also bringing up the network =

interface, e.g. 'Start network' in your case.  For ublox devices the =

network device flows packets as soon as the context is active...

>> I haven't tested this, but I suspect that calling "Start network" for
>> the same profile again will fail...???  A profile number corresponds
>> to a Context ID...???  Maybe...
>

I would imagine that a profile has the same meaning as the 27.007 =

equivalent of +CGDCONT <cid>

> I tested this and "start network" fails when attempting to connect a
> profile a second time.
>

Makes sense.  Do note that the same APN can be (in theory) double, =

triple, etc activated.  But this requires a separate cid for each instance.

>>
>> If you need a specific setting for the default bearer (like APN), you
>> need to set it in the default profile before registering to the
>> network.  This is what the LTE atom must take care of... and, hence,
>> the atom must be created
>> before setting the modem online.

Correct.  This is what .set_default_attach_info does.  lte atom should =

be created in post_sim.

>>
>> For non-LTE, the bearer isn't set up until "Start network" is called,
>> so the usual context parameters can be passed to it at that time.  Any
>> parameters that are omitted are taken from the default profile.
>>

Again, sounds right.

>> Given all of the above, for QMI this means:
>>
>> i)  When the netreg atom detects registration to an LTE network then
>> we can call "Start network" immediately.

gprs atom driver needs to tell ofono core that a context is active. =

This means gprs driver should call ofono_gprs_cid_activated

>> ii)  Start network will give us the packet-handle for the default
>> bearer.  This can be held by the netreg atom.

why netreg atom?  This should be managed by gprs-context.

>> iii)  The packet handle survives until the network becomes
>> unregistered (even through a transition to UMTS,GPRS,etc networks).
>> iv)  There is never any reason to call "Stop network" for the default
>> bearer because a network unregistration will achieve the same thing.
>> If the network becomes unregistered we can throw away the packet
>> handle.  The gprs-context associated with the default bearer won't
>> know the packet-handle, so we need to make sure it doesn't try to call
>> "Stop network" for it's instance... but that's a detail, I think.
> Point iv) is wrong... we need to release the packet handle using "stop
> network" when the bearer goes away.

Much of this has to be handled by the driver.  E.g. the driver has to =

detect that a default bearer has been activated.  Then:
1. call ofono_gprs_cid_activated
2. Step 1 in turn assigns a context and calls .read_settings
3. .read_settings should setup the active context and call 'start network'
4. When a context is de-activated for whatever reason, gprs-context =

driver needs to clean up, e.g. call 'stop network'.
>
> /Jonas
>
>> It seems that there exists a method to change the default profile
>> number... it's undocumented, though, AFAICT.
>>
>> What's a bit unclear to me, though, is how this interacts with network
>> technology transitions... what happens when I move out of LTE coverage
>> and into a UMTS/GPRS network?

The context should survive and keep going.  If it doesn't, then the =

network / model should tell us that a context is no longer active. =

There must be some notification to that effect.

Regards,
-Denis

--===============5126051196029580178==--

