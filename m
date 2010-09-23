Content-Type: multipart/mixed; boundary="===============2397089685355511257=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Fix test-sms.
Date: Thu, 23 Sep 2010 23:31:45 +0900
Message-ID: <1285252305.20811.77.camel@localhost.localdomain>
In-Reply-To: <AANLkTim=ZYKsRmmHgN-7_4umbHBJiALw0XPrwkuYVs1H@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2397089685355511257==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> >> +if smsc:
> >> +     manager.SetProperty("ServiceCenterAddress", dbus.String(smsc))
> >
> > the SMSC is a global message manager property, I prefer to just have a
> > test script that just modifies it. Using set-service-center-address
> > would be way better then trying to include this in this test script.
> =

> What about the SRR? Should I move setting it to a separate script, too?

that is called set-use-sms-reports. So from my point of view that extra
option is not needed at all.

Regards

Marcel



--===============2397089685355511257==--

