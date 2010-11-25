Content-Type: multipart/mixed; boundary="===============8193322532364203565=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 0/3] Patch Description
Date: Thu, 25 Nov 2010 20:28:59 +0800
Message-ID: <1290688142-14726-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8193322532364203565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series of patch is to add provide local info support by requesting the=
 terminal to send time and language info. Please comment on the following a=
spects as I'm not sure after reading the spec:
1. Timezone may be a number in the range -47 through +48. In struct sms_sct=
s, timezone is defined as gint8, thus 0xFF should shand for -1, which is a =
valid input. Thus I think build_dataobj_datetime_timezone() in src/stkutil.=
c is not correct. But I'm still not sure what value should be passed to oFo=
no when timezone is absent. =

2. DBUS_TYPE_BYTE represents an 8-bit unsigned integer, and D-Bus doesn't h=
ave a type related to 8-bit signed integer. So what's the best way to repre=
sent a timezone? =

3. Only one byte is used to represent the year. Is the following logic corr=
ect to get the year with one byte?
if (year_dbus >=3D 2000)
	year =3D year_dbus - 2000;
else
	year =3D year_dbus - 1900; =


Yang Gu (3):
  network: Use bit as size instead of byte
  stk: Handle provide local info proactive command
  test-stk: Add provide local info

 src/network.c      |    4 +-
 src/smsutil.c      |    6 +-
 src/stk.c          |  113 ++++++++++++++++++++++++++++++++++++++
 src/stkagent.c     |  153 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/stkagent.h     |   14 +++++
 src/stkutil.c      |    2 +-
 test/test-stk-menu |   36 ++++++++++++
 7 files changed, 322 insertions(+), 6 deletions(-)

-- =

1.7.2.3


--===============8193322532364203565==--

