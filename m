Content-Type: multipart/mixed; boundary="===============2666829110205554319=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 00/11] Add BIP command support
Date: Tue, 28 Jun 2011 19:16:12 +0200
Message-ID: <1309281383-6605-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2666829110205554319==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This new set of patches is introducing the support of the BIP commands in o=
Fono (stk class 'e'):
As agreed, this patch set is:	=

	- not exposing STK contexts over D-Bus 	=

	- only using the kernel buffer.
	- using blocking sockets after the connect phase.
	- oriented to support TCP/IP first (for UDP Rx, the packet boundaries are =
currently not preserved).

Philippe Nunes (11):
  gprs: Add private APIs to activate/deactivate private contexts
  stk: Add support for the proactive command 'Open channel'
  stk: Add support for the proactive command 'Get channel status'
  stk: Add support for the proactive command 'Close channel'
  stk: Add 'ofono_stk_activate_cb' definition
  stk: Add 'ofono_stk_deactivate_context_cb' definition
  stk: Add support for the proactive command 'Receive data'
  stk: Add support for the proactive command 'Send data'
  stk: Add support of the Setup event list proactive command
  stk: Add host route to route the traffic through the stk interface
  gprs: Add API to set a 'detach'notification callback

 src/gprs.c  |  248 +++++++++++++++++
 src/ofono.h |   23 ++
 src/stk.c   |  882 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 1153 insertions(+), 0 deletions(-)


--===============2666829110205554319==--

