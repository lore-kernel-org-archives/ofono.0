Received: from mxe.seznam.cz (mxe.seznam.cz [77.75.76.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6CE3D25D2
	for <ofono@lists.linux.dev>; Tue, 18 Aug 2026 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052679; cv=none; b=r5FU05aoqgzb6hGht02fFJ/V2y1fB/aLa2AaRwvZ72CI2b42iwcI7f8lGZpxUz69D+/7jXg2pm6PrguqKlpBwqtIHFU1vbglkF8REnxRuf8M7zlGQn+eRRdKWHVSGvToCNCQIqErpf61J79gB4J+q6HFJdASKIfBKMg1br4lk+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052679; c=relaxed/simple;
	bh=zGFXkpA/i5rzxFMDprRdllmhGElBJXGVwiGsi8vFGyI=;
	h=From:To:Subject:Date:Message-Id:Mime-Version:Content-Type; b=TXcMYBxXy/C3XJseQY6pwNIbezy5Itc4s2T+jYvBrunbD3sjMRp1yCXJ4lZZ6Dj0lABXMEhZ5dvipSKg2xlo2KB+JXRdlhkG5VxVPELGMZo37czIA3ivSnkWFUjbtd1jAr8hl2GGCfYfFCCVgWbFDUWIjy744220hCtyabM2X9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=JKnLrqZh; arc=none smtp.client-ip=77.75.76.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="JKnLrqZh"
Received: from email.seznam.cz
	by smtpc-mxe-9fb5dbb56-x48f2
	(smtpc-mxe-9fb5dbb56-x48f2 [2a02:598:128:8a00::1000:a81])
	id 102ed288cc0b256a1011fab8;
	Tue, 18 Aug 2026 13:31:13 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1787052673; bh=bgr62EUPlOo+39LTlKrMfWRFiM+wpkz2G20YIuXvsiI=;
	h=From:To:Subject:Date:Message-Id:Mime-Version:Content-Type;
	b=JKnLrqZh/ohbfEB7plVnsvsEOraFrwqXzzL2xN/kreOGhGs9CZXTDA7li2PKha+Kn
	 5cS1ZbgAk8r6T7wjjc+Bz48G2WLbyl9JnLrh+A7W6WTJF7XsCkgNjhiuz/4mT2yI+i
	 S1ZPqWkTYehzG3QUctW0VIucbl2UIdIEQgrIiYm18fljE3cdTW07ifNTvl9ZZ9xQhr
	 MJVMuuGK+QLxklOoiNKmifxxfZKKJaHptb2cuNsqK3m71IRCjLs7I3qgS+wfJQRK30
	 Br52ckGohlyD4huLMcDHizxuCIna8CdrxvaxP0HW2xKTpFlasIyr1svS+a+uzaduCn
	 eP9Iuo1raHqkg==
Received: from ais-gw.ais.cz (ais-gw.ais.cz [85.93.112.4])
	by email.seznam.cz (szn-ebox-5.1.10) with HTTP;
	Tue, 18 Aug 2026 13:27:52 +0200 (CEST)
From: <bugear@seznam.cz>
To: <ofono@lists.linux.dev>
Subject: [PATCH] smsutil: Fix cleanup of max-numbered SMS assembly fragment
Date: Tue, 18 Aug 2026 13:27:52 +0200 (CEST)
Message-Id: <2PT.FwmD.3hgWtmY}hVZ.1gX46u@seznam.cz>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (szn-mime-2.2.10)
X-Mailer: szn-ebox-5.1.10
Content-Type: multipart/mixed;
	boundary="=_4a2cb36b58ae639c5b0df815=de43bf65-d5ec-59c9-b9c9-f3382bf2ea75_="


--=_4a2cb36b58ae639c5b0df815=de43bf65-d5ec-59c9-b9c9-f3382bf2ea75_=
Content-Type: multipart/alternative;
	boundary="=_12efb7ca7340d40716504977=de43bf65-d5ec-59c9-b9c9-f3382bf2ea75_="


--=_12efb7ca7340d40716504977=de43bf65-d5ec-59c9-b9c9-f3382bf2ea75_=
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi oFono devs,=C2=A0



the attached patch fixes an off-by-one error in sms_assembly_backup_free()=
. 
The bug leaves stale sms_assembly entries behind after successful reassemb=
ly
when the highest-numbered fragment is received before the fragment 
completing the message. A regression test reproducing the issue is include=
d.
=C2=A0Without the fix, the test fails, because a stale persisted assembly =
is 
reloaded after successful message reassembly.




Thanks,

Vit Hampl

--=_12efb7ca7340d40716504977=de43bf65-d5ec-59c9-b9c9-f3382bf2ea75_=
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body>Hi oFono devs,&nbsp;<div><br></div><div>the attached patch fix=
es an off-by-one error in sms_assembly_backup_free().=0A=
=0A=
The bug leaves stale sms_assembly entries behind after successful=0A=
reassembly when the highest-numbered fragment is received before the=0A=
fragment completing the message.=0A=
=0A=
A regression test reproducing the issue is included.&nbsp;Without the fix,=
 the test fails, because a stale persisted assembly=0A=
is reloaded after successful message reassembly.</div><div><br></div><div>=
Thanks,</div><div>Vit Hampl</div></body></html>
--=_12efb7ca7340d40716504977=de43bf65-d5ec-59c9-b9c9-f3382bf2ea75_=--


--=_4a2cb36b58ae639c5b0df815=de43bf65-d5ec-59c9-b9c9-f3382bf2ea75_=
Content-Type: application/octet-stream;
	name=0001-smsutil-Fix-cleanup-of-max-numbered-SMS-assembly-fra.patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	size=3805;
	filename=0001-smsutil-Fix-cleanup-of-max-numbered-SMS-assembly-fra.patch

From 5a6cc737288d70c3b912f23a8b99735668ebcb3b Mon Sep 17 00:00:00 2001=
=0A=
From: =3D?UTF-8?q?V=3DC3=3DADt=3D20Hampl?=3D <bugear@seznam.cz>=0A=
Date: Tue, 18 Aug 2026 12:53:42 +0200=0A=
Subject: [PATCH] smsutil: Fix cleanup of max-numbered SMS assembly fragmen=
t=0A=
=0A=
This bug was observed as stale entries remaining in sms_assembly,=0A=
eventually causing collisions when the same originating address=0A=
reused an 8-bit concatenation reference.=0A=
=0A=
Concatenated SMS fragment sequence numbers are 1-based and valid values=
=0A=
are in the range 1..max_fragments.=0A=
=0A=
sms_assembly_backup_free() currently iterates over the range=0A=
0..max_fragments-1 when removing persisted fragments. As a result, a=0A=
persisted fragment whose sequence number equals max_fragments is never=
=0A=
removed.=0A=
=0A=
This can happen when the highest-numbered fragment arrives before the=
=0A=
fragment that completes the assembly. The SMS is successfully=0A=
reassembled, but the persisted max-numbered fragment remains on disk,=
=0A=
preventing removal of the assembly directory.=0A=
=0A=
The stale fragment is loaded again after restart and may later interfere=
=0A=
with reassembly of unrelated concatenated messages if the originating=
=0A=
address and concatenation reference are reused.=0A=
=0A=
Add a regression test which delivers a three-part message in the order=
=0A=
1, 3, 2. Without this fix the test leaves a stale persistent assembly;=
=0A=
with the fix it passes.=0A=
=0A=
Signed-off-by: Vit Hampl <bugear@seznam.cz>=0A=
---=0A=
 src/smsutil.c        |  2 +-=0A=
 unit/test-sms-root.c | 24 ++++++++++++++++++++----=0A=
 2 files changed, 21 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/src/smsutil.c b/src/smsutil.c=0A=
index 84895c4f..9fd3bec0 100644=0A=
--- a/src/smsutil.c=0A=
+++ b/src/smsutil.c=0A=
@@ -2529,7 +2529,7 @@ static void sms_assembly_backup_free(struct sms_asse=
mbly *assembly,=0A=
 	if (sms_address_to_hex_string(&node->addr, straddr) =3D=3D FALSE)=0A=
 		return;=0A=
 =0A=
-	for (seq =3D 0; seq < node->max_fragments; seq++) {=0A=
+	for (seq =3D 1; seq <=3D node->max_fragments; seq++) {=0A=
 		int offset =3D seq / 32;=0A=
 		int bit =3D 1 << (seq % 32);=0A=
 =0A=
diff --git a/unit/test-sms-root.c b/unit/test-sms-root.c=0A=
index 12ce0670..3566b6aa 100644=0A=
--- a/unit/test-sms-root.c=0A=
+++ b/unit/test-sms-root.c=0A=
@@ -78,10 +78,16 @@ static void test_serialize_assembly(void)=0A=
 	g_assert(g_slist_length(assembly->assembly_list) =3D=3D 1);=0A=
 	g_assert(l =3D=3D NULL);=0A=
 =0A=
-	decode_hex_own_buf(assembly_pdu2, -1, &pdu_len, 0, pdu);=0A=
-	sms_decode(pdu, pdu_len, FALSE, assembly_pdu_len2, &sms);=0A=
+	/*=0A=
+	 * Store the max-numbered fragment while the assembly is still=0A=
+	 * incomplete.  This fragment must be removed from persistent=0A=
+	 * storage when another fragment later completes the message.=0A=
+	 */=0A=
+	decode_hex_own_buf(assembly_pdu3, -1, &pdu_len, 0, pdu);=0A=
+	sms_decode(pdu, pdu_len, FALSE, assembly_pdu_len3, &sms);=0A=
 =0A=
 	sms_extract_concatenation(&sms, &ref, &max, &seq);=0A=
+	g_assert(seq =3D=3D max);=0A=
 	l =3D sms_assembly_add_fragment(assembly, &sms, time(NULL),=0A=
 					&sms.deliver.oaddr, ref, max, seq);=0A=
 	g_assert(l =3D=3D NULL);=0A=
@@ -90,8 +96,11 @@ static void test_serialize_assembly(void)=0A=
 =0A=
 	assembly =3D sms_assembly_new("1234");=0A=
 =0A=
-	decode_hex_own_buf(assembly_pdu3, -1, &pdu_len, 0, pdu);=0A=
-	sms_decode(pdu, pdu_len, FALSE, assembly_pdu_len3, &sms);=0A=
+	/*=0A=
+	 * Complete the message with a lower-numbered fragment.=0A=
+	 */=0A=
+	decode_hex_own_buf(assembly_pdu2, -1, &pdu_len, 0, pdu);=0A=
+	sms_decode(pdu, pdu_len, FALSE, assembly_pdu_len2, &sms);=0A=
 =0A=
 	sms_extract_concatenation(&sms, &ref, &max, &seq);=0A=
 	l =3D sms_assembly_add_fragment(assembly, &sms, time(NULL),=0A=
@@ -100,6 +109,13 @@ static void test_serialize_assembly(void)=0A=
 	g_assert(l !=3D NULL);=0A=
 =0A=
 	sms_assembly_free(assembly);=0A=
+=0A=
+	/*=0A=
+	 * Successful cleanup must leave no persistent assembly to reload.=0A=
+	 */=0A=
+	assembly =3D sms_assembly_new("1234");=0A=
+	g_assert(g_slist_length(assembly->assembly_list) =3D=3D 0);=0A=
+	sms_assembly_free(assembly);=0A=
 }=0A=
 =0A=
 int main(int argc, char **argv)=0A=
-- =0A=
2.55.0=0A=
=0A=

--=_4a2cb36b58ae639c5b0df815=de43bf65-d5ec-59c9-b9c9-f3382bf2ea75_=--

