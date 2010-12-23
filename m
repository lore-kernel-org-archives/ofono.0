Content-Type: multipart/mixed; boundary="===============6510914362089905155=="
MIME-Version: 1.0
From: Neil Jerram <neil@ossau.uklinux.net>
Subject: Re: PATCH: Enable udev-based autodetection of calypso modem on
 Freerunner
Date: Thu, 23 Dec 2010 12:02:22 +0000
Message-ID: <87vd2k8zox.fsf@ossau.uklinux.net>
In-Reply-To: <1293025029.2658.70.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6510914362089905155==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann <marcel@holtmann.org> writes:

> Hi Neil,
>
>> (I don't yet understand why it makes sense for calypso to be handled
>> differently from other cases in plugins/ofono.rules, but I'm happy to
>> trust that there is a good reason for this.)
>
> the other cases come from an unique vendor and product ID. The Calypso
> and also IFX modems are based on device nodes. These are not unique.
> They are platform specific. Not all platform will have a Calypso modem
> behind /dev/ttySAC0 for example.

Ah yes, that makes sense.  Thanks for explaining.

     Neil

--===============6510914362089905155==--

