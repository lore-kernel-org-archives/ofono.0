Content-Type: multipart/mixed; boundary="===============8858618271267351845=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [RFC] doc: Proposal for LTE/IMS API.
Date: Fri, 28 Jan 2011 12:22:28 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802DA10E3@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <1296053943-18748-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8858618271267351845==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

ofono-bounces(a)ofono.org wrote:
> =

> - SIM identities used for IMS registration such as:
>   PrivateImsIdentity, PublicImsIdentity, HomeDomainName.

Correct me if I'm wrong. Private Identity is the one used for registration,=
 authorisation, administration and billing purposes whereas the Public Iden=
tity is the identity by which the other parties know the subscriber. Basica=
lly, Public Identity is not used for IMS registration.

> +		string  PrivateImsIdentity [readonly, optional]
> +
> +			Identity used for IMS registration.
> +			Available if present on the ISIM.
> +

May I know whats the use of making it available to the user?
EFimpi is a mandatory file on the ISIM, so it is available always if the IS=
IM is present in an UICC card.

> +		string  PublicImsIdentity [readonly, optional]
> +
> +			Identity used for IMS registration.
> +			Available if present on the ISIM.

There can be more than one public identity. And also public identity is not=
 used for IMS registration. same as EFimpi, EFimpu is a mandatory file on t=
he ISIM.

> +
> +		string  HomeDomainName[readonly, optional]
> +
> +			Identity used for IMS registration.
> +			Available if present on the ISIM.
> +

same as EFimpi and EFimpu, EFdomain is a mandatory file.
Correct me if I'm wrong. Domain name just indicates the home network of the=
 subscriber.
Is it really used for registration?

> +		array{string}  PcscfAddresses[readonly]
> +
> +			Domain Name or IP Address of the P-CSCF servers.
> +			(SIP Proxy).

If I'm correct, this information also comes from the sim file EFp-cscf and =
it is optional.

Regards,
Jeevaka

--===============8858618271267351845==--

