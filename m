Content-Type: multipart/mixed; boundary="===============7501808745257188681=="
MIME-Version: 1.0
From: Kjetil ASDAL <kjetil.asdal@stericsson.com>
Subject: RE: [RFC] doc: Proposal for LTE/IMS API.
Date: Tue, 01 Feb 2011 12:01:14 +0100
Message-ID: <24601CEAED63B94588D46990641D59241B7B4D855C@EXDCVYMBSTM005.EQ1STM.local>
In-Reply-To: <AANLkTikRPOm=RG-wHKEyTBzF6tFKLpjb8hg-yYF3Jes1@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7501808745257188681==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> ---------- Forwarded message ----------
> From: =C2=A0<Jeevaka.Badrappan@elektrobit.com>
> Date: Fri, Jan 28, 2011 at 11:22 AM
> Subject: RE: [RFC] doc: Proposal for LTE/IMS API.
> To: ofono(a)ofono.org
> Cc: sjur.brandeland(a)stericsson.com
>
>
> Hi Sjur,
>
> ofono-bounces(a)ofono.org wrote:
> >
> > - SIM identities used for IMS registration such as:
> > =C2=A0 PrivateImsIdentity, PublicImsIdentity, HomeDomainName.
>
> Correct me if I'm wrong. Private Identity is the one used for
> registration, authorisation, administration and billing purposes
> whereas the Public Identity is the identity by which the other parties
> know the subscriber. Basically, Public Identity is not used for IMS
> registration.

The Private Identity is used to allow the UE access to the IMS network (for=
, =

as you say, the purpose of registration, authorization, administration and =

billing). =


The Public Identity is used to identify a specific IMS user (there may be m=
ore =

than one associated with one Private Identity). This information is conveye=
d to =

the IMS CN during registration so that the network can know what IMS users =
that =

are registered and available for service (e.g. a reception of a voice sessi=
on).

As far as I can see, the Home Network Domain Name is also part of the SIP =

registration procedure.

>
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 string =C2=A0PrivateImsIden=
tity [readonly, optional]
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 Identity used for IMS registration.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 Available if present on the ISIM.
> > +
>
> May I know whats the use of making it available to the user?
> EFimpi is a mandatory file on the ISIM, so it is available always if
> the ISIM is present in an UICC card.
>
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 string =C2=A0PublicImsIdent=
ity [readonly, optional]
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 Identity used for IMS registration.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 Available if present on the ISIM.
>
> There can be more than one public identity. And also public identity
> is not used for IMS registration. same as EFimpi, EFimpu is a
> mandatory file on the ISIM.
>
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 string =C2=A0HomeDomainName=
[readonly, optional]
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 Identity used for IMS registration.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 Available if present on the ISIM.
> > +
>
> same as EFimpi and EFimpu, EFdomain is a mandatory file.
> Correct me if I'm wrong. Domain name just indicates the home network
> of the subscriber.
> Is it really used for registration?
>
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 array{string} =C2=A0PcscfAd=
dresses[readonly]
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 Domain Name or IP Address of the P-CSCF servers.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (SIP Proxy).
>
> If I'm correct, this information also comes from the sim file EFp-cscf
> and it is optional.
>
> Regards,
> Jeevaka
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

Regards,
Kjetil

--===============7501808745257188681==--

