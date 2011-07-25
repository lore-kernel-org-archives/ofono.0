Content-Type: multipart/mixed; boundary="===============8376393960368749974=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: CDMA SIM atom
Date: Mon, 25 Jul 2011 01:19:30 -0500
Message-ID: <4E2D0AF2.9080109@gmail.com>
In-Reply-To: <568DE01DA537804BA73470071BAC288938F4E5B1@irsmsx503.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8376393960368749974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

On 07/25/2011 10:03 AM, Aygon, Bertrand wrote:
> Hi,
> =

>>> We are working on CDMA to enable some USB dongle, and we need to get the
>> IMSI for the ConnMan interface, to create the interface name.
>>>
>>> We could use the AT SIM atom, since there should be no big difference
>> between a CDMA SIM and a GSM SIM (same kind of functionality for SIM
>> lock/unlock, same IMSI info).
>>>
>>> But we could also create a CDMA dedicated one. This will duplicate some
>> code, but will be 'cleaner'.
>>>
>>> I would prefer the solution of a CDMA SIM atom, so CDMA plugins use only
>> CDMA atom, but I would prefer to have the oFono community opinion before=
 going
>> into the code.
>>
>> you do not need an IMSI for ConnMan. You just need a proper unique
>> identifier that is consistent. Using the hardware serial number in case
>> of CDMA should be a good enough interim solution.
> =

> The user can change its SIM card and put it in another dongle
> =


There are plenty of CDMA devices which have no SIM card.

>> We are using the IMSI for GSM since we wanna bind stored settings
>> towards the SIM card. So that hardware swapping has no effect on the
>> user experience.
> =

> This is exactly what we also want to do with CDMA dongle.
>  =


Then create a cdma-sim atom that does this and enable it on those
dongles that do have a SIM card.

>> With CDMA we could neglect this actually. So far all
>> CDMA account are still bound to the hardware itself.
> =

> Why do you want to neglect this?

Because right now this is not the highest priority and you still need to
figure out how to make the connman plugin handle cases with and without
a sim atom.

> =

> We should be consistent have have the same behaviour for this. If someone=
 unplug and replug its dongle, he do not want to re-insert the data call pa=
rameter, as with a GSM dongle.
> =


Sure, but remember to start small (and working) and build up.

> And what about PIN?
> =


Regards,
-Denis

--===============8376393960368749974==--

