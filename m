Content-Type: multipart/mixed; boundary="===============6539432419648164602=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/5] cdma-voicecall: Add CDMA MO Call Support
Date: Mon, 06 Dec 2010 21:16:30 -0600
Message-ID: <4CFDA70E.2050103@gmail.com>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702D3ABEC@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6539432419648164602==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rajesh,

On 12/03/2010 03:34 PM, Rajesh.Nagaiah(a)elektrobit.com wrote:
> =

> Hi Dara,
> =

>> -----Original Message-----
>> From: ofono-bounces(a)ofono.org =

>> [mailto:ofono-bounces(a)ofono.org] On Behalf Of Dara Spieker-Doyle
>> Sent: 03 December 2010 13:21
>  =

>>>> +enum cdma_call_status {
>>>> +	CDMA_CALL_STATUS_ACTIVE =3D 0,
>>>> +	CDMA_CALL_STATUS_DIALING =3D 1,
>>>> +	CDMA_CALL_STATUS_ALERTING =3D 2,
>>>> +	CDMA_CALL_STATUS_INCOMING =3D 4,
>>>
>>> Should be 3 ?
>>
>> Yes indeed. I will fix this, thank you for catching it.
>>  =

>>>> +	CDMA_CALL_STATUS_DISCONNECTED
>>>> +};
>>>
>>> We can use the existing gsm call status itself ?
>>> Just that we wont use the HELD and WAITING status in CDMA.
>>
>> In this early phase of CDMA support in oFono, we would like =

>> to evolve it in its own right for a while, per the offline =

>> conversation from the MeeGo Conference in Dublin. On a case =

>> by case basis, for items of large architectural impact, we =

>> intend to evaluate potential re-use upfront.
>> The plan is to allow smaller items like this for now, until =

>> the related feature has matured sufficiently that they can be =

>> re-factored correctly if applicable.
>  =

> I agree with the fact that we should evolve it in its own right.
> But with these kind of straight forward cases, where the GSM values
> are a superset of the CDMA values and these value definitions being
> internal to ofono, we should try to to reuse the values rather than
> creating new ones exclusive for CDMA.
> Thats my view, Denis/Marcel any comments ?
> =


So the general rule of thumb has been to use an int when a spec clearly
defines the meaning of the said int.  E.g. call status int values have
very clear meaning from 27.007.  If no such clear definition exists,
then an enum should be used.

So the question here becomes whether the CDMA modems all re-use the GSM
meanings / values for these states or not?  If they do, then re-using
the GSM enum values makes sense.

If not, then using an enum defined in include/cdma-voicecall.h would be
better.  One major benefit of defining a dedicated enum for CDMA is the
compiler checking that all enum values are being handled.  If you re-use
the GSM version you would have to resort to using default statements.
This causes you to lose that extra compiler sanity checking, not to
mention is against rule M12 of the coding style.  And yes I know we're
not always consistent with this one ;)

Regards,
-Denis

--===============6539432419648164602==--

