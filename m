Content-Type: multipart/mixed; boundary="===============3549534867530765370=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [RFC] doc: Proposal for LTE/IMS API.
Date: Thu, 27 Jan 2011 19:55:09 +0200
Message-ID: <AANLkTindjyjcBd5Ya1xZwv+zrgqpCoEpNFBJWfiH3zm3@mail.gmail.com>
In-Reply-To: <AANLkTin9R_F-H9xn2nHCrfpx_B1T608_EMDeJ2TbXYOv@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3549534867530765370==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

2011/1/27 Sjur Br=C3=A6ndeland <sjurbren@gmail.com>:
>> I think we need these in ConnectionContext, or perhaps a separate
>> DedicatedContext interface would be better.
>
> Yes, as I mentioned earlier I considered this as well. But do you see oth=
er
> scenarios than IMS where the NW will set up Dedicated Bearers?

I have no idea. On the other hand, there should be a straightforward
way to correlate these and the context that uses them; retrieving them
from the context is such a straightforward way.

>> Also the PcscfAddresses should be part of the Settings =C2=A0or Settings6
>> in ConnectionContext.
>
> Do you think we will ever have more than one IMS ConnectionContext pr SIM?
> If not not we could probably keep the PcscfAddresses in this IMS API =C2=
=A0(see
> object-path proposal below).

Unfortunately, yes.

>>> - The UE-Mode of operation, is primarily triggered by IMS application
>>> =C2=A0registering to the RadioStack that it has registered on Voice and=
/or
>>> =C2=A0SMS by setting the properties ImsVoiceRegistered or ImsSmsRegiste=
red.
>>>
>>> - SIM identities used for IMS registration such as: PrivateImsIdentity,
>>> =C2=A0PublicImsIdentity, HomeDomainName.
>>
>> These should be available from separate interface/object, one for each I=
SIM.
>
> I guess if you have more than one SIM, you would in fact have two
> modem instances
> and two instance of this API. In the next patch I should probably use
> [{modem1},{modem2}...] as the
> object-path of this IMS object.

ISIM is an application on SIM card (also known as UICC). There can be
multiple ISIMs on a single card but only a single USIM (3G SIM
application) or 2G SIM application.

-- =

Pekka.Pessi mail at nokia.com

--===============3549534867530765370==--

