Content-Type: multipart/mixed; boundary="===============1651374434562546672=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Implementing support for a  new modem- how to?
Date: Wed, 25 Aug 2010 17:27:59 +0200
Message-ID: <1282750079.6841.51.camel@localhost.localdomain>
In-Reply-To: <B668883EB5DD7144ADFC248A72176EA8029A85B1@fioues07.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1651374434562546672==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Arun,

> We are working with this type of modem,  and would like to submit
> patches to oFono. We found that we have to make few modifications to
> some of the AT command responses and also may have to introduce to
> support for a few new commands. =

> =

> We found that in network registration sms, call meter and gprs there
> are few AT command responses which differ from what is available in
> the generic AT modem of ofono. There are few new commands to be
> supported in network registration, gprs context etc, in order to
> support this modem.
> =

> Do we need write new atom drivers even though the change is only in
> one of the AT command response?, or can we use the vendor variable
> (where ever available) to include this, as part of the generic at
> modem drivers?
> =

> What is the recommended way to implement support for such a modem, so
> that we can start submitting patches?

there is no generic answer to this. Until you post patches and show us
details on what is different from the GSM AT command specification this
is all speculations.

However there are two ways:

a) Write a new atom driver

b) Use the atmodem atom driver with a vendor quirk

In a lot of cases we just do vendor quirks. Check the source code for
examples. But again, until we have more details, I can't tell what is
the correct approach for your specific modem.

Regards

Marcel



--===============1651374434562546672==--

