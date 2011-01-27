Content-Type: multipart/mixed; boundary="===============7545945517219605884=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [RFC] doc: Proposal for LTE/IMS API.
Date: Thu, 27 Jan 2011 18:37:36 +0100
Message-ID: <AANLkTin9R_F-H9xn2nHCrfpx_B1T608_EMDeJ2TbXYOv@mail.gmail.com>
In-Reply-To: <AANLkTi==Pz3ObYKNwSF3NA_xp0Pp6C=5sgchKMfM7O0h@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7545945517219605884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

>> Features:
>> - The QoS information is presented as an array of QoS settings with
>> =C2=A0an associated list IP Packet Filters. Only the QoS data for
>> =C2=A0connection context of type IMS will be reported.
>>
>> =C2=A0The assumption is that QoS is only going to be used by IMS applica=
tions.
>> =C2=A0Initially I was planning to put this in the connman-api.txt, but b=
ased
>> =C2=A0on feedback from Denis in the Paris workshop I have moved this to =
the
>> =C2=A0IMS API. If this assumption proves wrong QoS should be moved to
>> =C2=A0ConnectionContext interface.
>
>> =C2=A0The UE initiates the Default Bearer. In R8, the Network may then
>> =C2=A0initiate a number of Dedicated Bearers. Each Dedicated Bearer will
>> =C2=A0have a defined QoS. In order to route the IP traffic into the
>> =C2=A0different Dedicated Bearers, a set of Packet Filters can be defined
>> =C2=A0for each Dedicated Bearer.
>
> I think we need these in ConnectionContext, or perhaps a separate
> DedicatedContext interface would be better.

Yes, as I mentioned earlier I considered this as well. But do you see other
scenarios than IMS where the NW will set up Dedicated Bearers?

> Also the PcscfAddresses should be part of the Settings =C2=A0or Settings6
> in ConnectionContext.

Do you think we will ever have more than one IMS ConnectionContext pr SIM?
If not not we could probably keep the PcscfAddresses in this IMS API  (see
object-path proposal below).

>> - The UE-Mode of operation, is primarily triggered by IMS application
>> =C2=A0registering to the RadioStack that it has registered on Voice and/=
or
>> =C2=A0SMS by setting the properties ImsVoiceRegistered or ImsSmsRegister=
ed.
>>
>> - SIM identities used for IMS registration such as: PrivateImsIdentity,
>> =C2=A0PublicImsIdentity, HomeDomainName.
>
> These should be available from separate interface/object, one for each IS=
IM.

I guess if you have more than one SIM, you would in fact have two
modem instances
and two instance of this API. In the next patch I should probably use
[{modem1},{modem2}...] as the
object-path of this IMS object.


Regards,
Sjur

--===============7545945517219605884==--

