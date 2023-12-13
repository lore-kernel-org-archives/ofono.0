Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61AF7FBAA
	for <ofono@lists.linux.dev>; Wed, 13 Dec 2023 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOx8CVuL"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6d9e0f0cba9so4809556a34.1
        for <ofono@lists.linux.dev>; Wed, 13 Dec 2023 13:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702504342; x=1703109142; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1KVEnnKDmjqDOTqvPpuKzmwPHwR+atNx4ptG5ByOt8=;
        b=gOx8CVuLjmwrn1HggnibTRRl4in495htibVXumsH1MYp/2foYwmFoAUAmVtUSMUCBG
         8aL6nXhEo9YW5YL+8NhvD2I7CwLVyaMLgjiT+s6UyYJhRAcEOjBm48BEIpDjh62iDXSg
         iXbcdjgWoeyV0pEZf43MR3/kbrWPfLxHRub6HmI+k9XMO6C/LTSu1/ziS99B9Vo2YEEA
         xK9R8HIU0AM5ssShFW+ZnqrvqRxveD7a0DBl0ybCay0zjRDqZf8/7acKpLoW75qh7MMn
         3JPDKeRFf9MCq7psUzPTz9/QDhxQklx3WDZ4F+oG0bvPejduFjl4NzK+BaybHZO2HCkV
         WBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702504342; x=1703109142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1KVEnnKDmjqDOTqvPpuKzmwPHwR+atNx4ptG5ByOt8=;
        b=q2f6xrZqdoWj8cxGvVq9ozVZ2cOXZDURhxH1wz2FD8/cur8WaeAFZFozRN+oqYP1j/
         cPBqeCh6j2ySRgLZioz3sYy6D2G15gFYwIs40S4Dnz5z64GqxbXevrLe3MbAbIuC7Afs
         tG6IS5KLFBQBDB7tf58OiT+9R/VeRd1JcUxzZ0OZOY89p9Ap1cOEfeOFEta2Rubw7AU7
         P1tAOLSzcJHA8X18RAcvbN+D/Z0KN+2InHG94PVyC3nhNqi7LLgYBIOIxxLDm4h3KeMV
         oN9dI/P3YfkInJJ/UhJUBA5Ws/XbNtClCQ//Otz6Heka2fnsNV1WU+Gl0C9H6wIm1Aee
         U7WQ==
X-Gm-Message-State: AOJu0YxmdCa2zuFq4jOvsJjbQZkOM2F354foozuyc0Z9Lm11+6gCeWbN
	QhHIcaIljVup3Qob+YhJYQlQOH+xNho=
X-Google-Smtp-Source: AGHT+IGW2c12N6YzTu1KgjiPbx0OBWkWAuYotX/ymI0t8UJN8k+tv7ZxHadNNuYyWextTtI9gDTBPw==
X-Received: by 2002:a9d:77ca:0:b0:6d9:d368:65f6 with SMTP id w10-20020a9d77ca000000b006d9d36865f6mr7880693otl.22.1702504342726;
        Wed, 13 Dec 2023 13:52:22 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id n18-20020a9d7412000000b006ce33ba6474sm2925612otk.4.2023.12.13.13.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 13:52:22 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/6] doc: docs for intermediate provisioning db format
Date: Wed, 13 Dec 2023 15:51:27 -0600
Message-ID: <20231213215132.287577-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213215132.287577-1-denkenz@gmail.com>
References: <20231213215132.287577-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new provisioning file format to be used by oFono.  This
format will be an 'intermediate' format, that will be converted to a
binary format for use on the actual device.  This allows expensive and
error prone (not to mention hard to secure) parsing of XML files
(such asmobile-broadband-provider-info or Android apns-conf.xml) to be
avoided.

JSON was chosen since it is a much more readable format compared to
XML.
---
 doc/provision.rst | 139 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)
 create mode 100644 doc/provision.rst

diff --git a/doc/provision.rst b/doc/provision.rst
new file mode 100644
index 00000000..693b38a3
--- /dev/null
+++ b/doc/provision.rst
@@ -0,0 +1,139 @@
+Carrier Settings Provisioning Database
+======================================
+
+Carrier settings provisioning is performed automatically whenever a new,
+not previously used SIM card is detected for the first time.  Settings such as
+APN, username, password settings as well as the default bearer settings can be
+provisioned automatically if a matching database entry is found.
+
+Matches are performed based on the following information:
+    * SIM Mobile Country Code (MCC)
+    * SIM Mobile Network Code (MNC)
+    * SIM Service Provider Name (SPN)
+
+The carrier settings provisioning database is represented in JSON format and is
+converted to a binary format at installation time.
+
+JSON Structure
+--------------
+**(List):**
+    List of mobile network provider objects.  Top level element.
+
+    Example:
+    ``[{"name": "Operator XYZ", ...}, {"name": "Operator ZYX", ...}]``
+
+    - **name (String):**
+        The name of the mobile network provider.  This field is a freeform
+        string that identifies the provider.  This field is used purely for
+        human consumption and not used by the provisioning logic.
+
+        This field is `required`.
+
+        Example: "Operator XYZ"
+
+    - **ids (List of Strings):**
+        Unique identifiers associated with the mobile network provider.  This
+        is a list of all MCC+MNC identifiers associated with this provider.
+
+        This field is `required`.
+
+        Example: ``["99955", "99956", "99901", "99902"]``
+
+    - **spn (String):**
+        Service Provider Name associated with the mobile network provider.  This
+        field is typically used to differentiate MVNOs from non-MVNO providers.
+
+        This field is `optional`.
+
+        Example: "ZYX"
+
+    - **apns (List):**
+        List of access points associated with the mobile network provider.  At
+        least one entry must be present in the list.
+
+        This field is `required`.
+
+        - **name (String):**
+            The descriptive name of the access point.  If present, will be
+            reflected in the oFono context name after successful provisioning.
+
+            This field is `optional`.
+
+            Example: "Internet"
+
+        - **apn (String):**
+            Access Point Name - Setting required for successful bearer
+            activation.  Provided by the carrier.
+
+            This field is `required`.
+
+            Example: "internet"
+
+        - **type (List of Strings):**
+            The types of connections supported by the access point.  The
+            following types are recognized:
+
+            - "internet": Used for general internet access.
+            - "mms": Used for Multimedia Messaging Service (MMS).
+            - "wap": Used for Wireless Application Protocol (WAP).
+            - "ims": Used for IP Multimedia Subsystem (IMS).
+            - "supl": Used for Secure User Plane Location (SUPL).
+            - "ia": Used for Initial Attach in LTE networks.
+
+            This field is `required`.
+
+            Example: ``["internet", "mms"]``
+
+        - **authentication (String):**
+            Authentication method used for the connection.  The following types
+            are recognized:
+
+            - "chap": CHAP authentication
+            - "pap": PAP authentication
+            - "none": No authentication is used
+
+            This field is `optional`.
+
+            Example: "none"
+
+        - **username (String):**
+            Username used for autenticating to the access point.
+
+            This field is `optional`.
+
+            Example: "username"
+
+        - **password (String):**
+            Password used for autenticating to the access point.
+
+            This field is `optional`.
+
+            Example: "temp123"
+
+        - **protocol (String):**
+            Network protocol used for the connection.  The following types are
+            recognized:
+
+            - "ipv4": IPv4 only
+            - "ipv6": IPv6 only
+            - "ipv4v6": Dual protocol, both IPv4 and IPv6 will be negotiated
+
+            If omitted, then `"ipv4v6"` will be assumed.
+
+            This field is `optional`.
+
+            Example: "ipv4"
+
+        - **mmsc (String):**
+            Multimedia Messaging Service Center - URL for MMS.
+
+            This field is `required` for MMS contexts.
+
+            Example: "foobar.mmsc:80"
+
+        - **mmsproxy (String):**
+            Proxy server for Multimedia Messaging Service (MMS).
+
+            This field is `optional`.
+
+            Example: "mms.proxy.net"
-- 
2.43.0

