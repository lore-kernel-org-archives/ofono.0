Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB6114A85
	for <ofono@lists.linux.dev>; Mon, 26 Feb 2024 03:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918655; cv=none; b=UY7D9yhGeceKg2vUYOdkZj1Uv585CX7Y5h5xU0OiaqyPcLhTYBCdITFvwEls3LvALoV+SrguYDKBqqGvizzGDNmi1GVVQVUT/8C+qVGBu9SsQCvF0zi6+KN6TR3bd53KOjid8A6Km4uF1K8J9ZUrcOXirQD5OHy5J1wCXa70MDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918655; c=relaxed/simple;
	bh=b6I3KDbH8KUhiDXk8Zjd5aU2KGfXJx/QMhGU+iulAp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A980WWwJo886SvUgZTHNbKLWBBLTN402AdJpX4cZBQB/dIwvYDJnD5EEBmmqLjKSLaB5SMAMgvR54iKOBInBAqfNWjHFAkxbHNKHLmMEqR2x2VxfBHmKp0vUSiKFKVdk4UecdF1V4P8cwoQPtBuROpA3pmzTFSG6WZ5hMG2SQOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RO2CSOjl; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RO2CSOjl"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c199237eaeso1137029b6e.0
        for <ofono@lists.linux.dev>; Sun, 25 Feb 2024 19:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918653; x=1709523453; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ql1M7Cokb3tPCFBKBrORoPfwT8JVY5e83/vyr3UuU1Q=;
        b=RO2CSOjlVS5z6pX/eSAKhsJuifT32G+lW6ZzfGZAhb9g98pnHreFIzcmY6v7lb+Uzk
         v9OMdsJYaMNGJSR18fexiPhHUM7hIVuFrdXwXjbMLrpD1NMiEnWcQe0pQQurkq3CWOwg
         J0dG8bM4kQhd1eKWWK0VZ8wn5Fk6MbG6ui/QMVgcW1LqP3REufwYrbsj0dUB316dheID
         ou8zvew4JUtVqn+rY5zpUeeCu7gw/KqjDt2FRQv39VAuJz0YuwHsBquh930ofMKr1qMZ
         LeiTV//i6ZhnYV5+iKfUqDICqDE38r3Px8PrFKFiCDh+tVcWFqXFO7W2pXvk783DOje2
         Ipsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918653; x=1709523453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ql1M7Cokb3tPCFBKBrORoPfwT8JVY5e83/vyr3UuU1Q=;
        b=p7zB9TNMv74llOlScxjGqBbWJo1QGe37aJrWk5okkbo8BrYUgP+3xPLj+87dhXHCjb
         eUhOUVIkIJS84i+j4UU92BzzubDsw+ZlmXgcCsX7LKUSFfD5BpLxkUJpO0nG0ztwCZUZ
         VjhbACn6K7Jcd3uRkoCxrGgz+2r9Q7K02Xc8HBU2nX77UTMNMYeopG8FPhfXGxBsZjz9
         MF/zUO8UCRjgGi7K4a5Sa+ekr/iZ+U7gsf7NFRCSmv5PSrUow7Az99MkDlhqslcu7QVh
         eSVZs20ItFYEAXD3Dg9evdcSKsjPDWrs9zS9Kg6RJbky6Pgfvdfy4kyFAR+dVdgc3D1w
         DAoA==
X-Gm-Message-State: AOJu0YxdRQQAZgcuvGzpXd84To9HZ5+00hjhoD5TdNOysfLOKRoT+iD1
	wP0V/2fUTWytKSrgCXzFtuBRlE1g+B+GQ7HU6hxOfBAgec3YlSAPFT1Qd+aM
X-Google-Smtp-Source: AGHT+IEu0VGR3uH1d+Mos3h/paibaT4I1ehUGAtfvYE8YkiqoHyNoDBGu4KOJ3VPjRxJrmpYdXP/BA==
X-Received: by 2002:a05:6808:23d1:b0:3c0:4653:6e9e with SMTP id bq17-20020a05680823d100b003c046536e9emr7906961oib.6.1708918653353;
        Sun, 25 Feb 2024 19:37:33 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id fu27-20020a0568082a7b00b003c18c8be348sm951160oib.29.2024.02.25.19.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:37:33 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 11/22] plugins: Replace g_strndup use with l_strndup
Date: Sun, 25 Feb 2024 21:36:54 -0600
Message-ID: <20240226033724.1460079-11-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226033724.1460079-1-denkenz@gmail.com>
References: <20240226033724.1460079-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 plugins/allowed-apns.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/allowed-apns.c b/plugins/allowed-apns.c
index 199202b5c82b..63d1749043b4 100644
--- a/plugins/allowed-apns.c
+++ b/plugins/allowed-apns.c
@@ -116,7 +116,7 @@ static void sim_acl_read_cb(int ok, int total_length, int record,
 		if (simple_tlv_iter_get_tag(&tlv_iter) != 0xDD)
 			continue;
 
-		apn = g_strndup(
+		apn = l_strndup(
 			(char *) simple_tlv_iter_get_data(&tlv_iter),
 			simple_tlv_iter_get_length(&tlv_iter));
 
@@ -124,7 +124,7 @@ static void sim_acl_read_cb(int ok, int total_length, int record,
 					DBUS_TYPE_STRING,
 					&apn);
 
-		g_free(apn);
+		l_free(apn);
 	}
 
 done:
-- 
2.43.0

