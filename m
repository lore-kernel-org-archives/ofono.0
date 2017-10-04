Content-Type: multipart/mixed; boundary="===============4614806073556292104=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/7] sim-auth: implementation of core sim-auth atom
Date: Tue, 03 Oct 2017 22:33:07 -0500
Message-ID: <625c0cdb-4877-7e24-0e69-a775911eb110@gmail.com>
In-Reply-To: <e9e114d5-a809-5892-1736-d58d52709f20@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4614806073556292104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> org.ofono.SimAuthentication on path /modem1
> =

> SimAuthentication would have a property with signature 'a{sv}' Applicatio=
ns
> =


Actually reminds me that all our other interfaces do it using the =

array{object,dict} pattern.

E.g. array{object,dict} GetModems()
array{object,dict} GetCards()
array{object,dict} GetContexts()

So we should stick to that.

> where
> - 'o' Path -> Path to the application, something like /modem1/aid

So this part would just be the 'object' above serving as the key.

> - 's' Type -> Gsm/Umts/Ims.=C2=A0 The interface (USimApplication, =

> ISimApplication, etc) would depend on the type.
> - 's' Name -> Human readable name
> =


Regards,
-Denis

--===============4614806073556292104==--

