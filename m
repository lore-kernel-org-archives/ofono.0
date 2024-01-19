Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313AC5786C
	for <ofono@lists.linux.dev>; Fri, 19 Jan 2024 21:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705698674; cv=none; b=MdCTbWnzazvl7GWzwTI6y5HeBXWLlMMMT22FJvU7e4jAVzbKyLP2xI7pEOhJiRPwW0jF29orrt3OYrA3csyMXtcdMfaOV5//ugL/wQsBJsMV1NcsDl13xZk9OmGjPskkbLMqjR2/XP8RfBb28M3feGuNqr5yOwHMQUuKOpm3Rmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705698674; c=relaxed/simple;
	bh=Uc03OiWKQW6PyyXc5OxqFNRUbibqY8NT8Bh5BPHM3ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRXrkI8Eu1e/5JDoav0VM202+kAJ8X5ltSHcF+Gz3YpXy4hhTupEPsslzN3/YlrzHb/sPyDXAgR9xHRFuTVA0qGNHPCfU7lmal0Pz07gNW3f0J/pf4d3oal6TE2rQ3HjFTAhtFTxGiFbWr2GepnNA5rl0vl4kQhQfXXVtw3wpf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YorOuJmg; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YorOuJmg"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ddeec84e35so743149a34.3
        for <ofono@lists.linux.dev>; Fri, 19 Jan 2024 13:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705698667; x=1706303467; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9MdSCn2oCIxmUNaOF6VyzHNTZ9hiEqeUV1595UpBeQ=;
        b=YorOuJmg9C8rCLcZkRAG8Lm+2SvHVtSX51It8XjfBU+q3K6ZPiBPBhX/v/kRFp4ERK
         uiJEJa/xXB77n622wmS+lM+pvgnSpP3N3RlE9B/UVb5EvfCzHRYAlzDrp2B2Xk8lN7i6
         /QKkvEXMMmY9knqGtvjMcHmmGonIAa/zsm/rpX9ehyXRU81Dkk3KrvTRvxRpwwMSGlQa
         3/+NGwph7jPaffv3h0XsQE9KF6oeIEWFNi0KRoXMNroL9eJQeRSToZO4K9IjrrJEmsQS
         KGUdex2n1FRv5jJDTi6JEAJwS42P3JW5MrrBmOz8MueBnvkdl84hxHMkb59mBL5+b8Hi
         q7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705698667; x=1706303467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9MdSCn2oCIxmUNaOF6VyzHNTZ9hiEqeUV1595UpBeQ=;
        b=ck9k8VXfSsb+OK2+q+Ij9RkQoxsTXXBYCPY95CASNoqIlv+MZukPfTn4C6WgErRHna
         OWbDKN0EV51X8UCF++YnnYidaLMEPG3dNOlP0PPDnDQ5/RZLui4/dJsh3afhS9vG+Vpe
         aOJQK3hIDU2kMKbK8QWJlynTp/SnGfO9dTfmqQhw0K8yEC9O8Yw4GGNX50qaBj5baq3I
         dLaEZ5EXBEUNt9il76XMWcyImpWP7412azUi4GtqKlSywfDZadeD1A43p4V4nDbEd+JA
         vER1WgOWyXDY2tw8pg7DB1MhdlUyYT/IXvXE8OYYsPT/dIJNZBj708jP6NDUYFepVYna
         6n2w==
X-Gm-Message-State: AOJu0Yxz64bUh9P/+3d7UpVuO23pz7gMMCRv72ke6QRz+Ksk8KeQtKz8
	ch72I5lpxMjCdTpjHoTlXKZFijWOggeOkoU+BJ9SbncPmNu6YSpFX63IGOt8
X-Google-Smtp-Source: AGHT+IFmtIUiUH6lsJT47PYZE8TQXx2HlFiu8sdVTkplNdwjh5IsHSoBUkyKDDVk6Z4uiEhbpXSWNw==
X-Received: by 2002:a9d:7dd2:0:b0:6dc:7e7e:cd6b with SMTP id k18-20020a9d7dd2000000b006dc7e7ecd6bmr495574otn.44.1705698667067;
        Fri, 19 Jan 2024 13:11:07 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id l47-20020a056830336f00b006e0d8709ff3sm457597ott.39.2024.01.19.13.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 13:11:06 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 03/14] doc: docs for intermediate provisioning db format
Date: Fri, 19 Jan 2024 15:09:39 -0600
Message-ID: <20240119211017.474598-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119211017.474598-1-denkenz@gmail.com>
References: <20240119211017.474598-1-denkenz@gmail.com>
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
index 00000000..ed496e77
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
+            Username used for authenticating to the access point.
+
+            This field is `optional`.
+
+            Example: "username"
+
+        - **password (String):**
+            Password used for authenticating to the access point.
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

