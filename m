Content-Type: multipart/mixed; boundary="===============4029630246584063571=="
MIME-Version: 1.0
From: Nicola Mfb <nicola.mfb@gmail.com>
Subject: Re: Palm Pre modem plugin
Date: Sun, 22 Nov 2009 15:38:25 +0100
Message-ID: <359c5480911220638u422e7c09scabfdeb175fd494f@mail.gmail.com>
In-Reply-To: <200911200708.31068.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4029630246584063571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2009 at 2:08 PM, Denis Kenzior <denkenz@gmail.com> wrote:
[...]
> Then either you're not thinking hard enough or do not have enough domain
> experience to really comment. =C2=A0One example: carrier certification. P=
lease
> examine what oFono APIs cover and what FSO GSM APIs cover. =C2=A0Hint, to=
 pass GCF
> certification you will require quite a bit of what oFono provides (or fig=
ures
> out for you) and FSO is currently missing.

I cannot comment about FSO objectives but will forward to the right guys.
Keep in mind I'm speaking about general developers and their interest,
not about organizations, just pointing that *actually* FSO carries
more interests on *some* areas.

>>The forth and worring is that a developer may be forced to use
>>ofono, as the target device has some closed parts necessary for the os
>>that does not work anymore if you remove ofono and use FSO.
>
> Please do not post these crazy conspiracy theories here. =C2=A0oFono is G=
PLed for
> exactly this reason.

May you elaborate about that? May not a close source project use oFono
by calling it's DBus API?

>> So, instead of discuss oFono vs FSO, I'd like to know what is the long
>> time strategy and how to address these issues, and of course if I
>> missed some important points.
>
> FSO vs oFono is not a fair comparison anyway. =C2=A0 =C2=A0Please keep in=
 mind that
> oFono is focused _only_ on being a telephony stack that is generic and
> applicable to all types of devices. =C2=A0We started oFono to enable tele=
phony
> applications on Laptops, Netbooks, MIDs, In-Vehicle Infotainment and many
> other types of devices. =C2=A0These system types are different enough tha=
t different
> approaches to resource management, PIM, etc might be required. =C2=A0Not =
every
> device type will have or even needs a fully-featured GSM modem.

That's one of the reason FSO is modularized. Anyway resource
management in a complex system has to be handled in a central way to
take coherency between subsytems.
Having a middleware doing that is really important, just a case about
the correct way to suspend/resume a device should be not the interest
of a high level software.

[...]
> The other long-term goal is to integrate oFono with other system-level da=
emons
> such as BlueZ, NTPD, ConnMan, NetworkManager Gypsy, etc. =C2=A0This will =
allow us
> to e.g. expose GPS data from the modem; enable Bluetooth telephony profil=
es
> like DUN, HFP AG; and expose 3G data connections for management by real
> connection managers. =C2=A0We already have integration plugin infrastruct=
ure for
> feeding call history, sms history information to a PIM database of your
> choice, as well as export your phone's phonebooks to VCard format.
>
> So, as you see, oFono allows you to integrate it into any type of system.=
 =C2=A0You
> can even make it coexist with FSO daemons (with the exception of the gsm =
one
> of course) if these satisfy your particular requirements.

Nice to hear that. Anyway do not missunderstand, our team is adopting
oFono, we are just digging incoming issues with the nogsm part
integration!!!

Regards

      Niko

--===============4029630246584063571==--

