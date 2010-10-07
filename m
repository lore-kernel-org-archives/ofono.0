Content-Type: multipart/mixed; boundary="===============7876371456382658189=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: Re: Handling of Fixed Dialing
Date: Thu, 07 Oct 2010 18:28:04 +0300
Message-ID: <201010071828.04248.petteri.tikander@ixonos.com>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA802AF618B@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7876371456382658189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka and Denis,

and thanks for the comments.

I checked the invalidated-flag of EFadn (from file status-byte of GET RESPO=
NSE) =

and it actually changed according to FDN-enabling/disabling. But for some =

reason I didn't got any change in EFsst for FDN/ADN-services. Could it be a =

good idea to add also reading of EFadn in the SIM-initialization routine, =

check invalidated-flag, and make decision of continuing initialization rout=
ine =

based on that?

The other issue was that selection of service table (SIM/USIM) based on =

EFphase. So SIM returns '3' in my tests. But the SIM-card seems to be of ty=
pe =

SIM (not USIM), because I accessed some USIM-type elementary files (EFest, =

EFpbr) and those returned only error-codes. Like phase (3g) wouldn't actual=
ly =

be exactly the same thing than USIM-type. What about doing the next change =
in =

the SIM-init routine (not trusting to EFphase response when accessing the =

correct service tables):

- read first EFest
- if EFest-access gives a valid response, read EFust
- if EFest-access doesn't give a valid response, read EFsst

Br, Petteri

> =

>   I had a discussion with Denis today about both FDN and BDN status.
> =

> GSM SIM Card:(EFsst)
> =

>   In this case, FDN service status depends on the bits in EFsst and
> EFadn invalidation information.( invalidation information is part of the
> "Get RESPONSE" response data)
> =

>   EFsst - FDN is allocated and activated in the SIM:
> =

> 	FDN is enabled - When EFadn is invalidated or not activated.
>       FDN is disabled - When EFadn is validated.
> =

>   EFsst - FDN is not allocated or not activated in the SIM:
>       FDN is disabled
> =

>   Note: This information can be found in the 3GPP 11.11 specification
> section 11.5.1. Paragraph starts with "FDN capability request".
> Invalidation information bits information can be found in the 3GPP
> 51.011 specification section 9.2.1(Response parameters/data in case of
> an EF:) and section 9.3
> =

> USIM Card:(EFust, EFest)
> =

>   In USIM case, FDN enabled/disabled dependents on the bits in the EFust
> and EFest.
> =

> Let me know if something is unclear
> =

> Thanks and Regards,
> jeevaka
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
> =



--===============7876371456382658189==--

