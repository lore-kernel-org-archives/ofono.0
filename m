Content-Type: multipart/mixed; boundary="===============0030540827575285562=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [RFC PATCHv2 1/4] Automatic provisioning of GPRS context settings 
Date: Mon, 03 Jan 2011 09:31:48 +0200
Message-ID: <1294039912-6008-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0030540827575285562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello

Here is another RFC patchset about implementing automatic provisioning of I=
nternet and MMS GPRS context settings. ("Internet Access Provider database"=
 TODO item).

In case there are no previously configured contexts found during gprs atom =
registration, this code tries to provision Internet and MMS contexts based =
on MCC, MNC and SPN (Service Provider Name) values read from SIM. Settings =
are read from an operator settings database.

Settings database is an XML formatted file (combination of all xml-files in=
 a directory), containing one element per settings for a specific type of G=
PRS context (internet, mms)
Example:
<?xml version=3D"1.0"?>
<settings>
<access type=3D"internet" mcc=3D"246" mnc=3D"81" spn=3D"oFono" name=3D"Phon=
esim Internet-GPRS" apn=3D"internet.apn"/>
<access type=3D"mms" mcc=3D"246" mnc=3D"81" spn=3D"oFono" name=3D"Phonesim =
MMS-GPRS" apn=3D"mms.apn" protocol=3D"ipv4" username=3D"mmsuser" password=
=3D"mmspass" proxy=3D"10.11.12.13:8080" mmsserver=3D"http://mms.example.com=
:8000"/>
</settings>


Provisioning logic: first try to find exact match for type,MCC,MNC and SPN.=
 If that fails (or if SPN read from SIM is missing/empty), we select first =
match for type/MCC/MNC. If also that fails, an empty context is created (as=
 currently).

Patches also add new function ofono_sim_get_mnc_length to SIM atom API
for figuring out MNC value.

--Jukka Saunam=C3=A4ki



--===============0030540827575285562==--

