Content-Type: multipart/mixed; boundary="===============5527397627634688501=="
MIME-Version: 1.0
From: Kai.Vehmanen@nokia.com
Subject: RE: [RFC] doc: Proposal for LTE/IMS API.
Date: Mon, 31 Jan 2011 13:12:43 +0000
Message-ID: <C50CA21D80D6B74F80FB941E215DF4145DC66D@008-AM1MPN1-001.mgdnok.nokia.com>
In-Reply-To: <AANLkTi=g4Eev-MpkpPgiPTFM1NazKKTiHAGvO3_O5cHy@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5527397627634688501==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 31 Jan 2011, Sjur Br=C3=A6ndeland wrote:
>> Sjur Br=C3=A6ndeland wrote:
>>>=C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0array{dict,array{dict}} QosFilters [r=
eadonly, optional]
>>>=C2=A0+
>>>=C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Information about the Q=
oSes and associated Packet
>>>=C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Filters for the Default=
 PDN and it's dedicated
> Arun Ravindran wrote:
>> Do we really need this?. What is the real usage of this information?.
>> In 27.007 there are few AT commands for TFT, and are not used, may be
>> because no body (operator) supports this.
>
> BTW, did you see the response from Kai earlier in this mail thread?
> [kai.vehmanen(a)nokia.com wrote:]
> >this is used e.g. for SDP preconditions mechanism used in IMS:
> >http://www.faqs.org/rfcs/rfc3312.html

just to add to this: some information about the traffic filters =

is most definitely needed (RFC3312 is needed to set up calls =

according to TS24.229 and e.g. GSMA IR.92 ([1] a profile using 24.229)).

So in short the idea is that phone should not start alerting
before it has got a confirmation it has a voice-ready data connection
set up (including QoS).

But as the modem is just a IP transport in this case and does not know =

which ports (nor even which protocols) are used for voice (and which media =

streams are used by the application), it is really hard to prune down =

the list of information provided via oFono with 'QosFilters'. In the =

end it's the application that needs to check all the IP flows needed
for the call are covered by sufficient QoS, before continuing the call =

establishment.

So I'm not sure what the strategy should be.. expose the full
27.007 set, expose list based on what the first modems implementing
the interface support, or prune the list based on some known application
(e.g. IR.92 profile of TS24.229), or something in between.
The oFono design principle of '4.2 Minimal & Complete' is not so easy
to apply when doing something new... ;)

[1] http://gsmworld.com/documents/IR9230.pdf


--===============5527397627634688501==--

