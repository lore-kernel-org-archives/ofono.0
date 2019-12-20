Content-Type: multipart/mixed; boundary="===============3673279230220904890=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [pulseaudio-discuss] Proposal for a new API and usage of
 Bluetooth HSP and HFP profiles on Linux
Date: Fri, 20 Dec 2019 21:22:25 +0000
Message-ID: <76f1cb25-b608-e4e9-6fd9-8da932c56a15@gmail.com>
In-Reply-To: <20191219153344.hxnoa3idqvgdwrp2@pali>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3673279230220904890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pali,

>> There have been one or two implementations of AG role fully external to
>> oFono.  These implementations simply used the existing oFono APIs to dri=
ve
>> the modem.
> =

> bluez & pulseaudio developers told me that it would be a good idea to
> avoid implementing a new AT parser for telephony stack. And rather use
> ofono implementation for telephony part...

In my opinion there's nothing scary about AT parsing.  In fact that is =

the easiest part of this whole venture.  If you don't want to roll your =

own parser, you can borrow one from the oFono project.  We already =

solved this nicely in the form of the gatchat library.  You could =

incorporate this into your project (if it is GPL compatible).  Or you =

could wait until we port gatchat to ell which will be under LGPL license.

> =

> But if I should use existing DBus API provided by ofono, it means that I
> need to do parsing of all AT commands (including telephony) and
> translate them to ofono DBus API.

I think you will need to do this regardless.  Otherwise I fail to see =

how you prevent one 'agent' from consuming AT commands it shouldn't be. =

This is a possibility you need to consider, whether it happens by =

accident or maliciously.

> =

> I agree, this should work and there is not need to modify ofono. But it
> means that in hsphfpd daemon I need to have full AT parser for all
> telephony commands and it was something which bluez / pa developers
> thought that should be avoided. Therefore I come up with idea that
> telephony commands would be handled by external Telephony Agent, which
> can be ofono.

Understood.  But I think the metric function was selected =

inappropriately in this case.  My opinion is that you should have =

started with what the overall architecture should look like; you should =

not have based design decisions on which parts might be a little hard to =

implement.

> =

>> You could do that.  But as I said, we rejected such a design a
>> long time ago due to complexity and other issues.
> =

> Anyway, what is the problem with accepting modem socket in ofono via
> DBus and starts talking with it like with any other modem which ofono
> supports? Currently ofono already takes modem socket from bluez via DBus
> API, so in same way hsphfpd can pass modem socket to ofono. Basically
> ofono then can reuse same code which already uses for sockets from
> bluez, just it do not have to parse and interpret audio related AT
> commands (as these are handled by hsphpfd itself).
> =

> What are exact issues? I do not see complexity at ofono part (as has
> already everything implemented) and currently I do not see those "other"
> issues.

The issues are many.  And really the question is not whether it 'could =

be' done, but whether it 'should be' done.  Let me describe a couple =

examples:

- In the case of HF role (1), oFono already provides all the necessary =

APIs.  So put yourself in oFono's maintainer shoes.  What would we gain =

by supporting almost the same but different mechanism?  We would have to =

introduce a new hfp_hf plugin, one that is almost identical, but =

different to hfp_hf_bluez5 plugin.  These two plugins would have =

coexistence issues, which would add more complexity.  Then there's the =

impact on PulseAudio and other users.  How do they know when to use the =

HandsfreeAudio API vs some external API?  Supporting this new way buys =

us a lot of extra code / complexity with no value added.

- The other example is more practical. HFP Service Level Connection =

(SLC) establishment is actually quite tricky.  There are certain =

limitations on what can and cannot be done prior to SLC establishment, =

including how audio handling is done.  Unfortunately, codec negotiation, =

indicator negotiation, and feature negotiation are part of the SLC. =

oFono already solves all of this and handles all of it nicely.  We have =

passed all relevant certification testing.  It is very unclear how you =

plan to handle this (or whether you realistically even can) in your =

architecture when the responsibilities are split between the various =

daemons.  So again, oFono has nothing to gain here...

> =

> You suggested to use phone simulator together with ofono and then
> starts extending / patching phone simulator to supports all needed parts
> which are in my hsphfpd design (battery status, button press, codec
> selection)?
> =


Not quite.  I suggested you expand oFono's emulator implementation (for =

AG role) and its DBus APIs (for HF role) to support the new vendor =

specific features that you want.

Forget about the phone simulator, it is really irrelevant for what =

you're trying to accomplish.

> Also how to handle the main problem of phone simulator that it is too
> much complicated to setup it on desktop? Looking at the steps...
> =

> https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/B=
luetooth/#index5h2
> =

> ... that desktop user needs to run nontrivial commands in command like,
> plus creating configuration file only just to connect bluetooth headset
> is ridiculous and non-acceptable for desktop application.
> =

> If this problem is not fixed, ofono and phone simulator are not usable
> as "main" software implementation of HFP profile for usage of bluetooth
> headsets on Linux.

oFono was never advertised as solving the 'HFP AG without a modem' use =

case.  This is something we never had as a requirement / objective. =

Phonesim is a development tool.  So of course it isn't trivial to setup, =

it isn't meant to be used in production in the first place.  The use of =

phonesim described in the PA wiki, while creative, is a giant hack ;)

Basically it all boils down to the fact that nobody has stepped up all =

this time to solve a particular use case you care about.  But blaming =

oFono for this is misguided.

So, if you want to solve the HFP AG without a modem case I fully support =

your efforts.

Perhaps this can even be solved in oFono itself (since it already does =

90% of what you want) by making the modem requirement optional.  What we =

could do for example is to create a dummy modem if an AG connection is =

requested and no other suitable modems are detected in the system.  The =

resultant AG wouldn't have any call control capability, it could still =

be used for transferring audio data, battery, etc.  If you want to =

pursue this, we can brainstorm further.

Regards,
-Denis
--===============3673279230220904890==--

