Content-Type: multipart/mixed; boundary="===============1578768135489577217=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Bluetooth HF role
Date: Thu, 01 Sep 2011 03:18:00 -0500
Message-ID: <4E5F3FB8.5030505@gmail.com>
In-Reply-To: <4E687C55.5030807@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1578768135489577217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

> =

> Before discussing the source code itself, I would like to know your
> opinion about the different alternatives that come into my mind.
> =

> When you talk about a new atom interface, we could:
> =

> a. Create an HFP interface that includes all bluetooth-specific
> extensions. This could something like org.ofono.Handsfree or
> org.ofono.HfpModem.

This is my preferred option.

> b. Be more consistent with the existing oFono API and split the new
> extensions into several interfaces, such as org.ofono.hfp.Modem and
> org.ofono.hfp.VoiceCallManager (and whatever else is needed). This
> second interface would support methods such as Redial() and
> AnswerAndHold().

I don't think this is a good idea, you lose much of the flexibility for
the applications; e.g. being able to implement the same API and work on
real modems, hfp devices, sap devices, etc.

Having said that, the +BTRH is a bit special.  I believe it is only
supported on CDMA networks, while the HFP protocol is modeled after the
GSM call model.  We might have to look into implementing it on
VoiceCallManager and tweak the GSM call state logic accordingly, which
won't be fun ;)  Any ideas are welcome here, I have no experience with
Response and Hold or access to networks with it enabled.

> c. If this second approach of hfp.VoiceCallManager is followed, we could
> not only include the extensions there, but also replicate the whole API
> in org.ofono.VoiceCallManager. Personally I would rather not do this,
> but it seems to me that org.ofono.cdma.CdmaVoiceCallManager has been
> designed that way.
> =


CDMA versions were designed this way because the CDMA call state machine
is dirt simple.  There didn't seem to be a need to make applications
deal with the complexity of the GSM API while having a much simpler
model underneath.

> My vote would be in favor of the first option, for the sake of simplicity.
> =

> What do you think? Any other alternative?

Nope, your proposal is in line with my current thinking.

Regards,
-Denis

--===============1578768135489577217==--

