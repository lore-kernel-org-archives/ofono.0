Content-Type: multipart/mixed; boundary="===============8894927079826905177=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 0/2] Fix padding character issue in CBS message
Date: Fri, 03 Aug 2012 15:00:30 +0200
Message-ID: <1343998832-8111-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8894927079826905177==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Change log from v1:
	- Simplify cbs_decode_text() for more clarity
	- Fix M3 issue in previous patch
	- Add unit test to check padding character is correctly handled

Guillaume Zajac (1):
  unit: Add padding character decoding test

Philippe Nunes (1):
  smsutil: <CR> is not necessarily a padding character in CBS message

 src/smsutil.c   |  142 ++++++++++++++++++++++++++++++++++++---------------=
----
 unit/test-sms.c |   58 ++++++++++++++++++++++
 2 files changed, 152 insertions(+), 48 deletions(-)

-- =

1.7.5.4


--===============8894927079826905177==--

