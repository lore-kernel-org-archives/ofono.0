Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FC385958
	for <ofono@lists.linux.dev>; Fri,  2 Feb 2024 22:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914498; cv=none; b=bScDWhajarWVYcrwXHeVJahbcUAvS1WExoRx/y1Xu6FV2+AFre/m46inq7Gze50rOzcg4AjybgexwB9toLEvzmMQB7nfpOiBDs/0CbAfG+x8wWKeosP7NQfj5cvJEGjBwqY+ImkcHQFVmSLUi0kDn3zYrlScqMGg1FHlkbUc3Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914498; c=relaxed/simple;
	bh=hyPteJ2jqQQhUP5+JZGTuesBhi4L5h/BiDZrMdVQw7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIqducHZPz6PxOsdJYJKdKlzhagV8biAQxeHN6lJa7nni1MTNnWPD0/zcD4D7kl2vZy7t9d5fWDyLSkKPjIxw+xvSuYdgmsKRZ4PV0K2owYzxszRWc1Qt+B+uwPbBvPzmZyYSosmYjbgSXHouvGhAeFUL+0Pjvp7dXKNN+oOMTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0LWn0SH; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0LWn0SH"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6dbcebaf9a9so1535737a34.3
        for <ofono@lists.linux.dev>; Fri, 02 Feb 2024 14:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706914496; x=1707519296; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=td95VSf+KXU7eik86JTqU2W3lIsWJfE2VRdq1kJg8nc=;
        b=h0LWn0SHUcJjn6EkPCsY5zr6uMP3Rw9ro4FsgPoahQSymMkNmNkDhAYt904E1eXj/Q
         iiyQEdgVIS2rxLh9kt+SDg++mX8PMXLcpzk4nTMt7qPAcj0Zix9fttaPTd4xDdua/RVh
         3/ty1lLyva7pCz14CrESqwAKTcJghg7wfaLJLfahoNxAduqqW8Ly2dBe9nAMvdYKj4Am
         cHgHi0/pTTGNnrCOdEv5PvvJl5GtK7PaxYMlg3zzjdbUkDgmkF/ZylZR/WZfWTs+ly2U
         6ADYB+UtsAi2pKgk6k/B13+pbszzal9eAeJ7y8112ilLeVytQyxvJT5yTQyCmXvlj01W
         HxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706914496; x=1707519296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=td95VSf+KXU7eik86JTqU2W3lIsWJfE2VRdq1kJg8nc=;
        b=A6V04KRwADgFRpcvrbkcM0sTinUZAMW1KMfC9uZcxCt2bB343sFuyPo8rXOo2qHs4Z
         fYqazCtnwHBW8mKBWKiiEATyzv+aIU9pC4U+4hrd8X1rfhN4mcNeVpNimr1eirX/C4eD
         YOvGFRm/T2oXXU5r6xIk+/6eNWUqZy0Svd3hDvVghsbzL8g00V+qLpN+uKSCin0izSuB
         6FdlQ3iavBosX3ETVCfAtoaF+PjZtCNYQW4JYkdd1WXyu+Z5Z3rRjqHvnQAFrLxBli2r
         oKvuLJYHv/IxmN5xBCu0hTk3wPFv+ppvdpRhH7ieQcjf+Gw41+5vPBUtkZSReK2ai9u1
         /BuQ==
X-Gm-Message-State: AOJu0YzXO9OG4vCqfUENqrsbdJtb/QunyskDS3+t7x5ZfQXPFWvqp+QQ
	eYEfWZklFV2qGFZxAbCilY+VBuVhxY939VG5+b9dxIV3ktvQ4G6zPE3v24qd
X-Google-Smtp-Source: AGHT+IFnN9ET7Hpl5NV6zlw950uXARm9DzOsltUggkML3N1bgNugIfjNf3GTSSofNA9BfwB5cb8I3Q==
X-Received: by 2002:a05:6830:196:b0:6dd:cd73:3b0e with SMTP id q22-20020a056830019600b006ddcd733b0emr10125661ota.23.1706914496289;
        Fri, 02 Feb 2024 14:54:56 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id j20-20020a9d7d94000000b006e1424847d2sm563485otn.12.2024.02.02.14.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:54:55 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 05/18] provisiondb: Remove some duplicate MCCMNC entries
Date: Fri,  2 Feb 2024 16:53:37 -0600
Message-ID: <20240202225405.993792-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202225405.993792-1-denkenz@gmail.com>
References: <20240202225405.993792-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 provision.json | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/provision.json b/provision.json
index ae9a08482254..77d5bb977254 100644
--- a/provision.json
+++ b/provision.json
@@ -14145,7 +14145,6 @@
       "310070",
       "310080",
       "310090",
-      "310090",
       "310150",
       "310170",
       "310280",
@@ -14153,8 +14152,6 @@
       "310410",
       "310560",
       "310670",
-      "310670",
-      "310680",
       "310680",
       "310950",
       "311070",
@@ -14309,7 +14306,6 @@
       "310011",
       "310012",
       "311480",
-      "311480",
       "311481",
       "311482",
       "311483",
@@ -15038,4 +15034,4 @@
       }
     ]
   }
-]
\ No newline at end of file
+]
-- 
2.43.0

