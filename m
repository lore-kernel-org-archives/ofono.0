Content-Type: multipart/mixed; boundary="===============4891164944813542293=="
MIME-Version: 1.0
From: Martin Pitt <martin.pitt@ubuntu.com>
Subject: [PATCH 5/5] test: Convert to Python 3
Date: Tue, 11 Mar 2014 17:39:22 +0100
Message-ID: <1394555962-21661-5-git-send-email-martin.pitt@ubuntu.com>
In-Reply-To: <1394555962-21661-1-git-send-email-martin.pitt@ubuntu.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4891164944813542293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Change raw_input() to input() and unicode to str. This is *not* compatible =
with
Python 2. Update the hashbangs to run with Python 3.
---
 test/activate-context          |  2 +-
 test/answer-calls              |  2 +-
 test/backtrace                 |  2 +-
 test/cancel-ussd               |  2 +-
 test/cdma-connman-disable      |  2 +-
 test/cdma-connman-enable       |  2 +-
 test/cdma-dial-number          |  2 +-
 test/cdma-hangup               |  2 +-
 test/cdma-list-call            |  2 +-
 test/cdma-set-credentials      |  2 +-
 test/change-pin                |  2 +-
 test/create-internet-context   |  2 +-
 test/create-mms-context        |  2 +-
 test/create-multiparty         |  2 +-
 test/deactivate-all            |  2 +-
 test/deactivate-context        |  2 +-
 test/dial-number               |  2 +-
 test/disable-call-forwarding   |  2 +-
 test/disable-gprs              |  2 +-
 test/disable-modem             |  2 +-
 test/display-icon              |  2 +-
 test/dundee-connect            |  2 +-
 test/dundee-disconnect         |  2 +-
 test/enable-cbs                |  2 +-
 test/enable-gprs               |  2 +-
 test/enable-modem              |  2 +-
 test/enter-pin                 |  2 +-
 test/get-icon                  |  2 +-
 test/get-operators             |  2 +-
 test/get-tech-preference       |  2 +-
 test/hangup-active             |  2 +-
 test/hangup-all                |  2 +-
 test/hangup-call               |  2 +-
 test/hangup-multiparty         |  2 +-
 test/hold-and-answer           |  2 +-
 test/initiate-ussd             |  4 ++--
 test/list-calls                |  2 +-
 test/list-contexts             |  2 +-
 test/list-messages             |  2 +-
 test/list-modems               |  2 +-
 test/list-operators            |  2 +-
 test/lock-pin                  |  2 +-
 test/lockdown-modem            |  2 +-
 test/monitor-dundee            |  4 ++--
 test/monitor-ofono             |  4 ++--
 test/offline-modem             |  2 +-
 test/online-modem              |  2 +-
 test/private-chat              |  2 +-
 test/process-context-settings  |  2 +-
 test/receive-sms               |  2 +-
 test/reject-calls              |  2 +-
 test/release-and-answer        |  2 +-
 test/release-and-swap          |  2 +-
 test/remove-contexts           |  2 +-
 test/reset-pin                 |  2 +-
 test/scan-for-operators        |  2 +-
 test/send-sms                  |  2 +-
 test/send-ussd                 |  4 ++--
 test/send-vcal                 |  2 +-
 test/send-vcard                |  2 +-
 test/set-call-forwarding       |  2 +-
 test/set-cbs-topics            |  2 +-
 test/set-context-property      |  2 +-
 test/set-fast-dormancy         |  2 +-
 test/set-gsm-band              |  2 +-
 test/set-mic-volume            |  2 +-
 test/set-mms-details           |  2 +-
 test/set-msisdn                |  2 +-
 test/set-roaming-allowed       |  2 +-
 test/set-speaker-volume        |  2 +-
 test/set-tech-preference       |  2 +-
 test/set-tty                   |  2 +-
 test/set-umts-band             |  2 +-
 test/set-use-sms-reports       |  2 +-
 test/swap-calls                |  2 +-
 test/test-advice-of-charge     |  2 +-
 test/test-call-barring         |  2 +-
 test/test-call-forwarding      |  2 +-
 test/test-call-settings        |  2 +-
 test/test-cbs                  |  4 ++--
 test/test-gnss                 |  4 ++--
 test/test-message-waiting      |  2 +-
 test/test-modem                |  2 +-
 test/test-network-registration |  2 +-
 test/test-phonebook            |  2 +-
 test/test-push-notification    |  2 +-
 test/test-smart-messaging      |  2 +-
 test/test-sms                  | 18 +++++++++---------
 test/test-ss                   |  2 +-
 test/test-ss-control-cb        |  2 +-
 test/test-ss-control-cf        |  2 +-
 test/test-ss-control-cs        |  2 +-
 test/test-stk-menu             | 34 +++++++++++++++++-----------------
 test/unlock-pin                |  2 +-
 94 files changed, 124 insertions(+), 124 deletions(-)

diff --git a/test/activate-context b/test/activate-context
index 937b7db..22ad173 100755
--- a/test/activate-context
+++ b/test/activate-context
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/answer-calls b/test/answer-calls
index 45ff08f..daa794b 100755
--- a/test/answer-calls
+++ b/test/answer-calls
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 =

diff --git a/test/backtrace b/test/backtrace
index c624709..03c7632 100755
--- a/test/backtrace
+++ b/test/backtrace
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import os
 import re
diff --git a/test/cancel-ussd b/test/cancel-ussd
index 1797f26..e7559ba 100755
--- a/test/cancel-ussd
+++ b/test/cancel-ussd
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/cdma-connman-disable b/test/cdma-connman-disable
index 0ddc0cd..3adc14d 100755
--- a/test/cdma-connman-disable
+++ b/test/cdma-connman-disable
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/cdma-connman-enable b/test/cdma-connman-enable
index a3cca01..ac16a2d 100755
--- a/test/cdma-connman-enable
+++ b/test/cdma-connman-enable
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/cdma-dial-number b/test/cdma-dial-number
index 9cdfb24..683431e 100755
--- a/test/cdma-dial-number
+++ b/test/cdma-dial-number
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/cdma-hangup b/test/cdma-hangup
index 493ece4..41ffa60 100755
--- a/test/cdma-hangup
+++ b/test/cdma-hangup
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/cdma-list-call b/test/cdma-list-call
index 5d36a69..b132353 100755
--- a/test/cdma-list-call
+++ b/test/cdma-list-call
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 =

diff --git a/test/cdma-set-credentials b/test/cdma-set-credentials
index a286b0e..a60c86e 100755
--- a/test/cdma-set-credentials
+++ b/test/cdma-set-credentials
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/change-pin b/test/change-pin
index 000ce53..301c6ce 100755
--- a/test/change-pin
+++ b/test/change-pin
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/create-internet-context b/test/create-internet-context
index efd0998..1089053 100755
--- a/test/create-internet-context
+++ b/test/create-internet-context
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/create-mms-context b/test/create-mms-context
index e5be08d..598336f 100755
--- a/test/create-mms-context
+++ b/test/create-mms-context
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/create-multiparty b/test/create-multiparty
index 44a78f7..b6395e8 100755
--- a/test/create-multiparty
+++ b/test/create-multiparty
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/deactivate-all b/test/deactivate-all
index 427009e..5aa8587 100755
--- a/test/deactivate-all
+++ b/test/deactivate-all
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/deactivate-context b/test/deactivate-context
index 848bcbd..bc2ffd3 100755
--- a/test/deactivate-context
+++ b/test/deactivate-context
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/dial-number b/test/dial-number
index ee674d9..fe5adad 100755
--- a/test/dial-number
+++ b/test/dial-number
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/disable-call-forwarding b/test/disable-call-forwarding
index 3609816..811e4fa 100755
--- a/test/disable-call-forwarding
+++ b/test/disable-call-forwarding
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 from gi.repository import GLib
diff --git a/test/disable-gprs b/test/disable-gprs
index c6c40a5..61ce216 100755
--- a/test/disable-gprs
+++ b/test/disable-gprs
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/disable-modem b/test/disable-modem
index ca8c8d8..6fba857 100755
--- a/test/disable-modem
+++ b/test/disable-modem
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/display-icon b/test/display-icon
index 753d14d..ac40818 100755
--- a/test/display-icon
+++ b/test/display-icon
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/dundee-connect b/test/dundee-connect
index a23ce5f..77b16b8 100755
--- a/test/dundee-connect
+++ b/test/dundee-connect
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/dundee-disconnect b/test/dundee-disconnect
index 05403dd..4c3f048 100755
--- a/test/dundee-disconnect
+++ b/test/dundee-disconnect
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/enable-cbs b/test/enable-cbs
index c08bf2b..4a8bf66 100755
--- a/test/enable-cbs
+++ b/test/enable-cbs
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/enable-gprs b/test/enable-gprs
index 8664891..68d5ef0 100755
--- a/test/enable-gprs
+++ b/test/enable-gprs
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/enable-modem b/test/enable-modem
index dfaaaa8..fc5958a 100755
--- a/test/enable-modem
+++ b/test/enable-modem
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/enter-pin b/test/enter-pin
index c6ee669..9556363 100755
--- a/test/enter-pin
+++ b/test/enter-pin
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/get-icon b/test/get-icon
index fdaaee7..5569a33 100755
--- a/test/get-icon
+++ b/test/get-icon
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/get-operators b/test/get-operators
index ddbc194..afc2247 100755
--- a/test/get-operators
+++ b/test/get-operators
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/get-tech-preference b/test/get-tech-preference
index 77d20d0..7ba6365 100755
--- a/test/get-tech-preference
+++ b/test/get-tech-preference
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus, sys
 =

diff --git a/test/hangup-active b/test/hangup-active
index 1dd85a6..8e65bc4 100755
--- a/test/hangup-active
+++ b/test/hangup-active
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/hangup-all b/test/hangup-all
index 32933db..3a0138d 100755
--- a/test/hangup-all
+++ b/test/hangup-all
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/hangup-call b/test/hangup-call
index 447020c..5a2de20 100755
--- a/test/hangup-call
+++ b/test/hangup-call
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/hangup-multiparty b/test/hangup-multiparty
index 48fe342..24751c3 100755
--- a/test/hangup-multiparty
+++ b/test/hangup-multiparty
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/hold-and-answer b/test/hold-and-answer
index 2c47e27..da3be57 100755
--- a/test/hold-and-answer
+++ b/test/hold-and-answer
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/initiate-ussd b/test/initiate-ussd
index d7022f1..faf50d0 100755
--- a/test/initiate-ussd
+++ b/test/initiate-ussd
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
@@ -45,7 +45,7 @@ if state =3D=3D "idle":
 print("State: %s" % (state))
 =

 while state =3D=3D "user-response":
-	response =3D raw_input("Enter response: ")
+	response =3D input("Enter response: ")
 =

 	result =3D ussd.Respond(response, timeout=3D100)
 =

diff --git a/test/list-calls b/test/list-calls
index 08668c6..f3ee991 100755
--- a/test/list-calls
+++ b/test/list-calls
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 =

diff --git a/test/list-contexts b/test/list-contexts
index 221108c..384c258 100755
--- a/test/list-contexts
+++ b/test/list-contexts
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 =

diff --git a/test/list-messages b/test/list-messages
index 3b53d93..6500871 100755
--- a/test/list-messages
+++ b/test/list-messages
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 =

diff --git a/test/list-modems b/test/list-modems
index 3dd8ce4..a4b2c79 100755
--- a/test/list-modems
+++ b/test/list-modems
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 =

diff --git a/test/list-operators b/test/list-operators
index 39cd978..f603b54 100755
--- a/test/list-operators
+++ b/test/list-operators
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/lock-pin b/test/lock-pin
index 5579735..96ea9c2 100755
--- a/test/lock-pin
+++ b/test/lock-pin
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/lockdown-modem b/test/lockdown-modem
index 781abb6..4e04205 100755
--- a/test/lockdown-modem
+++ b/test/lockdown-modem
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/monitor-dundee b/test/monitor-dundee
index e68488a..5282a93 100755
--- a/test/monitor-dundee
+++ b/test/monitor-dundee
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 from gi.repository import GLib
 =

@@ -6,7 +6,7 @@ import dbus
 import dbus.mainloop.glib
 =

 _dbus2py =3D {
-	dbus.String : unicode,
+	dbus.String : str,
 	dbus.UInt32 : int,
 	dbus.Int32 : int,
 	dbus.Int16 : int,
diff --git a/test/monitor-ofono b/test/monitor-ofono
index bd31617..8830757 100755
--- a/test/monitor-ofono
+++ b/test/monitor-ofono
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 from gi.repository import GLib
 =

@@ -6,7 +6,7 @@ import dbus
 import dbus.mainloop.glib
 =

 _dbus2py =3D {
-	dbus.String : unicode,
+	dbus.String : str,
 	dbus.UInt32 : int,
 	dbus.Int32 : int,
 	dbus.Int16 : int,
diff --git a/test/offline-modem b/test/offline-modem
index ea1f522..e8c043a 100755
--- a/test/offline-modem
+++ b/test/offline-modem
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus, sys
 =

diff --git a/test/online-modem b/test/online-modem
index 310ed7d..029c4a5 100755
--- a/test/online-modem
+++ b/test/online-modem
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus, sys
 =

diff --git a/test/private-chat b/test/private-chat
index 254522e..17d17d0 100755
--- a/test/private-chat
+++ b/test/private-chat
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/process-context-settings b/test/process-context-settings
index a0c582d..932f10d 100755
--- a/test/process-context-settings
+++ b/test/process-context-settings
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import os
 import dbus
diff --git a/test/receive-sms b/test/receive-sms
index c23eb14..a0c6915 100755
--- a/test/receive-sms
+++ b/test/receive-sms
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 from gi.repository import GLib
 =

diff --git a/test/reject-calls b/test/reject-calls
index 9edf1ff..71b243e 100755
--- a/test/reject-calls
+++ b/test/reject-calls
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 =

diff --git a/test/release-and-answer b/test/release-and-answer
index ef860fc..62eaa79 100755
--- a/test/release-and-answer
+++ b/test/release-and-answer
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 =

diff --git a/test/release-and-swap b/test/release-and-swap
index 2748f20..b4c0af1 100755
--- a/test/release-and-swap
+++ b/test/release-and-swap
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 =

diff --git a/test/remove-contexts b/test/remove-contexts
index c5082cb..b54184e 100755
--- a/test/remove-contexts
+++ b/test/remove-contexts
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 =

diff --git a/test/reset-pin b/test/reset-pin
index b429254..3fbd126 100755
--- a/test/reset-pin
+++ b/test/reset-pin
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/scan-for-operators b/test/scan-for-operators
index 69051b0..7273380 100755
--- a/test/scan-for-operators
+++ b/test/scan-for-operators
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/send-sms b/test/send-sms
index e06444d..98808aa 100755
--- a/test/send-sms
+++ b/test/send-sms
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/send-ussd b/test/send-ussd
index e585883..a20e098 100755
--- a/test/send-ussd
+++ b/test/send-ussd
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
@@ -46,7 +46,7 @@ if state =3D=3D "idle":
 print("State: %s" % (state))
 =

 while state =3D=3D "user-response":
-	response =3D raw_input("Enter response: ")
+	response =3D input("Enter response: ")
 =

 	print(ussd.Respond(response, timeout=3D100))
 =

diff --git a/test/send-vcal b/test/send-vcal
index 7f8272b..566daef 100755
--- a/test/send-vcal
+++ b/test/send-vcal
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/send-vcard b/test/send-vcard
index 250b36f..4dedf51 100755
--- a/test/send-vcard
+++ b/test/send-vcard
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/set-call-forwarding b/test/set-call-forwarding
index 9fd358b..49d1ce0 100755
--- a/test/set-call-forwarding
+++ b/test/set-call-forwarding
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 from gi.repository import GLib
diff --git a/test/set-cbs-topics b/test/set-cbs-topics
index 78d6d44..db95e16 100755
--- a/test/set-cbs-topics
+++ b/test/set-cbs-topics
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/set-context-property b/test/set-context-property
index 64a6fb8..5ff7a67 100755
--- a/test/set-context-property
+++ b/test/set-context-property
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/set-fast-dormancy b/test/set-fast-dormancy
index 7bf7715..ef77bcd 100755
--- a/test/set-fast-dormancy
+++ b/test/set-fast-dormancy
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/set-gsm-band b/test/set-gsm-band
index 3c17c10..b37bcb5 100755
--- a/test/set-gsm-band
+++ b/test/set-gsm-band
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/set-mic-volume b/test/set-mic-volume
index e0bff49..cd6c73f 100755
--- a/test/set-mic-volume
+++ b/test/set-mic-volume
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/set-mms-details b/test/set-mms-details
index d2d0838..6ee59fa 100755
--- a/test/set-mms-details
+++ b/test/set-mms-details
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/set-msisdn b/test/set-msisdn
index 01f284d..b5fe819 100755
--- a/test/set-msisdn
+++ b/test/set-msisdn
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/set-roaming-allowed b/test/set-roaming-allowed
index 9e3e058..698c8b6 100755
--- a/test/set-roaming-allowed
+++ b/test/set-roaming-allowed
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/set-speaker-volume b/test/set-speaker-volume
index 7962f39..6d4e301 100755
--- a/test/set-speaker-volume
+++ b/test/set-speaker-volume
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/set-tech-preference b/test/set-tech-preference
index 2666cbd..b549abc 100755
--- a/test/set-tech-preference
+++ b/test/set-tech-preference
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/set-tty b/test/set-tty
index 53d6b99..eed1fba 100755
--- a/test/set-tty
+++ b/test/set-tty
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/set-umts-band b/test/set-umts-band
index c1e6448..0bae5c4 100755
--- a/test/set-umts-band
+++ b/test/set-umts-band
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/set-use-sms-reports b/test/set-use-sms-reports
index a4efe4f..288d4e1 100755
--- a/test/set-use-sms-reports
+++ b/test/set-use-sms-reports
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
diff --git a/test/swap-calls b/test/swap-calls
index eeb257b..018a8d3 100755
--- a/test/swap-calls
+++ b/test/swap-calls
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/test-advice-of-charge b/test/test-advice-of-charge
index 0f1f57f..6e87e61 100755
--- a/test/test-advice-of-charge
+++ b/test/test-advice-of-charge
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 from gi.repository import GLib
 import sys
diff --git a/test/test-call-barring b/test/test-call-barring
index be4ab57..eedb69f 100755
--- a/test/test-call-barring
+++ b/test/test-call-barring
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 from gi.repository import GLib
 import sys
diff --git a/test/test-call-forwarding b/test/test-call-forwarding
index 01a7294..5db84d7 100755
--- a/test/test-call-forwarding
+++ b/test/test-call-forwarding
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 from gi.repository import GLib
 =

diff --git a/test/test-call-settings b/test/test-call-settings
index 5d7ee49..435594c 100755
--- a/test/test-call-settings
+++ b/test/test-call-settings
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 from gi.repository import GLib
 =

diff --git a/test/test-cbs b/test/test-cbs
index 13cdd80..a5cec06 100755
--- a/test/test-cbs
+++ b/test/test-cbs
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import dbus.mainloop.glib
@@ -78,7 +78,7 @@ def set_topics(cbs):
 	invalidData =3D False;
 	index =3D 0
 =

-	topics =3D raw_input('Enter the topic ID(s) you want to register to: ')
+	topics =3D input('Enter the topic ID(s) you want to register to: ')
 =

 	while index < len(topics):
 		if topics[index] =3D=3D ',' or topics[index] =3D=3D '-':
diff --git a/test/test-gnss b/test/test-gnss
index aa0b160..6ae64db 100755
--- a/test/test-gnss
+++ b/test/test-gnss
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 from gi.repository import GLib
 import sys
@@ -40,7 +40,7 @@ def print_menu():
 def stdin_handler(channel, condition, gnss, path):
 	in_key =3D os.read(channel.unix_get_fd(), 160).rstrip().decode('UTF-8')
 	if in_key =3D=3D '0':
-		xml =3D raw_input('type the element and press enter: ')
+		xml =3D input('type the element and press enter: ')
 		try:
 			gnss.SendPositioningElement(dbus.String(xml))
 			print("ok")
diff --git a/test/test-message-waiting b/test/test-message-waiting
index b93fbf3..432862e 100755
--- a/test/test-message-waiting
+++ b/test/test-message-waiting
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 from gi.repository import GLib
 import sys
diff --git a/test/test-modem b/test/test-modem
index 29dbf14..aa38b1f 100755
--- a/test/test-modem
+++ b/test/test-modem
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 from gi.repository import GLib
 =

diff --git a/test/test-network-registration b/test/test-network-registration
index c5ad586..68b4347 100755
--- a/test/test-network-registration
+++ b/test/test-network-registration
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 from gi.repository import GLib
 import sys
diff --git a/test/test-phonebook b/test/test-phonebook
index 116fd4f..42646d3 100755
--- a/test/test-phonebook
+++ b/test/test-phonebook
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus, sys
 =

diff --git a/test/test-push-notification b/test/test-push-notification
index ecc6afb..d972ad3 100755
--- a/test/test-push-notification
+++ b/test/test-push-notification
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 from gi.repository import GLib
 =

diff --git a/test/test-smart-messaging b/test/test-smart-messaging
index 188ac1e..f22efd2 100755
--- a/test/test-smart-messaging
+++ b/test/test-smart-messaging
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 from gi.repository import GLib
 =

diff --git a/test/test-sms b/test/test-sms
index 49935e1..30ac651 100755
--- a/test/test-sms
+++ b/test/test-sms
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 # -*- coding: utf-8 -*-
 =

 from gi.repository import GLib
@@ -132,7 +132,7 @@ def stdin_handler(channel, condition, sms, value, numbe=
r):
 		lock =3D "on"
 		if in_key =3D=3D '0':
 			print_send_sms_menu()
-			sms_type =3D raw_input('Select SMS type: ')
+			sms_type =3D input('Select SMS type: ')
 =

 			if sms_type =3D=3D '1':
 				message_send(sms, number, value)
@@ -150,49 +150,49 @@ def stdin_handler(channel, condition, sms, value, num=
ber):
 =

 		elif in_key =3D=3D '1':
 			message_delivery_report(sms, 1)
-			send_msg =3D raw_input('Send test message[y/n]?: ')
+			send_msg =3D input('Send test message[y/n]?: ')
 			if send_msg =3D=3D 'y':
 				message_send(sms, number, ("(1)" + value +
 						": UseDeliveryReports[TRUE]"))
 =

 		elif in_key =3D=3D '2':
 			message_delivery_report(sms, 0)
-			send_msg =3D raw_input('Send test message[y/n]?: ')
+			send_msg =3D input('Send test message[y/n]?: ')
 			if send_msg =3D=3D 'y':
 				message_send(sms, number, ("(2) " + value +
 						": UseDeliveryReports[FALSE]"))
 =

 		elif in_key =3D=3D '3':
 			message_service_center_address(sms, SCA)
-			send_msg =3D raw_input('Send test message[y/n]?: ')
+			send_msg =3D input('Send test message[y/n]?: ')
 			if send_msg =3D=3D 'y':
 				message_send(sms, number, ("(3) " + value +
 						": ServiceCenterAddress"))
 =

 		elif in_key =3D=3D '4':
 			message_bearer(sms, "ps-only")
-			send_msg =3D raw_input('Send test message[y/n]?: ')
+			send_msg =3D input('Send test message[y/n]?: ')
 			if send_msg =3D=3D 'y':
 				message_send(sms, number, ("(4) " + value +
 						": Bearer[ps-only]"))
 =

 		elif in_key =3D=3D '5':
 			message_bearer(sms, "cs-only")
-			send_msg =3D raw_input('Send test message[y/n]?: ')
+			send_msg =3D input('Send test message[y/n]?: ')
 			if send_msg =3D=3D 'y':
 				message_send(sms, number, ("(5) " + value +
 						": Bearer[cs-only]"))
 =

 		elif in_key =3D=3D '6':
 			message_bearer(sms, "ps-preferred")
-			send_msg =3D raw_input('Send test message[y/n]?: ')
+			send_msg =3D input('Send test message[y/n]?: ')
 			if send_msg =3D=3D 'y':
 				message_send(sms, number, ("(6) " + value +
 						": Bearer[ps-preferred]"))
 =

 		elif in_key =3D=3D '7':
 			message_bearer(sms, "cs-preferred")
-			send_msg =3D raw_input('Send test message[y/n]?: ')
+			send_msg =3D input('Send test message[y/n]?: ')
 			if send_msg =3D=3D 'y':
 				message_send(sms,number, ("(7) " + value +
 						": Bearer[cs-preferred]"))
diff --git a/test/test-ss b/test/test-ss
index 2c80806..4cd8732 100755
--- a/test/test-ss
+++ b/test/test-ss
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import sys
 import dbus
diff --git a/test/test-ss-control-cb b/test/test-ss-control-cb
index 86bac9b..ddae6d3 100755
--- a/test/test-ss-control-cb
+++ b/test/test-ss-control-cb
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 from gi.repository import GLib
 =

diff --git a/test/test-ss-control-cf b/test/test-ss-control-cf
index d30bf4f..095eb5d 100755
--- a/test/test-ss-control-cf
+++ b/test/test-ss-control-cf
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 from gi.repository import GLib
 =

diff --git a/test/test-ss-control-cs b/test/test-ss-control-cs
index e0ed1d1..8180474 100755
--- a/test/test-ss-control-cs
+++ b/test/test-ss-control-cs
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 from gi.repository import GLib
 =

diff --git a/test/test-stk-menu b/test/test-stk-menu
index e76f292..9ef92a1 100755
--- a/test/test-stk-menu
+++ b/test/test-stk-menu
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 from gi.repository import GLib
 =

@@ -57,7 +57,7 @@ class StkAgent(dbus.service.Object):
 			index +=3D 1
 =

 		print("\nDefault: %d" % (default))
-		select =3D raw_input("Enter Selection (t, b):")
+		select =3D input("Enter Selection (t, b):")
 =

 		if select =3D=3D 'b':
 			raise GoBack("User wishes to go back")
@@ -74,7 +74,7 @@ class StkAgent(dbus.service.Object):
 		print("DisplayText (%s)" % (title))
 		print("Icon: (%d)" % (icon))
 		print("Urgent: (%d)" % (urgent))
-		key =3D raw_input("Press return to clear ('t' terminates, "
+		key =3D input("Press return to clear ('t' terminates, "
 						"'b' goes back, 'n' busy, "
 						"'w' return and wait):")
 =

@@ -107,7 +107,7 @@ class StkAgent(dbus.service.Object):
 		print("Hide typing: (%s)" % (hide_typing))
 		print("Enter characters, min: %d, max: %d:" % (min_chars,
 								max_chars))
-		userin =3D raw_input("")
+		userin =3D input("")
 =

 		return userin
 =

@@ -121,7 +121,7 @@ class StkAgent(dbus.service.Object):
 		print("Hide typing: (%s)" % (hide_typing))
 		print("Enter digits, min: %d, max: %d:" % (min_chars,
 								max_chars))
-		userin =3D raw_input("'t' terminates, 'b' goes back:")
+		userin =3D input("'t' terminates, 'b' goes back:")
 =

 		if userin =3D=3D 'b':
 			raise GoBack("User wishes to go back")
@@ -135,7 +135,7 @@ class StkAgent(dbus.service.Object):
 	def RequestKey(self, title, icon):
 		print("Title: (%s)" % (title))
 		print("Icon: (%d)" % (icon))
-		key =3D raw_input("Enter Key (t, b):")
+		key =3D input("Enter Key (t, b):")
 =

 		if key =3D=3D 'b':
 			raise GoBack("User wishes to go back")
@@ -149,7 +149,7 @@ class StkAgent(dbus.service.Object):
 	def RequestDigit(self, title, icon):
 		print("Title: (%s)" % (title))
 		print("Icon: (%d)" % (icon))
-		key =3D raw_input("Enter Digit (t, b):")
+		key =3D input("Enter Digit (t, b):")
 =

 		if key =3D=3D 'b':
 			raise GoBack("User wishes to go back")
@@ -163,7 +163,7 @@ class StkAgent(dbus.service.Object):
 	def RequestQuickDigit(self, title, icon):
 		print("Title: (%s)" % (title))
 		print("Icon: (%d)" % (icon))
-		key =3D raw_input("Quick digit (0-9, *, #, t, b):")
+		key =3D input("Quick digit (0-9, *, #, t, b):")
 =

 		if key =3D=3D 'b':
 			raise GoBack("User wishes to go back")
@@ -177,7 +177,7 @@ class StkAgent(dbus.service.Object):
 	def RequestConfirmation(self, title, icon):
 		print("Title: (%s)" % (title))
 		print("Icon: (%d)" % (icon))
-		key =3D raw_input("Enter Confirmation (t, b, y, n):")
+		key =3D input("Enter Confirmation (t, b, y, n):")
 =

 		if key =3D=3D 'b':
 			raise GoBack("User wishes to go back")
@@ -193,7 +193,7 @@ class StkAgent(dbus.service.Object):
 	def ConfirmCallSetup(self, info, icon):
 		print("Information: (%s)" % (info))
 		print("Icon: (%d)" % (icon))
-		key =3D raw_input("Enter Confirmation (t, y, n):")
+		key =3D input("Enter Confirmation (t, y, n):")
 =

 		if key =3D=3D 't':
 			raise EndSession("User wishes to terminate session")
@@ -208,7 +208,7 @@ class StkAgent(dbus.service.Object):
 		print("Information: (%s)" % (info))
 		print("Icon: (%d)" % (icon))
 		print("URL (%s)" % (url))
-		key =3D raw_input("Enter Confirmation (y, n):")
+		key =3D input("Enter Confirmation (y, n):")
 =

 		if key =3D=3D 'y':
 			return True
@@ -231,7 +231,7 @@ class StkAgent(dbus.service.Object):
 		signal.alarm(5)
 =

 		try:
-			key =3D raw_input("Press return to end before end of"
+			key =3D input("Press return to end before end of"
 							 " single tone (t):")
 			signal.alarm(0)
 =

@@ -249,7 +249,7 @@ class StkAgent(dbus.service.Object):
 		print("LoopTone: %s" % (tone))
 		print("Text: %s" % (text))
 		print("Icon: %d" % (icon))
-		key =3D raw_input("Press return to end before timeout "
+		key =3D input("Press return to end before timeout "
 				"('t' terminates, 'w' return and wait):")
 =

 		if key =3D=3D 'w':
@@ -278,7 +278,7 @@ class StkAgent(dbus.service.Object):
 	def DisplayAction(self, text, icon):
 		print("Text: (%s)" % (text))
 		print("Icon: (%d)" % (icon))
-		key =3D raw_input("Press 't' to terminate the session ")
+		key =3D input("Press 't' to terminate the session ")
 =

 		if key =3D=3D 't':
 			raise EndSession("User wishes to terminate session")
@@ -288,7 +288,7 @@ class StkAgent(dbus.service.Object):
 	def ConfirmOpenChannel(self, info, icon):
 		print("Open channel confirmation: (%s)" % (info))
 		print("Icon: (%d)" % (icon))
-		key =3D raw_input("Enter Confirmation (t, y, n):")
+		key =3D input("Enter Confirmation (t, y, n):")
 =

 		if key =3D=3D 't':
 			raise EndSession("User wishes to terminate session")
@@ -298,7 +298,7 @@ class StkAgent(dbus.service.Object):
 			return False
 =

 _dbus2py =3D {
-	dbus.String : unicode,
+	dbus.String : str,
 	dbus.UInt32 : int,
 	dbus.Int32 : int,
 	dbus.Int16 : int,
@@ -395,7 +395,7 @@ if __name__ =3D=3D '__main__':
 		except:
 			pass
 =

-		select =3D int(raw_input("Enter Selection: "))
+		select =3D int(input("Enter Selection: "))
 		stk.SelectItem(select, path)
 	elif mode =3D=3D 'agent':
 		path =3D "/test/agent"
diff --git a/test/unlock-pin b/test/unlock-pin
index 10b6626..61f4765 100755
--- a/test/unlock-pin
+++ b/test/unlock-pin
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/python3
 =

 import dbus
 import sys
-- =

1.9.0


--===============4891164944813542293==--

