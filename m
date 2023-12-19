Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6247381CD
	for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vhvm6apM"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7b435966249so202768639f.0
        for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 10:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703011275; x=1703616075; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyuHXoggKEYLJ5FXIw4NmIm74KROvXmwkCBeEwEPM7Q=;
        b=Vhvm6apM5H6X7H/I45f40AsuZPJlPr3/gR8PwLcqrhkOPSYGx+IQtQClmGiJ68gDvG
         o+NbsLW/6/Jd5BZ6w9wxoHQoWzMs5DiTg0XdI8gkR93dzY+nfQ5hLOfowO8iJaSu8vsF
         0U1HG9M0BrJN9zzW9Hq6izSQpYAKOzdEYQIN3dZjO+7GkZK11kajfruFptFn5vdmxujL
         SWHnBe05b2WC8ktgZruQU6GVTpWmAEum3d4Ogq5OSBvSXROboHfZ55RCxour4+hrzRwn
         E/rQLJa+dm8oMbiqx84HhH3BLNSWnZG7ldUAVmwX1x6p392UiMBTddFEgvR8SRlIMKnj
         j6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703011275; x=1703616075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyuHXoggKEYLJ5FXIw4NmIm74KROvXmwkCBeEwEPM7Q=;
        b=xHXgUoo0KDlrkJf5HuX/ada+ksK32VPlYtGsw16TCWW7bJG89mwkqqCsmY5FX6lcfA
         QxPaUQ26FX7G1lqbRBaN8i6OW/kwbs9gsnG8ezpru4w+qWLBWQQZq4/+eqWbAYiPBvVr
         98RrGpTGRc9k/4NmMe8KLwjfUpMEU/weC7vahseiKAcGYQCMtTTloPKE2KLXBNDCzEkb
         mvlsvnGZ9pugFOA4J+6SEffbsvOe5zuE8R1Qdc6K6hMPQpfOd26C69VQpMktTHQYpoxE
         E5h4+m6lO6mrrjorF1iU2NIbYD/2b7PE1fPmjI4mxwNDzbAOBI7VpdEB2R9j424Ayujl
         /aJg==
X-Gm-Message-State: AOJu0Yw/eYWY5CdXSmDCikC6UnZna4spDBfN+mqX3ofDaqav4CpppUfU
	DidbWF0D7CGekP0MgqAgPiLBMZbfvXs=
X-Google-Smtp-Source: AGHT+IFPaWZA+CQeT9PjPDvtTEeCBvtN1kZ/LFkGBUuSYQN65YLzq4kAJMzWGZf8XVbpB7WagwiVnQ==
X-Received: by 2002:a6b:4407:0:b0:7b7:fb58:bb2d with SMTP id r7-20020a6b4407000000b007b7fb58bb2dmr853141ioa.19.1703011274734;
        Tue, 19 Dec 2023 10:41:14 -0800 (PST)
Received: from localhost.localdomain ([136.33.23.24])
        by smtp.gmail.com with ESMTPSA id co13-20020a0566383e0d00b0046b406d9d95sm1549213jab.38.2023.12.19.10.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:41:14 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 07/15] tools: lookup-apn: Use the new provision_db utils
Date: Tue, 19 Dec 2023 12:37:04 -0600
Message-ID: <20231219184016.420116-7-denkenz@gmail.com>
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

Migrate lookup-apn tool to use the new provision.db binary file format.

The typical usage is now changed as follows:
  % tools/lookup-apn --file=sample.db 999 02
---
 Makefile.am        |   6 +-
 tools/lookup-apn.c | 173 ++++++++++++++++++++++++++-------------------
 2 files changed, 103 insertions(+), 76 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index b3a016cf..3023ed0c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -661,7 +661,6 @@ builtin_sources += plugins/provision.c
 
 builtin_modules += file_provision
 builtin_sources += plugins/file-provision.c
-
 endif
 
 if MAINTAINER_MODE
@@ -1010,8 +1009,9 @@ tools_auto_enable_LDADD = gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@
 tools_get_location_SOURCES = tools/get-location.c
 tools_get_location_LDADD = @GLIB_LIBS@ @DBUS_LIBS@
 
-tools_lookup_apn_SOURCES = plugins/mbpi.c plugins/mbpi.h tools/lookup-apn.c
-tools_lookup_apn_LDADD = @GLIB_LIBS@
+tools_lookup_apn_SOURCES = src/provisiondb.h src/provisiondb.c \
+				tools/lookup-apn.c
+tools_lookup_apn_LDADD = $(ell_ldadd)
 
 tools_tty_redirector_SOURCES = tools/tty-redirector.c
 tools_tty_redirector_LDADD = @GLIB_LIBS@
diff --git a/tools/lookup-apn.c b/tools/lookup-apn.c
index 884b32a0..493187a9 100644
--- a/tools/lookup-apn.c
+++ b/tools/lookup-apn.c
@@ -1,115 +1,142 @@
 /*
- *
  *  oFono - Open Source Telephony
- *
  *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2023  Cruise, LLC
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
+ *  SPDX-License-Identifier: GPL-2.0-only
  */
 
 #ifdef HAVE_CONFIG_H
 #include <config.h>
 #endif
 
+#include <stdio.h>
 #include <stdlib.h>
+#include <getopt.h>
+#include <errno.h>
 
-#include <glib.h>
+#include <ell/ell.h>
 
 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/modem.h>
 #include <ofono/gprs-provision.h>
 
-#include "plugins/mbpi.h"
+#include "provisiondb.h"
 
-static void lookup_apn(const char *match_mcc, const char *match_mnc,
-						gboolean allow_duplicates)
-{
-	GSList *l;
-	GSList *apns;
-	GError *error = NULL;
+static const char *option_file = NULL;
 
-	g_print("Searching for info for network: %s%s\n", match_mcc, match_mnc);
+static int lookup_apn(const char *match_mcc, const char *match_mnc,
+							const char *match_spn)
+{
+	struct provision_db *pdb;
+	struct ofono_gprs_provision_data *contexts;
+	size_t n_contexts;
+	int r;
+	size_t i;
+
+	if (option_file) {
+		fprintf(stdout, "Opening database at: '%s'\n", option_file);
+		pdb = provision_db_new(option_file);
+	} else {
+		fprintf(stdout, "Opening database in default location\n");
+		pdb = provision_db_new_default();
+	}
 
-	apns = mbpi_lookup_apn(match_mcc, match_mnc, allow_duplicates, &error);
+	if (!pdb) {
+		fprintf(stdout, "Database opening failed\n");
+		return -EIO;
+	}
 
-	if (apns == NULL) {
-		if (error != NULL) {
-			g_printerr("Lookup failed: %s\n", error->message);
-			g_error_free(error);
-		}
+	fprintf(stdout, "Searching for info for network: %s%s, spn: %s\n",
+			match_mcc, match_mnc, match_spn ? match_spn : "<None>");
 
-		return;
+	r = provision_db_lookup(pdb, match_mcc, match_mnc, match_spn,
+					&contexts, &n_contexts);
+	if (r < 0) {
+		fprintf(stderr, "Unable to lookup: %s\n", strerror(-r));
+		return r;
 	}
 
-	for (l = apns; l; l = l->next) {
-		struct ofono_gprs_provision_data *ap = l->data;
+	for (i = 0; i < n_contexts; i++) {
+		struct ofono_gprs_provision_data *ap = contexts + i;
+
+		fprintf(stdout, "\nName: %s\n", ap->name);
+		fprintf(stdout, "APN: %s\n", ap->apn);
+		fprintf(stdout, "Type: %x\n", ap->type);
+		fprintf(stdout, "Proto: %x\n", ap->proto);
 
-		g_print("\n");
-		g_print("Name: %s\n", ap->name);
-		g_print("APN: %s\n", ap->apn);
-		g_print("Type: %s\n", mbpi_ap_type(ap->type));
-		g_print("Username: %s\n", ap->username);
-		g_print("Password: %s\n", ap->password);
+		if (ap->username)
+			fprintf(stdout, "Username: %s\n", ap->username);
 
-		mbpi_ap_free(ap);
+		if (ap->password)
+			fprintf(stdout, "Password: %s\n", ap->password);
+
+		if (ap->type & OFONO_GPRS_CONTEXT_TYPE_MMS) {
+			if (ap->message_proxy)
+				fprintf(stdout, "Message Proxy: %s\n",
+							ap->message_proxy);
+			fprintf(stdout, "Message Center: %s\n",
+							ap->message_center);
+		}
 	}
 
-	g_slist_free(apns);
+	l_free(contexts);
+
+	provision_db_free(pdb);
+
+	return 0;
 }
 
-static gboolean option_version = FALSE;
-static gboolean option_duplicates = FALSE;
+static void usage(void)
+{
+	printf("lookup-apn\nUsage:\n");
+	printf("lookup-apn [options] <mcc> <mnc> [spn]\n");
+	printf("Options:\n"
+			"\t-v, --version	Show version\n"
+			"\t-f, --file		Provision DB file to use\n"
+			"\t-h, --help		Show help options\n");
+}
 
-static GOptionEntry options[] = {
-	{ "version", 'v', 0, G_OPTION_ARG_NONE, &option_version,
-				"Show version information and exit" },
-	{ "allow-duplicates", 0, 0, G_OPTION_ARG_NONE, &option_duplicates,
-				"Allow duplicate access point types" },
-	{ NULL },
+static const struct option options[] = {
+	{ "version",	no_argument,		NULL, 'v' },
+	{ "help",	no_argument,		NULL, 'h' },
+	{ "file",	required_argument,	NULL, 'f' },
+	{ },
 };
 
 int main(int argc, char **argv)
 {
-	GOptionContext *context;
-	GError *error = NULL;
-
-	context = g_option_context_new(NULL);
-	g_option_context_add_main_entries(context, options, NULL);
-
-	if (g_option_context_parse(context, &argc, &argv, &error) == FALSE) {
-		if (error != NULL) {
-			g_printerr("%s\n", error->message);
-			g_error_free(error);
-		} else
-			g_printerr("An unknown error occurred\n");
-		exit(1);
+	for (;;) {
+		int opt = getopt_long(argc, argv, "f:vh", options, NULL);
+
+		if (opt < 0)
+			break;
+
+		switch (opt) {
+		case 'f':
+			option_file = optarg;
+			break;
+		case 'v':
+			printf("%s\n", VERSION);
+			return EXIT_SUCCESS;
+		case 'h':
+			usage();
+			return EXIT_SUCCESS;
+		default:
+			return EXIT_FAILURE;
+		}
 	}
 
-	g_option_context_free(context);
-
-	if (option_version == TRUE) {
-		g_print("%s\n", VERSION);
-		exit(0);
+	if (argc - optind > 3) {
+		fprintf(stderr, "Invalid command line parameters\n");
+		return EXIT_FAILURE;
 	}
 
-	if (argc < 2) {
-		g_printerr("Missing parameters\n");
-		exit(1);
+	if (argc - optind < 2) {
+		fprintf(stderr, "Missing MCC MNC parameters\n");
+		return EXIT_FAILURE;
 	}
 
-	lookup_apn(argv[1], argv[2], option_duplicates);
-
-	return 0;
+	return lookup_apn(argv[optind], argv[optind + 1],
+			argc - optind == 3 ? argv[optind + 2] : NULL);
 }
-- 
2.43.0

