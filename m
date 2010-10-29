Content-Type: multipart/mixed; boundary="===============6214010644057223872=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: oFono SMS Validity Period and Message Class support
Date: Fri, 29 Oct 2010 03:09:16 -0700
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702BC71CC@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <C6FAFDDBC4402D44BFC43E57565F0219045093F4@ala-mail09.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6214010644057223872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> Hi, all:
>  =

> We are using ofono to send sms with validity period and =

> message class in our project.
> but by checking source code, it seems ofono doesn't support =

> these requirements.   =

> =

> Current implemntation is the dbus interface "SendMessage" =

> contains "To" and "Text" only.
>  =

> Does oFono plan to support these extra fields when sending sms? =

>  =


Right now oFono uses hardcoded Relative validity period of value
167 (24hrs: 12hrs +(167-143)x30mins)for SUBMIT message. =


If later supported then the Validity period should be part of the
SMS app settings and the setting changes will trigger the property
change in the org.ofono.MessageManager interface. But currently =

Validity Period property is missing in org.ofono.MessageManager
interface. So it doesnt need to be part of the SendMessage dbus
interface ?

Regarding the message class, none of the UE usually gives the a
user setting for message class for outgoing SMS. So oFono uses
unspecified message class and it sets only the encoding type
(GSM 7bit or UCS2) in the DCS byte for the SUBMIT message. For
the SMS DELIVER it decodes the Message class and handles it =

accordingly (Note: Class 2 messages are not supported in oFono)

BR,
Rajesh

--===============6214010644057223872==--

