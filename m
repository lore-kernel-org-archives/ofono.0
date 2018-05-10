Content-Type: multipart/mixed; boundary="===============5805646402310953750=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Incoming sms problem on Motorola Droid 4
Date: Thu, 10 May 2018 08:50:46 +0200
Message-ID: <2A2ECEE1-A379-497D-B92D-54AB5E862066@holtmann.org>
In-Reply-To: <5c300a1e-add8-c068-0b8b-2b9084f5cb18@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5805646402310953750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

>>>>>> If I attempt to do AT+CNMA=3D1, AT+CNMA=3D0 or just plain At=3DCNMA,=
 it does
>>>>>> not like that, either, but with +CMS ERROR: 500.
>>>>> =

>>>>> CNMA=3D1 is required to work in PDU mode according to 27.005 btw.  Ho=
w about:
>>>>> =

>>>>> window.open();
>>>>> window.throw(modem);
>>>> =

>>>> Heh :-). Well, there are two phones with reasonable Linux support:
>>>> N900 and Droid 4. N900 can't do voice calls of reasonable
>>>> quality. That leaves Droid 4... so I'd really like it to work.
>>> =

>>> Is this actually an AT command modem or one of those modems where AT
>>> commands were only bolted on for carrier certification?  Does it suppor=
t QMI
>>> or something maybe?
>> Ok, so ... this is complex. And maybe this is one of "those" modems.
>> There's USB with AT commands, USB with QMI protocol, then serial with
>> mux and U1234AT+XYZ commands.
>> It seems Android uses serial, but that is being worked on, so I'm
>> using AT commands for now.
> =

> Wow, okay.  You might want to try using the qmi driver family instead.

I would switch to QMI since then you can also ignore this weird multiplexer.

Regards

Marcel


--===============5805646402310953750==--

