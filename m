Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E441CEE86
	for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 22:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412414; cv=none; b=F6ZuUcuBRNwU66U5WTCJrCXi6NJGEI5lg9lN8+LDGdT9DOcrv/j7wZeHtSEn+XkUe3S5kr9ZJzJ9zBml7poFk1ZoH09tOGh7GnxIQCnSDiF733ti3zA8Rb8ZmuK8l7oIGm9JrJqrYx3lt6vHk+7rStL8/HRjVsr4jbfkScnAttw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412414; c=relaxed/simple;
	bh=qI+hPlKxbQUztStjnKxN890v/m3rWUrDNTzEajCrAjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvRo0wyufQ8RSmSIKEXH4B1sjLNjgaOQI8SqaRAYk2zO61/65jiE1rmI3Rx6/nNWu3cr8ioF7cS/DYbcmZgeXI1Ckv2EvMlQjw6dpxPNjc5fMx9jmshnNt4gEm6wZdjH2LmoLui6oH17Ft1iwtTk/zXUvNMme+WM3T30X6DcFuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDOEJ4Ui; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDOEJ4Ui"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-718078c7f53so711390a34.1
        for <ofono@lists.linux.dev>; Thu, 31 Oct 2024 15:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730412408; x=1731017208; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjNXH/9skdsA3RHTRJoux70UO5GM2qyjNnz9JkO/RFs=;
        b=YDOEJ4UidbfxwCUHK0xR8Hc6UzEbwkVM/KTR5L6R9l1jozRr5N7ATs9VGMpVAdqX0E
         KrNmzqEpY44rrG8LFrZOtHUHOVVyEZGXsIxjV+DJeYkU9jl5eddEYwY8xmVINveCQqT8
         weE8wMWC8NihtbS8tkxUauuc2MZULZ6urSFAtZbv0au3SHqTnue+ylHL0Ou3DeFyku6/
         CB2UvL7bGC/z7zVfwzme8qh92ySIGWtqHYtH7EXRmKlrGuQSzW1+7uNK6HAGdjvZaKfC
         xMow2rEHz0iO4o59mhuGTOpfMe/QmbaO+6Zs2HHPZ5K4PdYhlcI8xFQ4Rj1XDQAt7EJK
         VdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730412408; x=1731017208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjNXH/9skdsA3RHTRJoux70UO5GM2qyjNnz9JkO/RFs=;
        b=QQBb8zEXeYynZo8YJp8zTZW4hLFxYb0A3AkqBWNFxvc1gnQQMP9dwu4nJwLLjdGtUH
         H44RUymPx/ngLgEEZBcIebWGdmXE7oDbv83qEqUb/i/M3z9WSjVu8u+z21ITEFQXp/NV
         rLtv5aqtimv3kmk+bFKsDARdo/EsocMezuDmt/U0NB5NZXpei8EgnYcTCqUcHO+uuKwZ
         vPMjpHGcfDuqJwBF79bCFGBLmkEkUzR5neXArS5H0ofDYwAhxFxizZe8vYfCjWRjhZdK
         SYoIYNxUrTeIbjBxjJMHbi59MXM/pG2XNJV+x/m0Ptn4mafoH+tOZmDbzyr/r75LRIcJ
         djHw==
X-Gm-Message-State: AOJu0Yzi6UPDosg8sKOpnOS9k/+5pDstDJyCEnYIX0g0DD56lLLOT/8c
	oT5K2igy2wPTOJlbUSgBucl7/UcFtFu1m8G01S1uz4V4SpAzru9aIpDagg==
X-Google-Smtp-Source: AGHT+IECYu5O4YmSU9m5Yalxn7bzDfssaRGY0/tyLe5WSc0ySTq08lBV223e+kTan4MszBkDQt2p4A==
X-Received: by 2002:a05:6830:6d89:b0:709:3e34:2977 with SMTP id 46e09a7af769-7189d4bc0f6mr2403529a34.7.1730412407809;
        Thu, 31 Oct 2024 15:06:47 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cccf4a7sm507577a34.73.2024.10.31.15.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:06:47 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 12/13] gobi: document and validate "interfaceNumber"
Date: Thu, 31 Oct 2024 17:06:19 -0500
Message-ID: <20241031220638.1582166-12-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031220638.1582166-1-denkenz@gmail.com>
References: <20241031220638.1582166-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 plugins/gobi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index 6ad8a4b7f923..54b64acb7871 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -85,6 +85,7 @@ struct gobi_data {
 	uint8_t oper_mode;
 	int main_net_ifindex;
 	char main_net_name[IFNAMSIZ];
+	uint8_t interface_number;
 	uint32_t max_aggregation_size;
 	uint32_t set_powered_id;
 	bool using_mux : 1;
@@ -115,6 +116,9 @@ static void gobi_io_debug(const char *str, void *user_data)
  * NetworkInterfaceIndex
  *   The index of the main interface given by NetworkInterface
  *
+ * InterfaceNumber
+ *   The USB interface number of the network interface
+ *
  * NetworkInterfaceKernelDriver
  *   The kernel driver that is being used by the main network device.  Only
  *   'qmi_wwan' is supported.
@@ -127,6 +131,7 @@ static int gobi_probe(struct ofono_modem *modem)
 	struct gobi_data *data;
 	const char *if_driver;
 	const char *ifname;
+	uint8_t interface_number;
 	int ifindex;
 	const char *bus;
 
@@ -149,12 +154,17 @@ static int gobi_probe(struct ofono_modem *modem)
 	if (!L_IN_STRSET(bus, "usb"))
 		return -ENOTSUP;
 
+	if (l_safe_atox8(ofono_modem_get_string(modem, "InterfaceNumber"),
+				&interface_number) < 0)
+		return -EINVAL;
+
 	data = l_new(struct gobi_data, 1);
 	data->main_net_ifindex =
 		ofono_modem_get_integer(modem, "NetworkInterfaceIndex");
 	l_strlcpy(data->main_net_name,
 			ofono_modem_get_string(modem, "NetworkInterface"),
 			sizeof(data->main_net_name));
+	data->interface_number = interface_number;
 
 	ofono_modem_set_data(modem, data);
 	ofono_modem_set_capabilities(modem, OFONO_MODEM_CAPABILITY_LTE);
-- 
2.45.2

