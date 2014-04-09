Content-Type: multipart/mixed; boundary="===============0097324258434190775=="
MIME-Version: 1.0
From: Brian Ruptash <bruptash@gmail.com>
Subject: [PATCH] gprs: Attach status confusion
Date: Wed, 09 Apr 2014 15:57:34 +0200
Message-ID: <1397051854-30060-1-git-send-email-bruptash@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0097324258434190775==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm using a Cinterion PH8-P and an ofono driver I wrote for it, and
having a problem with how src/gprs.c manages the GPRS attach status.
You'll observe in the below trace that the modem deregisters/registers
and GPRS detaches/attaches several times in a short span, however I'm
intentionally inducing this in order to reproduce a problem that happens
in the field; my use case is a handheld terminal where the user is
constantly on the move, usually in an urban environment, so frequent
signal/connection loss is observed as expected.

Following is a trace of ofono events.  Prior to this point the modem was
happily network registered and attached, and now the modem loses both:

18:39:27.023 ph8.c:122           ph8_debug App: < \r\n+CGREG: 2\r\n\r\n+CRE=
G: 2\r\n
18:39:27.030 gprs.c:2174         ofono_gprs_status_notify /ph8_1 status 2 p=
owered
18:39:27.030 gprs.c:1503         gprs_attached_update /ph8_1 status 2 attac=
hed driver_attached changed active
18:39:27.030 gprs.c:1471         release_active_contexts /ph8_1 active
18:39:27.030 gprs-context.c:447  at_gprs_detach_shutdown cid 1
18:39:28.344 network.c:1349      ofono_netreg_status_notify /ph8_1 status 2=
 tech -1
18:39:28.358 gprs.c:1629         netreg_status_changed 2
18:39:28.358 gprs.c:1600         gprs_netreg_update /ph8_1 2 powered driver=
_attached
18:39:28.361 ph8.c:122           ph8_debug App: > AT+CGATT=3D0\r
18:39:28.412 ph8.c:122           ph8_debug App: < \r\nOK\r\n
18:39:28.413 gprs.c:1558         gprs_attach_callback /ph8_1 error =3D 0
18:39:28.431 ph8.c:122           ph8_debug App: > AT+CGREG?\r
18:39:28.442 ph8.c:122           ph8_debug App: < \r\n+CGREG: 1,2\r\n\r\nOK=
\r\n
18:39:28.443 gprs.c:1539         registration_status_cb /ph8_1 error 0 stat=
us 2 attaching
18:39:28.443 gprs.c:2174         ofono_gprs_status_notify /ph8_1 status 2 p=
owered
18:39:28.443 gprs.c:1503         gprs_attached_update /ph8_1 status 2 active

So now the modem is neither registered nor attached, and
driver_attached=3D0.

Now the modem network registers and attaches.  Yes, it's odd that the
modem attaches even though the prior +CGATT=3D0 completed; according to
the modem vendor the reason for this is that +CGATT=3D0 doesn't take
effect until the device has registered:

18:39:29.972 ph8.c:122           ph8_debug App: < \r\n+CGREG: 1\r\n\r\n+CRE=
G: 1,"0B2D","5F82F11"\r\n
18:39:29.972 gprs.c:2174         ofono_gprs_status_notify /ph8_1 status 1 p=
owered
18:39:29.972 gprs.c:1503         gprs_attached_update /ph8_1 status 1 drive=
r_attached changed active
18:39:29.983 network.c:1349      ofono_netreg_status_notify /ph8_1 status 1=
 tech 2
18:39:30.001 gprs.c:1629         netreg_status_changed 1
18:39:30.001 gprs.c:1600         gprs_netreg_update /ph8_1 1 powered driver=
_attached

And now that the modem is both registered and attached, =

driver_attached=3D1.

However the modem is now registered, so it obeys the +CGATT=3D0 and
detaches.  Note it returns +CGREG: 0 indicating it is detached and will =

not attach until instructed to do so:

18:39:33.422 ph8.c:122           ph8_debug App: < \r\n+CGREG: 0\r\n
18:39:33.422 gprs.c:2174         ofono_gprs_status_notify /ph8_1 status 0 p=
owered
18:39:33.422 gprs.c:1503         gprs_attached_update /ph8_1 status 0 drive=
r_attached active
18:39:34.452 gprs-context.c:104  ppp_debug HDLC: < 0d 0a 4e 4f 20 43 41 52 =
52 49 45 52 0d 0a        ..NO CARRIER..
18:39:37.809 gprs-context.c:183  ppp_disconnect state active, reason 6
18:39:37.809 gprs.c:2311         ofono_gprs_context_deactivated /ph8_1 upda=
te
18:39:37.813 gprs.c:1503         gprs_attached_update /ph8_1 status 0 drive=
r_attached

So I'm now in a state where the modem is registered and detached, but =

gprs->driver_attached=3D1.  And since +CGATT=3D0 it will never attach.

The underlying reason for this seems to be that gprs->driver_attached
follows the +CGATT state, but there's no logic to "synchronize" attach
status changes against the network registration status.  One could
better argue the underlying reason is the modem's misbehaviour in
attaching even though +CGATT=3D0, but it's simpler for me to address this
in ofono than to (1) convince the modem vendor that it's their problem,
(2) get them to release a firmware update, and (3) download the update
in 20,000 devices :)

Following is a proposed patch that seems to address this issue.

-- Brian

---
 src/gprs.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/gprs.c b/src/gprs.c
index e379f7b..73edfb4 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2149,6 +2149,21 @@ void ofono_gprs_status_notify(struct ofono_gprs *gpr=
s, int status)
 =

 	gprs->status =3D status;
 =

+	if (status =3D=3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED) {
+		if (gprs->flags & GPRS_FLAG_ATTACHING)
+			return;
+
+		gprs->driver_attached =3D FALSE;
+
+		if (gprs->powered =3D=3D FALSE) {
+			gprs_attached_update(gprs);
+			return;
+		}
+
+		gprs_netreg_update(gprs);
+		return;
+	}
+
 	if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
 			status !=3D NETWORK_REGISTRATION_STATUS_ROAMING) {
 		gprs_attached_update(gprs);
-- =

1.7.9.5


--===============0097324258434190775==--

