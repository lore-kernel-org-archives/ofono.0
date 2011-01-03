Content-Type: multipart/mixed; boundary="===============6819926021323139272=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [RFC PATCHv2 1/4] Automatic provisioning of GPRS context settings
Date: Mon, 03 Jan 2011 10:57:39 +0200
Message-ID: <87lj32xt30.fsf@potku.valot.fi>
In-Reply-To: <1294039912-6008-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6819926021323139272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Jukka Saunamaki <jukka.saunamaki@nokia.com> writes:

> Hello

Moi Jukka,

> Settings database is an XML formatted file (combination of all
> xml-files in a directory), containing one element per settings for a
> specific type of GPRS context (internet, mms)

> Example:
> <?xml version=3D"1.0"?>
> <settings>
> <access type=3D"internet" mcc=3D"246" mnc=3D"81" spn=3D"oFono" name=3D"Ph=
onesim Internet-GPRS" apn=3D"internet.apn"/>
> <access type=3D"mms" mcc=3D"246" mnc=3D"81" spn=3D"oFono" name=3D"Phonesi=
m MMS-GPRS" apn=3D"mms.apn" protocol=3D"ipv4" username=3D"mmsuser" password=
=3D"mmspass" proxy=3D"10.11.12.13:8080" mmsserver=3D"http://mms.example.com=
:8000"/>
> </settings>

The format here doesn't look very extensible to me, more like csv with
steroids and not proper xml. Any particular reason why you can't use the
same format as in mobile-broadband-provider-info?

http://git.gnome.org/browse/mobile-broadband-provider-info/tree/serviceprov=
iders.xml

-- =

Kalle Valo

--===============6819926021323139272==--

