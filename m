Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF65417C7C9
	for <ofono@lists.linux.dev>; Tue,  8 Oct 2024 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378671; cv=none; b=FhZYN2+XHOpBGKau6BT/crtfJrmgZjCLPzV331qlZ/qFDI3pCODBT8ykUCV6s+NbaQzlUGZ6iwyFhkyH6UU2fp6wrqj1tCTwm/7JlErVLIjEICAG/MXOkJMPChwXHmuM7rwlbaxojR7KgSGrolu/iOeI7MMVqqWf5s6ebFJlymI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378671; c=relaxed/simple;
	bh=vpQkhRWA9WuIeAMQtls888VaVio7+JfBVLiblbMqXkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LNEs0qTwi3VKURyzH9tqa3zOegix1hwLyVZzcVYhEeRCBQDbsEGxGs57nvwQiV2oyvnHyC58UQ0Tc3cW3TlLiLnAIftGVwwFGWzbuq+0TmZmCU3DJmLzCO8NYyW3RYKOVXmNjXm7drl89BVXbZJ/NDrACjfO6sJfXHsiW+i0ijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=pvkl5DU/; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="pvkl5DU/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=0TQkFw80gWto+dmIEcTvWTU0d40uHWqxA5PyQfTWsY4=; b=pvkl5DU/o5S8uP6enJVasDTyVu
	1qZ40VAkStLA65rPnQgupkLDGeebb2bvVbDZ0KevbCfXixpfx6BRu5jbyExqvQfVjIzAwCOQuthCc
	uOMCJBVY6p4KZmR9XpwdrkmqOeZrDgh06rjErWYfxtOMJU6H9iZVvSZ8hELfYu6BlfD8Dp7c0hFA+
	xfDCF+R1kfUaIrstNYbJ4Ut4imGfx7w7ABOxe9opzd7epi6uUrd9dz/cv+36yD3YV4y3bkZWLfe71
	Yj85GaK9jMuxAaEaJUo3jmSpGQM161EGjhd6OiIZJvX7diMkCuJ26iMob9CnL2eso6Kn8FSwm7RaL
	5DmTUN5w==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1sy6FG-000MYG-QQ; Tue, 08 Oct 2024 11:11:06 +0200
Received: from [185.17.218.86] (helo=zen..)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1sy6FG-00025v-1e;
	Tue, 08 Oct 2024 11:11:06 +0200
From: Sean Nyekjaer <sean@geanix.com>
To: ofono@lists.linux.dev
Cc: Sean Nyekjaer <sean@geanix.com>,
	denkenz@gmail.com
Subject: [PATCH 1/2] network: allow status' and notifications on eutran networks
Date: Tue,  8 Oct 2024 11:11:01 +0200
Message-ID: <20241008091104.1567517-1-sean@geanix.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27420/Mon Oct  7 10:43:46 2024)

SIMCom A7672E-FASE shows attached on LTE with +CREG <stat> either
6 registered for "SMS only", home network (applicable only when E-UTRAN)
7 registered for "SMS only", roaming (applicable only when <AcT> indicates E-UTRAN)
+COPS supplies the <AcT> = EUTRAN
---
 src/network.c | 58 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/src/network.c b/src/network.c
index 40626179..02853e23 100644
--- a/src/network.c
+++ b/src/network.c
@@ -376,7 +376,8 @@ static char *get_operator_display_name(struct ofono_netreg *netreg)
 		return name;
 	}
 
-	if (netreg->status == NETWORK_REGISTRATION_STATUS_REGISTERED)
+	if (netreg->status == NETWORK_REGISTRATION_STATUS_REGISTERED ||
+		netreg->status == NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN)
 		home_or_spdi = TRUE;
 	else
 		home_or_spdi = sim_spdi_lookup(netreg->spdi,
@@ -1205,9 +1206,15 @@ static void current_operator_callback(const struct ofono_error *error,
 	 * in which case the operator information frequently comes in bogus.
 	 * We ignore it here
 	 */
-	if (netreg->status != NETWORK_REGISTRATION_STATUS_REGISTERED &&
-			netreg->status != NETWORK_REGISTRATION_STATUS_ROAMING)
-		current = NULL;
+	switch (netreg->status) {
+		case NETWORK_REGISTRATION_STATUS_REGISTERED:
+		case NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN:
+		case NETWORK_REGISTRATION_STATUS_ROAMING:
+		case NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN:
+			break;
+		default:
+			current = NULL;
+	}
 
 	if (error->type != OFONO_ERROR_TYPE_NO_ERROR) {
 		DBG("Error during current operator");
@@ -1324,6 +1331,8 @@ static void notify_emulator_status(struct ofono_atom *atom, void *data)
 void ofono_netreg_status_notify(struct ofono_netreg *netreg, int status,
 			int lac, int ci, int tech)
 {
+	ofono_bool_t netreg_status;
+
 	if (netreg == NULL)
 		return;
 
@@ -1351,8 +1360,18 @@ void ofono_netreg_status_notify(struct ofono_netreg *netreg, int status,
 	if (netreg->technology != tech)
 		set_registration_technology(netreg, tech);
 
-	if (netreg->status == NETWORK_REGISTRATION_STATUS_REGISTERED ||
-		netreg->status == NETWORK_REGISTRATION_STATUS_ROAMING) {
+	switch (netreg->status) {
+		case NETWORK_REGISTRATION_STATUS_REGISTERED:
+		case NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN:
+		case NETWORK_REGISTRATION_STATUS_ROAMING:
+		case NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN:
+			netreg_status = true;
+			break;
+		default:
+			netreg_status = false;
+	}
+
+	if (netreg_status) {
 		if (netreg->driver->current_operator != NULL)
 			netreg->driver->current_operator(netreg,
 					current_operator_callback, netreg);
@@ -1448,6 +1467,7 @@ static void init_registration_status(const struct ofono_error *error,
 					void *data)
 {
 	struct ofono_netreg *netreg = data;
+	ofono_bool_t netreg_status;
 
 	if (error->type != OFONO_ERROR_TYPE_NO_ERROR) {
 		DBG("Error during registration status query");
@@ -1460,8 +1480,18 @@ static void init_registration_status(const struct ofono_error *error,
 	 * Bootstrap our signal strength value without waiting for the
 	 * stack to report it
 	 */
-	if (netreg->status == NETWORK_REGISTRATION_STATUS_REGISTERED ||
-		netreg->status == NETWORK_REGISTRATION_STATUS_ROAMING) {
+	switch (netreg->status) {
+		case NETWORK_REGISTRATION_STATUS_REGISTERED:
+		case NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN:
+		case NETWORK_REGISTRATION_STATUS_ROAMING:
+		case NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN:
+			netreg_status = true;
+			break;
+		default:
+			netreg_status = false;
+	}
+
+	if (netreg_status) {
 		if (netreg->driver->strength != NULL)
 			netreg->driver->strength(netreg,
 					signal_strength_callback, netreg);
@@ -1516,9 +1546,15 @@ void ofono_netreg_strength_notify(struct ofono_netreg *netreg, int strength)
 	 * Theoretically we can get signal strength even when not registered
 	 * to any network.  However, what do we do with it in that case?
 	 */
-	if (netreg->status != NETWORK_REGISTRATION_STATUS_REGISTERED &&
-			netreg->status != NETWORK_REGISTRATION_STATUS_ROAMING)
-		return;
+	switch (netreg->status) {
+		case NETWORK_REGISTRATION_STATUS_REGISTERED:
+		case NETWORK_REGISTRATION_STATUS_REGISTERED_SMS_EUTRAN:
+		case NETWORK_REGISTRATION_STATUS_ROAMING:
+		case NETWORK_REGISTRATION_STATUS_ROAMING_SMS_EUTRAN:
+			break;
+		default:
+			return;
+	}
 
 	DBG("strength %d", strength);
 
-- 
2.46.2

