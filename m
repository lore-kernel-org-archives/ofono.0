Content-Type: multipart/mixed; boundary="===============8909894064075000324=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH] Fix test-sms.
Date: Thu, 23 Sep 2010 17:14:33 +0300
Message-ID: <AANLkTim=ZYKsRmmHgN-7_4umbHBJiALw0XPrwkuYVs1H@mail.gmail.com>
In-Reply-To: <1285208096.20811.62.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8909894064075000324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,
>> +if smsc:
>> + =C2=A0 =C2=A0 manager.SetProperty("ServiceCenterAddress", dbus.String(=
smsc))
>
> the SMSC is a global message manager property, I prefer to just have a
> test script that just modifies it. Using set-service-center-address
> would be way better then trying to include this in this test script.

What about the SRR? Should I move setting it to a separate script, too?

-- =

Pekka.Pessi mail at nokia.com

--===============8909894064075000324==--

