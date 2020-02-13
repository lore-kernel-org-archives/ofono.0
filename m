Content-Type: multipart/mixed; boundary="===============1025237620442724646=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: HSP/HFP ofono bluetooth support for Linux desktop
Date: Thu, 13 Feb 2020 13:08:56 -0600
Message-ID: <77397684-1c15-854e-b88b-4adff6f73ada@gmail.com>
In-Reply-To: <20200213183253.44vkm6bpddre4dvp@pali>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1025237620442724646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pali,

On 2/13/20 12:32 PM, Pali Roh=C3=A1r wrote:
>> At the time this was all done in software.
> =

> CVSD was never done in software. Always in hardware. As said, even now I
> was not able to find bluetooth HW which would allow to do CVSD in softwar=
e.
>

I don't remember the exact details.  I seem to remember that for mSBC =

the conversion was being done on the host and no 'on-the-fly' conversion =

was done in hardware.  Thus this host codec negotiation was not needed / =

considered.

https://lists.ofono.org/hyperkitty/list/ofono(a)ofono.org/message/6CUFGDPUJ=
BRIZA4GUVFD2EPOET25XTN3/

>> So how do you negotiate the 'AgentCodec'?  Does BlueZ expose this
>> information?  If so, how? SCO socket option or ...?
> =

> It is done by HCI commands, therefore by kernel. There is discussion for
> exporting userspace <--> kernel API to allow setting arbitrary
> configurations for codecs supported by bluetooth HW.
> =

> Getting list of supported codecs can be done by this script:
> https://github.com/pali/hsphfpd-prototype/blob/prototype/sco_features.pl
> (needs to be run as root)

So you might want to get BlueZ guys to expose this info properly first. =

oFono is not in the business of opening raw hci sockets.

>> Isn't the MTU obtained from the SCO socket itself?  How is oFono at fault
>> here?
> =

> Yes, via some ioctl it can be done. But bluez for other bluetooth
> profiles provides this information via dbus API. As bluez does not
> support HSP/HFP it expects that software which implement it, provide
> needed info

Only PA (or whatever implements the audio agent) really cares about this =

info and it can obtain it via getsockopt.  So I really don't see why the =

MTU should be exposed via D-Bus.  And this is why it wasn't.  I don't =

see an issue here...?

>>
>> This seems to be a kernel / device driver / firmware  issue and should be
>> solved at that level.
> =

> Why??? It is up to the application which owns SLC socket and this
> application needs to provide API for it. Codecs are negotiated via AT
> commands, so again only HFP / HSP daemon can do it.

So in my opinion it is really up to the kernel to tell us whether a =

given hardware supports wideband speech.  So any quirks need to go into =

the kernel.  Then userspace can select the best available codec =

automatically without resorting to having the user twiddle some settings.

> So, why should I even consider to use ofono at all? It does not support
> none of above desktop feature, it does not support extended codecs, it
> does not support HSP profile and also it does not support HFP profile
> without physical modem (majority of desktops and laptops).

Your initial proposal wanted to use oFono as some sort of helper for =

your daemon, and that is just not going to be accepted by oFono =

upstream.  I gave you a few alternatives, including how to extend oFono =

to do what you want.  If you want to roll your own, go for it.

Regards,
-Denis
--===============1025237620442724646==--

