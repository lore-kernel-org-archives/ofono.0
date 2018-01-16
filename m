Content-Type: multipart/mixed; boundary="===============5790662304511677667=="
MIME-Version: 1.0
From: Engelbert Torremans <engelbert@torremans.com>
Subject: Re: Problem with dialstring ##21#
Date: Tue, 16 Jan 2018 17:22:49 +0100
Message-ID: <1cbfa8b7-2a62-52e9-089a-3e10d33f274f@torremans.com>
In-Reply-To: <228d5a26-aaae-c806-74a2-16d8e5d92524@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5790662304511677667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis,

Thanks.

The thing is that it does work when I am trying the same thing in my car =

:-) That is probably not based on ofono (I don't know what is used =

inside) but at least it works when having my phone connected via bluetooth

So if would like to change this behaviour where would I need to change =

the code so these ## codes are sent to the phone acros the bluetooth =

interface?
I don't mind creating my "own" version.

BTW I am using version 1.20 now because I can't get 1.21 compiled on the =

RaspberryPi

Engelbert

Op 16-1-2018 om 17:00 schreef Denis Kenzior:
> Hi Engelbert,
>
> On 01/16/2018 06:50 AM, Engelbert Torremans wrote:
>> All,
>>
>> I am looking for some help in trying to fix this problem I am =

>> experiencing when using Ofono on a RaspberryPi in "carkit/HFP mode".
>>
>> Currently I can make calls (originate and terminate) and audio is =

>> fine in combination with Bluez5 etc. also.
>>
>> But I cannot disable CallForwarding via the dial-number command.
>>
>
> Call Forwarding isn't supported via HFP, you must be doing something =

> evil...
>
>> Enabling CFU via **21*destination-number# is working fine.
>>
>
> Just FYI, all USSD requests should be sent via =

> org.ofono.SupplementaryServices.Initiate() which will forward them to =

> the right interface (e.g. Call Forwarding, Call Settings, etc)
>
>> Trying to disable CFU via ##21# gives below error. Doing the same via =

>> the keypad on the mobile phone works fine.
>>
>> I have the impression that somwhere this ##21# is not processed =

>> correctly but where? In ofono or in DBUS or?
>>
>> Any clues?
>>
>> Thanks,
>>
>> Engelbert
>>
>> pi(a)rpi-x:~/xgen/ofono $ ./dial-number BT-MAC-ADDRESS ##21#
>
> Yep, you're doing something evil.=C2=A0 This is not a valid dial string =

> according to 3GPP.=C2=A0 Your AG might be able to accept this via ATD, bu=
t =

> this is not standard behavior and oFono rightly complains.
>
> Regards,
> -Denis


--===============5790662304511677667==--

