Content-Type: multipart/mixed; boundary="===============2824476410918523918=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 0/6] Return specific ofono errors after SS transaction 
Date: Tue, 29 May 2012 18:38:31 +0200
Message-ID: <1338309517-14808-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2824476410918523918==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As pointed by the first GCF tests, the user indication does not distinguish=
 the type of error occured after an SS request.
Actually, the ofono error type .Failed is returned whatever is the telephon=
y error.
In order to return more specific ofono error types, I introduced an utility=
 function to map the telephony errors into ofono errors.
I extended also the ofono error types to match more closely with the teleph=
ony errors. =


Philippe Nunes (6):
  common: Fix typos in error strings
  dbus: Add new error types
  error-mapping: Add function to map telephony errors into ofono error
    types
  build: Add error-mapping utility to build
  Return specific ofono errors according telephony errors
  Extend the list of ofono error types returned by the method initiate

 Makefile.am                       |    1 +
 doc/supplementaryservices-api.txt |    6 +++
 src/call-barring.c                |   11 ++++--
 src/call-forwarding.c             |    6 ++-
 src/call-settings.c               |   18 +++++----
 src/common.c                      |   19 ++++-----
 src/dbus.c                        |   13 +++++++
 src/error-mapping.c               |   77 +++++++++++++++++++++++++++++++++=
++++
 src/error-mapping.h               |   25 ++++++++++++
 src/ofono.h                       |    2 +
 10 files changed, 155 insertions(+), 23 deletions(-)
 create mode 100644 src/error-mapping.c
 create mode 100644 src/error-mapping.h

-- =

1.7.9.5


--===============2824476410918523918==--

