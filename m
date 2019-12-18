Content-Type: multipart/mixed; boundary="===============5238981528557911197=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [pulseaudio-discuss] Proposal for a new API and usage of
 Bluetooth HSP and HFP profiles on Linux
Date: Wed, 18 Dec 2019 21:01:19 +0000
Message-ID: <06eb7e98-1357-afd1-40a5-2ccb139d8dec@gmail.com>
In-Reply-To: <20191218173632.aqdmdhutu3ruezck@pali>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5238981528557911197==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pali,

>>> I'm not sure what logic around HSP you really care about.  It is just a
>>> single button press in the end.
>>
>> CSR features (battery status level, ...) and CSR codec selection (e.g.
>> AuriStream). Also some apple extensions are used in HSP profile.

Since HFP can do everything that HSP can and more, I view HSP as =

deprecated and not to be used.  If these are also available in HFP, then =

I'd just use HFP instead.  But HSP was never my focus, so if you feel =

there's a need for better HSP support, then fair enough.

>>
>>> For HFP, oFono can already support all sorts of extensions.  See for ex=
ample
>>> how we handled Siri for HFP support in oFono here:
>>> https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/doc/siri-ap=
i.txt.
> =

> About Siri: In hsphfpd API it is delegated to Telephony Agent. So
> hsphfpd is not going to (re)implement it.
> =

>> I saw. But it does not support usage of vendor codecs, like CSR
>> AuriStream and it does not support CSR extensions, like displaying text
>> on embedded display.

But that's my point, you can easily accomplish this by creating another =

oFono API / atom for HFP CSR extensions and expose this information / =

functionality.  Similar to how Siri was done.  I see no need for a =

completely new external daemon.

>>
>>> Many of the extensions you talked about are also relevant for real mode=
ms as
>>> well (like battery reporting, call volume, etc).  Some of these APIs are
>>> already defined in fact.
>>>
>>> Given the above, oFono upstream has no interest in adding or maintaining
>>> support this new framework.
> =

> Maybe better question: Do you mean that you do not want to maintain
> hsphfpd, or that you completely do not want to see that ofono would be
> "Telepony Agent" for hsphfpd?

The latter.

> =

>> Denis, if you are not interested in my proposed hsphfpd daemon, how you
>> want to solve problem with other extensions and other vendor codecs?
>>

See above..

>> Also in my proposed solution it is possible to use HFP profile without
>> Telephony Agent (ofono). Do you think it is really a good idea to have
>> strong dependency on ofono just for bluetooth HFP headset?
>>

Why not?  The main purpose of HFP is telephony; whether it is classic =

phone calls or skype/facetime.  oFono seems a natural fit.

>> Also for using ofono with HFP profile is not possible on desktop
>> computer which do not have any modem as it is hooked to some active
>> modem.

This statement is not true at all.  You can use oFono without any 'real' =

modems attached.  It can happily manage only HFP devices (or modems as =

we call them.)

>>
>> There is a way to use ofono sim simulator which provide fake modem, but
>> its setup is hard on desktop and it not automated.
>>

You must be thinking of the oFono HFP AG implementation...

>> So connecting bluetooth headset in HFP profile with ofono is something
>> not so easy and not an obvious way.
>>

Again, not true.  As I said above, you can use oFono for this use case =

just fine.  Certainly the main driver for the development of oFono was =

to drive real modem hardware, but it isn't limited to that.  So if you =

want to use it only for HFP, you can.

Regards,
-Denis
--===============5238981528557911197==--

