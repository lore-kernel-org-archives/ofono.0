Content-Type: multipart/mixed; boundary="===============7275170908997852570=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [pulseaudio-discuss] Proposal for a new API and usage of
 Bluetooth HSP and HFP profiles on Linux
Date: Tue, 07 Jan 2020 17:39:10 +0000
Message-ID: <1eeea3f8-d06b-f774-c01d-1c7dbdb71c32@gmail.com>
In-Reply-To: <20191220224657.n4m6qkxa4sceau3l@pali>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7275170908997852570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pali,

<snip>

>> I think you will need to do this regardless.  Otherwise I fail to see how
>> you prevent one 'agent' from consuming AT commands it shouldn't be. This=
 is
>> a possibility you need to consider, whether it happens by accident or
>> maliciously.
> =

> Some subset of AT commands are needed to parse and interpret. But not
> telephony commands and having up-to-date internal telephony state.

Please think some more about what I said.  You will need to parse every =

AT command in your daemon, no way around that.  You are right that you =

do not need to keep track of the telephony state, but that is besides =

the point.  So if you need an AT parser anyway, the whole reasoning for =

the proposed architecture starts to look shaky.

<snip>

> =

>> - The other example is more practical. HFP Service Level Connection (SLC)
>> establishment is actually quite tricky.  There are certain limitations on
>> what can and cannot be done prior to SLC establishment, including how au=
dio
>> handling is done.
> =

> I know :-) I already implemented prototype implementation to check and
> see how complicated it is and if API make sense and how hard it is for
> agents (audio - pulseaudio) implement and maintain it.
> =

>> Unfortunately, codec negotiation, indicator negotiation,
>> and feature negotiation are part of the SLC. oFono already solves all of
>> this and handles all of it nicely.
> =

> CSR codecs are not supported nor implemented in ofono. It is more
> complicated as HFP codecs... and needs a new API for audio application.
> Another value which brings my hsphfpd is that it handles these CSR
> codecs and provide API for audio application to use them.
> =


Again, you're not addressing my main point.  Codec negotiation is part =

of SLC establishment.  SLC has both telephony and audio aspects. =

They're inseparable.  Your architecture fails to address this...

CSR codecs are not part of SLC and can be bolted on later.  I already =

told you that oFono can easily be changed to support this.

>> We have passed all relevant
>> certification testing.  It is very unclear how you plan to handle this (=
or
>> whether you realistically even can) in your architecture when the
>> responsibilities are split between the various daemons.  So again, oFono=
 has
>> nothing to gain here...
> =

> I was not thinking about certification. It is not something which I
> could do.... And also pulseaudio itself do not have certifications.

So again, no reason for us to get involved :)

Bottom line is there's no value for us in this architecture.  If you =

want to use the existing oFono APIs, that's fine.  But we're not adding =

a plugin for taking arbitrary AT commands from some other daemon :)

<snip>

>> Perhaps this can even be solved in oFono itself (since it already does 9=
0%
>> of what you want) by making the modem requirement optional.  What we cou=
ld
>> do for example is to create a dummy modem if an AG connection is request=
ed
>> and no other suitable modems are detected in the system.  The resultant =
AG
>> wouldn't have any call control capability, it could still be used for
>> transferring audio data, battery, etc.  If you want to pursue this, we c=
an
>> brainstorm further.
> =

> Well, if this would work automatically without any user interaction or
> without special setup, it seems to be usable.
> =

> But what is needed from this implementation in ofono? Basically API for
> each functionality designed in hsphfod daemon. And one of it is also
> support for HSP profile (with CSR and Apple extensions).

Start a separate thread on ofono for this.  I already gave you hints on =

how to solve the 'AG without a real modem' use case.  That would seem to =

be the biggest 'win' and it should be fairly easy to make this work.

> =

> I'm not against for it, but I thought that having functionality which is
> not related to telephony / modem you would not want to see in ofono
> project (like linux uinput layer for button events or API for displaying
> raw text on embedded display; or CSR audio codec negotiation).
> =

> So how do you see possibility to have also HSP profile in ofono? So have
> one place which would provide audio API for SCO? Because this is a big
> requirements from audio software side, to not use 4 different APIs to
> access SCO sockets (and its rfcomm / SLC configuration) in HSP and HFP
> profiles.
> =


HSP is a separate issue.  Maybe we can handle it like the 'dundee' =

daemon inside oFono (which handles Bluetooth DUN profile).  In other =

words have a dedicated daemon for hsp support that reuses the relevant =

bits of oFono and maybe exposes the same APIs (i.e the ones documented =

in doc/handsfree-audio-api.txt).  That would make life for PulseAudio =

pretty easy.

Regards,
-Denis
--===============7275170908997852570==--

