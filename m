Content-Type: multipart/mixed; boundary="===============1755230090163043478=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: Handling of Fixed Dialing v4
Date: Fri, 15 Oct 2010 00:02:47 +0300
Message-ID: <1287090175-3018-1-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1755230090163043478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The goal of these patches is to check, if Fixed Dialing is enabled in SIM-c=
ard.
Because also invalidation/rehabilitation status of ADN has to be checked,
functionality is added for retrieving file-status of EF-files.
So general information of EF-files is returned (containing now also file st=
atus)
without starting the actual EF-content retrieving.

The FDN-enable status is checked. If FDN is enabled, SIM-initialisation rou=
tine is =

interrupted (modem is left in PRE-SIM state), and FD-enabled property is si=
gnalled =

over D-BUS.

oFono still trusts to EFphase value when selecting SIM/USIM access.



--===============1755230090163043478==--

