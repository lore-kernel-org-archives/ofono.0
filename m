Content-Type: multipart/mixed; boundary="===============9220544859792723624=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 02/27] test-stkutil: Add test for poll interval parser
Date: Thu, 13 May 2010 18:48:19 +0800
Message-ID: <1273747724-28019-2-git-send-email-yang.gu@intel.com>
In-Reply-To: <1273747724-28019-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9220544859792723624==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 unit/test-stkutil.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/unit/test-stkutil.c b/unit/test-stkutil.c
index 1b24df3..4cce0f5 100644
--- a/unit/test-stkutil.c
+++ b/unit/test-stkutil.c
@@ -3883,6 +3883,49 @@ static void test_play_tone(gconstpointer data)
 	stk_command_free(command);
 }
 =

+struct poll_interval_test {
+	const unsigned char *pdu;
+	unsigned int pdu_len;
+	unsigned char qualifier;
+	struct stk_duration duration;
+};
+
+static unsigned char poll_interval_111[] =3D { 0xD0, 0x0D, 0x81, 0x03, 0x0=
1, 0x03,
+						0x00, 0x82, 0x02, 0x81, 0x82,
+						0x84, 0x02, 0x01, 0x14 };
+
+static struct poll_interval_test poll_interval_data_111 =3D {
+	.pdu =3D poll_interval_111,
+	.pdu_len =3D sizeof(poll_interval_111),
+	.qualifier =3D 0x00,
+	.duration =3D {
+		.unit =3D STK_DURATION_TYPE_SECONDS,
+		.interval =3D 20
+	}
+};
+
+/* Defined in TS 102.384 Section 27.22.4.6 */
+static void test_poll_interval(gconstpointer data)
+{
+	const struct poll_interval_test *test =3D data;
+	struct stk_command *command;
+
+	command =3D stk_command_new_from_pdu(test->pdu, test->pdu_len);
+
+	g_assert(command);
+
+	g_assert(command->number =3D=3D 1);
+	g_assert(command->type =3D=3D STK_COMMAND_TYPE_POLL_INTERVAL);
+	g_assert(command->qualifier =3D=3D test->qualifier);
+
+	g_assert(command->src =3D=3D STK_DEVICE_IDENTITY_TYPE_UICC);
+	g_assert(command->dst =3D=3D STK_DEVICE_IDENTITY_TYPE_TERMINAL);
+
+	check_duration(&command->poll_interval.duration, &test->duration);
+
+	stk_command_free(command);
+}
+
 struct send_sms_test {
 	const unsigned char *pdu;
 	unsigned int pdu_len;
@@ -4321,6 +4364,9 @@ int main(int argc, char **argv)
 	g_test_add_data_func("/teststk/Play Tone 6.1.3",
 				&play_tone_data_613, test_play_tone);
 =

+	g_test_add_data_func("/teststk/Poll Interval 1.1.1",
+				&poll_interval_data_111, test_poll_interval);
+
 	g_test_add_data_func("/teststk/Send SMS 1.1",
 				&send_sms_data_11, test_send_sms);
 =

-- =

1.7.0.4


--===============9220544859792723624==--

