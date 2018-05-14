Content-Type: multipart/mixed; boundary="===============0868279338848392255=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: [rfc] Fix incoming sms on Droid 4 was Re: Incoming sms problem on
 Motorola Droid 4
Date: Mon, 14 May 2018 15:02:42 +0200
Message-ID: <20180514130242.GA6564@amd>
In-Reply-To: <D8F86CC7-9B4B-4F61-9808-CE8E6A79EBC0@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0868279338848392255==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> >>>>> Is this actually an AT command modem or one of those modems where AT
> >>>>> commands were only bolted on for carrier certification?  Does it su=
pport QMI
> >>>>> or something maybe?
> >>>> Ok, so ... this is complex. And maybe this is one of "those" modems.
> >>>> There's USB with AT commands, USB with QMI protocol, then serial with
> >>>> mux and U1234AT+XYZ commands.
> >>>> It seems Android uses serial, but that is being worked on, so I'm
> >>>> using AT commands for now.
> >>> =

> >>> Wow, okay.  You might want to try using the qmi driver family instead.
> >> =

> >> I would switch to QMI since then you can also ignore this weird multip=
lexer.
> > =

> > More explanation needed it seems:
> > =

> > I can already do USB with AT commands, no multiplexer needed. We'd
> > actually prefer to go over serial (with multiplexer), because USB
> > needs to be powered down in idle, and you still need communication
> > ovre serial to know that wakeup of USB is needed.
> > =

> > Yes, it is complex :-(.
> =

> I missed the part that the weird serial multiplexer is wired independentl=
y. Then do everything via that serial multiplexer and never look back. Howe=
ver if that is as broken, then you will be really out of luck. Making this =
work reliable will be really hard.
> =

> While we have seen QMI protocol issues as well, but they have been less b=
ad than the bolted on AT commands. Manufactures always get AT commands wron=
g since they let humans test it and not a real telephony stack like oFono.
>

Ok, so it was a bit of a fight, and result is _not_ ready for
mergning, and probably not even ready for review.

But it works.. for me.

Trick is to use

AT+CSMS=3D0
AT+CNMI=3D1,2,2,1,0

combination and sabotage AT+CNMA commands. That way, ofono uses
PDU mode without acknowledgments, but we get working messages.

Best regards,
								Pavel


diff --git a/doc/location-reporting-api.txt b/doc/location-reporting-api.txt
index 21e346d4..ff0a35dc 100644
--- a/doc/location-reporting-api.txt
+++ b/doc/location-reporting-api.txt
@@ -13,7 +13,7 @@ Methods		dict GetProperties()
 		filedescriptor Request()
 =

 			Asks to turn ON the NMEA stream and supplies the
-			gps device file descriptor. The external cliend should
+			gps device file descriptor. The external client should
 			use the file descriptor to receive the NMEA data.
 =

 			Possible Errors: [service].Error.InProgress
diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index 6f4e8a20..b63d5b33 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -381,9 +381,16 @@ gboolean at_util_parse_sms_index_delivery(GAtResult *r=
esult, const char *prefix,
 		st =3D AT_UTIL_SMS_STORE_BM;
 	else
 		return FALSE;
-
-	if (!g_at_result_iter_next_number(&iter, &index))
-		return FALSE;
+#if 0
+	if (g_at_result_iter_next(&iter, "-")) {
+	  printf("Unexpected - arrived, ignoring\n");
+	}
+#endif
+	if (!g_at_result_iter_next_number(&iter, &index)) {
+	  printf("iter next number parse failed, faking\n");
+	  index =3D 1;
+	  //return FALSE;
+	}
 =

 	if (out_index)
 		*out_index =3D index;
diff --git a/drivers/atmodem/call-meter.c b/drivers/atmodem/call-meter.c
index 430d5461..3de3f59e 100644
--- a/drivers/atmodem/call-meter.c
+++ b/drivers/atmodem/call-meter.c
@@ -255,7 +255,7 @@ static void at_cpuc_query(struct ofono_call_meter *cm,
 	struct cb_data *cbd =3D cb_data_new(cb, data);
 =

 	cbd->user =3D "+CPUC:";
-	if (g_at_chat_send(chat, "AT+CPUC?", cpuc_prefix,
+	if (g_at_chat_send(chat, "AT+CPnottodayUC?", cpuc_prefix,
 				cpuc_query_cb, cbd, g_free) > 0)
 		return;
 =

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 68b89862..75dc6c6b 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -328,11 +328,13 @@ static inline void at_ack_delivery(struct ofono_sms *=
sms)
 =

 	/* We must acknowledge the PDU using CNMA */
 	if (data->cnma_ack_pdu) {
-		switch (data->vendor) {
+		switch (0) {
 		case OFONO_VENDOR_CINTERION:
 			snprintf(buf, sizeof(buf), "AT+CNMA=3D1");
 			break;
 		default:
+		  printf("PDU Len %d, strlen %d\n", data->cnma_ack_pdu_len, strlen(data-=
>cnma_ack_pdu));
+		  printf("PDU last char %d\n", data->cnma_ack_pdu[strlen(data->cnma_ack_=
pdu)-1]);
 			snprintf(buf, sizeof(buf), "AT+CNMA=3D1,%d\r%s",
 					data->cnma_ack_pdu_len,
 					data->cnma_ack_pdu);
@@ -340,7 +342,7 @@ static inline void at_ack_delivery(struct ofono_sms *sm=
s)
 		}
 	} else {
 		/* Should be a safe fallback */
-		snprintf(buf, sizeof(buf), "AT+CNMA=3D0");
+		snprintf(buf, sizeof(buf), "AT");
 	}
 =

 	g_at_chat_send(data->chat, buf, none_prefix, at_cnma_cb, NULL, NULL);
@@ -440,6 +442,8 @@ static void at_cmt_notify(GAtResult *result, gpointer u=
ser_data)
 	if (data->vendor !=3D OFONO_VENDOR_SIMCOM)
 		at_ack_delivery(sms);
 =

+	return;
+
 err:
 	ofono_error("Unable to parse CMT notification");
 }
@@ -832,9 +836,9 @@ static gboolean build_cnmi_string(char *buf, int *cnmi_=
opts,
 =

 	/* Prefer to deliver SMS via +CMT if CNMA is supported */
 	if (!append_cnmi_element(buf, &len, cnmi_opts[1],
-					data->cnma_enabled ? "21" : "1", FALSE))
+					data->cnma_enabled ? "21" : "21", FALSE))
 		return FALSE;
-
+	=

 	/* Always deliver CB via +CBM, otherwise don't deliver at all */
 	if (!append_cnmi_element(buf, &len, cnmi_opts[2], "20", FALSE))
 		return FALSE;
@@ -1204,8 +1208,8 @@ static void at_csms_status_cb(gboolean ok, GAtResult =
*result,
 		if (!g_at_result_iter_next_number(&iter, &mo))
 			goto out;
 =

-		if (service =3D=3D 1)
-			data->cnma_enabled =3D TRUE;
+		//if (service =3D=3D 1)
+		//	data->cnma_enabled =3D TRUE;
 =

 		if (mt =3D=3D 1 && mo =3D=3D 1)
 			supported =3D TRUE;
@@ -1255,6 +1259,9 @@ static void at_csms_query_cb(gboolean ok, GAtResult *=
result,
 		if (status_min <=3D 1 && 1 <=3D status_max)
 			cnma_supported =3D TRUE;
 =

+	printf("Forcing cnma to false\n");
+	cnma_supported =3D FALSE;
+
 	DBG("CSMS query parsed successfully");
 =

 out:
diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index e4c59c26..df2975bb 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -161,6 +161,7 @@ static void clcc_poll_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 			poll_again =3D TRUE;
 			goto poll_again;
 		}
+		goto poll_again;
 =

 		ofono_error("We are polling CLCC and received an error");
 		ofono_error("All bets are off for call management");
@@ -420,6 +421,7 @@ static void at_dial(struct ofono_voicecall *vc,
 =

 	strcat(buf, ";");
 =

+	/* Need to make it non-blocking or something? */
 	if (g_at_chat_send(vd->chat, buf, atd_prefix,
 				atd_cb, cbd, g_free) > 0)
 		return;
diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index 3f290ac2..86ed1352 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -579,6 +579,8 @@ static void have_line(struct at_chat *p, char *str)
 	if (str =3D=3D NULL)
 		return;
 =

+	printf("< %s\n", str);
+
 	/* Check for echo, this should not happen, but lets be paranoid */
 	if (!strncmp(str, "AT", 2))
 		goto done;
@@ -650,6 +652,9 @@ static void have_pdu(struct at_chat *p, char *pdu)
 	if (pdu =3D=3D NULL)
 		goto error;
 =

+	printf("<PDU %s\n", pdu);
+
+
 	result.lines =3D g_slist_prepend(NULL, p->pdu_notify);
 	result.final_or_pdu =3D pdu;
 =

@@ -764,11 +769,13 @@ static void new_bytes(struct ring_buffer *rbuf, gpoin=
ter user_data)
 			break;
 =

 		case G_AT_SYNTAX_RESULT_PROMPT:
+		  printf("<PR\n");
 			chat_wakeup_writer(p);
 			ring_buffer_drain(rbuf, p->read_so_far);
 			break;
 =

 		default:
+		  printf("<D\n");
 			ring_buffer_drain(rbuf, p->read_so_far);
 			break;
 		}
@@ -845,6 +852,7 @@ static gboolean can_write_data(gpointer data)
 	if (cmd =3D=3D NULL)
 		return FALSE;
 =

+	printf("> %s\n", cmd->cmd);
 	len =3D strlen(cmd->cmd);
 =

 	/* For some reason write watcher fired, but we've already
@@ -1018,6 +1026,7 @@ static gboolean at_chat_set_wakeup_command(struct at_=
chat *chat,
 	return TRUE;
 }
 =

+/* HERE ? */
 static guint at_chat_send_common(struct at_chat *chat, guint gid,
 					const char *cmd,
 					const char **prefix_list,
diff --git a/plugins/udevng.c b/plugins/udevng.c
index ff5d41af..a4b18488 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -233,10 +233,11 @@ static gboolean setup_gobi(struct modem_info *modem)
 		}
 	}
 =

+	DBG("qmi=3D%s net=3D%s mdm=3D%s gps=3D%s diag=3D%s", qmi, net, mdm, gps, =
diag);
+	=

 	if (qmi =3D=3D NULL || mdm =3D=3D NULL || net =3D=3D NULL)
 		return FALSE;
 =

-	DBG("qmi=3D%s net=3D%s mdm=3D%s gps=3D%s diag=3D%s", qmi, net, mdm, gps, =
diag);
 =

 	ofono_modem_set_string(modem->modem, "Device", qmi);
 	ofono_modem_set_string(modem->modem, "Modem", mdm);
@@ -1250,6 +1251,7 @@ static struct {
 	{ "cinterion",	setup_serial_modem	},
 	{ "nokiacdma",	setup_serial_modem	},
 	{ "sim900",	setup_serial_modem	},
+	{ "g1",		setup_serial_modem	},
 	{ "wavecom",	setup_wavecom		},
 	{ "tc65",	setup_tc65		},
 	{ "ehs6",	setup_ehs6		},
@@ -1578,8 +1580,6 @@ static struct {
 	{ "mbm",	"cdc_ether",	"0930"		},
 	{ "mbm",	"cdc_ncm",	"0930"		},
 	{ "hso",	"hso"				},
-	{ "gobi",	"qmi_wwan"			},
-	{ "gobi",	"qcserial"			},
 	{ "sierra",	"qmi_wwan",	"1199"		},
 	{ "sierra",	"qcserial",	"1199"		},
 	{ "sierra",	"sierra"			},
@@ -1602,6 +1602,8 @@ static struct {
 	{ "telit",	"cdc_acm",	"1bc7", "0021"	},
 	{ "telitqmi",	"qmi_wwan",	"1bc7", "1201"	},
 	{ "telitqmi",	"option",	"1bc7", "1201"	},
+	{ "telitqmi",	"qmi_wwan",	"22b8", "2a70"	},
+	{ "telitqmi",	"option",	"22b8", "2a70"	},
 	{ "nokia",	"option",	"0421", "060e"	},
 	{ "nokia",	"option",	"0421", "0623"	},
 	{ "samsung",	"option",	"04e8", "6889"	},
@@ -1717,10 +1719,12 @@ static void check_device(struct udev_device *device)
 			return;
 	}
 =

+#if 0
 	if ((g_str_equal(bus, "usb") =3D=3D TRUE) ||
 			(g_str_equal(bus, "usbmisc") =3D=3D TRUE))
 		check_usb_device(device);
 	else
+#endif
 		add_serial_device(device);
 =

 }
@@ -1749,14 +1753,17 @@ static gboolean create_modem(gpointer key, gpointer=
 value, gpointer user_data)
 		if (g_str_equal(driver_list[i].name, modem->driver) =3D=3D FALSE)
 			continue;
 =

+		DBG("Attempting modem setup, driver %s", modem->driver);
 		if (driver_list[i].setup(modem) =3D=3D TRUE) {
 			ofono_modem_set_string(modem->modem, "SystemPath",
 								syspath);
 			ofono_modem_register(modem->modem);
 			return FALSE;
 		}
+		DBG("Modem setup failed, driver %s", modem->driver);		=

 	}
 =

+	DBG("Modem setup failed or not in driver_list?");
 	return TRUE;
 }
 =

diff --git a/test/send-sms b/test/send-sms
index 98808aaf..cabe0652 100755
--- a/test/send-sms
+++ b/test/send-sms
@@ -6,6 +6,7 @@ import dbus
 if len(sys.argv) < 4:
 	print("Usage: %s [modem] <to> <message> <delivery report>" %\
 					(sys.argv[0]))
+        print("  where delivery report is 0|1")
 	sys.exit(1)
 =

 bus =3D dbus.SystemBus()
diff --git a/test/test-location b/test/test-location
new file mode 100755
index 00000000..850e472b
--- /dev/null
+++ b/test/test-location
@@ -0,0 +1,20 @@
+import dbus
+import sys
+import glib
+
+bus =3D dbus.SystemBus()
+
+if len(sys.argv) =3D=3D 2:
+        path =3D sys.argv[1]
+else:
+        manager =3D dbus.Interface(bus.get_object('org.ofono', '/'),
+                        'org.ofono.Manager')
+        modems =3D manager.GetModems()
+        path =3D modems[0][0]
+
+print("Connecting modem %s..." % path)
+modem =3D dbus.Interface(bus.get_object('org.ofono', path),
+                                                'org.ofono.LocationReporti=
ng')
+
+fd =3D modem.Request()
+


-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============0868279338848392255==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFscjVpUElBQ2drUU1PZndhcFhiK3ZMMDhRQ2dsSEliK2RNdTJEV0s1ME9oQi9CNUJVTmkK
Y24wQW5SRDZXaUNmYXN1NDNTWEMvbkVSeVJ5c3BlVmEKPS9JLzkKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============0868279338848392255==--

