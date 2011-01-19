Content-Type: multipart/mixed; boundary="===============4085717951507194874=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCHv2] voicecall: Fix emergency number handling
Date: Wed, 19 Jan 2011 13:42:24 +0200
Message-ID: <1295437344-30158-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4085717951507194874==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the SIM is present but doesn't contain any emergency numbers, the
set of emergency numbers needs to be reset to the default list.

This patch fixes the list shown in the SIM present case by removing
numbers from the list any ENs that are for the no-SIM case only.
---
 src/voicecall.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 77fa75a..6190b72 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2288,6 +2288,13 @@ static void sim_state_watch(enum ofono_sim_state new=
_state, void *user)
 =

 	switch (new_state) {
 	case OFONO_SIM_STATE_INSERTED:
+		/*
+		 * If reading for ENs from the SIM card fails, or
+		 * results in an empty set, we must reset the EN list
+		 * to the default list.
+		 */
+		add_to_en_list(&vc->new_en_list, default_en_list);
+
 		/* Try both formats, only one or none will work */
 		ofono_sim_read(vc->sim, SIM_EFECC_FILEID,
 				OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
-- =

1.7.1


--===============4085717951507194874==--

