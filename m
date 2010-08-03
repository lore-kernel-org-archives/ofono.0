Content-Type: multipart/mixed; boundary="===============4326646383661249577=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Add CDMA/EVDO into TODO
Date: Tue, 03 Aug 2010 10:55:57 -0500
Message-ID: <4C583C0D.10807@gmail.com>
In-Reply-To: <D87B22B1FE8C0F479CA9BEAD6C25AAE805424D07@ism-mail03.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4326646383661249577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

>>> +- Disable CDMA unsupport feature for CDMA modem. Include USSD,
>>> supplementary services,
>>> +  SSN, PDP context.
>>> +
>>> +  Priority: High
>>> +  Complexity: C2
>>
>> Actually this is not a TODO item. That is a modem plugin specific
>> detail. If your modem (CDMA or not) doesn't supports such features,
>> then
>> don't enable the atoms for it.
>>
>> So I say that this already supported ;)
>>
> =

> I do agree, besides, some atoms such as call-barring, call-setting ...
> Need do a little change, we need to disable the USSD watch and SSN watch =
etc.
> =


Just to nitpick, but if you don't create the SSN/USSD atoms, then the
atom watch will never fire.

Can you include descriptions of what needs to change in these atoms in
your TODO list as well?

>>> +- Add call forwarding, call waiting, network registration
>>> implementation for CDMA.
>>> +
>>> +  Priority: High
>>> +  Complexity: C4
>>
>> This is more like add CDMA specific atom drivers for netreg etc. That
>> these are CDMA specific is more a minor detail.
>>
>> I like to hear Denis comment on his, but first guess would be that this
>> should be done as drivers/cdmamodem/...
>>
> These features in CDMA are very different from that in GSM. Call forwardi=
ng and call waiting
> are achieved by dial a specified number(feature code). In CDMA system, th=
e modem =

> will always auto register network, but in GSM system, there are different=
 register modes,
> and can scan neighbor networks. =

> =

> So we would like implement them in separate files such as cdma_call-forwa=
rding.c ...
> But not base on current implementation.
> =


I'm not against this in general, but please start sharing with us more
details.  E.g. why these are different, why the current atom cannot be
extended, etc.  In some respect you will have to educate us about CDMA
first.

It would also be very helpful if you posted a table with CDMA feature
break down and the relevant CDMA specs.  E.g. like SMS in 3GPP is
covered in 23.040, CBS in 23.041, etc.  This way we can go straight to
the spec to help us understand why a particular solution was proposed.
I believe that would shorten our ramp up time considerably.  I've
updated doc/standards.txt to give you an idea of what I'd like to see.

>>> +- Change radio setting, SIM manager, SMS manager, voice call manager,
>>> Data Connection
>>> +  Manager to make them support both GSM and CDMA
>>> +
>>> +  Priority: High
>>> +  Complexity: C8
>>
>> I think you have to be a bit more specific here. Maybe it is a good
>> idea
>> to split them into separate items.
>>
>> Regards
>>
>> Marcel
>>
> =

> Yes, we do agree. We will do it. =

> =

> Generally, before do any change, we will sent out the proposed solution,
> and collect the suggestion first.
> =


I'd also like you to greatly expand your TODO item descriptions.  The
current level of detail is not enough.  Think of TODO as a sort of
high-level design document, but targeted at developers.  The more detail
you add here, the better.

Regards,
-Denis

--===============4326646383661249577==--

