Content-Type: multipart/mixed; boundary="===============1915970188065907355=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFC] doc: Proposal for LTE/IMS API.
Date: Thu, 27 Jan 2011 09:29:11 +0100
Message-ID: <AANLkTins5-1NY+R0FDGxVDOGSPxTSARoWPOKD=OeG6tD@mail.gmail.com>
In-Reply-To: <201101270950.18685.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1915970188065907355==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

>> - The QoS information is presented as an array of QoS settings with
>> =C2=A0 an associated list IP Packet Filters. Only the QoS data for
>> =C2=A0 connection context of type IMS will be reported.
>>
>> =C2=A0 The assumption is that QoS is only going to be used by IMS applic=
ations.
>> =C2=A0 Initially I was planning to put this in the connman-api.txt, but =
based
>> =C2=A0 on feedback from Denis in the Paris workshop I have moved this to=
 the
>> =C2=A0 IMS API. If this assumption proves wrong QoS should be moved to
>> =C2=A0 ConnectionContext interface.
>
> What is this for? In my understanding, the LTE modem will do the classifi=
cation
> on outgoing packets - not the application engine. Indeed, based on the
> proposed API, there is no way for the application engine to tag packet fo=
r the
> benefit of the modem...

Yes, this is correct. The modem should take care of this.

> And we do not need to know anything about classification of incoming pack=
ets,
> other than which primary context they belong to.

The point here is that the IMS application needs some information about
the QoS it actually got from the network. Apparently IMS-app needs this for
selecting appropriate codec-parameters to use. That's the only purpose
of presenting this information.

>> +Properties =C2=A0 boolean ImsVoiceRegistered [readwrite, optional]
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
Inform modem's radio stack that the IMS application
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
has registered for Voice over IMS. This impacts
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
"UE Mode of operation" and the ISR feature in the
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
radio stack. Related AT command: AT+EISR
>
> I suppose this should be similar to Modem.Lockdown: only one D-Bus client=
 can
> set it (at a time), and it gets automatically cleared if said client dies.

I assume you are right, but someone knowing more about the IMS application
should answer on this....

Regards,
Sjur

--===============1915970188065907355==--

