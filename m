Content-Type: multipart/mixed; boundary="===============8172012543142504138=="
MIME-Version: 1.0
From: Jukka Saunamaki <jukka.saunamaki@nokia.com>
Subject: [RFC PATCH 0/4] Automatic provisioning of GPRS context settings
Date: Tue, 21 Dec 2010 11:01:15 +0200
Message-ID: <1292922079-24711-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8172012543142504138==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello

Here is a first attempt to implement automatic provisioning of
Internet and MMS GPRS context settings. ("Internet Access Provider
database" TODO item).

In case there are no previously configured contexts found during gprs
atom registration, this code tries to provision Internet and MMS
contexts based on MCC, MNC and SPN (Service Provider Name) values read
from SIM. Settings are read from an operator settings database.

Settings database is CSV (comma separated values) formatted file(s)
with fields for: (type=3DINTERNET|MMS protocol=3Dipv4|ipv6)
MCC,MNC,SPN,type,UI name, APN, username, password, protocol, proxy IP addre=
ss, proxy port, MMS server URL

e.g. file /etc/ofono/operator-settings/50-default.csv:
001,01,test,INTERNET,Network Tester GPRS,internet,,,,,,
246,81,oFono,INTERNET,Phonesim Internet,internet.apn,,,ipv4,,,
246,81,oFono,MMS,Phonesim MMS,mms.apn,mmsuser,mmspass,ipv4,10.10.10.10,8080=
,http://192.168.0.111:8002

This format is loosely based on what was used in Nokia N900 for
similar use.

Provisioning logic goes, that first we try to find exact match for
type,MCC,MNC and SPN. If that fails (or if SPN read from SIM is
missing/empty), we select first match for type/MCC/MNC. If also that
fails, an empty context is created (as currently).

Patches also add new function ofono_sim_get_mnc_length to SIM atom API
for figuring out MNC value.

--Jukka Saunam=C3=A4ki



--===============8172012543142504138==--

