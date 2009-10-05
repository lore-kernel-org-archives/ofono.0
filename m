Content-Type: multipart/mixed; boundary="===============0488697043564843384=="
MIME-Version: 1.0
From: Olivier Le Thanh Duong <oliver.le.thanh.duong@collabora.co.uk>
Subject: Subject: RFC Migrate from RFC2822 to ISO8601 for time representations
Date: Mon, 05 Oct 2009 17:55:20 +0000
Message-ID: <4ACA3207.8050303@collabora.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0488697043564843384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

the format used to represent time in ofono is currently RFC2822 which is =

complex and a bit deprecated. I think it would be better to move to =

ISO8601 which is a well used and supported [1] format and simpler to parse.

RFC2822 date example: Mon, 05 Oct 2009 19:31:32 +0200
ISO8601 date example: 2009-10-05T19:31:26+0200


The proposed patch makes this transition.

Any comments?

Regards,
Olivier

[1] for example Glib has a g_time_val_from_iso8601 which understand =

timezone compared to strptime which doesn't support %z

 From 16359eccfcb4a7a5444e6f87729008192edefc5e Mon Sep 17 00:00:00 2001
From: Olivier Le Thanh Duong <olivier.le.thanh@collabora.co.uk>
Date: Mon, 5 Oct 2009 19:10:25 +0200
Subject: [PATCH] Migrate from RFC2822 to ISO8601 for time representations

---
  plugins/example_history.c |    6 +++---
  src/sms.c                 |    4 ++--
  src/voicecall.c           |    2 +-
  unit/test-sms.c           |    4 ++--
  4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/plugins/example_history.c b/plugins/example_history.c
index 384c88d..d923a8e 100644
--- a/plugins/example_history.c
+++ b/plugins/example_history.c
@@ -68,11 +68,11 @@ static void example_history_call_ended(struct =

ofono_history_context *context,
  	else
  		ofono_debug("From: %s", from);

-	strftime(buf, 127, "%a, %d %b %Y %H:%M:%S %z", localtime(&start));
+	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", localtime(&start));
  	buf[127] =3D '\0';
  	ofono_debug("StartTime: %s", buf);

-	strftime(buf, 127, "%a, %d %b %Y %H:%M:%S %z", localtime(&end));
+	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", localtime(&end));
  	buf[127] =3D '\0';
  	ofono_debug("EndTime: %s", buf);
  }
@@ -96,7 +96,7 @@ static void example_history_call_missed(struct =

ofono_history_context *context,
  		from =3D phone_number_to_string(&call->phone_number);

  	ofono_debug("From: %s", from);
-	strftime(buf, 127, "%a, %d %b %Y %H:%M:%S %z", localtime(&when));
+	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", localtime(&when));
  	buf[127] =3D '\0';
  	ofono_debug("When: %s", buf);
  }
diff --git a/src/sms.c b/src/sms.c
index 141f288..e02ac85 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -467,11 +467,11 @@ static void dispatch_text_message(struct ofono_sms =

*sms,

  	ts =3D sms_scts_to_time(scts, &remote);

-	strftime(buf, 127, "%a, %d %b %Y %H:%M:%S %z", localtime(&ts));
+	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", localtime(&ts));
  	buf[127] =3D '\0';
  	ofono_dbus_dict_append(&dict, "LocalSentTime", DBUS_TYPE_STRING, &str);

-	strftime(buf, 127, "%a, %d %b %Y %H:%M:%S %z", &remote);
+	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", &remote);
  	buf[127] =3D '\0';
  	ofono_dbus_dict_append(&dict, "SentTime", DBUS_TYPE_STRING, &str);

diff --git a/src/voicecall.c b/src/voicecall.c
index eff6321..3f70f9e 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -164,7 +164,7 @@ static const char *time_to_str(const time_t *t)
  {
  	static char buf[128];

-	strftime(buf, 127, "%a, %d %b %Y %H:%M:%S %z", localtime(t));
+	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", localtime(t));
  	buf[127] =3D '\0';

  	return buf;
diff --git a/unit/test-sms.c b/unit/test-sms.c
index ac4f1ff..9c1528c 100644
--- a/unit/test-sms.c
+++ b/unit/test-sms.c
@@ -59,12 +59,12 @@ static void print_scts(struct sms_scts *scts, const =

char *prefix)

  	ts =3D sms_scts_to_time(scts, &remote);

-	strftime(buf, 127, "%a, %d %b %Y %H:%M:%S %z", localtime(&ts));
+	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", localtime(&ts));
  	buf[127] =3D '\0';

  	g_print("local time: %s\n", buf);

-	strftime(buf, 127, "%a, %d %b %Y %H:%M:%S %z", &remote);
+	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", &remote);
  	buf[127] =3D '\0';

  	g_print("remote time: %s\n", buf);
-- =

1.6.3.3

--===============0488697043564843384==--

