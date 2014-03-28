Content-Type: multipart/mixed; boundary="===============6000120533973360553=="
MIME-Version: 1.0
From: Eric BOUXIROT <eric.bouxirot@azimut-monitoring.com>
Subject: Re: wwan0 interface without IP
Date: Fri, 28 Mar 2014 16:45:13 +0100
Message-ID: <lh45ds$8ir$1@ger.gmane.org>
In-Reply-To: <53358B76.9000505@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6000120533973360553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> oFono does not assign the IP parameters.  ConnMan does that or you need
> to do this some other way.

forget to tell, i must apply this patch too, because my modem do not =

reconize the command and ofono fail.

diff -uprN a/drivers/swmodem/gprs-context.c =

b/drivers/swmodem/gprs-context.c
--- a/drivers/swmodem/gprs-context.c	2012-07-02 09:55:34.000000000 =

+0200
+++ b/drivers/swmodem/gprs-context.c	2014-03-27 23:08:44.904767915 =

+0100
@@ -100,9 +100,6 @@ static void at_scact_up_cb(gboolean ok,
 	snprintf(buf, sizeof(buf), "AT!SCPADDR=3D%u", gcd->active_context);
 	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);

-	snprintf(buf, sizeof(buf), "AT+CGCONTRDP=3D%u", gcd->active_context);
-	g_at_chat_send(gcd->chat, buf, none_prefix, NULL, NULL, NULL);
-
 	modem =3D ofono_gprs_context_get_modem(gc);
 	interface =3D ofono_modem_get_string(modem, "NetworkInterface");


--===============6000120533973360553==--

