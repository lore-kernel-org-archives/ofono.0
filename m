Content-Type: multipart/mixed; boundary="===============1052903239497992715=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: Underlying Bluetooth device of a modem
Date: Fri, 12 Aug 2011 09:21:07 +0200
Message-ID: <4E44D463.7060503@bmw-carit.de>
In-Reply-To: <1313102382.3373.145.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1052903239497992715==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo and Marcel,

On 08/12/2011 12:39 AM, Marcel Holtmann wrote:
> Hi Gustavo,
>
>>>> I am trying to set up a simple HFP demonstrator using
>>>> BlueZ+oFono+PulseAudio, with a dbus client that coordinates the three =
of
>>>> them. Being a simple prototype, the goal is to see how they behave and
>>>> analyze how well it would all scale.
>>>>
>>>> The first question that arises is quite simple. In a multi-phone
>>>> scenario (all of them connected to our PC using Bluetooth HFP), oFono
>>>> properly lists all the phones as available modems. I would like to know
>>>> whether these modems can be associated to their underlying bluetooth
>>>> device (mac address, bluez device dbus path, or whatever). I have been
>>>> looking on the available modem properties but this seems not to be
>>>> present. Could somebody confirm this or otherwise explain how it can be
>>>> done?
>>>>
>>>> The purpose of my interest is that, depending on the use-case, the fin=
al
>>>> user would have to choose the modem (or device) manually.
>>> you would need to be a bit more specific on what the actual use case
>>> entails here. How would selection work and how the user is involved in
>>> it. Depending on that, things should be done differently.
>>>
>>> So besides that, some simple pieces that come to mind quickly are to
>>> create a HFP devinfo atom driver that just exports the BD_ADDR as serial
>>> number.
>> Only the BD_ADDR is not enough, the device can paired with two or more
>> adapters. Exports its DBUS path seems a best option.
>> HFP plugin already keep the path for internal use, so its just a matter =
of put
>> it devinfo.
>> Also, the modem path gives you the information you need. The numbers the=
re are
>> the adapter bd_addr followed by the remove device bd_add.
> you can not get the BD_ADDR out of the device path. The device path is
> arbitrary. And if anybody considers to misuse it, then I will add even
> more random bits into it.
>
> Regards
>
> Marcel
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

Yes, I was assuming that ofono did not intentionally guarantee to encode =

this kind of information in the dbus path. Exposing the needed =

information explicitly seemed more clear.

Considering the case pointed out by Gustavo about two adapters paired to =

the same device, I agree that the device path is the appropriate choice.

Besides, do you think exposing this information can be interesting for =

the upstream project? Do you believe that this is a special use-case? I =

mean that any bluetooth-centered application would probably like to know =

the relationship between the modems and the devices.

Regards,
Mikel


--===============1052903239497992715==--

