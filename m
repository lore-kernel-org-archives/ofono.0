Content-Type: multipart/mixed; boundary="===============3289925501145675013=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: HSP/HFP ofono bluetooth support for Linux desktop
Date: Wed, 12 Feb 2020 15:29:04 -0600
Message-ID: <57639029-7588-956b-8e3c-a2a6ed11b758@gmail.com>
In-Reply-To: <20200108212537.zs6pesil2vjguvu6@pali>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3289925501145675013==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pali,

On 1/8/20 3:25 PM, Pali Roh=C3=A1r wrote:
> Hello!
> =


Somehow this went straight to my Junk folder, so I didn't see this =

message at all until now.

> =

> Audio application (e.g. pulseaudio) really do not want to handle two
> separate services to monitor and process HSP/HFP devices. >
> For audio application are HSP and HFP devices equivalent, they provide
> same features: SCO socket, API for controlling microphone and speaker
> gain; plus optionally specify used codec.
> =

> So having two separate services which fully divided for audio
> application purpose does not make sense.
> =

> So it is possible that both HSP and HFP audio cards would be available
> via one audio API? Because I do not see how it could be done via design
> like dundee.
> =


One API sure.  Maybe on multiple services.  Honestly, I don't see why =

this would be such a burden for PA to watch 2 dbus services instead of =

1.  From oFono perspective it would make more sense to keep the HSP part =

a separate daemon.  I could be convinced otherwise if it is indeed a big =

burden for PA...

>> You can then implement the same API interfaces for setting up the HSP au=
dio
>> stream as oFono does today (i.e. https://git.kernel.org/pub/scm/network/=
ofono/ofono.git/tree/doc/handsfree-audio-api.txt),
> =

> This API is unusable for both HSP and HFP audio streams. In pulseaudio
> it is somehow used, but it is not suitable.
> =


Funny.  "It is used but not suitable"?

> Main objection for handsfree-audio-api.txt is that it does not provide
> information about locally used codec and somehow mixes air codec and
> local codec. In my hsphfpd.txt I used term "AgentCodec" for bluetooth
> local codec and term "AirCodec" for bluetooth air codec format.

Okay.  But, just FYI, at the time there was no hw that could do such =

on-the-fly conversions, so this use case wasn't considered/implemented. =

There's really no reason why we couldn't extend our APIs to handle this.

> =

> Another objection against handsfree-audio-api.txt API is that it is
> bound to HF codecs (via number) and does not support for pass e.g. CSR
> codecs.

True.  In retrospect we probably should have used strings.  But it was =

assumed that vendor extensions would go via the Bluetooth SIG Assigned =

Numbers facility.  Anyhow, we can always add a 'Register2' method that =

could take codecs as a string array or a combination of strings & ints. =

And if Register2 was used, then use 'NewConnection2' with a signature =

that supports passing in vendor codecs and whatever else that might be =

needed.

> =

> What is completely missing in that API is controlling volume level.
>

It is there on the CallVolume interface

> And also API does not provide socket MTU information or ability to
> change/specify which codec would be used.

There was no need, we automatically defaulted to using Wide band if =

available.  Third party codecs are a new use case (for oFono HFP), so =

would require an API extension.

> =

> Non-audio APIs which are needed to export (for both HSP and HFP profiles):
> =

> * battery level (0% - 100%)
> * power source (external, battery, unknown)
> * ability to send "our laptop" battery level and power source to remote d=
evice
> * send text message to embedded display
> * process button press event (exported via linux kernel uinput)
> =


I think all of these are feasible to support under the current oFono =

structure, either via plugins or API extensions.

Regards,
-Denis
--===============3289925501145675013==--

