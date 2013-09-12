Content-Type: multipart/mixed; boundary="===============3180014791634205949=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Query locked pins after reset pin
Date: Thu, 12 Sep 2013 08:51:47 -0500
Message-ID: <5231C6F3.5090403@gmail.com>
In-Reply-To: <DA62CA5DDF4CA640AA25B1684E5D141101D861A1@SHSMSX102.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3180014791634205949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

 >>> +
>>> +	if (sim->driver->query_locked)
>>> +		sim->driver->query_locked(sim, type, sim_query_locked_cb, req);
>>
>> The oFono driver calling semantics do not allow for a cleanup handler.
>> So if the modem hardware crashes or is removed in the time between you
>> submit the request to the driver and the driver returns with the result,=
 you will
>> incur a memory leak.
>>
> In any case, the callback (sim_query_locked_cb) will be invoked. If only =
the callback is called,
> "req" will be freed. If I am wrong, please correct me.

Please re-read my comment above.  The callback is not guaranteed to be =

always called.  If the atom is removed for any reason between the time =

the driver request is submitted and the callback is called, you have a =

memory leak.  For example, if the modem resets itself or crashes or the =

SIM is removed.

>>
>> Why do you need this in the first place.  Are you suggesting that by unb=
locking
>> the SIM PIN it somehow has the side-effect of also resetting the SIM lock
>> status?
>>
> It is true for IMC modem. After reset SIM PIN, the SIM PIN locking is cha=
nged. I doubt this is an issue of
> IMC modem. Following is the log:
>
>> AT+CLCK=3D"SC",2
> < \r\n+CLCK: 0\r\n
> < \r\nOK\r\n
>
>> AT+CLCK=3D"SC",1,"1111"
> < \r\nERROR\r\n
>
>> AT+CMEE=3D1
> < \r\nOK\r\n
>
>> AT+CLCK=3D"SC",1,"1111"
> < \r\n+CME ERROR: 16\r\n
>
>> AT+CLCK=3D"SC",1,"1111"
> < \r\n+CME ERROR: 12\r\n
>
>> AT+CPIN=3D"13570794","1234"
> < \r\nOK\r\n
>
>> AT+CLCK=3D"SC",2
> < \r\n+CLCK: 1\r\n
> < \r\nOK\r\n
>
> To be safe, query SIM PIN locked information after reset sim pin.

Fair enough.  Please fix the other comments in my review.

Regards,
-Denis

--===============3180014791634205949==--

