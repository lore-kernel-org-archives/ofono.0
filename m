Content-Type: multipart/mixed; boundary="===============1512731082069214348=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [RFC] doc: Proposal for LTE/IMS API.
Date: Thu, 27 Jan 2011 18:52:26 +0200
Message-ID: <AANLkTi==Pz3ObYKNwSF3NA_xp0Pp6C=5sgchKMfM7O0h@mail.gmail.com>
In-Reply-To: <1296053943-18748-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1512731082069214348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

2011/1/26 Sjur Br=C3=A6ndeland <sjurbren@gmail.com>:
> Features:
> - The QoS information is presented as an array of QoS settings with
> =C2=A0an associated list IP Packet Filters. Only the QoS data for
> =C2=A0connection context of type IMS will be reported.
>
> =C2=A0The assumption is that QoS is only going to be used by IMS applicat=
ions.
> =C2=A0Initially I was planning to put this in the connman-api.txt, but ba=
sed
> =C2=A0on feedback from Denis in the Paris workshop I have moved this to t=
he
> =C2=A0IMS API. If this assumption proves wrong QoS should be moved to
> =C2=A0ConnectionContext interface.

> =C2=A0The UE initiates the Default Bearer. In R8, the Network may then
> =C2=A0initiate a number of Dedicated Bearers. Each Dedicated Bearer will
> =C2=A0have a defined QoS. In order to route the IP traffic into the
> =C2=A0different Dedicated Bearers, a set of Packet Filters can be defined
> =C2=A0for each Dedicated Bearer.

I think we need these in ConnectionContext, or perhaps a separate
DedicatedContext interface would be better. The structure of QoS TFT

Also the PcscfAddresses should be part of the Settings  or Settings6
in ConnectionContext.

> - The UE-Mode of operation, is primarily triggered by IMS application
> =C2=A0registering to the RadioStack that it has registered on Voice and/or
> =C2=A0SMS by setting the properties ImsVoiceRegistered or ImsSmsRegistere=
d.
>
> - SIM identities used for IMS registration such as: PrivateImsIdentity,
> =C2=A0PublicImsIdentity, HomeDomainName.

These should be available from separate interface/object, one for each ISIM.

Otherwise, this looks fine. R=C3=A9mi and Marcel had some other concerns...

-- =

Pekka.Pessi mail at nokia.com

--===============1512731082069214348==--

