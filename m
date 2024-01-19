Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F7657876
	for <ofono@lists.linux.dev>; Fri, 19 Jan 2024 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705698672; cv=none; b=AwqWSG/X8+CJMNeB8EfiBYkpToSjknAHrJe+QvHl8GU2yLn7GVmybA8ysoxa0h2SQbXc8R5M5YHcycd57MUbfm+PsUIbvydYW3bwXsFd+UwxyBxCDvOmSeUE96oaMmoO1vke//vpdY/TF87QCGZrOKbAHShYizy624YEc233TU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705698672; c=relaxed/simple;
	bh=GmPZfcsAC5eNwE8lBepQQ3Oa5q7+cb+TnC+wZp4yf8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LidrHaKYibo5OCqDUDFqQqQKcPkoHjT4O1+muF6yLD0heKu7YiitxMTDyA/ByCsU+gSMKZTUOkw/759LX7UmttmTvfMSIvfIvCXip/BbgppDNuJGsTIfHBM6rOkUsrbLAuUlSnv4y69xVw4UkEObeDssp7gZQft3qJM9NNu9zZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPTzaiGQ; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPTzaiGQ"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e0a64d9449so764233a34.2
        for <ofono@lists.linux.dev>; Fri, 19 Jan 2024 13:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705698669; x=1706303469; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWcdb2PMr1ztoRRARJuAtYp/5zpN3PdtV3v50ZLxZto=;
        b=KPTzaiGQcu0JfuMIBLzPGhcBAFF93SCqQjlOHDiy6GQFJPfo4EsR7oK5IvhJktATCU
         dZ28/AJzWf//HMdR+1AtkDUypA0OjHCiMR9zrJWyUO1q178ssaD2n7lhV0hjQdbzE+QY
         jvVmGLrMkeIhhoMzbmKqjqdOw1KyMNBu/PoAn7fZUx1gq4JnfcguU8ekSbDgVhSlrYpH
         vCKPD+pXNAWh1cUjzPxHM5jCDma2ImwS4NmUfdQvaBYpjla0y5UuIXl2p3E5LFS2CAbf
         39j/Z6FneM2BqU+DodYTWEOcWUvfkKbbNib6DZijiMTLkn3Zr1VKeWqjxx/ETrVdjMjm
         LHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705698669; x=1706303469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWcdb2PMr1ztoRRARJuAtYp/5zpN3PdtV3v50ZLxZto=;
        b=YNfAjWw1gvNzI4iJoGn3c/XMJKWFx1SN09MkfA6BhxvGZA6ReapIe7AjUZ10qwkDGh
         FqsGGEy8eSs32OFotfH7vEz/1B200u9wUlNgJyF9WyDDNAze8ix8PUzL0/kGcxWoGUfB
         2wX4eeLO0IUQVA8dRTNhyiQygmhQ9x4yAr80kbWtSnNe78FxEbN5R9fAVJPF/Pz+oU/5
         shzZeMYAc+HESRJ6aMdxaQHtSlfKZSpRY7AJdelt8YLc8VoCx411qWDWNnjUfzFcYqeY
         2CxHUZTwTyXabAYIObmUA4WULU/UYfhTuxi19nt23w/0H+rslxSV7q6msa0ePZrLgs7U
         wR7A==
X-Gm-Message-State: AOJu0YxBDVJkWDVuTEbfNWVhdax+SfgnTkp40FiHuA4XMj+lMV0209Tm
	uCxRBKwi8X9sz/RPYhzSZK8EDt1MhYE3XLld9SNjq7+gAZOBnOhDIgIMSMjN
X-Google-Smtp-Source: AGHT+IEVWYLJf6F8z9i9GV7C2L1ipQtVG/pEW9Y5IJU1P1G2P6VqgpJyq5i2Wq0yPXh7u4vTGa/O4g==
X-Received: by 2002:a05:6830:ed8:b0:6df:b685:203a with SMTP id dq24-20020a0568300ed800b006dfb685203amr440310otb.59.1705698669530;
        Fri, 19 Jan 2024 13:11:09 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id l47-20020a056830336f00b006e0d8709ff3sm457597ott.39.2024.01.19.13.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 13:11:08 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 05/14] core: Add utilities to read the provisioning db
Date: Fri, 19 Jan 2024 15:09:41 -0600
Message-ID: <20240119211017.474598-5-denkenz@gmail.com>
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

Binary provisioning format is based on a patricia trie / crit-bit tree,
with each MCC + MNC combination represented by a single node.  Each node
contains an array of { SPN, offset } pairs, with the offset pointing to
the region of memory where the context information resides.

Each node also has two offsets, corresponding to left and right children
of the node, as well as the position of the critical bit, based on which
the tree is traversed.

All strings are placed in the last section and are nil terminated.
Structures are designed with 8-byte alignment and stored in little
endian format, which will require no conversion for the vast majority of
platforms in use.
---
 Makefile.am       |   3 +-
 src/provisiondb.c | 442 ++++++++++++++++++++++++++++++++++++++++++++++
 src/provisiondb.h |  18 ++
 3 files changed, 462 insertions(+), 1 deletion(-)
 create mode 100644 src/provisiondb.c
 create mode 100644 src/provisiondb.h

diff --git a/Makefile.am b/Makefile.am
index f7b59a47..b3a016cf 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -726,7 +726,8 @@ src_ofonod_SOURCES = $(builtin_sources) $(gatchat_sources) src/ofono.ver \
 			src/hfp.h src/siri.c \
 			src/netmon.c src/lte.c src/ims.c \
 			src/netmonagent.c src/netmonagent.h \
-			src/module.c
+			src/module.c \
+			src/provisiondb.h src/provisiondb.c
 
 src_ofonod_LDADD = gdbus/libgdbus-internal.la $(builtin_libadd) $(ell_ldadd) \
 			@GLIB_LIBS@ @DBUS_LIBS@ -ldl
diff --git a/src/provisiondb.c b/src/provisiondb.c
new file mode 100644
index 00000000..6b864dec
--- /dev/null
+++ b/src/provisiondb.c
@@ -0,0 +1,442 @@
+/*
+ *  oFono - Open Source Telephony
+ *  Copyright (C) 2023  Cruise, LLC
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <linux/types.h>
+#include <string.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <errno.h>
+#include <unistd.h>
+
+#include <ell/ell.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/modem.h>
+#include <ofono/gprs-provision.h>
+
+#include "provisiondb.h"
+
+struct provision_header {
+	__le64 version;
+	__le64 file_size;
+	__le64 header_size;
+	__le64 node_struct_size;
+	__le64 provision_data_struct_size;
+	__le64 context_struct_size;
+	__le64 nodes_offset;
+	__le64 nodes_size;
+	__le64 contexts_offset;
+	__le64 contexts_size;
+	__le64 strings_offset;
+	__le64 strings_size;
+
+	/* followed by nodes_size of node structures */
+	/* followed by contexts_size of context structures */
+	/* followed by strings_size packed strings */
+} __attribute__((packed));
+
+struct node {
+	__le64 bit_offsets[2];
+	__le32 mccmnc;
+	__le32 diff; /* Signed */
+	__le64 provision_data_count;
+	/* followed by provision_data_count provision_data structures */
+} __attribute__((packed));
+
+struct provision_data {
+	__le64 spn_offset;
+	__le64 context_offset;	/* the offset contains count of contexts */
+				/* followed by context structures */
+} __attribute__((packed));
+
+struct context {
+	__le32 type; /* Corresponds to ofono_gprs_context_type bitmap */
+	__le32 protocol; /* Corresponds to ofono_gprs_proto */
+	__le32 authentication; /* Corresponds to ofono_gprs_auth_method */
+	__le32 reserved;
+	__le64 name_offset;
+	__le64 apn_offset;
+	__le64 username_offset;
+	__le64 password_offset;
+	__le64 mmsproxy_offset;
+	__le64 mmsc_offset;
+} __attribute__((packed));
+
+struct provision_db {
+	int fd;
+	time_t mtime;
+	size_t size;
+	void *addr;
+	uint64_t nodes_offset;
+	uint64_t nodes_size;
+	uint64_t contexts_offset;
+	uint64_t contexts_size;
+	uint64_t strings_offset;
+	uint64_t strings_size;
+};
+
+struct provision_db *provision_db_new(const char *pathname)
+{
+	struct provision_header *hdr;
+	struct provision_db *pdb = NULL;
+	struct stat st;
+	void *addr;
+	size_t size;
+	int fd;
+
+	if (!pathname)
+		return NULL;
+
+	fd = open(pathname, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return NULL;
+
+	if (fstat(fd, &st) < 0)
+		goto error_close;
+
+	size = st.st_size;
+	if (size < sizeof(struct provision_header))
+		goto error_close;
+
+	addr = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
+	if (addr == MAP_FAILED)
+		goto error_close;
+
+	hdr = addr;
+
+	if (L_LE64_TO_CPU(hdr->file_size) != size)
+		goto failed;
+
+	if (L_LE64_TO_CPU(hdr->header_size) != sizeof(struct provision_header))
+		goto failed;
+
+	if (L_LE64_TO_CPU(hdr->node_struct_size) != sizeof(struct node))
+		goto failed;
+
+	if (L_LE64_TO_CPU(hdr->provision_data_struct_size) !=
+			sizeof(struct provision_data))
+		goto failed;
+
+	if (L_LE64_TO_CPU(hdr->context_struct_size) != sizeof(struct context))
+		goto failed;
+
+	if (L_LE64_TO_CPU(hdr->header_size) + L_LE64_TO_CPU(hdr->nodes_size) +
+			L_LE64_TO_CPU(hdr->contexts_size) +
+			L_LE64_TO_CPU(hdr->strings_size) != size)
+		goto failed;
+
+	pdb = l_new(struct provision_db, 1);
+
+	pdb->fd = fd;
+	pdb->mtime = st.st_mtime;
+	pdb->size = size;
+	pdb->addr = addr;
+	pdb->nodes_offset = L_LE64_TO_CPU(hdr->nodes_offset);
+	pdb->nodes_size = L_LE64_TO_CPU(hdr->nodes_size);
+	pdb->contexts_offset = L_LE64_TO_CPU(hdr->contexts_offset);
+	pdb->contexts_size = L_LE64_TO_CPU(hdr->contexts_size);
+	pdb->strings_offset = L_LE64_TO_CPU(hdr->strings_offset);
+	pdb->strings_size = L_LE64_TO_CPU(hdr->strings_size);
+
+	return pdb;
+
+failed:
+	munmap(addr, st.st_size);
+error_close:
+	close(fd);
+	return NULL;
+}
+
+struct provision_db *provision_db_new_default(void)
+{
+	struct provision_db *db = NULL;
+	size_t i;
+	const char * const paths[] = { "/usr/share/ofono/provision.db" };
+
+	for (i = 0; !db && i < L_ARRAY_SIZE(paths); i++)
+		db = provision_db_new(paths[i]);
+
+	return db;
+}
+
+void provision_db_free(struct provision_db *pdb)
+{
+	if (!pdb)
+		return;
+
+	munmap(pdb->addr, pdb->size);
+	close(pdb->fd);
+	l_free(pdb);
+}
+
+static int __get_node(struct provision_db *pdb, uint64_t offset,
+				struct node **out_node)
+{
+	uint64_t count;
+	struct node *node;
+
+	if (offset + sizeof(struct node) > pdb->nodes_size)
+		return -EPROTO;
+
+	node = pdb->addr + pdb->nodes_offset + offset;
+	offset += sizeof(struct node);
+	count = L_LE64_TO_CPU(node->provision_data_count);
+
+	if (offset + count * sizeof(struct provision_data) > pdb->nodes_size)
+		return -EPROTO;
+
+	*out_node = node;
+	return 0;
+}
+
+static struct provision_data *__get_provision_data(struct node *node)
+{
+	return ((void *) node) + sizeof(struct node);
+}
+
+static int __get_string(struct provision_db *pdb, uint64_t offset,
+				char **out_str)
+{
+	if (!offset) {
+		*out_str = NULL;
+		return 0;
+	}
+
+	if (offset >= pdb->strings_size)
+		return -EPROTO;
+
+	*out_str = pdb->addr + pdb->strings_offset + offset;
+	return 0;
+}
+
+static int __get_contexts(struct provision_db *pdb, uint64_t offset,
+				struct ofono_gprs_provision_data **contexts,
+				size_t *n_contexts)
+{
+	void *start = pdb->addr + pdb->contexts_offset;
+	uint64_t num;
+	uint64_t i;
+	struct ofono_gprs_provision_data *ret;
+	int r;
+
+	if (offset + sizeof(__le64) >= pdb->contexts_size)
+		return -EPROTO;
+
+	num = l_get_le64(start + offset);
+	offset += sizeof(__le64);
+
+	if (offset + num * sizeof(struct context) > pdb->contexts_size)
+		return -EPROTO;
+
+	ret = l_new(struct ofono_gprs_provision_data, num);
+
+	for (i = 0; i < num; i++, offset += sizeof(struct context)) {
+		struct context *context = start + offset;
+
+		ret[i].type = L_LE32_TO_CPU(context->type);
+		ret[i].proto = L_LE32_TO_CPU(context->protocol);
+		ret[i].auth_method = L_LE32_TO_CPU(context->authentication);
+
+		r = __get_string(pdb, L_LE64_TO_CPU(context->name_offset),
+					&ret[i].name);
+		if (r < 0)
+			goto fail;
+
+		r = __get_string(pdb, L_LE64_TO_CPU(context->apn_offset),
+					&ret[i].apn);
+		if (r < 0)
+			goto fail;
+
+		r = __get_string(pdb, L_LE64_TO_CPU(context->username_offset),
+					&ret[i].username);
+		if (r < 0)
+			goto fail;
+
+		r = __get_string(pdb, L_LE64_TO_CPU(context->password_offset),
+					&ret[i].password);
+		if (r < 0)
+			goto fail;
+
+		r = __get_string(pdb, L_LE64_TO_CPU(context->mmsproxy_offset),
+					&ret[i].message_proxy);
+		if (r < 0)
+			goto fail;
+
+		r = __get_string(pdb, L_LE64_TO_CPU(context->mmsc_offset),
+					&ret[i].message_center);
+		if (r < 0)
+			goto fail;
+	}
+
+	*contexts = ret;
+	*n_contexts = num;
+	return 0;
+
+fail:
+	l_free(ret);
+	return r;
+}
+
+static uint8_t choose(struct node *node, uint32_t key)
+{
+	return (key >> (31U - L_LE32_TO_CPU(node->diff))) & 1;
+}
+
+static int __find(struct provision_db *pdb, uint32_t key,
+						struct node **out_node)
+{
+	struct node *child;
+	struct node *parent;
+	int r;
+
+	r = __get_node(pdb, 0, &parent);
+	if (r < 0)
+		return r;
+
+	r = __get_node(pdb, L_LE64_TO_CPU(parent->bit_offsets[0]), &child);
+	if (r < 0)
+		return r;
+
+	while ((int32_t) L_LE32_TO_CPU(parent->diff) <
+			(int32_t) L_LE32_TO_CPU(child->diff)) {
+		uint8_t bit = choose(child, key);
+		uint64_t offset = L_LE64_TO_CPU(child->bit_offsets[bit]);
+
+		parent = child;
+
+		r = __get_node(pdb, offset, &child);
+		if (r < 0)
+			return r;
+	}
+
+	if (L_LE32_TO_CPU(child->mccmnc) != key)
+		return -ENOENT;
+
+	*out_node = child;
+	return 0;
+}
+
+static int id_as_num(const char *id, size_t len)
+{
+	uint32_t v = 0;
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (!l_ascii_isdigit(id[i]))
+			return -EINVAL;
+
+		v = v * 10 + id[i] - '0';
+	}
+
+	return v;
+}
+
+static int key_from_mcc_mnc(const char *mcc, const char *mnc, uint32_t *key)
+{
+	size_t mcc_len = strlen(mcc);
+	size_t mnc_len = strlen(mnc);
+	uint32_t v;
+	int r;
+
+	if (mcc_len != 3)
+		return -EINVAL;
+
+	if (mnc_len != 2 && mnc_len != 3)
+		return -EINVAL;
+
+	r = id_as_num(mcc, mcc_len);
+	if (r < 0)
+		return r;
+
+	v = r << 11;
+
+	r = id_as_num(mnc, mnc_len);
+	if (r < 0)
+		return r;
+
+	if (mnc_len == 3)
+		v |= 1 << 10;
+
+	v |= r;
+
+	*key = v;
+	return 0;
+}
+
+int provision_db_lookup(struct provision_db *pdb,
+			const char *mcc, const char *mnc, const char *match_spn,
+			struct ofono_gprs_provision_data **items,
+			size_t *n_items)
+{
+	int r;
+	uint32_t key;
+	struct node *node;
+	struct provision_data *data;
+	struct provision_data *found = NULL;
+	uint64_t count;
+	uint64_t i;
+
+	if (pdb == NULL)
+		return -EBADF;
+
+	r = key_from_mcc_mnc(mcc, mnc, &key);
+	if (r < 0)
+		return r;
+
+	/*
+	 * Find the target node, then walk the provision_data items to
+	 * match the spn.  After that it is a matter of allocating the
+	 * return contexts and copying over the details.
+	 */
+
+	r = __find(pdb, key, &node);
+	if (r < 0)
+		return r;
+
+	count = L_LE64_TO_CPU(node->provision_data_count);
+	data = __get_provision_data(node);
+
+	if (!count)
+		return -ENOENT;
+
+	/*
+	 * provision_data objects are sorted by SPN, with no SPN (non-MVNO)
+	 * being first.  Since the provisioning data is imperfect, we try to
+	 * match by SPN, but if that fails, we return the non-SPN entry, if
+	 * present
+	 */
+	if (data[0].spn_offset == 0) {
+		found = data;
+		data += 1;
+		count -= 1;
+	}
+
+	for (i = 0; i < count; i++) {
+		char *spn;
+
+		r = __get_string(pdb, L_LE64_TO_CPU(data[i].spn_offset), &spn);
+		if (r < 0)
+			return r;
+
+		if (l_streq0(spn, match_spn)) {
+			found = data + i;
+			break;
+		}
+	}
+
+	if (!found)
+		return -ENOENT;
+
+	return __get_contexts(pdb, L_LE64_TO_CPU(found->context_offset),
+				items, n_items);
+}
diff --git a/src/provisiondb.h b/src/provisiondb.h
new file mode 100644
index 00000000..d7381b94
--- /dev/null
+++ b/src/provisiondb.h
@@ -0,0 +1,18 @@
+/*
+ *  oFono - Open Source Telephony
+ *  Copyright (C) 2023  Cruise, LLC
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+struct ofono_gprs_provision_data;
+struct provision_db;
+
+struct provision_db *provision_db_new(const char *pathname);
+struct provision_db *provision_db_new_default(void);
+void provision_db_free(struct provision_db *pdb);
+
+int provision_db_lookup(struct provision_db *pdb,
+			const char *mcc, const char *mnc, const char *spn,
+			struct ofono_gprs_provision_data **items,
+			size_t *n_items);
-- 
2.43.0

