Content-Type: multipart/mixed; boundary="===============6265571242737249505=="
MIME-Version: 1.0
From: Vijay Nayani <vijay.nayani@elektrobit.com>
Subject: [RFC PATCH 14/20] packet: add get technology api implementation
Date: Mon, 11 Apr 2011 13:20:12 +0300
Message-ID: <1302517218-2147-15-git-send-email-vijay.nayani@elektrobit.com>
In-Reply-To: <1302517218-2147-1-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6265571242737249505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/packet.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/src/packet.c b/src/packet.c
index 6077617..ed8e1ae 100644
--- a/src/packet.c
+++ b/src/packet.c
@@ -3,6 +3,7 @@
  *  oFono - Open Source Telephony
  *
  *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *  Copyright 2011 EB(Elektrobit).
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -75,6 +76,7 @@ struct ofono_packet_service {
 	unsigned int last_context_id;
 	struct idmap *cid_map;
 	int netreg_status;
+	int netreg_access_tech;
 	struct ofono_netreg *netreg;
 	unsigned int netreg_watch;
 	unsigned int status_watch;
@@ -1537,10 +1539,11 @@ static void netreg_status_changed(int status, int l=
ac, int ci, int tech,
 =

 	DBG("%d", status);
 =

-	if (ps->netreg_status =3D=3D status)
+	if (ps->netreg_status =3D=3D status && ps->netreg_access_tech =3D=3D tech)
 		return;
 =

 	ps->netreg_status =3D status;
+	ps->netreg_access_tech =3D tech;
 =

 	ps_netreg_update(ps);
 }
@@ -2522,6 +2525,7 @@ struct ofono_packet_service *ofono_packet_service_cre=
ate(
 =

 	ps->status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
 	ps->netreg_status =3D NETWORK_REGISTRATION_STATUS_UNKNOWN;
+	ps->netreg_access_tech =3D -1;
 	ps->pid_map =3D idmap_new(MAX_CONTEXTS);
 =

 	return ps;
@@ -2540,6 +2544,7 @@ static void netreg_watch(struct ofono_atom *atom,
 =

 	ps->netreg =3D __ofono_atom_get_data(atom);
 	ps->netreg_status =3D ofono_netreg_get_status(ps->netreg);
+	ps->netreg_access_tech =3D ofono_netreg_get_technology(ps->netreg);
 	ps->status_watch =3D __ofono_netreg_add_status_watch(ps->netreg,
 					netreg_status_changed, ps, NULL);
 =

@@ -2944,3 +2949,12 @@ void *ofono_packet_service_get_data(struct ofono_pac=
ket_service *ps)
 {
 	return ps->driver_data;
 }
+
+int ofono_packet_service_get_technology(struct ofono_packet_service *ps)
+{
+	if (ps->netreg_status !=3D NETWORK_REGISTRATION_STATUS_ROAMING &&
+		ps->netreg_status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED)
+		return -1;
+
+	return ps->netreg_access_tech;
+}
\ No newline at end of file
-- =

1.7.0.4


--===============6265571242737249505==--

