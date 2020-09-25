Content-Type: multipart/mixed; boundary="===============0949065779420599517=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCH 2/2] quectel: Power on/off with a gpio pulse
Date: Fri, 25 Sep 2020 10:23:02 +0200
Message-ID: <b74559fd-1b00-2b84-5912-03c212981ce2@geanix.com>
In-Reply-To: <20200925081159.guef4opj4ydecdhl@lem-wkst-02.lemonage>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0949065779420599517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On 25/09/2020 10.11, Lars Poeschel wrote:
> On Fri, Sep 25, 2020 at 08:43:15AM +0200, Martin Hundeb=C3=B8ll wrote:
>> Hi Lars and Janez,
>>
>> On 24/09/2020 13.02, Martin Hundeb=C3=B8ll wrote:
>>> Hi Lars,
>>>
>>> On 24/09/2020 12.38, poeschel(a)lemonage.de wrote:
>>>> From: Lars Poeschel <poeschel@lemonage.de>
>>>>
>>>> Current implementation uses a gpio level of 1 for powering on quectel
>>>> modems using a gpio and a level of 0 for powering off.
>>>
>>> We actually implemented this on the M95 by keeping the POWER pin always
>>> high, and then controlling power using the RESET pin. This avoids the
>>> need for pulses, which I find simpler.
>>
>> Sorry, this is not accurate. We control the regulator supplying the mode=
m,
>> not the reset pin.
> =

> But this is bad also. The modem does a lot of things after you tell it
> to power-off for example unregistering from the network gracefully. It
> also might save some settings it uses internally or whatever.

I see your point. We do, however, send AT+CFUN=3D0 before pulling the =

plug, so most of what you mention should happen anyways.

> You are using a way that does not seem to be intended by the vendor and
> it reading the hardware design document it is also not obvious to me.
> The obivous way to me is just using the PWR_KEY pin that every supported
> quectel modem in ofono provides ready to use. And doing a pulse on this
> is also not very hard.

I haven't looked too deeply into this, but how can we tell if we are =

powering the module on or off when sending a pulse the first time?

> I am open to discuss if we should power-off the modem with the pulse or
> use the AT+QPOWD at command instead, but for power-on I think the pulse
> is the way to go.
> =

> By the way this is not specific to the M95 or EC21. This does apply to
> all ofono-supported quectel modems.

Yeah, I've seen this on other modems too, and I think it's a weird way =

to do hardware for embedded systems... A power-key would make sense if I =

was building a mobile phone, and even then I would probably prefer it to =

be a dedicated circuit instead of a modem-thing :)

> For me I don't have the choice. I have to support the pulse-approach
> somehow, either ofono accepts it upstream or I have to maintain it as a
> private patch, as I have to support a hardware that is built as is.
> I can imagine the same somehow applies to you. The question is now: What
> to do ?
> I would like to see the pulse-approach in ofono as a default. We can
> then work out a way to configure the level-solution you need maybe as a
> new envionment option ?
> What do others think ?

I have both options available, so we should be able to figure something =

out :)

// Martin
--===============0949065779420599517==--

