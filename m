Content-Type: multipart/mixed; boundary="===============5089602604420260813=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: HSP/HFP ofono bluetooth support for Linux desktop
Date: Thu, 13 Feb 2020 12:14:06 -0600
Message-ID: <6679dd2b-4780-e44f-b86d-28cf65638888@gmail.com>
In-Reply-To: <20200213174621.e2q4ryu36p5ericx@pali>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5089602604420260813==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pali,

> Used by who? Gateway role is fully broken and client (hfp) role is used

I guess that depends on your perspective.  I've already pointed out that =

the desktop 'AG' use case was never something we needed to implement. =

If you want to fix oFono to do that, great.  If you want to write your =

own daemon to do this, also great.

> probably only by some power users. Also there is no support for mSBC in
> pusleaudio.

Why is oFono at fault for this?  Genuine question.  What are the =

roadblocks to mSBC support?

> =

> So, no, really it is not used.
> =

>>> Main objection for handsfree-audio-api.txt is that it does not provide
>>> information about locally used codec and somehow mixes air codec and
>>> local codec. In my hsphfpd.txt I used term "AgentCodec" for bluetooth
>>> local codec and term "AirCodec" for bluetooth air codec format.
>>
>> Okay.  But, just FYI, at the time there was no hw that could do such
>> on-the-fly conversions, so this use case wasn't considered/implemented.
> =

> This cannot be truth as probably every bluetooth HW is doing on-the-fly
> conversion between CVSD and PCM. I was not able to find HW which allows
> me to send raw CVSD samples...

At the time this was all done in software.  Alternatively, the hardware =

was directly wired between the sound card / modem and the bluetooth =

chip.  So just opening the SCO socket was enough.

>> True.  In retrospect we probably should have used strings.  But it was
>> assumed that vendor extensions would go via the Bluetooth SIG Assigned
>> Numbers facility.  Anyhow, we can always add a 'Register2' method that c=
ould
>> take codecs as a string array or a combination of strings & ints. And if
>> Register2 was used, then use 'NewConnection2' with a signature that supp=
orts
>> passing in vendor codecs and whatever else that might be needed.
> =

> This is still not enough. Audio application (e.g. pulseaudio) need to
> register AgentCodec, not AirCodec. And current API is somehow mixed.
> Audio application needs to know what is the format which bluetooth chip
> sends to userspace (PCM? mSBC? CVSD? PCMA? AuriStream?) and which format
> bluetooth chip expects. I named this AgentCodec.

So how do you negotiate the 'AgentCodec'?  Does BlueZ expose this =

information?  If so, how? SCO socket option or ...?

>>> And also API does not provide socket MTU information or ability to
>>> change/specify which codec would be used.
>>
>> There was no need, we automatically defaulted to using Wide band if
>> available.  Third party codecs are a new use case (for oFono HFP), so wo=
uld
>> require an API extension.
> =

> MTU is needed also for mSBC codec if encoding is done in software
> (pulseaudio). Without it, this wide band support in ofono is unusable
> for pulseaudio.

Isn't the MTU obtained from the SCO socket itself?  How is oFono at =

fault here?

> =

> And also API extension for choosing codec. Also for choosing if software
> of hardware encoding would be used. We know that there are lot of broken
> devices in different way and it is really needed for either blacklist
> some codec or switch between hw and sw encoding if something strange
> happen. Without it pulseaudio is not going to support more codes then
> default required (CVSD).

This seems to be a kernel / device driver / firmware  issue and should =

be solved at that level.

> =

>>>
>>> Non-audio APIs which are needed to export (for both HSP and HFP profile=
s):
>>>
>>> * battery level (0% - 100%)
>>> * power source (external, battery, unknown)
>>> * ability to send "our laptop" battery level and power source to remote=
 device
>>> * send text message to embedded display
>>> * process button press event (exported via linux kernel uinput)
>>>
>>
>> I think all of these are feasible to support under the current oFono
>> structure, either via plugins or API extensions.
> =

> Ok. Are you going to implement them?
> I think that all of these are missing parts in ofono and something which
> is needed to be implemented for desktop/laptop HSP and HFP profile
> support.
> =


There are no plans to do this at the moment.

Regards,
-Denis
--===============5089602604420260813==--

