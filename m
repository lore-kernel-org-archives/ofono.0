Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C589E7FBA9
	for <ofono@lists.linux.dev>; Wed, 13 Dec 2023 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CI9kQBqU"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6d9dbe224bbso5682810a34.2
        for <ofono@lists.linux.dev>; Wed, 13 Dec 2023 13:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702504345; x=1703109145; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYKkK+f5zZdlnWTNXVtYDVOmQKapWxwmnn+Z7bX2oLI=;
        b=CI9kQBqUmXX79qETVwBHBjDOLD82Ea8y2FWVrlmvVOq1v9floLGCGRFJICugcQnMiJ
         lhoc4omNbBHa8RToqd5KoFLMnfWNB/FqjAlQuW/nodMKZwnD2a2gmY3spkXUfnjeIPN3
         r8erdZvV2Qur/kKPKnp/M+NiEnkNMhxuUpekKqo4hitEAPjYACeda24jVtj88qaMyUMT
         f4tFRe9zTlhM4rJ93E6dfF61ZPmS8nv5J2fvebrzfI3rFIotfpjkNVq6XtdV+5Bqsa3d
         XXY4hVHnH6Zkhkwe3XqwzWPxejFwGau3TY9QkOy8DbgA8p0weVB7a50J2Of1c9lyiaxd
         mG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702504345; x=1703109145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYKkK+f5zZdlnWTNXVtYDVOmQKapWxwmnn+Z7bX2oLI=;
        b=oSO+PmYEgAiojf2pZKzgx9CjaZ3lUnyoCdO6332qYZx67ahR0iRQMLMj6qWG31ecGj
         Q0ijauF+zDIh95loUUwZw5H3ZwEuA6fgNE9pFU7TDym+1qFaxuyHfolynxwK+RPomxKQ
         66S689JpRiKr0KRtSBxY7ldK52n8jQUypC/Uxz6K3NiX8jAimMWBvu6MG3GEFYvPMYZd
         +iuSjk1Y46I3yOfK1gftVk+HVmHhefAZUtKeOh5FwhkKwvQOY7xpzdGuhhPPAmnaxu/H
         TGLaz9m0YkQrS3BrcMq+M6LjYuLAey3RucvZ0cwANeBx3zPh1x0DYSDdHJmwSv1tdowB
         2qNQ==
X-Gm-Message-State: AOJu0YzTkl+9oHmtvLt2KFWUUlgxUSbnJqbLBIVTWsXbel/QJhUUXeV+
	zjz28i2F00OaQZcMqQl0xH7EJjuvoYI=
X-Google-Smtp-Source: AGHT+IHVlcBDCEr1kkGaszYrP0/97NouXlGNbZ9T7dw+J3Rtfq9/9BU/QcKFkpz8FtgamfMn25QQ7w==
X-Received: by 2002:a05:6830:1655:b0:6d9:da23:9a27 with SMTP id h21-20020a056830165500b006d9da239a27mr8899572otr.68.1702504344832;
        Wed, 13 Dec 2023 13:52:24 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id n18-20020a9d7412000000b006ce33ba6474sm2925612otk.4.2023.12.13.13.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 13:52:24 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 5/6] plugins: Support the new binary provisioning format
Date: Wed, 13 Dec 2023 15:51:29 -0600
Message-ID: <20231213215132.287577-5-denkenz@gmail.com>
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
 Makefile.am           |   2 +
 plugins/provisiondb.c | 436 ++++++++++++++++++++++++++++++++++++++++++
 plugins/provisiondb.h |  18 ++
 3 files changed, 456 insertions(+)
 create mode 100644 plugins/provisiondb.c
 create mode 100644 plugins/provisiondb.h

diff --git a/Makefile.am b/Makefile.am
index e7fd030f..11106162 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -656,6 +656,8 @@ endif
 if PROVISION
 builtin_sources += plugins/mbpi.h plugins/mbpi.c
 
+builtin_sources += plugins/provisiondb.h plugins/provisiondb.c
+
 builtin_modules += provision
 builtin_sources += plugins/provision.c
 
diff --git a/plugins/provisiondb.c b/plugins/provisiondb.c
new file mode 100644
index 00000000..d45166e2
--- /dev/null
+++ b/plugins/provisiondb.c
@@ -0,0 +1,436 @@
+/*
+ *  oFono - Open Source Telephony
+ *  Copyright (C) 2023  Cruise, LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
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
+		if ((r = __get_string(pdb, L_LE64_TO_CPU(context->name_offset),
+					&ret[i].name)) < 0)
+			goto fail;
+
+		if ((r = __get_string(pdb, L_LE64_TO_CPU(context->apn_offset),
+					&ret[i].apn)) < 0)
+			goto fail;
+
+		if ((r = __get_string(pdb,
+					L_LE64_TO_CPU(context->username_offset),
+					&ret[i].username)) < 0)
+			goto fail;
+
+		if ((r = __get_string(pdb,
+					L_LE64_TO_CPU(context->password_offset),
+					&ret[i].password)) < 0)
+			goto fail;
+
+		if ((r = __get_string(pdb,
+					L_LE64_TO_CPU(context->mmsproxy_offset),
+					&ret[i].message_proxy)) < 0)
+			goto fail;
+
+		if ((r = __get_string(pdb, L_LE64_TO_CPU(context->mmsc_offset),
+					&ret[i].message_center)) < 0)
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
diff --git a/plugins/provisiondb.h b/plugins/provisiondb.h
new file mode 100644
index 00000000..19a738fd
--- /dev/null
+++ b/plugins/provisiondb.h
@@ -0,0 +1,18 @@
+/*
+ *  oFono - Open Source Telephony
+ *  Copyright (C) 2023  Cruise, LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-only
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

