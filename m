Content-Type: multipart/mixed; boundary="===============0271222904838234972=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [RFC] doc: Proposal for LTE/IMS API.
Date: Fri, 28 Jan 2011 17:11:49 +0200
Message-ID: <AANLkTi=+9Z=Xeywtj8TOcNwnD+AYNTPz9g4m_Di+e6Ef@mail.gmail.com>
In-Reply-To: <4D42A866.5040604@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0271222904838234972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Arun,

2011/1/28 Arun Ravindran <ext-arun.1.ravindran@nokia.com>:
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0boolean ImsVoiceOverPs [readonly, opt=
ional]
>> =C2=A0+
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IMS voice is enabled by=
 network
>> =C2=A0+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Related AT command: AT+=
CIREP.
>> =C2=A0+
>
> Which specification details this AT command, searched in 27.007 rel 10, b=
ut
> it is not available there.

According to the 27.007 CRs, it should be in 10.0.0:

http://www.3gpp.org/ftp/specs/html-info/27007-CRs.htm

My copy is 10.2., and it has CIREP along with +CIREPI,+ CIRPEH and +CISRVCC,

> Isn't ISR a property by default a UE should have when it is registered to
> LTE?. 23.401 says ISR support is mandatory for E-UTRAN UEs that support
> GERAN and/or UTRAN and optional for the network.
> i don't think this setting should affect ISR behavior.

The ISR means that device is registered to both 2G/3G and LTE. It
might receive pagings from both of these radio networks. However, the
network needs to know if the currently available radio network
supports PS voice or not, so the device has to update its state when
changing between LTE radio supporting PS voice and other radio not
supporting it.

-- =

Pekka.Pessi mail at nokia.com

--===============0271222904838234972==--

