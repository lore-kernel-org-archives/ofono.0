Content-Type: multipart/mixed; boundary="===============6376291402260804858=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 0/1] Update possible errors
Date: Fri, 11 Feb 2011 03:34:30 -0800
Message-ID: <1297424071-5464-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6376291402260804858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

  Following patch updates the possible errors to the api documentation.
Possible error values are updated based on currently returned errors.

Regards,
Jeevaka

Jeevaka Badrappan (1):
  doc: Update possible errors

 doc/audio-settings-api.txt         |    2 -
 doc/call-barring-api.txt           |   31 ++++++++++++++++++++++
 doc/call-forwarding-api.txt        |   16 +++++++++++
 doc/call-meter-api.txt             |   14 ++++++++++
 doc/call-settings-api.txt          |    8 ++++++
 doc/call-volume-api.txt            |    9 +++---
 doc/cdma-voicecall-manager-api.txt |   10 +++++++
 doc/cell-broadcast-api.txt         |    7 ++---
 doc/connman-api.txt                |   25 ++++++++++++++----
 doc/manager-api.txt                |    2 -
 doc/message-api.txt                |    2 -
 doc/message-waiting-api.txt        |    7 +++--
 doc/messagemanager-api.txt         |   14 ++++++++--
 doc/modem-api.txt                  |   10 ++++---
 doc/network-api.txt                |   16 +++++++----
 doc/phonebook-api.txt              |    2 +-
 doc/pushnotification-api.txt       |    8 ++++++
 doc/radio-settings-api.txt         |    9 +++---
 doc/sim-api.txt                    |   37 +++++++++++++++++++++++++-
 doc/stk-api.txt                    |   17 +++++++-----
 doc/supplementaryservices-api.txt  |   20 +++++++++++---
 doc/voicecall-api.txt              |   17 +++++++++++-
 doc/voicecallmanager-api.txt       |   49 ++++++++++++++++++++++++++++++++=
++-
 23 files changed, 273 insertions(+), 59 deletions(-)


--===============6376291402260804858==--

