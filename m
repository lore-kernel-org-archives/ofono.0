Content-Type: multipart/mixed; boundary="===============1015044546919744063=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [pulseaudio-discuss] Proposal for a new API and usage of
 Bluetooth HSP and HFP profiles on Linux
Date: Thu, 19 Dec 2019 01:11:10 +0000
Message-ID: <0cfbe253-417c-e7c0-553a-abf360a80c9f@gmail.com>
In-Reply-To: <20191218213349.2ksew2wnhgu3peub@pali>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1015044546919744063==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pali,

> Yes, I see. Also there are devices without HFP support, only with HSP.
> pulseaudio support also these devices and pulseaudio is not going to
> drop support for them. Last time when I looked at ofono, it has no HSP
> support. Is ofono going to add support for HSP?
> =


No.

<snip>

> =

> But would you accept patches which exports DBus API e.g. for displaying t=
ext
> on HFP headset with embedded display? Or patches which implements 3
> different way for reporting battery level status of HFP headset? And API
> for sending "computer battery level" to HFP headset? Or implementing
> setup of SCO sockets (via RFCOMM layer) for custom codecs? Or exporting
> uinput linux device for button press events? Because all these

So which roles are we talking about here?  Your Design document shows =

hsphfpd registering for both HFP AG and HFP HF roles, but maybe this was =

not the intent?

If you're talking about extending oFono APIs when it is acting as the HF =

connecting to the AG, then codec setup APIs, etc are definitely =

something that would be welcome.

If you're talking about AG role, then that is different... In general, =

if the oFono is in an AG role, then there should be nothing to configure =

and there are no APIs for this role.  Things like reporting AG battery =

level to HFP headset are done directly using plugins.  See =

ofono_emulator_set_indicator and how this is done by upower.c for =

example.  I happily take patches for any additional features (codecs, =

etc) you want to support here.

But... oFono upstream has no interest in accepting forwarded AT commands =

from some external daemon if we're in AG role.  We rejected such a =

design years ago and nothing has changed.

AG role is already quite tricky to implement without additional =

complexity introduced by having multiple applications and IPC.  "Its =

your funeral" as the saying goes if you want to go that route.

<snip>

> I disagree here. Primary purpose of HFP for desktop users is ability to
> use bluetooth's microphone. And not telephony stack and its complicated
> features like call hold and others, which are in HFP used and
> implemented probably only in car kits.

So your primary goal here is to have the desktop play the role of the =

AG, purely so you can forward the audio from a headset out to whatever =

it is that you want.  And you want oFono (or some other daemon) to =

(optionally) handle the call related AT commands in the HFP AG role.

Such a design will get a NAK from me on the oFono side.  But don't let =

that stop you.  You can simply invoke oFono APIs directly from your =

daemon.  No need for any changes in oFono itself.  As mentioned above, I =

wouldn't recommend it, but... :)

> =

>>>> Also for using ofono with HFP profile is not possible on desktop
>>>> computer which do not have any modem as it is hooked to some active
>>>> modem.
>>
>> This statement is not true at all.  You can use oFono without any 'real'
>> modems attached.  It can happily manage only HFP devices (or modems as we
>> call them.)
> =

> Ok, can you please provide exact steps how to do it, including
> activating of bidirectional audio stream?

So again, which role?  If we're the HF connecting to the AG, then things =

just work without a modem.  If we're the AG, then yes you need a modem =

to be driven by the AG connection.

>>
>> You must be thinking of the oFono HFP AG implementation...
> =

> Yes! For connecting bluetooth headset you need HFP AG implementation.
> =

> And I guess this is the reason why simulator is needed. HFP headset acts
> as a "client" for modem. Therefore on desktop / laptop you need to
> implement "modem server" which will be used by HFP headset "client".
> =

> And phone simulator is doing exactly this "modem server", it is
> simulator of modem.
> =


Okay, I see now.  Yes, the above is correct.  My comments about not =

needing a modem device hold true only if oFono is in HFP HF role =

connecting to an AG.

Regards,
-Denis
--===============1015044546919744063==--

