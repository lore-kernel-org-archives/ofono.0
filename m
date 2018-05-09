Content-Type: multipart/mixed; boundary="===============1196541635498441667=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Incoming sms problem on Motorola Droid 4
Date: Wed, 09 May 2018 14:33:02 -0500
Message-ID: <5c300a1e-add8-c068-0b8b-2b9084f5cb18@gmail.com>
In-Reply-To: <20180509185755.GA32379@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1196541635498441667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On 05/09/2018 01:57 PM, Pavel Machek wrote:
> Hi!
> =

>>>>> If I attempt to do AT+CNMA=3D1, AT+CNMA=3D0 or just plain At=3DCNMA, =
it does
>>>>> not like that, either, but with +CMS ERROR: 500.
>>>>
>>>> CNMA=3D1 is required to work in PDU mode according to 27.005 btw.  How=
 about:
>>>>
>>>> window.open();
>>>> window.throw(modem);
>>>
>>> Heh :-). Well, there are two phones with reasonable Linux support:
>>> N900 and Droid 4. N900 can't do voice calls of reasonable
>>> quality. That leaves Droid 4... so I'd really like it to work.
>>
>> Is this actually an AT command modem or one of those modems where AT
>> commands were only bolted on for carrier certification?  Does it support=
 QMI
>> or something maybe?
> =

> Ok, so ... this is complex. And maybe this is one of "those" modems.
> =

> There's USB with AT commands, USB with QMI protocol, then serial with
> mux and U1234AT+XYZ commands.
> =

> It seems Android uses serial, but that is being worked on, so I'm
> using AT commands for now.

Wow, okay.  You might want to try using the qmi driver family instead.

> =

>>> Afaict.. In PDU mode we need either +CNMA, which is broken, or CMTI,
>>> which reports '+CMTI: "ME",-1' which I assume is broken, too.
>>>
>>> Is there chance that '+CMTI: "ME",-1' can be understood as '+CMTI:
>>> "ME",1' ?
>>
>> ITU v.250, Section 5.3.1:
>> < number>
>> may be a string of one or more characters from "0" through "9" represent=
ing
>> a decimal integer value. Commands that expect a < number>
>> are noted in the description of the command (see clause 6).
>>
>> So strictly speaking negative numbers are not allowed.  But who reads sp=
ecs
>> anyway for something as unimportant as a communications device that lives
>> might depend on.
> =

> Would it be possible to re-scan the messages similar way we do scan on
> startup when invalid +CMTI is received?

Possible.  You can try adding another vendor enumeration inside =

drivers/atmodem/vendor.h.  Make sure that that enumeration is passed to =

ofono_sms_create in your modem driver.  Then inside =

drivers/atmodem/sms.c modify the CMTI logic to issue a +CGML if the =

relevant vendor quirk is set.  Refer to 27.005 for the right parameter. =

I think at startup we use '4' which is to grab all of the messages. =

Here you might want to use '0' for received/unread.

Also, oFono does not manage the store itself and assumes that all =

messages are routed directly via +CMT.  If that is not possible, then it =

is assumed that the driver takes care of issuing +CMGD, etc.  So you =

would need to do that as well.

I think the logic issues a +CPMS properly already, but if not you might =

need to issue +CPMS with the right storage location first.

Regards,
-Denis

--===============1196541635498441667==--

