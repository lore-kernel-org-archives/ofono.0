Content-Type: multipart/mixed; boundary="===============5548627979081711629=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Incoming sms problem on Motorola Droid 4
Date: Thu, 10 May 2018 09:11:02 +0200
Message-ID: <D8F86CC7-9B4B-4F61-9808-CE8E6A79EBC0@holtmann.org>
In-Reply-To: <20180510065856.GA21093@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5548627979081711629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

>>>>>>>> If I attempt to do AT+CNMA=3D1, AT+CNMA=3D0 or just plain At=3DCNM=
A, it does
>>>>>>>> not like that, either, but with +CMS ERROR: 500.
>>>>>>> =

>>>>>>> CNMA=3D1 is required to work in PDU mode according to 27.005 btw.  =
How about:
>>>>>>> =

>>>>>>> window.open();
>>>>>>> window.throw(modem);
>>>>>> =

>>>>>> Heh :-). Well, there are two phones with reasonable Linux support:
>>>>>> N900 and Droid 4. N900 can't do voice calls of reasonable
>>>>>> quality. That leaves Droid 4... so I'd really like it to work.
>>>>> =

>>>>> Is this actually an AT command modem or one of those modems where AT
>>>>> commands were only bolted on for carrier certification?  Does it supp=
ort QMI
>>>>> or something maybe?
>>>> Ok, so ... this is complex. And maybe this is one of "those" modems.
>>>> There's USB with AT commands, USB with QMI protocol, then serial with
>>>> mux and U1234AT+XYZ commands.
>>>> It seems Android uses serial, but that is being worked on, so I'm
>>>> using AT commands for now.
>>> =

>>> Wow, okay.  You might want to try using the qmi driver family instead.
>> =

>> I would switch to QMI since then you can also ignore this weird multiple=
xer.
> =

> More explanation needed it seems:
> =

> I can already do USB with AT commands, no multiplexer needed. We'd
> actually prefer to go over serial (with multiplexer), because USB
> needs to be powered down in idle, and you still need communication
> ovre serial to know that wakeup of USB is needed.
> =

> Yes, it is complex :-(.

I missed the part that the weird serial multiplexer is wired independently.=
 Then do everything via that serial multiplexer and never look back. Howeve=
r if that is as broken, then you will be really out of luck. Making this wo=
rk reliable will be really hard.

While we have seen QMI protocol issues as well, but they have been less bad=
 than the bolted on AT commands. Manufactures always get AT commands wrong =
since they let humans test it and not a real telephony stack like oFono.

Regards

Marcel


--===============5548627979081711629==--

