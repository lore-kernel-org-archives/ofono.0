Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C251C07D5
	for <ofono@lists.linux.dev>; Tue, 19 Nov 2024 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036724; cv=none; b=gIXGMayqzRz8iwJb/sJv+PSDhZ0Vgd/uK2nPm7iMdlHLF6/D0Ax/OdbMBXgrlbPsVBtbwy+WZRBB57b4X2/imePGV+u6zvlGNdLdPVFKPCHgqVde9CjFamwBlfpxJ4OZz9ji6N4oVwHrvGLdyoYkWWmUinzYrQ2fRN1EajMaqAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036724; c=relaxed/simple;
	bh=7UupV5U7V0Ks6seIWmf4hYiVCj2Sm3KN9bmB2RzOlSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQ0FMWJJhZD/x1HBzjtJ+t08ug9558HJEXqF1Sp2x+owKKBKgjN8JZMBvUnpgex8yIG+loJMfddKmBn8TQBNLl+gq2olucd42KlL5+EpPiIY8h67TryG1suSgYIn6t1Dm8iBocJ2dYlSQXnUo1meU/kzlY/4HhFiDsv4CpmU1IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaJ9Ej1a; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaJ9Ej1a"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5edfe8c17c4so1495826eaf.2
        for <ofono@lists.linux.dev>; Tue, 19 Nov 2024 09:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732036722; x=1732641522; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvRSzLEw1nW6La6Iyj8LiVTVOvcPlwY7JWuWmeJ0nVs=;
        b=FaJ9Ej1aD4+0eVPkr66eAThXP5k9XkQToJXebWyR47L56fXT4tHjVAsRFaSPN/7rST
         wcGlGHXBr833CKeJeYur/MJXfZAxu+2hv3CpNxFJ+er9GcIekM9pWPp4m4KabZ3Yjzru
         55hCrmR8hTT2G/U8WmoWB65P3BGXZdURO0sBzZYM4QleZiA1WdzVUiYuZC1YP5Pzxe3V
         Mz0QnIjIYfG1Wz/UeZVkGtshtG3wzAPCl9nEP6tncO5Oe860pskn1KYZOqW0zezsdwRl
         mUkmSoweTjSH/G2X91y4w+g+0k4u6vjsZ8SKtLhLf5KN+JRpsk+TWMs8ET1N42ZRdL06
         RroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732036722; x=1732641522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvRSzLEw1nW6La6Iyj8LiVTVOvcPlwY7JWuWmeJ0nVs=;
        b=CleBLF/hPCkhZppwUTAKOIw95MchxK7cGdacalCIJxzxgGcAdyZZJg9Fr6VJuksvO0
         Zc3wCL06bd7GjvsKbPZafbcPLQkEK7s1FPhnz20/yHCrP/MwhwqfdZym3FKUJCKHh8IA
         wVNSrV9gkm1XH+pYRl6h1NVR7kK7snPWTAKYwynkjXu9euDTTCl0+BjjFASFEiQHqMTw
         3uRUD6aejwCigK6YXkky9bM9ASM5vzIpIR+IepqL6F5CjU826A73+9y3HMNkI3D4sb5S
         5PoqNpOfWrJ+iriYHVEtbSoFnf3XcMYd05GUf0FUpJmHWqlWiFNjeXYbn5sAGDiSl04w
         JsnQ==
X-Gm-Message-State: AOJu0YxyL3k6kWmlGdOK3ZimAMjuixsbwa+FXUIunBGN+pIv0lKiCiea
	kUxkEj5VwCzzUdvPMbaEchIdTXrrnykHXnONgQc8iXiJTcMg0mi6G4ObbQ==
X-Google-Smtp-Source: AGHT+IFFT6RnCGbpVFwzg8L3poXCenhVCnIXQk8iZbI2FVMftDJorIm5FITwekzwWJl6jDFi62h5PA==
X-Received: by 2002:a05:6820:4ccc:b0:5eb:85ee:2cbd with SMTP id 006d021491bc7-5eeab446133mr13105320eaf.6.1732036721926;
        Tue, 19 Nov 2024 09:18:41 -0800 (PST)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eeabd7feaesm3664016eaf.39.2024.11.19.09.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:18:41 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 8/8] rmnet: Implement cancel
Date: Tue, 19 Nov 2024 11:18:19 -0600
Message-ID: <20241119171832.1119-8-denkenz@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241119171832.1119-1-denkenz@gmail.com>
References: <20241119171832.1119-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement cancellation of an ongoing rmnet request.  Any links that
have already been created are deleted by putting another request to
the head of the queue.
---
 src/rmnet.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/src/rmnet.c b/src/rmnet.c
index b51ebfd18f65..83110c33a980 100644
--- a/src/rmnet.c
+++ b/src/rmnet.c
@@ -32,6 +32,7 @@ struct rmnet_request {
 	void *user_data;
 	rmnet_destroy_func_t destroy;
 	int id;
+	bool canceled;
 	uint32_t netlink_id;
 	uint16_t request_type;
 	uint8_t current;
@@ -54,6 +55,14 @@ static void rmnet_request_free(struct rmnet_request *req)
 	l_free(req);
 }
 
+static bool rmnet_request_id_matches(const void *a, const void *b)
+{
+	const struct rmnet_request *req = a;
+	int id = L_PTR_TO_INT(b);
+
+	return req->id == id;
+}
+
 static struct rmnet_request *__rmnet_del_request_new(unsigned int n_interfaces,
 					const struct rmnet_ifinfo *interfaces)
 {
@@ -199,7 +208,7 @@ static void rmnet_new_link_cb(int error, uint16_t type, const void *data,
 	if (!error)
 		req->current += 1;
 
-	if (error) {
+	if (error || req->canceled) {
 		__rmnet_cancel_request();
 		req->n_interfaces = 0;
 	} else {
@@ -273,6 +282,7 @@ int rmnet_get_interfaces(uint32_t parent_ifindex, unsigned int n_interfaces,
 	req->user_data = user_data;
 	req->destroy = destroy;
 	req->id = next_request_id++;
+	req->canceled = false;
 	req->request_type = RTM_NEWLINK;
 	req->netlink_id = 0;
 	req->current = 0;
@@ -309,7 +319,53 @@ int rmnet_del_interfaces(unsigned int n_interfaces,
 
 int rmnet_cancel(int id)
 {
-	return -ENOTSUP;
+	struct rmnet_request *req;
+
+	req = l_queue_peek_head(request_q);
+	if (!req)
+		return -ENOENT;
+
+	/* Simple Case: Request not yet started (not queue head) */
+	if (req->id != id) {
+		req = l_queue_remove_if(request_q, rmnet_request_id_matches,
+						L_INT_TO_PTR(id));
+		if (!req)
+			return -ENOENT;
+
+		DBG("Removing non-head of queue request %d", id);
+		rmnet_request_free(req);
+		return 0;
+	}
+
+	/* Harder Case: In progress, but the next request not in flight */
+	if (!l_netlink_request_sent(rtnl, req->netlink_id)) {
+		DBG("Removing in-progress request (not in flight) %d", id);
+		req = __rmnet_cancel_request();
+		l_netlink_cancel(rtnl, req->netlink_id);
+		rmnet_request_free(req);
+
+		if (l_queue_length(request_q))
+			rmnet_start_next_request();
+
+		return 0;
+	}
+
+	/*
+	 * Hardest Case: In progress, next request in flight
+	 * We have to wait until the next callback since the ifindex won't be
+	 * known until then.
+	 */
+	if (req->destroy)
+		req->destroy(req->user_data);
+
+	req->new_cb = NULL;
+	req->destroy = NULL;
+	req->user_data = NULL;
+
+	DBG("Setting canceled on in-progress request %d", id);
+	req->canceled = true;
+
+	return 0;
 }
 
 static int rmnet_parse_info_data(struct l_netlink_attr *linkinfo,
-- 
2.47.0

