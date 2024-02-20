Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A16E1468E0
	for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468931; cv=none; b=ostLN5vUUjduFdJYysLU9vMUWF0w9U23C9j5suV9EsEJdJ2/bC0qXZmLeO/pC2vR74Tx5F3LNzUVRuWPMj1UjWDvuS5DbwJBMQI0njZCTK2rmX3bPDxEAB8tGVmNXED1L+Gu/UblMWNCr/MVRPOEqgx2ltNQyHmRdvVPV/dR79Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468931; c=relaxed/simple;
	bh=i7tvfcKFmnVh78d8KtLw3QfEElFRS6FPwMN02y3MjuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aG90GdvoCtFdRDEKvebPHlMdV6cSsNNdDHGUuV3qACjyogi1bFBD00djle8YPbilobRcqmcaI3s/ovrVlb2Y6ynCvDJRDA/rNJ3QbWN6N+z5Af60IA8DX7OsVlsecyYtyrMBUf0Wcg0ShjleTA597JEZNmAX0Fzdgdmv6aa7UC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7EcITkd; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7EcITkd"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbbc6bcc78so4489550b6e.1
        for <ofono@lists.linux.dev>; Tue, 20 Feb 2024 14:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708468927; x=1709073727; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUxnPqn+84Zt1123ccdhiKW5ymXzGKm/tisgzCQrOLY=;
        b=X7EcITkd4sgszfoXdrwFhGS79U7qutlr3qXgJlR1+esLPjc3oAxtkApC0JmafehANG
         8VZkhXff0vkg8HENllVY4uAeCA1fBoOqpc82Yh+nOuJWvjOl6iUp2Jn2AKqXWombfIIi
         GHIPj7VUmNp8TvRb2d1cWNhtcB1WzwI+IqW8jdcsRECEObW5ZwOlOWJsT48yuBjICheq
         Xqr80f4S1jC+mpEqDnEflqQBmgxWkkGob0VG7ha3wmQ0xuaFKLHlSP+rSikrOBh3TPwN
         l0GUuHpf3rnrO4aJSkoO98DeMD7jKCwkvFdCSKKy3py3OHWtQv9o4NGkmIDg+mOA/tMe
         m4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708468927; x=1709073727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUxnPqn+84Zt1123ccdhiKW5ymXzGKm/tisgzCQrOLY=;
        b=KYGtBYmhqO8/e9W+xSoLf6NmdVq876QiCYNeaX231q1oZ6zQbmQIgw7QqMufGEvWO7
         VI2NH4zIsRQgOvU0hAFVHqpJowQkIrVkT+XRJtc8+6izJMOCmwjgQOz85hTMMtf05/YT
         KZJi5fYKylYpLIeJJDNO9KvtY7KXS94spQUJzZ4tbUiRmsUJfyMYB9+1+DI6F3ax6Tqq
         OO25iEAp1zCjGjY7IS0Urbw12GYle3iR8m7VkZYC/jzgh0lJl+WKzVByjcZ2AzB+4qmg
         sySH1EPaRu71nELjSz4I/wmD/qJz4p20lAyPe63Xc3AHQzWXGfynO09XpJbX9WPuThf8
         RNJQ==
X-Gm-Message-State: AOJu0YySB8wdafIJ99q5FxaBOkORXj/0ZXs9lzR5RxQ/v9wQ31RvCOfY
	U/QUDVjJTZHWoJRyNYGEhL8DbErzuLqkEpH+a8AN/NCd3/3kfdpg2iwKniu5
X-Google-Smtp-Source: AGHT+IE9wiHDTFcZ4kV3WWiZJGQk0MUhjTc3buxocRLBTNai2CGneNMEFI//NzQrN48+43k8Wr9B0w==
X-Received: by 2002:a05:6871:58d:b0:21e:ac8c:d39e with SMTP id u13-20020a056871058d00b0021eac8cd39emr9433640oan.13.1708468927624;
        Tue, 20 Feb 2024 14:42:07 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id nd15-20020a056871440f00b0021a1492f000sm2056403oab.38.2024.02.20.14.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:42:07 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 7/7] gobi: Fail if device could not be created
Date: Tue, 20 Feb 2024 16:41:00 -0600
Message-ID: <20240220224115.1254853-7-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220224115.1254853-1-denkenz@gmail.com>
References: <20240220224115.1254853-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If for some reason the qmux device creation fails, indicate failure
early and do not rely on the 5 second modem powered timeout.
---
 plugins/gobi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index e22b8146cf93..4134c62d398e 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -431,6 +431,8 @@ static int gobi_enable(struct ofono_modem *modem)
 		return -EINVAL;
 
 	data->device = qmi_device_new_qmux(device);
+	if (!data->device)
+		return -EIO;
 
 	if (getenv("OFONO_QMI_DEBUG"))
 		qmi_device_set_debug(data->device, gobi_debug, "QMI: ");
-- 
2.43.0

