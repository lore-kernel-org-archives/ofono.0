Content-Type: multipart/mixed; boundary="===============4033891883642742298=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] telit: sim status notification without polling
Date: Tue, 28 Aug 2012 09:53:29 -0500
Message-ID: <503CDB69.5040705@gmail.com>
In-Reply-To: <503CE18A.9060300@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4033891883642742298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

On 08/28/2012 10:19 AM, Christopher Vogl wrote:
> Hi Denis,
>
> On 23/08/12 19:37, Denis Kenzior wrote:
>> Hi Christopher,
>>
>>>> Also, one other thing I'm concerned about is the CFUN=3D4 usage when we
>>>> try to set the modem offline. Your comments indicate that the Telit
>>>> modem resets the SIM when we issue CFUN=3D4. Going from Online True ->
>>>> False we don't actually want to reset the SIM. Does CFUN take an extra
>>>> parameter to turn SIM reset off by any chance?
>>>
>>> Telit documentation says that +CFUN supports a second parameter which
>>> should turn reset off.
>>> AT+CFUN=3D? also returns +CFUN: (0,1,2,4,5),(0)
>>> AT reference manual: "reset flag 0 - do not reset the ME before setting
>>> it to <fun> functionality level"
>>>
>>> But the modem keeps returning +CME ERROR: 4 when I try it (no matter
>>> which CFUN level).
>>
>> That is funny. Maybe the modem does not support a true 'offline' or
>> 'airplane' mode. In which case the driver might need to be modified
>> somewhat.
>>
>> This is something we will need to solve in the future. If not fixed,
>> I'm guessing that going Online then Offline will reset the SIM and
>> cause all kinds of funny behavior.
>>
>>>
>>> The modem behaves very strange sometimes. I kept getting timeouts when
>>> setting AT+CFUN=3D4. I once tried it manually and it took 26 seconds un=
til
>>> I got an OK.
>>> Currently it works fine again.
>>>
>>
>> Is there a newer firmware available by any chance?
>
> Telit support was so kind to send me a firmware version (08.01.108-B006)
> which supports +CFUN without resetting.
> I suppose this is not an official version yet and if I adapt the code in
> the telit plugin I will probably be the only one who can use it.
> Is it ok if I send a corrected version of this patch and change the
> offline/online mode handling in a further patch when it is sure
> supported by an official firmware version?
>

Just send it in, their official docs do mention the reset parameter, so =

if the modem rejects it then that is a firmware bug.  The end-user will =

have to upgrade the firmware in that case.

Regards,
-Denis

--===============4033891883642742298==--

