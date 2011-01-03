Content-Type: multipart/mixed; boundary="===============5324959424371468877=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: Re: [RFC PATCHv2 1/4] Automatic provisioning of GPRS context settings
Date: Mon, 03 Jan 2011 12:44:19 +0200
Message-ID: <1294051459.2077.22.camel@jsaunama-desktop>
In-Reply-To: <87lj32xt30.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5324959424371468877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello

On Mon, 2011-01-03 at 10:57 +0200, Kalle Valo wrote:
> Jukka Saunamaki <jukka.saunamaki@nokia.com> writes:
> > Settings database is an XML formatted file (combination of all
> > xml-files in a directory), containing one element per settings for a
> > specific type of GPRS context (internet, mms)
> =

> > Example:
> > <?xml version=3D"1.0"?>
> > <settings>
> > <access type=3D"internet" mcc=3D"246" mnc=3D"81" spn=3D"oFono" name=3D"=
Phonesim Internet-GPRS" apn=3D"internet.apn"/>
> > <access type=3D"mms" mcc=3D"246" mnc=3D"81" spn=3D"oFono" name=3D"Phone=
sim MMS-GPRS" apn=3D"mms.apn" protocol=3D"ipv4" username=3D"mmsuser" passwo=
rd=3D"mmspass" proxy=3D"10.11.12.13:8080" mmsserver=3D"http://mms.example.c=
om:8000"/>
> > </settings>
> =

> The format here doesn't look very extensible to me, more like csv with
> steroids and not proper xml. Any particular reason why you can't use the
> same format as in mobile-broadband-provider-info?
> =

> http://git.gnome.org/browse/mobile-broadband-provider-info/tree/servicepr=
oviders.xml

Well, my intention was to make format simple and fast to parse, but
still be extensible enough, which I think my proposed format fulfills. =


These <access>-elements contain just data needed for GPRS context
settings (as attributes), and if there is need for any other operator
specific provisioning information, you can always add separate elements,
this is still proper XML.

--Jukka
 =




--===============5324959424371468877==--

