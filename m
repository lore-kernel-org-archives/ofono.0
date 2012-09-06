Content-Type: multipart/mixed; boundary="===============2850794812007597076=="
MIME-Version: 1.0
From: Lemoine Simon <simon.lemoine@dunasys.com>
Subject: sierra wireless MC8092 issues
Date: Thu, 06 Sep 2012 10:22:22 +0200
Message-ID: <1346919742.2526.94.camel@dunasys010>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2850794812007597076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I work on Sierra wireless MC8092 card, with ofono and connman and I have
three questions :

1/

I have post on this list 3 weeks ago, about Sierra Wireless MC8092 card,
http://lists.ofono.org/pipermail/ofono/2012-August/013450.html .
Following your advices I have used at_util_sim_state_query_new as in
zte.c and it has worked well.

The following patch shows my changes :

--- a/plugins/sierra.c	2012-09-06 09:03:15.842101127 +0200
+++ b/plugins/sierra.c	2012-09-06 09:03:03.788099867 +0200
@@ -48,6 +48,7 @@
 =

 struct sierra_data {
 	GAtChat *modem;
+	struct at_util_sim_state_query *sim_state_query;
 };
 =

 static void sierra_debug(const char *str, void *user_data)
@@ -119,6 +120,17 @@
 	return chat;
 }
 =

+static void sim_state_cb(gboolean present, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct sierra_data *data =3D ofono_modem_get_data(modem);
+
+	at_util_sim_state_query_free(data->sim_state_query);
+	data->sim_state_query =3D NULL;
+
+	ofono_modem_set_powered(modem, TRUE);
+}
+
 static void cfun_enable(gboolean ok, GAtResult *result, gpointer
user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -129,9 +141,12 @@
 	if (!ok) {
 		g_at_chat_unref(data->modem);
 		data->modem =3D NULL;
+		=

+		return;
 	}
-
-	ofono_modem_set_powered(modem, ok);
+	data->sim_state_query =3D at_util_sim_state_query_new(data->modem,
+						2, 20, sim_state_cb, modem,
+						NULL);
 }
 =

 static int sierra_enable(struct ofono_modem *modem)

Are my corrections correct?

2/
As I have explained in post
http://lists.ofono.org/pipermail/ofono/2012-August/013460.html I losted
the IP address just after I obtained it, it comes from connman which
fail with the message "Invalid index and/or address". =

To workaround this issue, I have change the Sierra modem handling tu use
it as an atmodem, see below :

--- a/plugins/sierra.c	2012-09-06 09:36:53.478312137 +0200
+++ b/plugins/sierra.c	2012-09-06 09:03:03.788099867 +0200
@@ -260,7 +260,7 @@
 	ofono_netreg_create(modem, 0, "atmodem", data->modem);
 =

 	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->modem);
-	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->modem);
+	gc =3D ofono_gprs_context_create(modem, 0, "swmodem", data->modem);
 =

 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);

It works well, I have an internet connection, but I don't really know
what are the effects of my change (so I don't like it). Does anybody can
explain me how does swmodem work , and why does connman return "Invalid
index and/or address"?

3/
I have a last issue, when I boot my system the card is not handle by
ofono, I have to reset the Sierra Wireless card to ofono works with it.
I have seen in the log that udevng plugins detects the card but ofono
doesn't handle it (see the log below) . If you have any ideas or
suggestions to solve my issue, feel free to contact me.

Sep  6 05:34:14 dunamux user.debug kernel: [    5.130000] usb usb2:
uevent                                                                   =

Sep  6 05:34:14 dunamux daemon.debug ofonod[530]:
plugins/udevng.c:check_usb_device() hub
[(null):(null)]                                    =

Sep  6 05:34:14 dunamux daemon.debug ofonod[530]:
plugins/udevng.c:check_usb_device() hub
[(null):(null)]                          =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.150000] usb 2-0:1.0:
uevent                                                 =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.150000] usb usb2:
uevent                                                         =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.150000] usb usb1:
uevent                                                                     =
      =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.150000] usb 1-0:1.0:
uevent                                                                     =
   =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.150000] usb usb1:
uevent                                                                     =
      =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.150000] usb 1-2:
uevent                                                                     =
       =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.150000] usb usb1:
uevent                                                                     =

Sep  6 05:34:14 dunamux daemon.debug ofonod[530]:
plugins/udevng.c:check_usb_device() usb
[(null):(null)]                                  =

Sep  6 05:34:14 dunamux daemon.debug ofonod[530]:
plugins/udevng.c:check_usb_device() usb
[(null):(null)]                                =

Sep  6 05:34:14 dunamux daemon.debug ofonod[530]:
plugins/udevng.c:check_usb_device() sierra
[(null):(null)]                         =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.170000] usb 1-2.4:
uevent                                                                  =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.170000] usb 1-2:
uevent                                                          =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.170000] usb 1-2.4:1.0:
uevent                                                    =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.170000] usb 1-2.4:
uevent                                                        =

Sep  6 05:34:14 dunamux daemon.debug ofonod[530]:
plugins/udevng.c:check_usb_device() sierra [(null):(null)]             =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.190000] usb 1-2:
uevent                                                                      =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.190000] usb usb1:
uevent                                                                     =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.190000] usb 1-2.4:1.1:
uevent                                                                =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.190000] usb 1-2.4:
uevent                                                                    =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.190000] usb 1-2:
uevent                                                                    =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.190000] usb usb1:
uevent                                                                   =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.190000] usb 1-2.4:1.2:
uevent                                                              =

Sep  6 05:34:14 dunamux daemon.debug ofonod[530]:
plugins/udevng.c:check_usb_device() sierra
[(null):(null)]                                 =

Sep  6 05:34:14 dunamux daemon.debug ofonod[530]:
plugins/udevng.c:check_usb_device() sierra
[(null):(null)]                           =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.210000] usb 1-2.4:
uevent                                     =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.210000] usb 1-2:
uevent                                       =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.210000] usb usb1:
uevent                                      =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.210000] usb 1-2.4:1.3:
uevent                                 =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.210000] usb 1-2.4:
uevent                                                      =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.210000] usb 1-2:
uevent                                                                    =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.210000] usb usb1:
uevent                                                                   =

Sep  6 05:34:14 dunamux daemon.debug ofonod[530]:
plugins/udevng.c:check_usb_device() sierra_net
[(null):(null)]                             =

Sep  6 05:34:14 dunamux daemon.debug ofonod[530]:
plugins/udevng.c:check_usb_device() hub
[(null):(null)]                                    =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.230000] usb 1-2.4:1.7:
uevent                                          =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.230000] usb 1-2.4:
uevent                                       =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.230000] usb 1-2:
uevent                                         =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.230000] usb usb1:
uevent                                                          =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.230000] usb 1-2:1.0:
uevent                                                       =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.230000] usb 1-2:
uevent                                                           =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.410000] usb 1-2.4:1.0:
uevent                                                     =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.410000] usb 1-2.4:
uevent                                                         =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.410000] usb 1-2.4:1.1:
uevent                                                     =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.410000] usb 1-2.4:
uevent                                                         =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.410000] usb 1-2.4:1.2:
uevent                                                     =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.430000] usb 1-2.4:
uevent                                                         =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.430000] usb 1-2.4:1.3:
uevent                                                     =

Sep  6 05:34:14 dunamux user.debug kernel: [    5.430000] usb 1-2.4:
uevent =


Thank you for your help.
Simon Lemoine



--===============2850794812007597076==--

