Content-Type: multipart/mixed; boundary="===============8081047968259553141=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Testing the iPhone 5
Date: Mon, 13 May 2013 08:30:28 -0500
Message-ID: <5190EAF4.9030007@gmail.com>
In-Reply-To: <CANT-zCVoxX1=p_ogY73Y1iEqBebEJHf=mhBW0SasqtOKdAUVgA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8081047968259553141==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

 >>> (At this point, a second call is dialed from the phone)
>>>
>>> ofonod[14366]: < \r\n+CIEV: 3,2\r\n
>>> ofonod[14366]: > AT+CLCC\r
>>> ofonod[14366]: < \r\n+CLCC: 1,0,0,0,0,"<phone-number-1>",145\r\n
>>> ofonod[14366]: < \r\n+CLCC: 2,0,2,0,0,"<phone-number-2>",129\r\n
>>
>>
>> So here we have call with index 1 in state 'Active' and call with index =
2 in
>> state 'Dialing'.  Obviously a bug with the iPhone.
>
> Is this the kind of bug oFono is interested in fixing as IOP issue? Or
> is it something acceptable in oFono's API?
>

This is an obvious IOP issue, and I've been mentioning for a while that =

we need a comprehensive HFP quirks system.  The patches from Timo are a =

good start, however I'd really be interested in seeing the framework for =

HFP IOP issues first.

I suspect we will have quite a bit of work to do here since every phone =

manufacturer so far has screwed up the HFP protocol implementation in =

some way.

Regards,
-Denis


--===============8081047968259553141==--

