Content-Type: multipart/mixed; boundary="===============0994357961044820622=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] Add Lockdown property to Modem interface
Date: Tue, 23 Nov 2010 15:43:12 -0600
Message-ID: <4CEC3570.7050709@gmail.com>
In-Reply-To: <20101123175314.GC22502@vigoh>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0994357961044820622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On 11/23/2010 11:53 AM, Gustavo F. Padovan wrote:
>>> +		boolean Lockdown [readwrite]
>>> +
>>> +			Boolean representing the lock state of the modem.
>>> +			Setting it to true, makes the calling application hold
>>> +			the modem lock and power it down. Setting to false
>>> +			makes the it restore the modem state before the
>>> +			lockdown and release the modem lock. Only the
>>> +			application that holds the lock can power up the modem.
>>> +			If the the application exits Lockdown is set to false.
>>> +
>>
>> So me and Marcel discussed this briefly and I think we want to modify
>> the behavior slightly.  When Lockdown is set to True, the modem should
>> be brought down to Powered=3DOff state, and setting the Powered property
>> should return an error.
> =

> That's what my code does.
> =


Yep.

>>
>> When Lockdown is set to False from True, only the lock is lifted.
>> Powered state still has to be triggered manually.  This should make the
>> implementation a little simpler.
> =

> So this also means that we shall not restore the modem state when
> someone set Powered to true?
> =


No, lets forget doing this for now.  I think it was making things too
complicated.

Regards,
-Denis

--===============0994357961044820622==--

