Content-Type: multipart/mixed; boundary="===============0884562314593324536=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 1/2] gemalto: Prepare new interface for hardware monitoring
Date: Mon, 15 May 2017 11:47:27 -0500
Message-ID: <a8e4b2e1-9ffe-d6ba-2a7c-28dc1fd1e445@gmail.com>
In-Reply-To: <578699111450176e4882a6d5e3473417@smile.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0884562314593324536==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vincent,

On 05/15/2017 10:53 AM, Vincent CESSON wrote:
> Hi Denis,
>
>
> Le 2017-05-12 16:13, Denis Kenzior a =C3=A9crit :
>> Hi Vincent,
>>
>>>>
>>>> So the applications would need to poll these values.  Does the modem
>>>> enable some sort of unsolicited notifications of these?
>>>>
>>>
>>> No unsolicited notifications for voltage.
>>> There are notifications for over/under temperature warning,
>>> but exact value must be polled.
>>
>> Okay.  In that case a method call is probably the best way to do
>> this. I would combine the two method calls into one.  e.g.
>> GetStatistics() that would return a dictionary of values.  Something
>> like:
>>
>> a{sv} GetStatistics()
>>
>> where s is the key:
>> "Voltage" - uint32 (I assume this can't be negative)
>> "Temperature" - int32
>>
>> This keeps your round-trips to a minimum.  It takes ages to go over
>> D-Bus, so it should be considerably faster to have oFono query both
>> values at once.  Especially if you can combine the query into a single
>> AT commmand.
>>
>> Might want to mention the units as well.  F vs C, etc.
>>
>
> Ok to squash the methods. Why GetStatistics? I suggest simply
> GetProperties instead.

If you use GetProperties then it would be expected that you implement =

PropertyChanged signal as well, and maybe SetProperty().  Don't think it =

makes sense to have a signal if the caller is responsible for polling =

the values.  Hence a separate method call.

> How would you mention the units? In the key name? "Temperature (C)" and
> "Voltage (mV)"?
> Or in a new entry?
> It's details but I prefer to have your opinion.

I assume you would provide a doc file for this.  E.g. =

doc/cinterion-hardware-monitor-api.txt  The API description would be the =

place to mention the units, ranges, etc.

>
>>>
>>> How would you implement the notification? With a property and a signal
>>> PropertyChanged? Is it ok to keep the methods as I propose, and add
>>> the notification later?
>>>
>>
>> If it is just a plain notification that e.g. a temperature exceeds
>> the threshold, then I would model it as a signal.  Something like:
>> TemperatureThresholdExceeded()
>>
>> Is there a way to set the threshold?
>
> There is no way to set the thresholds. In fact there are 5 levels:
>
> Below lowest temperature limit (causes switch-off after 5 s time).
> Below low temperature alert limit.
> Normal operating temperature.
> Above upper temperature alert limit.
> Above uppermost temperature limit (causes switch-off after 5 s time).
>

Okay, this probably should be described in the doc file as well.

Regards,
-Denis


--===============0884562314593324536==--

