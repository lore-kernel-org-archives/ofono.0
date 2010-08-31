Content-Type: multipart/mixed; boundary="===============7092480691115905906=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: Clarification on USSD support in ofono
Date: Tue, 31 Aug 2010 18:39:39 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA802A0E1B0@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <AANLkTinDO02k1GSRUzFr3WaJX+4wxkrf_dS7L9UY2a_F@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7092480691115905906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
 =

> Yes, the driver api may need a change like this.  The current API was
created based on the fact that many modems don't understand anything
other than DCS =3D 15.  However =

> with STK's "Send USSD" command, sending the requested DCS as-is is
probably our best bet.

> There is a hope that most modems implement Send USSD in their firmware
so that ofono doesn't have to do anything (this is the case on the Texas
Instruments Calypso modem), > do you have a modem that you know does not
handle Send USSD internally?  Of course it makes sense to implement the
fallback in ofono anyway.

> Have you been working on implementation of this command? I'm asking to
avoid duplicating the effort.

No, I dont have any modem which doesn't handle the Send USSD command
internally. =


Yes, I have done some implementation. Planning to test it with the
phonesim. If needed, I can do the implementation of the Send USSD
command.

Regards,
jeevaka
_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono


----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


--===============7092480691115905906==--

