Content-Type: multipart/mixed; boundary="===============6237147271888560533=="
MIME-Version: 1.0
From: bruno.souben@alstomgroup.com
Subject: LTE set private APN
Date: Fri, 03 Apr 2020 14:20:59 +0000
Message-ID: <20200403142059.2692.60467@ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6237147271888560533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

During start-up, a default Ofono context is set as soon as LTE is attached =
: defaut public APN is then recorded.
How then context must be handle to change it with another private APN authe=
nticated with user, password ?
I tried to change it dynamically with dbus (AccessPointName, Username, Pass=
word) but error message "The resource is currently in use" is returned

Ofono 1.24
Modem Quectel EC25
--===============6237147271888560533==--

