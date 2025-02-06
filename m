Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2029F9F8
	for <ofono@lists.linux.dev>; Thu,  6 Feb 2025 00:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738802479; cv=none; b=qsi0nn4fbX2hQCiZ2jeLAby/CrZgZ7bBPOQbTvVBHm3C5FsxYaqCBILBO2cuy0iOpWsJLPViE2qa59qKxgNWmfNAPaZqqrfabIsXSxN8Zg+5IuVOnreJlTmgWDH11FwaY5zve6fbxf9xZ6NhaoqJp1Uo1REMOXz/A7Q07k9r1rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738802479; c=relaxed/simple;
	bh=1kwlqT9UPSJWM8JIiiEpRoisZrhKgOe91mfLBcjgoqI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRMQ54ZnL1jf6V/7oJ+NRwJrmwlECKfXXRnlZmcYAd3FFVtqsuRBVXe1uYNya0ijohMFn5geOgIU+bVz4NFGyyGA9GnwUJa0SHBE6WEBxY+Kf9sSz6Ep9uul+vd6CDHby4dPO2660F4QQMU7cutQSgd7f1ILjOP3Rw27eWYdxyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=MgE4gCNM; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="MgE4gCNM"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id E3A0F164A7D
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 19:34:49 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 9A62712636E
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 19:34:49 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 3/5] provisiondb: Correct the precondition return conditions of 'tags_match'.
Date: Wed,  5 Feb 2025 16:34:44 -0800
Message-ID: <dda4411f6c7fee423770b046b696a7596e0edeca.1738800116.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1738800116.git.gerickson@nuovations.com>
References: <cover.1738800116.git.gerickson@nuovations.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=pair-202401062137; bh=L8ZesYZgPffNhwUrxdGUESlbH3Zk2RV1/UX9qyjSK5U=; b=MgE4gCNMA2YZ740K3r43HVaV/hR2hxljzi1MqKdg0iA6btcovmNwwUDeAm38Kg2k4xBvhYJHpTdYTjzq9FjDS63MszwY5nKeCGsvqK9iCCMog1IY7OvpJGDM4nqpqY2y9MQLDeu+ciT23vcZb8IU3yImGK6+6SaqW9lULkjuZttdjgujMi9NUJujdmxMjhq0mDQuiqovt7CKInU60o36VCrjOtV7K7nV+QPy1eqR2+30qgrfBd3S3odSDPH//iPbX6jeK0K8PoeJXA1FxSg/wgqa2GPOO/zcu7gTAl33zokh45HudLWALpLEZ8NU8Td/Du3nBq7K+3LSScKF7AUHHw==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

Prior to this change, specifying 'TagsFilter' in
${sysconfdir}/ofono/main.conf resulted in returning APNs which have no
tags plus APNs that match a tag in 'TagsFilter'. In addition to
seemingly violating the rule of least astonishment, this did not do
what was desired, which was to downselect more than one APN to one (or
more) matching a specific tag.

With this change, specifying 'TagsFilter' now follows the rule of
least astonishment and matches expectations, returning only those APNs
which match a tag in 'TagsFilter', period.

One specific tag:

    # ./lookup-apn -t "kore-m2m-public" 311 480
    Opening database in default location
    Searching for info for network: 311480, spn: <None>
    Name: 4G LTE Contract (Public)
    APN: vzwinternet
    Type: 1
    Proto: 2
    Tags: kore-m2m-public

As desired / expected.

Another specific tag:

    # ./lookup-apn -t "kore-m2m-private" 311 480
    Opening database in default location
    Searching for info for network: 311480, spn: <None>
    Name: 4G LTE Contract (Private)
    APN: wyleslte.gw7.vzwentp
    Type: 1
    Proto: 2
    Tags: kore-m2m-private

As desired / expected.

Two specific tags:

    # ./lookup-apn -t "kore-m2m-private,kore-m2m-public" 311 480
    Opening database in default location
    Searching for info for network: 311480, spn: <None>
    Name: 4G LTE Contract (Public)
    APN: vzwinternet
    Type: 1
    Proto: 2
    Tags: kore-m2m-public

    Name: 4G LTE Contract (Private)
    APN: wyleslte.gw7.vzwentp
    Type: 1
    Proto: 2
    Tags: kore-m2m-private

As desired / expected.

No tags:

    # ./lookup-apn 311 480
    Opening database in default location
    Searching for info for network: 311480, spn: <None>
    Name: 4G LTE Contract
    APN: vzwims
    Type: 28
    Proto: 2
    Tags: (null)

    Name: 4G LTE Contract (Public)
    APN: vzwinternet
    Type: 1
    Proto: 2
    Tags: kore-m2m-public

    Name: 4G LTE Contract (Private)
    APN: wyleslte.gw7.vzwentp
    Type: 1
    Proto: 2
    Tags: kore-m2m-private

    Name: 4G LTE Contract
    APN: vzwapp
    Type: 4
    Proto: 2
    Tags: (null)

As desired / expected.
---
 src/provisiondb.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/provisiondb.c b/src/provisiondb.c
index 4a7f1bb6ef6e..753d7725103a 100644
--- a/src/provisiondb.c
+++ b/src/provisiondb.c
@@ -224,9 +224,22 @@ static bool tags_match(char **tags_filter, const char *tags)
 	_auto_(l_strv_free) char **split_tags = 0;
 	unsigned int i;
 
-	if (!tags_filter || !tags)
+	/*
+	 * If tags_filter was not specified, then the caller does not want
+	 * to match on tags, so just return true.
+	 */
+	if (!tags_filter)
 		return true;
 
+	/*
+	 * If tags_filter was specified, then the caller does want to
+	 * match on tags. Consequently, if there are no tags to match
+	 * against, then we must return false since such an entry cannot
+	 * match.
+	 */
+	if (tags_filter && !tags)
+		return false;
+
 	split_tags = l_strsplit(tags, ',');
 
 	for (i = 0; tags_filter[i]; i++)
-- 
2.45.0

