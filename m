Content-Type: multipart/mixed; boundary="===============3935899271660134687=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFCv2] doc: Proposal for LTE/IMS API
Date: Wed, 09 Feb 2011 17:35:52 +0100
Message-ID: <AANLkTi=Lgkzj6m=zzG6+OxfDmN_=mCJnV1bnHV+jj4hD@mail.gmail.com>
In-Reply-To: <201102090902.43928.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3935899271660134687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

>> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 boolean PreConditionChec=
k(string Type, string
>> > > PeerAddress, + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u=
int16 PeerPort,
>> > > =C2=A0uint16 LocalPort) +
>> >
>> > That stuff is per context. Should it not be in the context object rath=
er
>> > than in the IMS manager?
>>
>> oFono should only consider QoS information from the IMS
>> Default and Dedicated bearers when checking the precondition.
>>
>> In theory there might be more than one IMS APN for a operator,
>> but I really don't see this as a real life scenario for this.
>> If anyone disagrees please speak out and explain...
>
> Well, I don't care if it is part of the normal context interface, or if i=
t is
> an extra IMS-specific interface on the IMS context object path. But this =
is
> clearly a per-context thing so it should be in the context.
>
> I don't want to end up in a 'woops' situation down the line. And I don't =
trust
> operators not to actually implement those useless in real life scenarii...

One option could be to keep it here in the IMS API but
to include the Local IP Address as a argument to the PreConditionCheck.
This fits quite nicely with the QoS SIP Precondition operation and can
easily be used
by oFono core to map to the right APN.

There is still a theoretical problem here if you get the same Home Address =
from
two IMS APN, If anyone think this is an issue I'll throw in the towel
and move the
PreConditionCheck to the ConnectionContext object ;-)

Anyway, I think either solution would work just fine.
In terms of the "separation of concern" i think keeping it here is the
best solution,
but putting it in the ConnectionContext is more flexible.

I'm not going to keep arguing for this forever ;-)

>> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 array{string} PcscfAddre=
sses [readonly]
>> >
>> > Should this be in the context object? The AT command is per CID. Would=
 it
>> > make any sense for a network to have different P-CSCF based on the
>> > bearer?
>>
>> As mentioned above, I don't see why an operator would ever have more than
>> one IMS APN. If we only have one IMS APN, then we might as well present
>> this information here in the IMS API.
>
> How do you cope with two connections to the same APN?

3GPP TS 24.229,  B.2.2.1 "PDP context activation and P-CSCF discovery",
describes that the P-CSCF can be provided as dynamic parameter with the
PDN connection, stored on the ISIM, or by provisioning. As far as I underst=
and
this It is up to the IMS application to select which one of the P-CSCF
addresses it should use.

So I think the best would be to expose the P-CSCF address stored on ISIM
in the IMS API, and move add the P-CSCF provided with the PDN Connection
to the ConnectionContext API.


Regards,
Sjur

--===============3935899271660134687==--

