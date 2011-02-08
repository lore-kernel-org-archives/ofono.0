Content-Type: multipart/mixed; boundary="===============5462768249258808619=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFCv2] doc: Proposal for LTE/IMS API
Date: Tue, 08 Feb 2011 17:42:45 +0100
Message-ID: <AANLkTi=0aM+gQvUxtEH8wV-EPvpW-XxEYqyJtGKw9ZyC@mail.gmail.com>
In-Reply-To: <8281606748F03E4390BB98A3F47F2E948A9CB41FD5@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5462768249258808619==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Redouane,

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void UnRegister(object path)
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
Un-register a IpMultimediaSubsystemAgent.
>
> Register and UnRegister functions are not really symmetric here ...
> How object path is used by UnRegister function ??
> Maybe we should have :
> void UnRegister(string type)

Thanks for spotting this, it's a bug. It should have been
"void UnRegister()". I'll fix this in the next patch.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 boolean PreConditionCheck(st=
ring Type, string PeerAddress,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16 PeerPort, =
=C2=A0uint16 LocalPort)
>
> How to make the link between the primary context (or default bearer) acti=
vated by the IMS client ,
> and the TFT and QOS.

When Dedicated bearers are created  +CGEV: NW ACT reports both the
Default Bearer and the Dedicated bearer.

> We can imagine that we have a good QOS / TFT but it doesn't belong to the=
 primary context (or default bearer) activated by the IMS client.

As mentioned to R=C3=A9mi, we should only consider the QoS/TFT for the IMS
ConnectionContext
and related Dedicated Bearers. So oFono core only needs to keep track
of the QoS/TFTs for IMS.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void PreConditionChanged()
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
This signal is sent when the network has changed
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
the QoS or Packet Filters for a Bearer.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
The IMS application can then check the QoS SIP
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
preconditions by calling PreConditionCheck().
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
Only QoS information relevant for IMS will be
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
signaled, i.e. QCI=3D1 for voice and QCI=3D2 for video.
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
Related AT commands: AT+CGEREP,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
+CGEV: NW ACT, +CGEV: NW MODIFY
>> +
>
> Same here , IMS client will be notified for all dedicated bearer ?
> I agree with R=C3=A9mi, it 'll be better if we can put QOS/TFT somewhere =
under primary context.

I believe we will have only one IMS APN for each operator, so we might
as well keep it here in
the IMS Interface.


Regards,
Sjur

--===============5462768249258808619==--

