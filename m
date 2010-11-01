Content-Type: multipart/mixed; boundary="===============2092063093664419522=="
MIME-Version: 1.0
From: Su, Yong <Yong.Su@windriver.com>
Subject: RE: oFono SMS Validity Period and Message Class support
Date: Sun, 31 Oct 2010 20:44:33 -0700
Message-ID: <C6FAFDDBC4402D44BFC43E57565F021904590D98@ala-mail09.corp.ad.wrs.com>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702BC71CC@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2092063093664419522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


 Hi,

> -----Original Message-----
> From: Rajesh.Nagaiah(a)elektrobit.com =

> [mailto:Rajesh.Nagaiah(a)elektrobit.com] =

> Sent: 2010?10?29? 18:09
> To: ofono(a)ofono.org
> Subject: RE: oFono SMS Validity Period and Message Class support
> =

> Hi,
> =

> > Hi, all:
> >  =

> > We are using ofono to send sms with validity period and =

> message class =

> > in our project.
> > but by checking source code, it seems ofono doesn't support =

> > these requirements.   =

> > =

> > Current implemntation is the dbus interface "SendMessage" =

> > contains "To" and "Text" only.
> >  =

> > Does oFono plan to support these extra fields when sending sms? =

> >  =

> =

> Right now oFono uses hardcoded Relative validity period of value
> 167 (24hrs: 12hrs +(167-143)x30mins)for SUBMIT message. =

> =

> If later supported then the Validity period should be part of =

> the SMS app settings and the setting changes will trigger the =

> property change in the org.ofono.MessageManager interface. =

> But currently Validity Period property is missing in =

> org.ofono.MessageManager interface. So it doesnt need to be =

> part of the SendMessage dbus interface ?
> =

> Regarding the message class, none of the UE usually gives the =

> a user setting for message class for outgoing SMS. So oFono =

> uses unspecified message class and it sets only the encoding =

> type (GSM 7bit or UCS2) in the DCS byte for the SUBMIT =

> message. For the SMS DELIVER it decodes the Message class and =

> handles it accordingly (Note: Class 2 messages are not =

> supported in oFono)
> =

> BR,
> Rajesh
> =

> =


Thanks for your feedback. I know you are the CDMS SMS owner from the TODO l=
ist. =


We are developing one GSM&CDMA dual mode phone.  But current ofono is not s=
upport CDMA SMS decode&encode as ISA637 PDU format. =


Can I ask you another question about CDMA SMS? =


I want to know the CDMA SMS delepment schedule if possible. =


Thank you very much




--===============2092063093664419522==--

