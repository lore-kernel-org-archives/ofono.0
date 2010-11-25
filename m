Content-Type: multipart/mixed; boundary="===============0958570607406072089=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Add voice call boolean property for MO/MT distinction
Date: Thu, 25 Nov 2010 17:51:18 -0600
Message-ID: <4CEEF676.3020902@gmail.com>
In-Reply-To: <20101125082310.GA17294@jh-x301>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0958570607406072089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On 11/25/2010 02:23 AM, Johan Hedberg wrote:
> Hi,
> =

> On Thu, Nov 25, 2010, R=C3=A9mi Denis-Courmont wrote:
>>>> +		boolean Originated [readonly]
>>>> +
>>>> +			Indicates whether the call was mobile-originated
>>>> +			(true) or mobile-terminated (false).
>>>> +
>>>
>>> What use case are you trying to enable with this API?  I don't see how
>>> this could be useful for the UI...
>>
>> This becomes a problem if we have more than one application "managing" v=
oice =

>> calls. And I expect that will _be_ the most common case. You have the ma=
in =

>> call UI, but you also have the Bluetooth headset/carkit, the USB AT comm=
ands =

>> port, and possibly some third party call applications.
> =

> Right. At least for HFP the call direction needs to be in the AT+CLCC
> reply. I.e. if the bluetoothd ofono telephony driver is used and
> bluetoothd starts after one or more calls are already in progress
> bluetoothd wouldn't have seen the call setup process and therefore not
> know the direction of the call (without this property).

I really don't view +CLCC emulation outside oFono as a valid use case.
We already have a task to implement HFP AG role inside oFono, and
especially with CDMA on the horizon this is the only way to go.

So unless there are more convincing arguments, I'm against this API
change.  I really suggest that instead of doing this outside oFono,
someone picks up the AT modem emulator work and continue where Zhenhua
left off.

Regards,
-Denis

--===============0958570607406072089==--

