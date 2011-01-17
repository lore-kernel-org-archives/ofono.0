Content-Type: multipart/mixed; boundary="===============5694708645878524637=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [RFC PATCH] gprs: add function to handle activated context
Date: Tue, 18 Jan 2011 00:39:20 +0200
Message-ID: <AANLkTimLmnoJcTUyVw1+BWoU8ex9+hjtRsD2PWO0uiuy@mail.gmail.com>
In-Reply-To: <AANLkTik_iqS0+hwV5OyaENQ40mY16n3-wWEVLV2XLVU7@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5694708645878524637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

2011/1/17 Sjur Br=C3=A6ndeland <sjurbren@gmail.com>:
>> The 27.007 for release 9 (from version 9.3.0 onwards) says:
>>
>> NOTE 1: The <cid>s for network-initiated PDP contexts will have values
>> outside the ranges indicated for the
>> <cid> in the test form of the commands +CGDCONT and +CGDSCONT.
>>
>> The change was proposed by STE last February.
>>
>> This has some ramifications on how we use the CIDs within driver/core.
>
> I'm not sure we have any problems with Network Initiated Connection in oF=
ono,
> unless someone is planning to add support for Network Initiated
> Primary Contexts / PDN Connections.

AFAIK the initial LTE default bearer context can be network-initiated,
and the CID 0 falls outside the range from +CGDCONT.

> If we need to expose information about the Network Initiated Dedicated Be=
arers,
> I don't think we should model this as separate Connection-Contexts (with =
CID),
> but rather as a dictionary within the primary context object containing
> the necessary information about the QoS available.
>
> I guess we need to hear from IMS-folks the minimum information they
> need about the QoS, and provide just that information.

Uh, on one hand, the IMS Signaling flag for signaling. For
audio/video, we need QCI, a GBR rate, and TFT.

-- =

Pekka.Pessi mail at nokia.com

--===============5694708645878524637==--

