Content-Type: multipart/mixed; boundary="===============1391586516360439911=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Need Help with GetProperties() method on SimManager interface.
Date: Tue, 05 Oct 2010 16:57:19 +0200
Message-ID: <1286290639.2588.2.camel@aeonflux>
In-Reply-To: <AANLkTimDSTJU6hsQSK1V8BO33KXSxA7nACkyyDfGBFmh@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1391586516360439911==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sai,

>      We are testing SimManager interface , In that we want to check
> the whether sim is present  or not.
>      To do  that we are invoking "GetProperties" method on SimManager
> interface , but in return we are getting all the properties on the
> given interface .
>      As a result of this we are facing some delays  to parse all properti=
es,
> =

> is there any mechanism in ofono to get value of the required property
> on the given interface?

no there is not. When starting your application you are suppose to get
all properties of an interface. And from there on use signals to monitor
its changes.

Regards

Marcel



--===============1391586516360439911==--

