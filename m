Content-Type: multipart/mixed; boundary="===============3758906905969882220=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: Handling of Fixed Dialing
Date: Wed, 06 Oct 2010 18:36:21 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA802AF618B@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <1286374677-2932-1-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3758906905969882220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

> First patch checks if Fixed Dialing is enabled in the SIM-card by
reading FD-activated bit from EFsst or EFest. If FDN is enabled, SIM
initialization procedure is stopped, > and modem will stay in the
PRE-SIM state. =

> If FD is enabled, this is signaled via DBUS.

> I haven't been abled to test this in my 2G-modem properly. Response
for EF-phase is 3. So oFono-API starts to access EFust/EFest files. =

> But reading of EFest gives next error:

> 'technical problem with no diagnostic given'. =


> So FD-status is no reachable, although I have activated it in the
SIM-card.
> I also checked if the FD-status could be located in EFsst (well,
accessed with same code as with EFust), but I couldn't give any change
for allocated/activated bits for =

> FDN, even though I enabled/disabled FDN.

> Please comment/test.

  I had a discussion with Denis today about both FDN and BDN status.

GSM SIM Card:(EFsst)

  In this case, FDN service status depends on the bits in EFsst and
EFadn invalidation information.( invalidation information is part of the
"Get RESPONSE" response data)
  =

  EFsst - FDN is allocated and activated in the SIM:
     =

	FDN is enabled - When EFadn is invalidated or not activated.
      FDN is disabled - When EFadn is validated.

  EFsst - FDN is not allocated or not activated in the SIM:
      FDN is disabled

  Note: This information can be found in the 3GPP 11.11 specification
section 11.5.1. Paragraph starts with "FDN capability request".
Invalidation information bits information can be found in the 3GPP
51.011 specification section 9.2.1(Response parameters/data in case of
an EF:) and section 9.3

USIM Card:(EFust, EFest) =


  In USIM case, FDN enabled/disabled dependents on the bits in the EFust
and EFest. =


Let me know if something is unclear

Thanks and Regards,
jeevaka

--===============3758906905969882220==--

