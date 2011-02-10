Content-Type: multipart/mixed; boundary="===============3377598816530019728=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [RFC PATCH 0/1] Gprs context provisioning plugin
Date: Thu, 10 Feb 2011 14:54:49 +0200
Message-ID: <1297342490-8123-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3377598816530019728==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello

Following patch introduces a gprs context provisioning plugin.

It tries to find settings from a operator settings database for internet an=
d mms type of gprs contexts. ims and wap types may be added later.

Provisioning logic: first try to find exact match for type,MCC,MNC and SPN.=
 If that fails (or if SPN read from SIM is missing/empty), select first mat=
ch for type/MCC/MNC.

Settings database is an XML formatted file, containing one <access>-element=
 per settings for a specific type of GPRS context (internet, mms, ims)

Example:
<?xml version=3D"1.0"?>
<settings>
<access type=3D"internet" mcc=3D"246" mnc=3D"81" spn=3D"oFono" name=3D"Phon=
esim Internet" apn=3D"internet.apn"/>
<access type=3D"mms" mcc=3D"246" mnc=3D"81" spn=3D"oFono" name=3D"Phonesim =
MMS" apn=3D"mms.apn" protocol=3D"ipv4" username=3D"mmsuser" password=3D"mms=
pass" proxy=3D"10.11.12.13:8080" mmsc=3D"http://mms.example.com:8000"/>
</settings>

Plugin reads xml-files from a settings file directory in alphabetical order=
, until matching settings are found. This enables easy way to enable local =
variants by just installing separate configuration package that provides va=
riant specific xml-file with name alphabetically earlier than the default s=
ettings file.


Open issue:
* Location of settings files: current code uses $CONFIGDIR/operator-setting=
s, but I guess something like /usr/share/operator-settings would be better?=
 (autoconf magic help needed)

--Jukka

--===============3377598816530019728==--

