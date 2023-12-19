Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D6A381A4
	for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NI00KzOv"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7b7d65d4eecso107265839f.0
        for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 10:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703011267; x=1703616067; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1KVEnnKDmjqDOTqvPpuKzmwPHwR+atNx4ptG5ByOt8=;
        b=NI00KzOvjD+SgM7m1jfff0IitlSEDlYlmWAaOCOmzF+WP9zJFMDxK8PgcPxJxUtsSE
         HCcZ4hOGzgt3qx1JzxvVyTZmS+Z8otIWJcT+JzAzauCyQSttRfugHIoweFMNZreElegp
         BjOUz5DHJS+cPPGFzV4GnlE6gObxO497RvtfwOHQRIgVnhYcwqDZUjhGBgyVeDkvJIH1
         5SHOIcwL3UaAWxq+QSxMV/aSjKCHMHGllgaDTO3rAw36Foow2CbcearHIv7weABlsGsz
         c74VN3Tgz6krKkL7V/F3qfIbjXDmwYYwXh1Qa/Lft5CepmN8F3hkJiPB1vkrXQdJmDTq
         Liow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703011267; x=1703616067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1KVEnnKDmjqDOTqvPpuKzmwPHwR+atNx4ptG5ByOt8=;
        b=drHOgTnF2YSQ2rWEOepTzzBliizxKVvvHwYy+ZSYOLnkFepVONVS82dq5YBvo0JMUv
         gTueSumBL+G2Qkb02YqdD8uFes8jYhuBrC60EPCoBYe8gpoTadKITxUsXHxohk0NYH/b
         43y6FDyVvG7vfFsfh6dnEXBK0PUNU90VrceP6v+yTbpS9ZCQIZWSUGDB/kRHXwo+DfdQ
         iwFQ34OOJ6eT6sN9iK25hZcwFXbCD6Cula0M+tN9iAKHUDhU0aXplABYFnU47oZZR0nD
         K76teM2s/QxhtPBHF5ZkUEQ66sBvPZHEi5QGIapp88dDkiAHJG8lk4vbYlwbawTYaUhp
         SMCg==
X-Gm-Message-State: AOJu0YwoHReH9roFY/os+lp/yeGGNEPSL+/zdkxVu0FJslFW0XN8akK8
	a/i4Kbi7ZM9/ouumlnvqYA4J6yTaH4k=
X-Google-Smtp-Source: AGHT+IHFsNMcFM+W4BmD05Z1asxOdtAFGw+5EiS7MY+0fSnDHPJRl9y7D8CZa6E3ZwZuncVeCbpmFg==
X-Received: by 2002:a6b:5b15:0:b0:7b7:382:2b65 with SMTP id v21-20020a6b5b15000000b007b703822b65mr23029108ioh.33.1703011267495;
        Tue, 19 Dec 2023 10:41:07 -0800 (PST)
Received: from localhost.localdomain ([136.33.23.24])
        by smtp.gmail.com with ESMTPSA id co13-20020a0566383e0d00b0046b406d9d95sm1549213jab.38.2023.12.19.10.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:41:06 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 04/15] doc: docs for intermediate provisioning db format
Date: Tue, 19 Dec 2023 12:37:01 -0600
Message-ID: <20231219184016.420116-4-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219184016.420116-1-denkenz@gmail.com>
References: <20231219184016.420116-1-denkenz@gmail.com>
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

