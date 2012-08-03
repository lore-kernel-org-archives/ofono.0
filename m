Content-Type: multipart/mixed; boundary="===============5040610326561077421=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v3 0/2] Fix padding character issue in CBS message
Date: Fri, 03 Aug 2012 15:44:41 +0200
Message-ID: <1344001483-9901-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5040610326561077421==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Change log from v2:
	- Fix functions returning unsigned char * although it should not.

Guillaume Zajac (1):
  unit: Add padding character decoding test

Philippe Nunes (1):
  smsutil: <CR> is not necessarily a padding character in CBS message

 src/smsutil.c   |  138 ++++++++++++++++++++++++++++++++++++---------------=
----
 unit/test-sms.c |   58 +++++++++++++++++++++++
 2 files changed, 148 insertions(+), 48 deletions(-)

-- =

1.7.5.4


--===============5040610326561077421==--

