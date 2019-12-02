Content-Type: multipart/mixed; boundary="===============5660230566517221845=="
MIME-Version: 1.0
From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: [pulseaudio-discuss] Proposal for a new API and usage of
 Bluetooth HSP and HFP profiles on Linux
Date: Mon, 02 Dec 2019 17:04:46 +0000
Message-ID: <508d35f29c2abc26af15e232a38d3ca53eb33706.camel@iki.fi>
In-Reply-To: <20191201185740.uot7zb2s53p5gu7z@pali>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5660230566517221845==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 2019-12-01 at 19:57 +0100, Pali Roh=C3=A1r wrote:
> Hello!
> =

> I'm sending this email to relevant mailing lists and other people who
> could be interested in it. (I'm not subscribed to all of ML, so please
> CC me when replying).
> =

> =

> I would like to open a discussion about a completely new way of handling
> Bluetooth HSP and HFP profiles on Linux. These two profiles are the only
> standard way how to access microphone data from Bluetooth Headsets.
> =

> =

> Previously in bluez4, HFP profile was implemented by bluez daemon and
> telephony HFP functionality was provided by either dummy modem, ofono
> modem or by Nokia's CSD Maemo modem.
> =

> In bluez5 version was modem code together with implementation of HFP
> profile removed. And let implementation of HSP and HFP profiles to
> external application.
> =

> Currently HSP profile is implemented in pulseaudio daemon to handle
> microphone and Bluetooth speakers. HFP profile is not implemented yet.
> =

> =

> HSP and HFP profiles use AT modem commands, so its implementation needs
> to parse and generates AT commands, plus implement needed state machine
> for it.
> =

> And now problem is that last version of HFP profile specification is too
> complicated, plus Bluetooth headsets vendors started to inventing and
> using of own custom extensions to HFP profile and AT commands.
> =

> Main problem of this "external" implementation outside of bluez is that
> only one application can communicate with remote Bluetooth device. It
> is application which received needed socket from bluez.
> =

> So in this design if audio daemon (pulseaudio) implements HFP profile
> for processing audio, and e.g. power supply application wants to
> retrieve battery level from Bluetooth device, it means that audio daemon
> needs to implement also battery related functionality.
> =

> It does not make sense to force power supply daemon (upower) to
> implement audio routing/encoding/decoding or audio daemon (power supply)
> to force implementing battery related operations.
> =

> =

> For handle this problem I would like to propose a new way how to use and
> implement HSP and HFP profiles on Linux.
> =

> Implement a new HSP/HFP daemon (I called it hsphfpd) which register HSP
> and HFP profiles in bluez and then exports functionality for all other
> specific applications via DBus API (API for audio, power supply, input
> layer, telephony functions, vendor extensions, etc...). So it would acts
> as proxy daemon between bluez and target applications (pulseaudio,
> upower, ofono, ...)
> =

> This would simplify whole HFP usage as applications would not need to
> re-implement parsing and processing of AT commands and it would allow
> more applications to use HFP profile at one time. And also it means that
> audio software does not have to implement telephony stack or power
> supply operations.
> =

> =

> I wrote a document how such DBus API could look like, see here:
> =

>   https://github.com/pali/hsphfpd-prototype/raw/prototype/hsphfpd.txt
> =

> =

> And also I implemented "prototype" implementation to verify that
> designed API make sense and can be really implemented. Prototype fully
> supports HSP profile in both HS and AG role, plus HFP profile in HF
> role. This prototype implementation is available here:
> =

>   https://github.com/pali/hsphfpd-prototype
> =

> Some other details are written in README:
> =

>   https://github.com/pali/hsphfpd-prototype/raw/prototype/README
> =

> =

> What do you think about it? Does it make sense to have such design?
> Would you accept usage of such hsphfpd daemon, implemented according to
> specification, on Linux desktop?
> =

> I would like to hear your opinion if I should continue with this hsphfpd
> design, or not.
> =

> =

> With this design and implementation of hsphfpd is possible to easily fix
> pulseaudio issue about power supply properties:
> =

>   https://gitlab.freedesktop.org/pulseaudio/pulseaudio/issues/722

I quite like this proposal. Avoiding the need to implement the button
press, battery level etc. handling separately in PulseAudio, oFono and
PipeWire seems like a pretty good justification to me. I assume you're
volunteering to maintain this new daemon?

It's not clear to me how this would affect the PulseAudio <-> oFono
interaction, if at all. When oFono is used, would PulseAudio get the
audio socket from oFono or hsphfpd? What about volume commands, would
they go through oFono or would PulseAudio interact with hsphfpd
directly?

I think hsphfpd should be part of bluetoothd, but if that's not
possible, then that's not possible.

(I don't want to get into a lengthy discussion about programming
languages, but I'll just note here that I don't like Perl.)

-- =

Tanu

https://www.patreon.com/tanuk
https://liberapay.com/tanuk

--===============5660230566517221845==--

