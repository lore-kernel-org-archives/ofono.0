Content-Type: multipart/mixed; boundary="===============4362554734915901224=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [RFC PATCHv2 1/4] Automatic provisioning of GPRS context settings
Date: Mon, 03 Jan 2011 13:40:13 +0200
Message-ID: <87hbdqxlk2.fsf@potku.valot.fi>
In-Reply-To: <1294051459.2077.22.camel@jsaunama-desktop>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4362554734915901224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Jukka Saunamaki <jukka.saunamaki@nokia.com> writes:

> Hello

Moro,

> On Mon, 2011-01-03 at 10:57 +0200, Kalle Valo wrote:
>> Jukka Saunamaki <jukka.saunamaki@nokia.com> writes:
>>
>> > <access type=3D"mms" mcc=3D"246" mnc=3D"81" spn=3D"oFono" name=3D"Phon=
esim MMS-GPRS" apn=3D"mms.apn" protocol=3D"ipv4" username=3D"mmsuser" passw=
ord=3D"mmspass" proxy=3D"10.11.12.13:8080" mmsserver=3D"http://mms.example.=
com:8000"/>
>> > </settings>
>> =

>> The format here doesn't look very extensible to me, more like csv with
>> steroids and not proper xml. Any particular reason why you can't use the
>> same format as in mobile-broadband-provider-info?
>> =

>> http://git.gnome.org/browse/mobile-broadband-provider-info/tree/servicep=
roviders.xml
>
> Well, my intention was to make format simple and fast to parse, but
> still be extensible enough, which I think my proposed format fulfills. =

>
> These <access>-elements contain just data needed for GPRS context
> settings (as attributes), and if there is need for any other operator
> specific provisioning information, you can always add separate elements,
> this is still proper XML.

But IMHO it is really ugly and not a properly designed XML. You could do
the same even with this style of CSV and have the same extensibility:

type=3D"internet",mcc=3D"246",mnc=3D"81",spn=3D"oFono",\
name=3D"Phonesim Internet-GPRS",pn=3D"internet.apn"

If you want to use XML, why not do it properly? XML parsing can't be
that performance critical. And if it is (to my great surprise), then XML
is not the correct choise for this.

Again, why not use mobile-broadband-provider-info DTD? If there's something
missing, I'm sure maintainers are willing to extend it. No need to
reinvent the wheel.

-- =

Kalle Valo

--===============4362554734915901224==--

