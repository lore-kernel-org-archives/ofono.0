Content-Type: multipart/mixed; boundary="===============7538543694359036958=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 0/4] Automatic provisioning of GPRS context settings
Date: Tue, 21 Dec 2010 06:11:01 -0800
Message-ID: <1292940661.2658.23.camel@aeonflux>
In-Reply-To: <1292922079-24711-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7538543694359036958==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

> Here is a first attempt to implement automatic provisioning of
> Internet and MMS GPRS context settings. ("Internet Access Provider
> database" TODO item).
> =

> In case there are no previously configured contexts found during gprs
> atom registration, this code tries to provision Internet and MMS
> contexts based on MCC, MNC and SPN (Service Provider Name) values read
> from SIM. Settings are read from an operator settings database.
> =

> Settings database is CSV (comma separated values) formatted file(s)
> with fields for: (type=3DINTERNET|MMS protocol=3Dipv4|ipv6)
> MCC,MNC,SPN,type,UI name, APN, username, password, protocol, proxy IP add=
ress, proxy port, MMS server URL
> =

> e.g. file /etc/ofono/operator-settings/50-default.csv:
> 001,01,test,INTERNET,Network Tester GPRS,internet,,,,,,
> 246,81,oFono,INTERNET,Phonesim Internet,internet.apn,,,ipv4,,,
> 246,81,oFono,MMS,Phonesim MMS,mms.apn,mmsuser,mmspass,ipv4,10.10.10.10,80=
80,http://192.168.0.111:8002
> =

> This format is loosely based on what was used in Nokia N900 for
> similar use.

I am really not set on a file format, but my obvious question is if we
don't wanna better use keyfile or XML based database since that are the
file formats we are currently using inside oFono. We have not used CSV
at all so far.

My vote would go for keyfile or XML since it is a bit more self
explanatory with its fields. And the order of values doesn't really
matter.

The one thing that I don't like about CSV is that you have no real
flexibility with its format. Especially coming think about that we might
have to extend this additional information for IMS or operator specific
behavior.

Regards

Marcel



--===============7538543694359036958==--

