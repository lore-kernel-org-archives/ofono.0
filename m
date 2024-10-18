Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD0B20263D
	for <ofono@lists.linux.dev>; Fri, 18 Oct 2024 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248728; cv=none; b=cFlwby/PDtHdH9H/9SapJ/hcO+/AZjNRWB6hi4S0sR4I6s/IxSkTudOaZPRRSIM71BzAF76PbDByw+xe9Kkw4iT2JtVAPUmHIM/sKPQz0/jKTDIqA/FYJeXBaP0xSrsq9lp47r3narHNyFVyRexzhic+8aHWk/zWT5Ss7DWWZIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248728; c=relaxed/simple;
	bh=Qbx6XArF+PzSqF2fGzHV0OTq1qJrPy6YmUhMSKL1kqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHh79zz79qwKO5wLJZi0G+/YHKG3HXgafcEGznE++v0jHveoRZUeWi//A69j+7jGMD5cFAlFvLOHQmzSRD1N+bY3cwENHMhlUBsFG7NtNEJN1QmTMvmcqMSQLTqcXqRNeXmNCGIuIGz9ikc4ppDe4PEbRPhe8GDPCyTiZNG1XeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=uNF93vwL; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="uNF93vwL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=S7IplemJ1YHQhJeAUw/aYe0nM/xnIG4suHBBN27Dy6s=; b=uNF93vwLGjqsX+WyW+z3i0p+Qx
	YSIAzEWdYQIabY/zIVXdpmea3OrqF14zq0Wk1PodYodkZpQvkIYtYw6/jvAcuGld6UJgZ0+CbwB1J
	/DXNKX16P6wHvDm3NiDhbrcpaxdFgdZxdy4vxGKzLyTglpWq08aN8TMIyaTzjAHV5IjZWf4i3PHeJ
	s1RkcrWRo1nv5JMwewW3+87JpLO7uTpqojLAAy5bH9sa2433q6j2BU+PPjOVhY9XXRATUXU4axBtg
	PxhZUuOXuU0St+i3PsxfIbwU0RdYpmdW7Ff77T2yHSd6bFh+s9ThJMQdXz4Mxr/K19FzNlVAFr7En
	O6Z715ow==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1t1kaQ-0005yq-H9; Fri, 18 Oct 2024 12:52:02 +0200
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1t1kaQ-000E0u-1O;
	Fri, 18 Oct 2024 12:52:02 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>,
	denkenz@gmail.com
Subject: [PATCH v2 1/2] network: allow status' and notifications on eutran networks
Date: Fri, 18 Oct 2024 12:51:44 +0200
Message-ID: <20241018105147.1382861-1-sean@geanix.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27431/Fri Oct 18 10:53:06 2024)

SIMCom A7672E-FASE shows attached on LTE with +CREG <stat> either
6 registered for "SMS only", home network (applicable only when E-UTRAN)
7 registered for "SMS only", roaming (applicable only when <AcT> indicates
E-UTRAN)
+COPS supplies the <AcT> = EUTRAN
---
Changes since v1:
 - removed switch cases in favor of L_IN_SET

 src/network.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/src/network.c b/src/network.c
index 40626179..48944219 100644
--- a/src/network.c
+++ b/src/network.c
@@ -376,7 +376,8 @@ static char *get_operator_display_name(struct ofono_netreg *netreg)
 		return name;
 	}
 
-	if (netreg->status == NETWORK_REGISTRATION_STATUS_REGISTERED)
+	if (L_IN_SET(netreg->status, NETWORK_REGISTRATION_STATUS_REGISTERED,
+				NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN))
 		home_or_spdi = TRUE;
 	else
 		home_or_spdi = sim_spdi_lookup(netreg->spdi,
@@ -1205,8 +1206,10 @@ static void current_operator_callback(const struct ofono_error *error,
 	 * in which case the operator information frequently comes in bogus.
 	 * We ignore it here
 	 */
-	if (netreg->status != NETWORK_REGISTRATION_STATUS_REGISTERED &&
-			netreg->status != NETWORK_REGISTRATION_STATUS_ROAMING)
+	if (!L_IN_SET(netreg->status, NETWORK_REGISTRATION_STATUS_REGISTERED,
+				NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN,
+				NETWORK_REGISTRATION_STATUS_ROAMING,
+				NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN))
 		current = NULL;
 
 	if (error->type != OFONO_ERROR_TYPE_NO_ERROR) {
@@ -1351,8 +1354,10 @@ void ofono_netreg_status_notify(struct ofono_netreg *netreg, int status,
 	if (netreg->technology != tech)
 		set_registration_technology(netreg, tech);
 
-	if (netreg->status == NETWORK_REGISTRATION_STATUS_REGISTERED ||
-		netreg->status == NETWORK_REGISTRATION_STATUS_ROAMING) {
+	if (L_IN_SET(netreg->status, NETWORK_REGISTRATION_STATUS_REGISTERED,
+				NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN,
+				NETWORK_REGISTRATION_STATUS_ROAMING,
+				NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN)) {
 		if (netreg->driver->current_operator != NULL)
 			netreg->driver->current_operator(netreg,
 					current_operator_callback, netreg);
@@ -1460,8 +1465,10 @@ static void init_registration_status(const struct ofono_error *error,
 	 * Bootstrap our signal strength value without waiting for the
 	 * stack to report it
 	 */
-	if (netreg->status == NETWORK_REGISTRATION_STATUS_REGISTERED ||
-		netreg->status == NETWORK_REGISTRATION_STATUS_ROAMING) {
+	if (L_IN_SET(netreg->status, NETWORK_REGISTRATION_STATUS_REGISTERED,
+				NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN,
+				NETWORK_REGISTRATION_STATUS_ROAMING,
+				NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN)) {
 		if (netreg->driver->strength != NULL)
 			netreg->driver->strength(netreg,
 					signal_strength_callback, netreg);
@@ -1516,8 +1523,10 @@ void ofono_netreg_strength_notify(struct ofono_netreg *netreg, int strength)
 	 * Theoretically we can get signal strength even when not registered
 	 * to any network.  However, what do we do with it in that case?
 	 */
-	if (netreg->status != NETWORK_REGISTRATION_STATUS_REGISTERED &&
-			netreg->status != NETWORK_REGISTRATION_STATUS_ROAMING)
+	if (!L_IN_SET(netreg->status, NETWORK_REGISTRATION_STATUS_REGISTERED,
+				NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN,
+				NETWORK_REGISTRATION_STATUS_ROAMING,
+				NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN))
 		return;
 
 	DBG("strength %d", strength);
-- 
2.46.2

