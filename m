Content-Type: multipart/mixed; boundary="===============3217695870906602657=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 00/26] Escape Sequence Dectection implementation
Date: Fri, 01 Apr 2011 10:56:02 +0200
Message-ID: <1301648188-7208-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3217695870906602657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This set of patches is an update of the previous one.
The main diff are:
	- Rework Escape Sequence detection mechanism: =

		* we don't need a timeout to detect the 3 '+'
		  GUARD_TIMEOUTS only is enough.
		* Be sure g_source timeout is deleted at hdlc_unref().
	- GAtIO: add API to drain write buffer when hdlc is suspended
	  because we can't acces to GAtIO ring buffer externally.
	- ppp_net: add API to suspend/resume GIOCHannel read watch =

	  of TUN/TAP interface.
	- GAtChat: add API to send <pause> +++ <pause> escape sequence
	- gsmdial controls only the time interval between escape sequence
	and ATO0/ATHO.
	- emulator: rework ATH0 and ATO0 callbacks, add switch on emulator
	  type to register AT callbacks.

Kind regards,
Guillaume


Guillaume Zajac (26):
  gat: add GAtSuspendFunc CB typedef
  gatio: add prototype to drain GAtIO read buffer
  gatio: add g_at_io_drain_ring_buffer() definition
  gathdlc: add g_at_hdlc_set_suspend_function() prototype
  gathdlc: add mechansim to detect '+++' escape sequence
  gatppp: add g_at_ppp_set_suspend_function() prototype
  gatppp: add g_at_ppp_set_suspend_function() definition
  gathdlc: add g_at_hdlc_suspend() prototype
  gathdlc: add g_at_hdlc_suspend() definition
  ppp: add ppp_net_suspend_interface() prototype
  ppp_net: add ppp_net_suspend_interface() definition
  gatppp: add g_at_ppp_suspend() prototype
  gatppp: add g_at_ppp_suspend() definition
  emulator: add ppp_suspend() CB and register it
  emulator: add dun_ath_cb() and register it
  gathdlc: add g_at_hdlc_resume() prototype
  gathdlc: add g_at_hdlc_resume() definition
  ppp: add ppp_net_resume_interface() prototype
  ppp_net: add ppp_net_resume_interface() definition
  gatppp: add g_at_ppp_resume() prototype
  gatppp: add g_at_ppp_resume() definition.
  emulator: add dun_ato_cb() and register it
  gsmdial: add new option to test sending escape sequence
  gatchat: add g_at_chat_send_escape_sequence() prototype
  gatchat: add g_at_chat_send_escape_sequence() definition
  gsmdial: implement test sequence +++-ATO0-+++-ATH0

 gatchat/gat.h     |    1 +
 gatchat/gatchat.c |   32 +++++++++++++
 gatchat/gatchat.h |    2 +
 gatchat/gathdlc.c |  126 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 gatchat/gathdlc.h |    6 +++
 gatchat/gatio.c   |    5 ++
 gatchat/gatio.h   |    2 +
 gatchat/gatppp.c  |   34 ++++++++++++++
 gatchat/gatppp.h  |    4 ++
 gatchat/gsmdial.c |   81 ++++++++++++++++++++++++++++++++++
 gatchat/ppp.h     |    2 +
 gatchat/ppp_net.c |   19 ++++++++
 src/emulator.c    |  125 +++++++++++++++++++++++++++++++++++++++++++++++++=
++-
 13 files changed, 437 insertions(+), 2 deletions(-)


--===============3217695870906602657==--

