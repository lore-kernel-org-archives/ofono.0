Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCF0524C4
	for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122166; cv=none; b=Kt147Spv8QR0WKtJN0tg4Euqvay7kircSnEhyVuFwfaPcOsDwDxeIBXCdBzvk9XoTnMurpO5Id5BIRsFfd46nFRASj2uAiRkD6E3OW9QF69gnfbOfo1DXqD3lwdc+mv5CyscMZsai45fPhDiEEfh/vIVyeP3tUmdOOzkTge7yoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122166; c=relaxed/simple;
	bh=svGUzHoaR5yP/BFo4XrE1O4VWjuO5JyLktkaHhJ6wd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4o/6Ol25G4cQuNPtvEzBriKPnhKB4wqAWf+JQvWGxrtAlR7aytzK0eHe/P9ip2mCQqbaAfqIeofOVW7CBR/GGrskvTT1nq47EbzmUgn66ZcS1QF8HRrWhXumSYTEGT5Q955KULFuLO6XaY5/vU4m5eRvEIGPKJ/tL74bEDL44s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D21z+goN; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D21z+goN"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e69543fc1eso1315244a34.3
        for <ofono@lists.linux.dev>; Fri, 22 Mar 2024 08:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711122164; x=1711726964; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVsPuW/g7+EBBvGGprHEy4VCYnfPu3lslt5Y7BuTzaA=;
        b=D21z+goNwZ2IFXdho8uT1z3BTYXX8Xm3qzUEUyd/glXDFz+p7TXlD4qDzB27sCa9rY
         KMbp8K60x1sM4fxBYnD9W7woZONJqsEJcxvOuFRnxvffUIcWFwTWBiXTuyw++ZAfer6h
         dnVE67Sck1paEEtowxso07EVsrN/O2Aejvxrjvy9vg0jbuu2e1SP6IS0cWIw+vQeG80G
         hrzZ59msEntvm0omqkkAl1iEyW3pYEWulCj2vZO78+FCw5wB/Z6ouZNCiS+RfXhh4T42
         bk4KaFAVjeiORWQsM+yAAk84xS1gWYkfUccXddF0SwsRkZGWOeoqfTdcNPH++at/EUwt
         dbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711122164; x=1711726964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVsPuW/g7+EBBvGGprHEy4VCYnfPu3lslt5Y7BuTzaA=;
        b=oWE2UdrJW24nIiIljth3/UN9Y8Cwfo3D4N6148gqqZsw1U9aPUfD4+ybs7WlXICVZQ
         yeUAgRElpY741SD8CUFnf1JhoGpX+5MqeCGkdS0EikF4D/8zgOeHqAUGfh0oeyf+qi4c
         cKPJvfoETZ4PCwtPd8uI3QqBU8P9LwujJawdQ52FnDCcd6JqpBZTsSP5T/iOiK5e4Y3D
         LruwNDFmAU0TL30aqh0WYLMmWFu+iVtubKdx/VuhrF6TGM0sZAxZnCnJQTArEIWtSRvM
         97b8RfHhinoaQBkDYyyIFEm56azgryyISdiEOHKNU5JGdQNXrnZfDK2ZmWZU7eTzNBxf
         9CFA==
X-Gm-Message-State: AOJu0YyEDHuwDpVhjMheg8W972hUzGHAfmQ4caemPmqmlEmLpG8o1kYQ
	ioBPl6O1CjY6J8yoZJ9CxvbidvGjtIuEit3FH2u2FiS1psQYqmHQgi6haziw
X-Google-Smtp-Source: AGHT+IGY8DtD7FoRvmY+dHVqQX2vyWaymt6iyVk6ISxH6xpQU5q1BL9NM6gqU0iT6oSlWyqSwx2o/A==
X-Received: by 2002:a9d:6519:0:b0:6e6:a3ca:2736 with SMTP id i25-20020a9d6519000000b006e6a3ca2736mr17675otl.12.1711122164051;
        Fri, 22 Mar 2024 08:42:44 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id u12-20020a9d4d8c000000b006e6763530e1sm386538otk.61.2024.03.22.08.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:42:43 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 11/11] quectel: Set modem lte capable
Date: Fri, 22 Mar 2024 10:42:24 -0500
Message-ID: <20240322154234.2720542-11-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322154234.2720542-1-denkenz@gmail.com>
References: <20240322154234.2720542-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 plugins/quectel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/plugins/quectel.c b/plugins/quectel.c
index 69e1ff48729d..18cc33123759 100644
--- a/plugins/quectel.c
+++ b/plugins/quectel.c
@@ -648,6 +648,10 @@ static void qinistat_cb(gboolean ok, GAtResult *result, gpointer user_data)
 	}
 
 	data->sim_ready = true;
+
+	if (quectel_model_supports_lte(data->model))
+		ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
+
 	ofono_modem_set_powered(modem, TRUE);
 }
 
-- 
2.43.0

