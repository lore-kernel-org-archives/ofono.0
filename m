Content-Type: multipart/mixed; boundary="===============6526022466097984952=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Discussion on CTM enhancement
Date: Tue, 04 Jan 2011 14:02:58 -0800
Message-ID: <1294178578.5852.115.camel@aeonflux>
In-Reply-To: <8250E4885F9967469CAC3FB5CBA2CE69934E645C02@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6526022466097984952==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fred,

> As we are currently implementing the CTM modem driver for ifxmodem, I wou=
ld like to bring a couple of things in the discussion.
> Today, patches for our modem driver are ready by before submitting them o=
n the mailing list, I have 2 items to discuss:
> =

> 1) First, it might a good proposal to merge the TextTelephony and the Aud=
ioSettings atoms. Enabling and disabling CTM on a platform require to confi=
gure the audio settings on the modem side (audio routing parameters changes=
). Today, in my patches, I have nearly the same code as the AudioSetting mo=
dem driver for configuring the audio. Another proposal would be that the Te=
xtTelephony atom indicates to the AudioSetting atom that CTM is enable or d=
isable but that would be good also to merge the 2.
> Any idea?

to be fairly honest, the CTM stuff is not my strong suit. The
AudioSettings atom was just designed to give PulseAudio the change to
handle the voice uplink/downlink setup and processing of the data. And
mainly only because following the call states is not enough.

So adding a parameter that indicates CTM might be a good idea. I am not
100% sure about this. So I am happy to hear thoughts from the audio
experts on this list.

The more and more I think about this, I come to the conclusion that we
might needed a better cmtspeech to PA interaction and not do this via
oFono at all. Something similar to what the ISI modem and cmtspeech
actually did. So that you have a proper signaling of types from the
kernel directly into PA and not just via oFono. Just an idea.

> 2) Secondly, I think that 2 properties can be added in the TextTelephony =
atom and/or the AudioSetting atom (or the "merged" atom described in 1). Th=
e first property is when the device receives an incoming CTM call. Even if =
the type is still a voice call, upper layers should be notified that the in=
coming is a TTY call to display some UI stuff or to turn on the TTY mode in=
 case the device is not already TTY enabled (this is totally UI dependant b=
ut at least we leave the flexibility to the UI to decide).
> The second property is for MO calls. Remote user can accept the call as a=
 TTY enable device or not. This is supported by the standard. In our case, =
we are receiving unsolicited AT commands "CTM CALL" when the remote party h=
as accepted the call as a TTY enabled device and "NO CTM CALL" when the rem=
ote has accepted the call but his device is not TTY enabled.

I think we need a property inside the voice call that indicates that
this is a TTY call. You have played with TTY hardware which I have not.

So we might need to figure what the UI requirement for TTY really is.
This is still pretty much unclear to me how this all needs to be
indicated to the actual impaired user. Any experts here?

Regards

Marcel



--===============6526022466097984952==--

