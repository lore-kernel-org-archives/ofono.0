Content-Type: multipart/mixed; boundary="===============2240236949702777253=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: Handling of Fixed Dialing
Date: Thu, 07 Oct 2010 19:40:08 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA802AF634E@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <201010071828.04248.petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2240236949702777253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 =

Hi Petteri,

> and thanks for the comments.

> I checked the invalidated-flag of EFadn (from file status-byte of GET
RESPONSE) and it actually changed according to FDN-enabling/disabling.
But for some reason I didn't =

> got any change in EFsst for FDN/ADN-services. Could it be a good idea
to add also reading of EFadn in the SIM-initialization routine, check
invalidated-flag, and make =

> decision of continuing initialization routine based on that?

  Exactly, thats what the specification also says. EFsst will inform 2
things: SIM's capabilty to support the service and service's
availability for the card holder. EFadn's file status is the one we need
to depend on for FDN enabled/disabled status. =


> The other issue was that selection of service table (SIM/USIM) based
on EFphase. So SIM returns '3' in my tests. But the SIM-card seems to be
of type SIM (not USIM), =

> because I accessed some USIM-type elementary files (EFest,
> EFpbr) and those returned only error-codes. Like phase (3g) wouldn't
actually be exactly the same thing than USIM-type. What about doing the
next change in the SIM-init =

> routine (not trusting to EFphase response when accessing the correct
service tables):

> - read first EFest
> - if EFest-access gives a valid response, read EFust
> - if EFest-access doesn't give a valid response, read EFsst

EFphase information is not the correct way to determine the SIM card
type(SIM/USIM). =


In most of the message based modems(eg: isimodem), there exists a
mechanism to get the type of the card. =


AT based modem is the issue. Since most of the AT based modems doesn't
support AT+CSIM, its difficult to determine the card type.

I still believe that we need to determine the card type during the SIM
initialization itself for reading the right SIM files.

Regards,
jeevaka


--===============2240236949702777253==--

