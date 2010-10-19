Content-Type: multipart/mixed; boundary="===============7328623876195926464=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: Identification of Active Application in UICC card
Date: Tue, 19 Oct 2010 07:38:47 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA802B3818D@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7328623876195926464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi,

According to 3GPP specification 3GPP TS 31.102 section 5.1.1 USIM
application selection, "After UICC activation, the ME selects a USIM
application. If no EFDIR file is found or no USIM applications are
listed in the EFDIR file, the ME may then try to select the GSM
application as specified in TS 51.011".

 If EFdir is present and if AID present is matching with the USIM
AID(RID =3D A000000087, Application Code =3D 1002), then the selected/active
application is 3G USIM. If EFdir is not present or the AID present is
matching with the SIM AID(RID =3D A000000009, ETSI application code =3D
0001), then the selected/active application is GSM. Information on the
AID and RID can be found in the specification 3GPP TS 31.110.

RID - Registered application provider identifier
AID - Application Identifier

 Since almost all the cards nowdays are UICC cards and EFdir is also a
mandatory file, can we rely on the EFdir to confirm the active
application? This way, we can avoid reading of files which are not
present in the active application and also we can avoid issuing of
multiple read requests for the same file(eg: EFecc)

Thanks and Regards,
jeevaka

--===============7328623876195926464==--

