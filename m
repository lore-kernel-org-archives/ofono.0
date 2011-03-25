Content-Type: multipart/mixed; boundary="===============2614657405532280832=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 00/18] Send and detect Escape Sequence implementation
Date: Fri, 25 Mar 2011 16:25:31 +0100
Message-ID: <1301066749-12052-1-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2614657405532280832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Patch 1 to 6:
Implement the "+++" escape sequence detection with guard timeouts.

Patch 7:
Implement the Hook Control Callback into emulator.

Patch 8 to 12:
Implement the return to Online Data State Callback into emulator.
Implement gatppp and gathdlc new APIs to resume PPP server.

Patch 13 to 16:
Implement gatppp and gathdlc new APIs to control PPP client with gsmdial.

Patch 17 and 18 are adding a new option into gsmdial to send an escape sequ=
ence whether a PPP conection is established.
The "+++" sequence can't be written using GAtChat because it is adding and =
'\r' character at the end of the string.

I have used the write_done GAtIO CB to detect when a PPP packet is written =
to suspend PPP client and write "+++" on GAtIO.
The GUARD_TIMEOUTS value defined into gsmdial is ruling the timing to do:
+++ --> ATO0 --> +++ --> ATH0

If you want to send an escape sequence you have to use gsmdial in this way:

sudo ./gsmdial -i your_inet_addr -p 12346 -b -e

Guillaume Zajac (18):
  gat: add GAtSuspendFunc CB typedef
  gathdlc: add g_at_hdlc_set_suspend_function() prototype
  gathdlc: add mechansim to detect '+++' escape sequence
  gatppp: add g_at_ppp_set_suspend_function() prototype
  gatppp: add g_at_ppp_set_suspend_function() definition
  emulator: add ppp_suspend() CB and register it
  emulator: add AT hook_control_cb() and register it
  gathdlc: add g_at_resume_hdlc() prototype.
  gathdlc: add g_at_hdlc_resume() definition.
  gatppp: add g_at_ppp_resume() prototype
  gatppp: add g_at_ppp_resume() definition.
  emulator: add AT online_data_state_cb() and register it
  gathdlc: add prototype to suspend gathdlc externally
  gathdlc: add g_at_hdlc_suspend() definition
  gatppp: add prototype to suspend ppp server externally
  gatppp: add g_at_ppp_suspend() definition
  gsmdial: add new option to test sending escape sequence
  gsmdial: implement mechanism to send +++ -> ATO0 -> +++ -> ATH0

 gatchat/gat.h     |    1 +
 gatchat/gathdlc.c |  152 ++++++++++++++++++++++++++++++++++++++++++++++++
 gatchat/gathdlc.h |    7 ++
 gatchat/gatppp.c  |   32 ++++++++++
 gatchat/gatppp.h  |    5 ++
 gatchat/gsmdial.c |  167 ++++++++++++++++++++++++++++++++++++++++++++-----=
---
 src/emulator.c    |  100 +++++++++++++++++++++++++++++++-
 7 files changed, 435 insertions(+), 29 deletions(-)


--===============2614657405532280832==--

