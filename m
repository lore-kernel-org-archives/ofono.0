Received: from mxe.seznam.cz (mxe.seznam.cz [77.75.78.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C156C40BCBB
	for <ofono@lists.linux.dev>; Wed, 19 Aug 2026 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128202; cv=none; b=opAKCOKHb4fWB38d5pm6CAtionJOyr+BEX3aAiEBMM+hkrV+qcdLxgesIVXUCVA5oAdaJD5zME6cyod8/ODpnIfZkH7kUUOADSSD3FnllVpPOFKSlDs+oDGiU0ua+wQwcoDh2qivgWFPMFP3Rgh8pojHwvWB7wA75AT4RG30Les=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128202; c=relaxed/simple;
	bh=GCdzjpGGvGvmpQ0ZKkaVoTZYoxDSt6Rya1os9s+zI6w=;
	h=From:To:Subject:Date:Message-Id:Mime-Version:Content-Type; b=T40Ak+BVE3UxBL4UFIN9W5JDJ7VnLfH7t4xIXpXqU07vukMKZE2QuOvpEGQxbFYJvtCnzAT5HDCJrrBhsRpcgtQ5rYoLjHmhnLJdN2ri0mh1hAaubRyg0K37lSDLAkyVZEtg/P3wF//JsDHEzV8tgH2loUH5ywUMwlrrUaxG3mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=aPRXF7TR; arc=none smtp.client-ip=77.75.78.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="aPRXF7TR"
Received: from email.seznam.cz
	by smtpc-mxe-9fb5dbb56-fv7lw
	(smtpc-mxe-9fb5dbb56-fv7lw [2a02:598:64:8a00::1000:a81])
	id 257b4de8f95eba0a254465d8;
	Wed, 19 Aug 2026 10:29:56 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1787128196; bh=AmmSwToDc05vq8U8ILDnJTgNLLfcTWMgh/psdW3WO/g=;
	h=From:To:Subject:Date:Message-Id:Mime-Version:Content-Type;
	b=aPRXF7TR8CNTXsHXfs3/PRuWBvV7rbvot97CYVKd5Skh1x8vm4NqJ7pusAhgqwqcz
	 fiCdWY3/N2scFFREQuG3XqDu/ZgWCUHelv/sOgqTlXqk0zF+TWP2mHySGGf5/fvFt6
	 GePdrHkWN2r39MjNHNmcwOW3EXNeWUluo4s8ybvAmPwGOnRO7PCW3MO00j3leUz38d
	 QYZbesotuIVFl6+2jSQDaBaY+bMZHUmGuDu/walCNLt3VElaFkD76ryMne5nsSVUpH
	 Zo2g4DcCdvnfZzF0wQIdSOlkvj7Ey9Hkslc0U/67xIr2GHupunznqE60WyD7ZJBmLH
	 Lpz6wYsCXyFHQ==
Received: from ais-gw.ais.cz (ais-gw.ais.cz [85.93.112.4])
	by email.seznam.cz (szn-ebox-5.1.10) with HTTP;
	Wed, 19 Aug 2026 10:29:48 +0200 (CEST)
From: <bugear@seznam.cz>
To: <ofono@lists.linux.dev>
Subject: [PATCH] smsutil: Expire stale SMS assemblies after 73 hours
Date: Wed, 19 Aug 2026 10:29:48 +0200 (CEST)
Message-Id: <35f.Fwnv.1OBONKGRARS.1gXMby@seznam.cz>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (szn-mime-2.2.10)
X-Mailer: szn-ebox-5.1.10
Content-Type: multipart/mixed;
	boundary="=_2a1bd3cb108c525e30200845=de43bf65-d5ec-59c9-b9c9-f3382bf2ea75_="


--=_2a1bd3cb108c525e30200845=de43bf65-d5ec-59c9-b9c9-f3382bf2ea75_=
Content-Type: multipart/alternative;
	boundary="=_6980b46143cb2585506974cc=de43bf65-d5ec-59c9-b9c9-f3382bf2ea75_="


--=_6980b46143cb2585506974cc=de43bf65-d5ec-59c9-b9c9-f3382bf2ea75_=
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi oFono devs,





this is a follow-up to:=C2=A0smsutil: Fix cleanup of max-numbered SMS asse=
mbly 
fragment




This patch builds on the previously submitted fix and handles=C2=A0stale =

assemblies already present on deployed systems, whether left=C2=A0behind b=
y the 
cleanup bug or by incomplete multipart SMS delivery.




It expires assemblies older than 73 hours when restoring persistent=C2=A0s=
tate 
and handles concatenation reference reuse with a different=C2=A0fragment c=
ount. A
stale conflicting assembly is discarded so the new=C2=A0multipart message =
can be 
assembled, while a recent conflicting assembly=C2=A0is preserved and the =

collision is logged.




Tests are included for restore-time expiry, stale collision recovery=C2=A0=
and 
preservation of recent assemblies.




The 73-hour timeout is based on a commonly used three-day SMSC message=
=C2=A0
retention period with an additional one-hour safety margin.





Thanks,

Vit Hampl

--=_6980b46143cb2585506974cc=de43bf65-d5ec-59c9-b9c9-f3382bf2ea75_=
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div>Hi oFono devs,</div><div><br></div><div><div>this is a fo=
llow-up to:&nbsp;<span style=3D"background-color:transparent">smsutil: Fix=
 cleanup of max-numbered SMS assembly fragment</span></div><div><br></div>=
<div>This patch builds on the previously submitted fix and handles&nbsp;<s=
pan style=3D"background-color:transparent">stale assemblies already presen=
t on deployed systems, whether left&nbsp;</span><span style=3D"background-=
color:transparent">behind by the cleanup bug or by incomplete multipart SM=
S delivery.</span></div><div><br></div><div>It expires assemblies older th=
an 73 hours when restoring persistent&nbsp;<span style=3D"background-color=
:transparent">state and handles concatenation reference reuse with a diffe=
rent&nbsp;</span><span style=3D"background-color:transparent">fragment cou=
nt. A stale conflicting assembly is discarded so the new&nbsp;</span><span=
 style=3D"background-color:transparent">multipart message can be assembled=
, while a recent conflicting assembly&nbsp;</span><span style=3D"backgroun=
d-color:transparent">is preserved and the collision is logged.</span></div=
><div><br></div><div>Tests are included for restore-time expiry, stale col=
lision recovery&nbsp;<span style=3D"background-color:transparent">and pres=
ervation of recent assemblies.</span></div><div><br></div><div>The 73-hour=
 timeout is based on a commonly used three-day SMSC message&nbsp;<span sty=
le=3D"background-color:transparent">retention period with an additional on=
e-hour safety margin.</span></div></div><div><br></div><div>Thanks,</div><=
div>Vit Hampl</div></body></html>
--=_6980b46143cb2585506974cc=de43bf65-d5ec-59c9-b9c9-f3382bf2ea75_=--


--=_2a1bd3cb108c525e30200845=de43bf65-d5ec-59c9-b9c9-f3382bf2ea75_=
Content-Type: application/octet-stream;
	name=0001-smsutil-Expire-stale-SMS-assemblies-after-73-hours.patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	size=9679;
	filename=0001-smsutil-Expire-stale-SMS-assemblies-after-73-hours.patch

From 683de933465cb01ed868120ceb7f1cecb08dd6c5 Mon Sep 17 00:00:00 2001=
=0A=
From: =3D?UTF-8?q?V=3DC3=3DADt=3D20Hampl?=3D <bugear@seznam.cz>=0A=
Date: Wed, 19 Aug 2026 09:51:53 +0200=0A=
Subject: [PATCH] smsutil: Expire stale SMS assemblies after 73 hours=0A=
=0A=
Concatenated SMS assemblies are persisted on disk and restored when=0A=
oFono starts. If an assembly remains incomplete for a long time, an SMSC=
=0A=
may later reuse the same concatenation reference for a different=0A=
multipart message from the same sender.=0A=
=0A=
The current implementation rejects such messages when the fragment count=
=0A=
(max) differs from the stale assembly, preventing the new multipart=0A=
message from being assembled.=0A=
=0A=
Fix this by:=0A=
=0A=
- expiring SMS assemblies older than 73 hours immediately after they are=
=0A=
  restored from persistent storage;=0A=
- discarding stale SMS assemblies when a reference collision with a=0A=
  different fragment count is detected;=0A=
- logging reference collisions and failures to remove stale persistent=
=0A=
  state.=0A=
=0A=
The 73-hour timeout corresponds to the commonly used 72-hour SMSC=0A=
delivery retry period with an additional one-hour safety margin.=0A=
=0A=
Signed-off-by: Vit Hampl <bugear@seznam.cz>=0A=
---=0A=
 src/smsutil.c        |  60 ++++++++++++++---=0A=
 src/smsutil.h        |   1 +=0A=
 unit/test-sms-root.c | 152 +++++++++++++++++++++++++++++++++++++++++++=
=0A=
 3 files changed, 205 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/src/smsutil.c b/src/smsutil.c=0A=
index 9fd3bec0..896b55bb 100644=0A=
--- a/src/smsutil.c=0A=
+++ b/src/smsutil.c=0A=
@@ -17,6 +17,8 @@=0A=
 #include <sys/types.h>=0A=
 #include <sys/stat.h>=0A=
 #include <unistd.h>=0A=
+#include <errno.h>=0A=
+#include <time.h>=0A=
 =0A=
 #include <glib.h>=0A=
 #include <ell/ell.h>=0A=
@@ -2516,18 +2518,19 @@ static gboolean sms_assembly_store(struct sms_asse=
mbly *assembly,=0A=
 	return TRUE;=0A=
 }=0A=
 =0A=
-static void sms_assembly_backup_free(struct sms_assembly *assembly,=0A=
+static gboolean sms_assembly_backup_free(struct sms_assembly *assembly,=
=0A=
 					struct sms_assembly_node *node)=0A=
 {=0A=
 	char *path;=0A=
 	int seq;=0A=
+	gboolean success =3D TRUE;=0A=
 	DECLARE_SMS_ADDR_STR(straddr);=0A=
 =0A=
 	if (assembly->imsi =3D=3D NULL)=0A=
-		return;=0A=
+		return TRUE;=0A=
 =0A=
 	if (sms_address_to_hex_string(&node->addr, straddr) =3D=3D FALSE)=0A=
-		return;=0A=
+		return FALSE;=0A=
 =0A=
 	for (seq =3D 1; seq <=3D node->max_fragments; seq++) {=0A=
 		int offset =3D seq / 32;=0A=
@@ -2537,15 +2540,23 @@ static void sms_assembly_backup_free(struct sms_as=
sembly *assembly,=0A=
 			path =3D l_strdup_printf(SMS_BACKUP_PATH_FILE,=0A=
 					assembly->imsi, straddr,=0A=
 					node->ref, node->max_fragments, seq);=0A=
-			unlink(path);=0A=
+=0A=
+			if (unlink(path) < 0 && errno !=3D ENOENT)=0A=
+				success =3D FALSE;=0A=
+=0A=
 			l_free(path);=0A=
 		}=0A=
 	}=0A=
 =0A=
 	path =3D l_strdup_printf(SMS_BACKUP_PATH_DIR, assembly->imsi, straddr,=
=0A=
 				node->ref, node->max_fragments);=0A=
-	rmdir(path);=0A=
+=0A=
+	if (rmdir(path) < 0 && errno !=3D ENOENT)=0A=
+		success =3D FALSE;=0A=
+=0A=
 	l_free(path);=0A=
+=0A=
+	return success;=0A=
 }=0A=
 =0A=
 struct sms_assembly *sms_assembly_new(const char *imsi)=0A=
@@ -2573,6 +2584,9 @@ struct sms_assembly *sms_assembly_new(const char *im=
si)=0A=
 		}=0A=
 =0A=
 		free(entries);=0A=
+=0A=
+		sms_assembly_expire(ret,=0A=
+					time(NULL) - SMS_ASSEMBLY_EXPIRY_SECONDS);=0A=
 	}=0A=
 =0A=
 	return ret;=0A=
@@ -2637,11 +2651,41 @@ static GSList *sms_assembly_add_fragment_backup(st=
ruct sms_assembly *assembly,=0A=
 			continue;=0A=
 =0A=
 		/*=0A=
-		 * Message Reference and address the same, but max is not=0A=
-		 * ignore the SMS completely=0A=
+		 * A concatenation reference can be reused. If an existing=0A=
+		 * assembly with the same sender and reference has a different=0A=
+		 * fragment count, discard it only if it is older than the=0A=
+		 * maximum expected SMSC delivery window.=0A=
 		 */=0A=
-		if (max !=3D node->max_fragments)=0A=
+		if (max !=3D node->max_fragments) {=0A=
+			if (node->ts <=3D ts - SMS_ASSEMBLY_EXPIRY_SECONDS) {=0A=
+				if (!sms_assembly_backup_free(assembly, node)) {=0A=
+					l_warn("Failed to remove stale SMS assembly: "=0A=
+							"sender=3D%s ref=3D%u old-max=3D%u "=0A=
+							"new-max=3D%u",=0A=
+							addr->address, ref,=0A=
+							node->max_fragments, max);=0A=
+					return NULL;=0A=
+				}=0A=
+=0A=
+				g_slist_free_full(node->fragment_list, g_free);=0A=
+=0A=
+				if (prev)=0A=
+					prev->next =3D l->next;=0A=
+				else=0A=
+					assembly->assembly_list =3D l->next;=0A=
+=0A=
+				g_free(node);=0A=
+				node =3D NULL;=0A=
+				g_slist_free_1(l);=0A=
+				break;=0A=
+			}=0A=
+=0A=
+			l_warn("SMS assembly collision: sender=3D%s ref=3D%u "=0A=
+					"old-max=3D%u new-max=3D%u",=0A=
+					addr->address, ref,=0A=
+					node->max_fragments, max);=0A=
 			return NULL;=0A=
+		}=0A=
 =0A=
 		/* Now check if we already have this seq number */=0A=
 		if (node->bitmap[offset] & bit)=0A=
diff --git a/src/smsutil.h b/src/smsutil.h=0A=
index 2c1c7d2e..8865df8f 100644=0A=
--- a/src/smsutil.h=0A=
+++ b/src/smsutil.h=0A=
@@ -9,6 +9,7 @@ enum cbs_language;=0A=
 =0A=
 #define CBS_MAX_GSM_CHARS 93=0A=
 #define SMS_MSGID_LEN 20=0A=
+#define SMS_ASSEMBLY_EXPIRY_SECONDS (73 * 60 * 60)=0A=
 =0A=
 enum sms_type {=0A=
 	SMS_TYPE_DELIVER =3D 0,=0A=
diff --git a/unit/test-sms-root.c b/unit/test-sms-root.c=0A=
index 3566b6aa..4407abb3 100644=0A=
--- a/unit/test-sms-root.c=0A=
+++ b/unit/test-sms-root.c=0A=
@@ -13,6 +13,7 @@=0A=
 #include <unistd.h>=0A=
 #include <stdlib.h>=0A=
 #include <string.h>=0A=
+#include <utime.h>=0A=
 =0A=
 #include <glib.h>=0A=
 =0A=
@@ -118,12 +119,163 @@ static void test_serialize_assembly(void)=0A=
 	sms_assembly_free(assembly);=0A=
 }=0A=
 =0A=
+static void test_assembly_expire_on_load(void)=0A=
+{=0A=
+	const char *imsi =3D "1235";=0A=
+	unsigned char pdu[176];=0A=
+	long pdu_len;=0A=
+	struct sms sms;=0A=
+	struct sms_assembly *assembly;=0A=
+	guint16 ref;=0A=
+	guint8 max;=0A=
+	guint8 seq;=0A=
+	GSList *l;=0A=
+	time_t now =3D time(NULL);=0A=
+	time_t old =3D now - SMS_ASSEMBLY_EXPIRY_SECONDS - 60;=0A=
+	struct utimbuf times =3D {=0A=
+		.actime =3D old,=0A=
+		.modtime =3D old,=0A=
+	};=0A=
+	DECLARE_SMS_ADDR_STR(straddr);=0A=
+	char *path;=0A=
+=0A=
+	/*=0A=
+	 * Remove data left by a previous failed test run.=0A=
+	 */=0A=
+	assembly =3D sms_assembly_new(imsi);=0A=
+	sms_assembly_expire(assembly, now + 1);=0A=
+	sms_assembly_free(assembly);=0A=
+=0A=
+	assembly =3D sms_assembly_new(imsi);=0A=
+=0A=
+	decode_hex_own_buf(assembly_pdu1, -1, &pdu_len, 0, pdu);=0A=
+	sms_decode(pdu, pdu_len, FALSE, assembly_pdu_len1, &sms);=0A=
+=0A=
+	sms_extract_concatenation(&sms, &ref, &max, &seq);=0A=
+	l =3D sms_assembly_add_fragment(assembly, &sms, now,=0A=
+					&sms.deliver.oaddr, ref, max, seq);=0A=
+	g_assert(l =3D=3D NULL);=0A=
+	g_assert_cmpuint(g_slist_length(assembly->assembly_list), =3D=3D, 1);=
=0A=
+=0A=
+	g_assert(sms_address_to_hex_string(&sms.deliver.oaddr, straddr));=0A=
+=0A=
+	path =3D g_strdup_printf(STORAGEDIR "/%s/sms_assembly/%s-%u-%u/%03u",=
=0A=
+				imsi, straddr, ref, max, seq);=0A=
+	g_assert_cmpint(utime(path, &times), =3D=3D, 0);=0A=
+	g_free(path);=0A=
+=0A=
+	sms_assembly_free(assembly);=0A=
+=0A=
+	/*=0A=
+	 * sms_assembly_new() must expire the stale assembly immediately=0A=
+	 * after loading it from persistent storage.=0A=
+	 */=0A=
+	assembly =3D sms_assembly_new(imsi);=0A=
+	g_assert_cmpuint(g_slist_length(assembly->assembly_list), =3D=3D, 0);=
=0A=
+	sms_assembly_free(assembly);=0A=
+}=0A=
+=0A=
+static void test_assembly_stale_collision(void)=0A=
+{=0A=
+	unsigned char pdu[176];=0A=
+	long pdu_len;=0A=
+	struct sms sms;=0A=
+	struct sms_assembly *assembly =3D sms_assembly_new(NULL);=0A=
+	struct sms_assembly_node *node;=0A=
+	guint16 ref;=0A=
+	guint8 max;=0A=
+	guint8 seq;=0A=
+	GSList *l;=0A=
+	time_t now =3D time(NULL);=0A=
+	guint8 old_max;=0A=
+=0A=
+	decode_hex_own_buf(assembly_pdu1, -1, &pdu_len, 0, pdu);=0A=
+	sms_decode(pdu, pdu_len, FALSE, assembly_pdu_len1, &sms);=0A=
+	sms_extract_concatenation(&sms, &ref, &max, &seq);=0A=
+=0A=
+	old_max =3D max + 1;=0A=
+=0A=
+	l =3D sms_assembly_add_fragment(assembly, &sms,=0A=
+					now - SMS_ASSEMBLY_EXPIRY_SECONDS - 60,=0A=
+					&sms.deliver.oaddr,=0A=
+					ref, old_max, seq);=0A=
+	g_assert(l =3D=3D NULL);=0A=
+=0A=
+	node =3D assembly->assembly_list->data;=0A=
+	g_assert_cmpuint(node->max_fragments, =3D=3D, old_max);=0A=
+=0A=
+	/*=0A=
+	 * Reuse the same sender and reference with a different fragment=0A=
+	 * count. Since the existing assembly is stale, it must be discarded=
=0A=
+	 * and this fragment must start a new assembly.=0A=
+	 */=0A=
+	l =3D sms_assembly_add_fragment(assembly, &sms, now,=0A=
+					&sms.deliver.oaddr, ref, max, seq);=0A=
+	g_assert(l =3D=3D NULL);=0A=
+	g_assert_cmpuint(g_slist_length(assembly->assembly_list), =3D=3D, 1);=
=0A=
+=0A=
+	node =3D assembly->assembly_list->data;=0A=
+	g_assert_cmpuint(node->ref, =3D=3D, ref);=0A=
+	g_assert_cmpuint(node->max_fragments, =3D=3D, max);=0A=
+	g_assert_cmpuint(node->num_fragments, =3D=3D, 1);=0A=
+=0A=
+	sms_assembly_free(assembly);=0A=
+}=0A=
+=0A=
+static void test_assembly_fresh_collision(void)=0A=
+{=0A=
+	unsigned char pdu[176];=0A=
+	long pdu_len;=0A=
+	struct sms sms;=0A=
+	struct sms_assembly *assembly =3D sms_assembly_new(NULL);=0A=
+	struct sms_assembly_node *node;=0A=
+	guint16 ref;=0A=
+	guint8 max;=0A=
+	guint8 seq;=0A=
+	GSList *l;=0A=
+	time_t now =3D time(NULL);=0A=
+	guint8 old_max;=0A=
+=0A=
+	decode_hex_own_buf(assembly_pdu1, -1, &pdu_len, 0, pdu);=0A=
+	sms_decode(pdu, pdu_len, FALSE, assembly_pdu_len1, &sms);=0A=
+	sms_extract_concatenation(&sms, &ref, &max, &seq);=0A=
+=0A=
+	old_max =3D max + 1;=0A=
+=0A=
+	l =3D sms_assembly_add_fragment(assembly, &sms, now - 60 * 60,=0A=
+					&sms.deliver.oaddr,=0A=
+					ref, old_max, seq);=0A=
+	g_assert(l =3D=3D NULL);=0A=
+=0A=
+	/*=0A=
+	 * A recent assembly must win the collision. The new fragment is=0A=
+	 * ignored and the existing assembly remains unchanged.=0A=
+	 */=0A=
+	l =3D sms_assembly_add_fragment(assembly, &sms, now,=0A=
+					&sms.deliver.oaddr, ref, max, seq);=0A=
+	g_assert(l =3D=3D NULL);=0A=
+	g_assert_cmpuint(g_slist_length(assembly->assembly_list), =3D=3D, 1);=
=0A=
+=0A=
+	node =3D assembly->assembly_list->data;=0A=
+	g_assert_cmpuint(node->ref, =3D=3D, ref);=0A=
+	g_assert_cmpuint(node->max_fragments, =3D=3D, old_max);=0A=
+	g_assert_cmpuint(node->num_fragments, =3D=3D, 1);=0A=
+=0A=
+	sms_assembly_free(assembly);=0A=
+}=0A=
+=0A=
 int main(int argc, char **argv)=0A=
 {=0A=
 	g_test_init(&argc, &argv, NULL);=0A=
 =0A=
 	g_test_add_func("/testsms/Test SMS Assembly Serialize",=0A=
 			test_serialize_assembly);=0A=
+	g_test_add_func("/testsms/Test SMS Assembly Expire On Load",=0A=
+			test_assembly_expire_on_load);=0A=
+	g_test_add_func("/testsms/Test SMS Assembly Stale Collision",=0A=
+			test_assembly_stale_collision);=0A=
+	g_test_add_func("/testsms/Test SMS Assembly Fresh Collision",=0A=
+			test_assembly_fresh_collision);=0A=
 =0A=
 	return g_test_run();=0A=
 }=0A=
-- =0A=
2.55.0=0A=
=0A=

--=_2a1bd3cb108c525e30200845=de43bf65-d5ec-59c9-b9c9-f3382bf2ea75_=--

