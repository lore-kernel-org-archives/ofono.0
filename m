Content-Type: multipart/mixed; boundary="===============8731616488533599022=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 1/3] Remove stray newlines in DBG and ofono log messages
Date: Thu, 25 Nov 2010 12:51:03 +0200
Message-ID: <1290682265-11373-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8731616488533599022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/call-barring.c    |   10 +++++-----
 drivers/isimodem/call-forwarding.c |    8 ++++----
 drivers/isimodem/call-settings.c   |    8 ++++----
 drivers/isimodem/cbs.c             |    2 +-
 drivers/isimodem/sms.c             |    2 +-
 drivers/stemodem/caif_rtnl.c       |    2 +-
 drivers/stemodem/gprs-context.c    |    2 +-
 plugins/isigen.c                   |    2 +-
 src/gprs.c                         |    2 +-
 src/sim.c                          |    2 +-
 src/voicecall.c                    |    4 ++--
 11 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/isimodem/call-barring.c b/drivers/isimodem/call-barrin=
g.c
index 2a982f9..7cdd218 100644
--- a/drivers/isimodem/call-barring.c
+++ b/drivers/isimodem/call-barring.c
@@ -125,7 +125,7 @@ static void isi_set(struct ofono_call_barring *barr, co=
nst char *lock,
 		0, 0			/* Filler */
 	};
 =

-	DBG("lock code %s enable %d class %d password %s\n",
+	DBG("lock code %s enable %d class %d password %s",
 		lock, enable, cls, passwd);
 =

 	if (!cbd || !bd)
@@ -177,7 +177,7 @@ static void update_status_mask(unsigned int *mask, int =
bsc)
 		break;
 =

 	default:
-		DBG("Unknown BSC: 0x%04X\n", bsc);
+		DBG("Unknown BSC: 0x%04X", bsc);
 		break;
 	}
 }
@@ -244,7 +244,7 @@ static gboolean query_resp_cb(GIsiClient *client,
 		}
 	}
 =

-	DBG("mask=3D0x%04X\n", mask);
+	DBG("mask=3D0x%04X", mask);
 	CALLBACK_WITH_SUCCESS(cb, mask, cbd->data);
 	goto out;
 =

@@ -273,7 +273,7 @@ static void isi_query(struct ofono_call_barring *barr, =
const char *lock,
 		0				/* Subblock count */
 	};
 =

-	DBG("barring query lock code %s\n", lock);
+	DBG("barring query lock code %s", lock);
 =

 	if (!cbd || !bd)
 		goto error;
@@ -343,7 +343,7 @@ static void isi_set_passwd(struct ofono_call_barring *b=
arr, const char *lock,
 		0, 0				/* Filler */
 	};
 =

-	DBG("lock code %s (%u) old password %s new password %s\n",
+	DBG("lock code %s (%u) old password %s new password %s",
 		lock, ss_code, old_passwd, new_passwd);
 =

 	if (!cbd || !bd)
diff --git a/drivers/isimodem/call-forwarding.c b/drivers/isimodem/call-for=
warding.c
index 1448451..bb25ee7 100644
--- a/drivers/isimodem/call-forwarding.c
+++ b/drivers/isimodem/call-forwarding.c
@@ -70,7 +70,7 @@ static int forw_type_to_isi_code(int type)
 		ss_code =3D SS_GSM_ALL_COND_FORWARDINGS;
 		break;
 	default:
-		DBG("Unknown forwarding type %d\n", type);
+		DBG("Unknown forwarding type %d", type);
 		ss_code =3D -1;
 		break;
 	}
@@ -227,7 +227,7 @@ static void isi_registration(struct ofono_call_forwardi=
ng *cf,
 	/* Followed by number in UCS-2, zero sub address bytes, and 0
 	 * to 3 bytes of filler */
 =

-	DBG("forwarding type %d class %d\n", type, cls);
+	DBG("forwarding type %d class %d", type, cls);
 =

 	if (!cbd || !fd || !number->number || strlen(number->number) > 28)
 		goto error;
@@ -347,7 +347,7 @@ static void isi_erasure(struct ofono_call_forwarding *c=
f, int type, int cls,
 		0  /* Subblock count */
 	};
 =

-	DBG("forwarding type %d class %d\n", type, cls);
+	DBG("forwarding type %d class %d", type, cls);
 =

 	if (!cbd || !fd)
 		goto error;
@@ -479,7 +479,7 @@ static void isi_query(struct ofono_call_forwarding *cf,=
 int type, int cls,
 		0  /* Subblock count */
 	};
 =

-	DBG("forwarding type %d class %d\n", type, cls);
+	DBG("forwarding type %d class %d", type, cls);
 =

 	if (!cbd || !fd || cls !=3D 7)
 		goto error;
diff --git a/drivers/isimodem/call-settings.c b/drivers/isimodem/call-setti=
ngs.c
index c845d54..23c1982 100644
--- a/drivers/isimodem/call-settings.c
+++ b/drivers/isimodem/call-settings.c
@@ -84,7 +84,7 @@ static void update_status_mask(unsigned int *mask, int bs=
c)
 		break;
 =

 	default:
-		DBG("Unknown BSC value %d, please report\n", bsc);
+		DBG("Unknown BSC value %d, please report", bsc);
 		break;
 	}
 }
@@ -146,7 +146,7 @@ static gboolean query_resp_cb(GIsiClient *client,
 		}
 	}
 =

-	DBG("status_mask %d\n", mask);
+	DBG("status_mask %d", mask);
 	CALLBACK_WITH_SUCCESS(cb, mask, cbd->data);
 	goto out;
 =

@@ -175,7 +175,7 @@ static void isi_cw_query(struct ofono_call_settings *cs=
, int cls,
 		0 /* Subblock count */
 	};
 =

-	DBG("waiting class %d\n", cls);
+	DBG("waiting class %d", cls);
 =

 	if (!cbd || !sd)
 		goto error;
@@ -266,7 +266,7 @@ static void isi_cw_set(struct ofono_call_settings *cs, =
int mode, int cls,
 		0  /* Subblock count */
 	};
 =

-	DBG("waiting mode %d class %d\n", mode, cls);
+	DBG("waiting mode %d class %d", mode, cls);
 =

 	if (!cbd || !sd)
 		goto error;
diff --git a/drivers/isimodem/cbs.c b/drivers/isimodem/cbs.c
index dec8154..2a32720 100644
--- a/drivers/isimodem/cbs.c
+++ b/drivers/isimodem/cbs.c
@@ -104,7 +104,7 @@ static gboolean routing_resp_cb(GIsiClient *client,
 				"It appears some other component is "
 				"already\n  registered as the CBS "
 				"routing endpoint.\n  As a consequence, "
-				"receiving CBSs is NOT going to work.\n\n",
+				"receiving CBSs is NOT going to work.\n",
 				msg[1], sms_isi_cause_name(msg[1]));
 		return TRUE;
 	}
diff --git a/drivers/isimodem/sms.c b/drivers/isimodem/sms.c
index 319eb54..e2c2533 100644
--- a/drivers/isimodem/sms.c
+++ b/drivers/isimodem/sms.c
@@ -524,7 +524,7 @@ static gboolean routing_resp_cb(GIsiClient *client,
 				"already\n  registered as the SMS "
 				"routing endpoint.\n  As a consequence, "
 				"receiving SMSs is NOT going to work.\n  "
-				"On the other hand, sending might work.\n\n",
+				"On the other hand, sending might work.\n",
 				msg[1], sms_isi_cause_name(msg[1]));
 			ofono_sms_register(sms);
 		}
diff --git a/drivers/stemodem/caif_rtnl.c b/drivers/stemodem/caif_rtnl.c
index 4c00446..c327d57 100644
--- a/drivers/stemodem/caif_rtnl.c
+++ b/drivers/stemodem/caif_rtnl.c
@@ -155,7 +155,7 @@ static int add_attribute(struct nlmsghdr *n, unsigned i=
nt maxlen, int type,
 	struct rtattr *rta;
 =

 	if ((NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len)) > maxlen) {
-		DBG("attribute to large for message %d %d %d\n",
+		DBG("attribute to large for message %d %d %d",
 				n->nlmsg_len, len, maxlen);
 		return -1;
 	}
diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index 05fec3f..1675cd8 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -130,7 +130,7 @@ static void text_handler(GMarkupParseContext *context,
 static void error_handler(GMarkupParseContext *context,
 				GError *error, gpointer user_data)
 {
-	DBG("Error parsing xml response from eppsd: %s\n",
+	DBG("Error parsing xml response from eppsd: %s",
 		error->message);
 }
 =

diff --git a/plugins/isigen.c b/plugins/isigen.c
index fad4e20..3384e9f 100644
--- a/plugins/isigen.c
+++ b/plugins/isigen.c
@@ -290,7 +290,7 @@ static int isigen_probe(struct ofono_modem *modem)
 	if (address) {
 		int error =3D g_pn_netlink_set_address(idx, address);
 		if (error && error !=3D -EEXIST) {
-			DBG("g_pn_netlink_set_address: %s\n", strerror(-error));
+			DBG("g_pn_netlink_set_address: %s", strerror(-error));
 			g_pn_netlink_stop(link);
 			return -errno;
 		}
diff --git a/src/gprs.c b/src/gprs.c
index 3de3f2b..7e42a99 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1730,7 +1730,7 @@ static DBusMessage *gprs_remove_context(DBusConnectio=
n *conn,
 		storage_sync(gprs->imsi, SETTINGS_STORE, gprs->settings);
 	}
 =

-	DBG("Unregistering context: %s\n", ctx->path);
+	DBG("Unregistering context: %s", ctx->path);
 	context_dbus_unregister(ctx);
 	gprs->contexts =3D g_slist_remove(gprs->contexts, ctx);
 =

diff --git a/src/sim.c b/src/sim.c
index c4af079..bc7859c 100644
--- a/src/sim.c
+++ b/src/sim.c
@@ -1097,7 +1097,7 @@ static void sim_sdn_read_cb(int ok, int length, int r=
ecord,
 	if (sim->service_numbers &&
 			g_slist_find_custom(sim->service_numbers,
 				alpha, service_number_compare)) {
-		ofono_error("Duplicate EFsdn entries for `%s'\n",
+		ofono_error("Duplicate EFsdn entries for `%s'",
 				alpha);
 		g_free(alpha);
 =

diff --git a/src/voicecall.c b/src/voicecall.c
index 045b492..874f958 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -1829,7 +1829,7 @@ void ofono_voicecall_notify(struct ofono_voicecall *v=
c,
 				call_compare_by_id);
 =

 	if (l) {
-		DBG("Found call with id: %d\n", call->id);
+		DBG("Found call with id: %d", call->id);
 		voicecall_set_call_status(l->data, call->status);
 		voicecall_set_call_lineid(l->data, &call->phone_number,
 						call->clip_validity);
@@ -1837,7 +1837,7 @@ void ofono_voicecall_notify(struct ofono_voicecall *v=
c,
 		return;
 	}
 =

-	DBG("Did not find a call with id: %d\n", call->id);
+	DBG("Did not find a call with id: %d", call->id);
 =

 	__ofono_modem_callid_hold(modem, call->id);
 =

-- =

1.7.1


--===============8731616488533599022==--

