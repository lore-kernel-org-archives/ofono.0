Content-Type: multipart/mixed; boundary="===============2145549508982524242=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: Re: [RFC PATCH 0/4] Automatic provisioning of GPRS context settings
Date: Wed, 22 Dec 2010 12:08:11 +0200
Message-ID: <4D11CE0B.2040402@nokia.com>
In-Reply-To: <1292940661.2658.23.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2145549508982524242==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

On 21/12/10 16:11, ext Marcel Holtmann wrote:
>> Settings database is CSV (comma separated values) formatted file(s)
>> with fields for: (type=3DINTERNET|MMS protocol=3Dipv4|ipv6)
>> MCC,MNC,SPN,type,UI name, APN, username, password, protocol, proxy IP ad=
dress, proxy port, MMS server URL
>>
>> e.g. file /etc/ofono/operator-settings/50-default.csv:
>> 001,01,test,INTERNET,Network Tester GPRS,internet,,,,,,
>> 246,81,oFono,INTERNET,Phonesim Internet,internet.apn,,,ipv4,,,
>> 246,81,oFono,MMS,Phonesim MMS,mms.apn,mmsuser,mmspass,ipv4,10.10.10.10,8=
080,http://192.168.0.111:8002
>>
>> This format is loosely based on what was used in Nokia N900 for
>> similar use.
> I am really not set on a file format, but my obvious question is if we
> don't wanna better use keyfile or XML based database since that are the
> file formats we are currently using inside oFono. We have not used CSV
> at all so far.
>
> My vote would go for keyfile or XML since it is a bit more self
> explanatory with its fields. And the order of values doesn't really
> matter.
>
> The one thing that I don't like about CSV is that you have no real
> flexibility with its format. Especially coming think about that we might
> have to extend this additional information for IMS or operator specific
> behavior.

Good points. I suggested csv, because it is very simple and fast to =

parse, and it has proven to be "good enough" for this specific purpose. =

But, true, it is also very inflexible.
So, how about something like this XML format: (better element name =

suggestions welcome)

<?xml version=3D"1.0"?>
<settings>
<access type=3D"internet" mcc=3D"001" mnc=3D"01" spn=3D"test" name=3D"Examp=
le =

Internet GPRS" apn=3D"internet" protocol=3D"ipv4"/>
<access type=3D"mms" mcc=3D"001" mnc=3D"01" spn=3D"test" name=3D"Example MM=
S GPRS" =

apn=3D"mms" proxy=3D"10.11.12.13:8080" mmsserver=3D"http://mms.example.com:=
8000"/>
<access ... />
...
</settings>

This would still be quite easy and fast to parse (using glib simple XML =

parser), would not be hugely larger in size and would allow easy adding =

of new attributes/values.

Also, do you or anybody have comments about the logic of provisioning, =

and changes to sim and gprs parts?

--Jukka Saunam=C3=A4ki


--===============2145549508982524242==--

