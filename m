Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A97D1E4AA
	for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGUwGJtL"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7b3708b3eacso186439839f.2
        for <ofono@lists.linux.dev>; Tue, 19 Dec 2023 10:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703011281; x=1703616081; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBFFJb5dV7pYDAl4WXos0XWXN0kaTz7V6N1FRqevDY4=;
        b=EGUwGJtL4eokIhGeps9sc7EHPwygYWd5pHsKh5Gwg0fI6tmFUd5mugRajSf7RqAZyH
         FETwCoRiWrp7GsN+rEu6UDmwpPNNEgaF/ONEQLU4cnChize3h7/+nDcOLYNDiDXV3Nwz
         N/S1nSQB/FnYxyUyrfpSCImRKXKwm/7PQzI13MJgQc8FynqGK1CyOB8zzuxydwysf3hP
         pUPXfI4rWPgqjVQJUhS5u1vPcujpPLgS5yTWGgzlq2F1Gvo/gGFALdA8gQFXqFGfa8eR
         qqWN+LpXi4kEYxmxoJpkP5so1610fU9LupdxAEZLGrxrDWRQ6w4n3FCrIjSI8Rk9Ro9Y
         NWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703011281; x=1703616081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBFFJb5dV7pYDAl4WXos0XWXN0kaTz7V6N1FRqevDY4=;
        b=HXZuULpRt06pCNiu45zFhfeKrSDq4fXRJnzlSEv39iHwHO+oBJkTtEebzi4Kczfjfi
         Su+XiLGWapMl9jMjGqMt5c443jncDfTiXUl6p/ibNTkuqVkhYD142Cst2RWpQULpTLa4
         8YMpqmZSKryJWN7z8mLwBneHtpjxGsjDwjAB4tqajuxN3+s3HHfs6jdBKqg3+ZOyqqPt
         kKNMxI/IqAs9jWL5HN7CCwlIkEojeAcEtRjo3BCQMgxjbOenFn3dUvly9FI23HDWfclO
         5dARnKP2ssbcDCV9v3mjpphhVz2sRVp7GrLvVmexhy0yUQuNC4pyix5JCn4cT9C8m52G
         E2Qw==
X-Gm-Message-State: AOJu0Ywz4b2qa4tGq8BrkK/JKheHoyRN9YmoA4GlchpLznJnju7Dqs1k
	lOw5WyOnjptC0lUvOhcYpJ9HhyTOZA8=
X-Google-Smtp-Source: AGHT+IFFv37huI8oG9Q0JnFQRKsGyM5RQe5J8k+5rmS/0l4f3cY+hfZwLQr79i39DFLCEUynaVmCeQ==
X-Received: by 2002:a6b:c9c2:0:b0:7b7:fb0f:ee13 with SMTP id z185-20020a6bc9c2000000b007b7fb0fee13mr872661iof.27.1703011281150;
        Tue, 19 Dec 2023 10:41:21 -0800 (PST)
Received: from localhost.localdomain ([136.33.23.24])
        by smtp.gmail.com with ESMTPSA id co13-20020a0566383e0d00b0046b406d9d95sm1549213jab.38.2023.12.19.10.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:41:20 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 12/15] plugins: provision: Remove mbpi support
Date: Tue, 19 Dec 2023 12:37:09 -0600
Message-ID: <20231219184016.420116-12-denkenz@gmail.com>
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

This is now completely superceded by the provisiondb infrastructure.
---
 Makefile.am         |   7 -
 configure.ac        |  24 ---
 plugins/mbpi.c      | 506 --------------------------------------------
 plugins/mbpi.h      |  27 ---
 plugins/provision.c | 118 -----------
 5 files changed, 682 deletions(-)
 delete mode 100644 plugins/mbpi.c
 delete mode 100644 plugins/mbpi.h
 delete mode 100644 plugins/provision.c

diff --git a/Makefile.am b/Makefile.am
index a7404121..447f2466 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -653,13 +653,6 @@ builtin_sources += plugins/upower.c
 endif
 endif
 
-if PROVISION
-builtin_sources += plugins/mbpi.h plugins/mbpi.c
-
-builtin_modules += provision
-builtin_sources += plugins/provision.c
-endif
-
 if MAINTAINER_MODE
 builtin_modules += example_history
 builtin_sources += examples/history.c
diff --git a/configure.ac b/configure.ac
index 626055ad..d48235b6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -239,30 +239,6 @@ fi
 AM_CONDITIONAL(BLUEZ4, test "${enable_bluetooth}" != "no" && test "${enable_bluez4}" = "yes")
 AM_CONDITIONAL(BLUETOOTH, test "${enable_bluetooth}" != "no")
 
-AC_ARG_WITH([provisiondb], AS_HELP_STRING([--with-provisiondb=FILE],
-	[location of provision database]), [path_provisiondb=${withval}])
-
-AC_ARG_ENABLE(provision, AS_HELP_STRING([--disable-provision],
-				[disable provisioning support]),
-					[enable_provision=${enableval}])
-if (test "${enable_provision}" != "no"); then
-	if (test -n "${path_provisiondb}"); then
-		AC_DEFINE_UNQUOTED(PROVIDER_DATABASE, "${path_provisiondb}",
-						[Mobile provider database])
-	else
-		AC_MSG_CHECKING([for mobile-broadband-provider-info])
-		PKG_CHECK_EXISTS(mobile-broadband-provider-info,
-			_PKG_CONFIG(PROVIDER_DATABASE, [variable=database],
-					[mobile-broadband-provider-info])
-			AC_DEFINE_UNQUOTED(PROVIDER_DATABASE,
-						"$pkg_cv_PROVIDER_DATABASE",
-						[Mobile provider database])
-			AC_MSG_RESULT([yes]),
-			AC_MSG_ERROR(Mobile broadband provider database is required))
-	fi
-fi
-AM_CONDITIONAL(PROVISION, test "${enable_provision}" != "no")
-
 AC_ARG_ENABLE(upower, AS_HELP_STRING([--disable-upower],
 			[disable UPower plugin]),
 					[enable_upower=${enableval}])
diff --git a/plugins/mbpi.c b/plugins/mbpi.c
deleted file mode 100644
index d91f8e07..00000000
--- a/plugins/mbpi.c
+++ /dev/null
@@ -1,506 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
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
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <string.h>
-#include <fcntl.h>
-#include <sys/mman.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <unistd.h>
-
-#include <glib.h>
-
-#define OFONO_API_SUBJECT_TO_CHANGE
-#include <ofono/modem.h>
-#include <ofono/gprs-provision.h>
-
-#ifndef MBPI_DATABASE
-#define MBPI_DATABASE  "/usr/share/mobile-broadband-provider-info/" \
-							"serviceproviders.xml"
-#endif
-
-#include "mbpi.h"
-
-#define _(x) case x: return (#x)
-
-enum MBPI_ERROR {
-	MBPI_ERROR_DUPLICATE,
-};
-
-struct gsm_data {
-	const char *match_mcc;
-	const char *match_mnc;
-	GSList *apns;
-	gboolean match_found;
-	gboolean allow_duplicates;
-};
-
-const char *mbpi_ap_type(enum ofono_gprs_context_type type)
-{
-	switch (type) {
-		_(OFONO_GPRS_CONTEXT_TYPE_ANY);
-		_(OFONO_GPRS_CONTEXT_TYPE_INTERNET);
-		_(OFONO_GPRS_CONTEXT_TYPE_MMS);
-		_(OFONO_GPRS_CONTEXT_TYPE_WAP);
-		_(OFONO_GPRS_CONTEXT_TYPE_IMS);
-	}
-
-	return "OFONO_GPRS_CONTEXT_TYPE_<UNKNOWN>";
-}
-
-static GQuark mbpi_error_quark(void)
-{
-	return g_quark_from_static_string("ofono-mbpi-error-quark");
-}
-
-void mbpi_ap_free(struct ofono_gprs_provision_data *ap)
-{
-	g_free(ap->name);
-	g_free(ap->apn);
-	g_free(ap->username);
-	g_free(ap->password);
-	g_free(ap->message_proxy);
-	g_free(ap->message_center);
-
-	g_free(ap);
-}
-
-static void mbpi_g_set_error(GMarkupParseContext *context, GError **error,
-				GQuark domain, gint code, const gchar *fmt, ...)
-{
-	va_list ap;
-	gint line_number, char_number;
-
-	g_markup_parse_context_get_position(context, &line_number,
-						&char_number);
-	va_start(ap, fmt);
-
-	*error = g_error_new_valist(domain, code, fmt, ap);
-
-	va_end(ap);
-
-	g_prefix_error(error, "%s:%d ", MBPI_DATABASE, line_number);
-}
-
-static void text_handler(GMarkupParseContext *context,
-				const gchar *text, gsize text_len,
-				gpointer userdata, GError **error)
-{
-	char **string = userdata;
-
-	*string = g_strndup(text, text_len);
-}
-
-static const GMarkupParser text_parser = {
-	NULL,
-	NULL,
-	text_handler,
-	NULL,
-	NULL,
-};
-
-static void authentication_start(GMarkupParseContext *context,
-			const gchar **attribute_names,
-			const gchar **attribute_values,
-			enum ofono_gprs_auth_method *auth_method,
-			GError **error)
-{
-	const char *text = NULL;
-	int i;
-
-	for (i = 0; attribute_names[i]; i++)
-		if (g_str_equal(attribute_names[i], "method") == TRUE)
-			text = attribute_values[i];
-
-	if (text == NULL) {
-		mbpi_g_set_error(context, error, G_MARKUP_ERROR,
-					G_MARKUP_ERROR_MISSING_ATTRIBUTE,
-					"Missing attribute: method");
-		return;
-	}
-
-	if (strcmp(text, "chap") == 0)
-		*auth_method = OFONO_GPRS_AUTH_METHOD_CHAP;
-	else if (strcmp(text, "pap") == 0)
-		*auth_method = OFONO_GPRS_AUTH_METHOD_PAP;
-	else
-		mbpi_g_set_error(context, error, G_MARKUP_ERROR,
-					G_MARKUP_ERROR_UNKNOWN_ATTRIBUTE,
-					"Unknown authentication method: %s",
-					text);
-}
-
-static void usage_start(GMarkupParseContext *context,
-			const gchar **attribute_names,
-			const gchar **attribute_values,
-			enum ofono_gprs_context_type *type, GError **error)
-{
-	const char *text = NULL;
-	int i;
-
-	for (i = 0; attribute_names[i]; i++)
-		if (g_str_equal(attribute_names[i], "type") == TRUE)
-			text = attribute_values[i];
-
-	if (text == NULL) {
-		mbpi_g_set_error(context, error, G_MARKUP_ERROR,
-					G_MARKUP_ERROR_MISSING_ATTRIBUTE,
-					"Missing attribute: type");
-		return;
-	}
-
-	if (strcmp(text, "internet") == 0)
-		*type = OFONO_GPRS_CONTEXT_TYPE_INTERNET;
-	else if (strcmp(text, "mms") == 0)
-		*type = OFONO_GPRS_CONTEXT_TYPE_MMS;
-	else if (strcmp(text, "wap") == 0)
-		*type = OFONO_GPRS_CONTEXT_TYPE_WAP;
-	else if (strcmp(text, "mms-internet-hipri-fota") == 0)
-		*type = OFONO_GPRS_CONTEXT_TYPE_INTERNET;
-	else if (strcmp(text, "mms-internet-hipri") == 0)
-		*type = OFONO_GPRS_CONTEXT_TYPE_INTERNET;
-	else
-		mbpi_g_set_error(context, error, G_MARKUP_ERROR,
-					G_MARKUP_ERROR_UNKNOWN_ATTRIBUTE,
-					"Unknown usage attribute: %s", text);
-}
-
-static void apn_start(GMarkupParseContext *context, const gchar *element_name,
-			const gchar **attribute_names,
-			const gchar **attribute_values,
-			gpointer userdata, GError **error)
-{
-	struct ofono_gprs_provision_data *apn = userdata;
-
-	if (g_str_equal(element_name, "name"))
-		g_markup_parse_context_push(context, &text_parser, &apn->name);
-	else if (g_str_equal(element_name, "username"))
-		g_markup_parse_context_push(context, &text_parser,
-						&apn->username);
-	else if (g_str_equal(element_name, "password"))
-		g_markup_parse_context_push(context, &text_parser,
-						&apn->password);
-	else if (g_str_equal(element_name, "authentication"))
-		authentication_start(context, attribute_names,
-				attribute_values, &apn->auth_method, error);
-	else if (g_str_equal(element_name, "mmsc"))
-		g_markup_parse_context_push(context, &text_parser,
-						&apn->message_center);
-	else if (g_str_equal(element_name, "mmsproxy"))
-		g_markup_parse_context_push(context, &text_parser,
-						&apn->message_proxy);
-	else if (g_str_equal(element_name, "usage"))
-		usage_start(context, attribute_names, attribute_values,
-				&apn->type, error);
-}
-
-static void apn_end(GMarkupParseContext *context, const gchar *element_name,
-			gpointer userdata, GError **error)
-{
-	if (g_str_equal(element_name, "name") ||
-			g_str_equal(element_name, "username") ||
-			g_str_equal(element_name, "password") ||
-			g_str_equal(element_name, "mmsc") ||
-			g_str_equal(element_name, "mmsproxy"))
-		g_markup_parse_context_pop(context);
-}
-
-static void apn_error(GMarkupParseContext *context, GError *error,
-			gpointer userdata)
-{
-	/*
-	 * Note that even if the error happened in a subparser, this will
-	 * be called.  So we always perform cleanup of the allocated
-	 * provision data
-	 */
-	mbpi_ap_free(userdata);
-}
-
-static const GMarkupParser apn_parser = {
-	apn_start,
-	apn_end,
-	NULL,
-	NULL,
-	apn_error,
-};
-
-static const GMarkupParser skip_parser = {
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-};
-
-static void network_id_handler(GMarkupParseContext *context,
-				struct gsm_data *gsm,
-				const gchar **attribute_names,
-				const gchar **attribute_values,
-				GError **error)
-{
-	const char *mcc = NULL, *mnc = NULL;
-	int i;
-
-	for (i = 0; attribute_names[i]; i++) {
-		if (g_str_equal(attribute_names[i], "mcc") == TRUE)
-			mcc = attribute_values[i];
-		if (g_str_equal(attribute_names[i], "mnc") == TRUE)
-			mnc = attribute_values[i];
-	}
-
-	if (mcc == NULL) {
-		mbpi_g_set_error(context, error, G_MARKUP_ERROR,
-					G_MARKUP_ERROR_MISSING_ATTRIBUTE,
-					"Missing attribute: mcc");
-		return;
-	}
-
-	if (mnc == NULL) {
-		mbpi_g_set_error(context, error, G_MARKUP_ERROR,
-					G_MARKUP_ERROR_MISSING_ATTRIBUTE,
-					"Missing attribute: mnc");
-		return;
-	}
-
-	if (g_str_equal(mcc, gsm->match_mcc) &&
-			g_str_equal(mnc, gsm->match_mnc))
-		gsm->match_found = TRUE;
-}
-
-static void apn_handler(GMarkupParseContext *context, struct gsm_data *gsm,
-			const gchar **attribute_names,
-			const gchar **attribute_values,
-			GError **error)
-{
-	struct ofono_gprs_provision_data *ap;
-	const char *apn;
-	int i;
-
-	if (gsm->match_found == FALSE) {
-		g_markup_parse_context_push(context, &skip_parser, NULL);
-		return;
-	}
-
-	for (i = 0, apn = NULL; attribute_names[i]; i++) {
-		if (g_str_equal(attribute_names[i], "value") == FALSE)
-			continue;
-
-		apn = attribute_values[i];
-		break;
-	}
-
-	if (apn == NULL) {
-		mbpi_g_set_error(context, error, G_MARKUP_ERROR,
-					G_MARKUP_ERROR_MISSING_ATTRIBUTE,
-					"APN attribute missing");
-		return;
-	}
-
-	ap = g_new0(struct ofono_gprs_provision_data, 1);
-	ap->apn = g_strdup(apn);
-	ap->type = OFONO_GPRS_CONTEXT_TYPE_INTERNET;
-	ap->proto = OFONO_GPRS_PROTO_IP;
-	ap->auth_method = OFONO_GPRS_AUTH_METHOD_CHAP;
-
-	g_markup_parse_context_push(context, &apn_parser, ap);
-}
-
-static void gsm_start(GMarkupParseContext *context, const gchar *element_name,
-			const gchar **attribute_names,
-			const gchar **attribute_values,
-			gpointer userdata, GError **error)
-{
-	if (g_str_equal(element_name, "network-id")) {
-		struct gsm_data *gsm = userdata;
-
-		/*
-		 * For entries with multiple network-id elements, don't bother
-		 * searching if we already have a match
-		 */
-		if (gsm->match_found == TRUE)
-			return;
-
-		network_id_handler(context, userdata, attribute_names,
-					attribute_values, error);
-	} else if (g_str_equal(element_name, "apn"))
-		apn_handler(context, userdata, attribute_names,
-				attribute_values, error);
-}
-
-static void gsm_end(GMarkupParseContext *context, const gchar *element_name,
-			gpointer userdata, GError **error)
-{
-	struct gsm_data *gsm;
-	struct ofono_gprs_provision_data *ap;
-
-	if (!g_str_equal(element_name, "apn"))
-		return;
-
-	gsm = userdata;
-
-	ap = g_markup_parse_context_pop(context);
-	if (ap == NULL)
-		return;
-
-	/* select authentication method NONE if others cannot be used */
-	if (!ap->username || (!ap->username && !ap->password))
-		ap->auth_method = OFONO_GPRS_AUTH_METHOD_NONE;
-
-	if (gsm->allow_duplicates == FALSE) {
-		GSList *l;
-
-		for (l = gsm->apns; l; l = l->next) {
-			struct ofono_gprs_provision_data *pd = l->data;
-
-			if (pd->type != ap->type)
-				continue;
-
-			mbpi_g_set_error(context, error, mbpi_error_quark(),
-						MBPI_ERROR_DUPLICATE,
-						"Duplicate context detected");
-
-			mbpi_ap_free(ap);
-			return;
-		}
-	}
-
-	gsm->apns = g_slist_append(gsm->apns, ap);
-}
-
-static const GMarkupParser gsm_parser = {
-	gsm_start,
-	gsm_end,
-	NULL,
-	NULL,
-	NULL,
-};
-
-static void toplevel_gsm_start(GMarkupParseContext *context,
-					const gchar *element_name,
-					const gchar **atribute_names,
-					const gchar **attribute_values,
-					gpointer userdata, GError **error)
-{
-	struct gsm_data *gsm = userdata;
-
-	if (g_str_equal(element_name, "gsm")) {
-		gsm->match_found = FALSE;
-		g_markup_parse_context_push(context, &gsm_parser, gsm);
-	} else if (g_str_equal(element_name, "cdma"))
-		g_markup_parse_context_push(context, &skip_parser, NULL);
-}
-
-static void toplevel_gsm_end(GMarkupParseContext *context,
-					const gchar *element_name,
-					gpointer userdata, GError **error)
-{
-	if (g_str_equal(element_name, "gsm") ||
-			g_str_equal(element_name, "cdma"))
-		g_markup_parse_context_pop(context);
-}
-
-static const GMarkupParser toplevel_gsm_parser = {
-	toplevel_gsm_start,
-	toplevel_gsm_end,
-	NULL,
-	NULL,
-	NULL,
-};
-
-static gboolean mbpi_parse(const GMarkupParser *parser, gpointer userdata,
-				GError **error)
-{
-	struct stat st;
-	char *db;
-	int fd;
-	GMarkupParseContext *context;
-	gboolean ret;
-
-	fd = open(MBPI_DATABASE, O_RDONLY);
-	if (fd < 0) {
-		g_set_error(error, G_FILE_ERROR,
-				g_file_error_from_errno(errno),
-				"open(%s) failed: %s", MBPI_DATABASE,
-				g_strerror(errno));
-		return FALSE;
-	}
-
-	if (fstat(fd, &st) < 0) {
-		close(fd);
-		g_set_error(error, G_FILE_ERROR,
-				g_file_error_from_errno(errno),
-				"fstat(%s) failed: %s", MBPI_DATABASE,
-				g_strerror(errno));
-		return FALSE;
-	}
-
-	db = mmap(NULL, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
-	if (db == MAP_FAILED) {
-		close(fd);
-		g_set_error(error, G_FILE_ERROR,
-				g_file_error_from_errno(errno),
-				"mmap(%s) failed: %s", MBPI_DATABASE,
-				g_strerror(errno));
-		return FALSE;
-	}
-
-	context = g_markup_parse_context_new(parser,
-						G_MARKUP_TREAT_CDATA_AS_TEXT,
-						userdata, NULL);
-
-	ret = g_markup_parse_context_parse(context, db, st.st_size, error);
-
-	if (ret == TRUE)
-		g_markup_parse_context_end_parse(context, error);
-
-	munmap(db, st.st_size);
-	close(fd);
-	g_markup_parse_context_free(context);
-
-	return ret;
-}
-
-GSList *mbpi_lookup_apn(const char *mcc, const char *mnc,
-			gboolean allow_duplicates, GError **error)
-{
-	struct gsm_data gsm;
-	GSList *l;
-
-	memset(&gsm, 0, sizeof(gsm));
-	gsm.match_mcc = mcc;
-	gsm.match_mnc = mnc;
-	gsm.allow_duplicates = allow_duplicates;
-
-	if (mbpi_parse(&toplevel_gsm_parser, &gsm, error) == FALSE) {
-		for (l = gsm.apns; l; l = l->next)
-			mbpi_ap_free(l->data);
-
-		g_slist_free(gsm.apns);
-		gsm.apns = NULL;
-	}
-
-	return gsm.apns;
-}
diff --git a/plugins/mbpi.h b/plugins/mbpi.h
deleted file mode 100644
index 6d343584..00000000
--- a/plugins/mbpi.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
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
- */
-
-const char *mbpi_ap_type(enum ofono_gprs_context_type type);
-
-void mbpi_ap_free(struct ofono_gprs_provision_data *data);
-
-GSList *mbpi_lookup_apn(const char *mcc, const char *mnc,
-			gboolean allow_duplicates, GError **error);
diff --git a/plugins/provision.c b/plugins/provision.c
deleted file mode 100644
index 99c299eb..00000000
--- a/plugins/provision.c
+++ /dev/null
@@ -1,118 +0,0 @@
-/*
- *
- *  oFono - Open Source Telephony
- *
- *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
- *
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
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <errno.h>
-#include <string.h>
-
-#include <glib.h>
-
-#define OFONO_API_SUBJECT_TO_CHANGE
-#include <ofono/types.h>
-#include <ofono/log.h>
-#include <ofono/plugin.h>
-#include <ofono/modem.h>
-#include <ofono/gprs-provision.h>
-
-#include "mbpi.h"
-
-static int provision_get_settings(const char *mcc, const char *mnc,
-				const char *spn,
-				struct ofono_gprs_provision_data **settings,
-				int *count)
-{
-	GSList *l;
-	GSList *apns;
-	GError *error = NULL;
-	int ap_count;
-	int i;
-
-	DBG("Provisioning for MCC %s, MNC %s, SPN '%s'", mcc, mnc, spn);
-
-	apns = mbpi_lookup_apn(mcc, mnc, FALSE, &error);
-	if (apns == NULL) {
-		if (error != NULL) {
-			ofono_error("%s", error->message);
-			g_error_free(error);
-		}
-
-		return -ENOENT;
-	}
-
-	ap_count = g_slist_length(apns);
-
-	DBG("Found %d APs", ap_count);
-
-	*settings = g_try_new0(struct ofono_gprs_provision_data, ap_count);
-	if (*settings == NULL) {
-		ofono_error("Provisioning failed: %s", g_strerror(errno));
-
-		for (l = apns; l; l = l->next)
-			mbpi_ap_free(l->data);
-
-		g_slist_free(apns);
-
-		return -ENOMEM;
-	}
-
-	*count = ap_count;
-
-	for (l = apns, i = 0; l; l = l->next, i++) {
-		struct ofono_gprs_provision_data *ap = l->data;
-
-		DBG("Name: '%s'", ap->name);
-		DBG("APN: '%s'", ap->apn);
-		DBG("Type: %s", mbpi_ap_type(ap->type));
-		DBG("Username: '%s'", ap->username);
-		DBG("Password: '%s'", ap->password);
-
-		memcpy(*settings + i, ap,
-			sizeof(struct ofono_gprs_provision_data));
-
-		g_free(ap);
-	}
-
-	g_slist_free(apns);
-
-	return 0;
-}
-
-static struct ofono_gprs_provision_driver provision_driver = {
-	.name		= "Provisioning",
-	.get_settings	= provision_get_settings
-};
-
-static int provision_init(void)
-{
-	return ofono_gprs_provision_driver_register(&provision_driver);
-}
-
-static void provision_exit(void)
-{
-	ofono_gprs_provision_driver_unregister(&provision_driver);
-}
-
-OFONO_PLUGIN_DEFINE(provision, "Provisioning Plugin", VERSION,
-			OFONO_PLUGIN_PRIORITY_DEFAULT,
-			provision_init, provision_exit)
-- 
2.43.0

