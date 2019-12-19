Content-Type: multipart/mixed; boundary="===============2545857764583791606=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [pulseaudio-discuss] Proposal for a new API and usage of
 Bluetooth HSP and HFP profiles on Linux
Date: Thu, 19 Dec 2019 15:01:50 +0000
Message-ID: <90261b42-1048-370f-7680-acd9f7e754ed@gmail.com>
In-Reply-To: <20191219095132.blj3oyyrlfowv5ik@pali>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2545857764583791606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pali,

>>> But would you accept patches which exports DBus API e.g. for displaying=
 text
>>> on HFP headset with embedded display? Or patches which implements 3
>>> different way for reporting battery level status of HFP headset? And API
>>> for sending "computer battery level" to HFP headset? Or implementing
>>> setup of SCO sockets (via RFCOMM layer) for custom codecs? Or exporting
>>> uinput linux device for button press events? Because all these
>>
>> So which roles are we talking about here?  Your Design document shows
>> hsphfpd registering for both HFP AG and HFP HF roles, but maybe this was=
 not
>> the intent?
> =

> My proposed hsphfpd is going to support both roles. Which means to
> implement whole HFP profile. So for connecting bluetooth headsets (when
> AG role is needed on desktop) and also for connecting mobile phones
> (when HF role is needed on desktop).
> =

> And my primary motivation is for bluetooth headsets as this is what are
> asking desktop and laptop users again and again that is missing on Linux
> systems.
> =

> So higher priority has AG role and slightly lower priority has HF role.
> =


So to summarize.  You have broadly 3 main use cases for HFP:

1. HF connecting to AG role.  Essentially a carkit role.  oFono does =

this pretty well already and has the APIs defined that cover up to HFP =

1.7.  Any vendor extensions can be easily added.  And some carkit =

manufacturers already use it.

2. AG role when you have a 'real modem' behind it.  oFono already =

provides everything needed for this scenario.

3. AG role when you don't have a real modem or you have some sort of =

VoIP use case.  oFono doesn't cover this case as you stated.

So I can see value in something that implements case #3.  But having =

said that, oFono will not be receiving AT commands from external daemons:
	- For case 1, it'd just be a rehash of what oFono does well already.  I =

reinvented a few wheels in my time, but doesn't mean I think this one =

should be.
	- The reasoning for case 2/3 I already covered upthread.

>> If you're talking about extending oFono APIs when it is acting as the HF
>> connecting to the AG, then codec setup APIs, etc are definitely something
>> that would be welcome.
>>
>> If you're talking about AG role, then that is different... In general, if
>> the oFono is in an AG role, then there should be nothing to configure and
>> there are no APIs for this role.
> =

> Codecs needs to be configured also in AG role. Before accepting SCO
> connection you need to configure SCO socket for correct codec. Also for
> vendor codecs it needs to be properly negotiated via AT commands.
>

Sure, but that doesn't mean they need an actual D-Bus API to be =

configured with.  You can simply extend oFono emulator to support =

whatever codecs you want and whatever custom AT command handling that =

you need.  If the HF requests the codec, then you use it.  There's no =

D-Bus API required here.  Again, take a look at how this is done in =

oFono today.

>> Such a design will get a NAK from me on the oFono side.  But don't let t=
hat
>> stop you.  You can simply invoke oFono APIs directly from your daemon.  =
No
>> need for any changes in oFono itself.  As mentioned above, I wouldn't
>> recommend it, but... :)
> =

> So if you are disagreeing with this design, can you propose alternative?
> Which would support needs for desktop users? Support for HSP profile (in
> AG role), support for HFP profile (in AG role), ability to parse and
> interpret needed AT commands. And later also HS and HF role of these
> profiles.
> =


There have been one or two implementations of AG role fully external to =

oFono.  These implementations simply used the existing oFono APIs to =

drive the modem.  You could do that.  But as I said, we rejected such a =

design a long time ago due to complexity and other issues.

Or you can ignore the call control aspects entirely...

But in the end, it is your architecture.  All I can do is point out =

(early in the process) what is and what is not acceptable to oFono upstream.

>>
>> Okay, I see now.  Yes, the above is correct.  My comments about not need=
ing
>> a modem device hold true only if oFono is in HFP HF role connecting to an
>> AG.
> =

> Ok. So I guess now you understood main problem. I thought it was
> obvious, but seems that bluetooth HFP is too complicated, so talking
> about it always needs more detailed explanation. Sorry for that if it
> was not clear from my side since beginning what are requirements for my
> setup.

Well it was a bit of reading comprehension fail on my part as well.  The =

two roles are really quite different, so precise language helps.

Regards,
-Denis
--===============2545857764583791606==--

