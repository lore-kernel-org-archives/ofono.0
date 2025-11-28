Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FF5332EA2
	for <ofono@lists.linux.dev>; Fri, 28 Nov 2025 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764351435; cv=none; b=eGdtl9xukjbclsdVyJoKkhV+RUy//RScXvg9uCWNU4yoI2Jg3qLuLhqy3PMXNgSkdc0xQNvhqFn+c5qnNDbsc6/B5Kjqu63Y0saPOm3LSaJdBq11ZY9mzJRdQ3dxemhcRoiQCd2jSx+7rlOvc2Wa1ZZv67x/GJoGRSskD/fC+Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764351435; c=relaxed/simple;
	bh=Pau/BlUZPB9s58F1Z/Wmd2XqQIaMgHpKbXShjCF1ucE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c7JfvYiL1QB1Zlpp5+xnpcC7p0BICTmCmJFWypf+dnIo5nzt6awDiMD3uooiiPW6HZpG1oq1+dbuRxCzWDO+ZxCPCmYlrZoscNmNb9HXhjkRqzim/ZIYoZkqZZBAUl6iPtjd+SHnMUszM9lXJQE5bOsgizw/Rf+rsT6Dj6jvXoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=RV7SEYih; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="RV7SEYih"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=RV7SEYiht98XBKJIncsQ4VuSYmiBH/ihH+RXR0TV344IVIDAH77cUycYdJMCViA9SkMgaT0dim92OesrvJ0kin6KS9u40SVX036DPuIldrVFEdlvqOMOd9lO1NVmFYaef7K/btvGSx6JW3DbDpLhI/lX6i7pR5QHUvMscA776y7r3PUpQrWWJkxrUr4p4Glnitmszu1k/3LzI9B5CkquSW/MpHKefvG0+G75g8q9S6tNye8uEHlOM7pC0X6r1ytjlYkKg9K5CVX5FY9Qf2MYXho3m3KTXrS1Q++7KqFzTzDv0I3zSGCYJDQWV6dOC+J0CQdE1QLgTJ0E/vo2zZ6U9w==; s=purelymail2; d=purelymail.com; v=1; bh=Pau/BlUZPB9s58F1Z/Wmd2XqQIaMgHpKbXShjCF1ucE=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1079628981;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 28 Nov 2025 17:37:10 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v7 02/10] plugins/udevng: Add support for PCIe MBIM modems
Date: Fri, 28 Nov 2025 22:36:48 +0500
Message-ID: <20251128173656.55692-3-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251128173656.55692-1-thevancedgamer@mentallysanemainliners.org>
References: <20251128173656.55692-1-thevancedgamer@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Parses through the sysfs tree and detects MBIM control nodes, net and
AT nodes
---
 plugins/udevng.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 18954d44..e779524c 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1182,6 +1182,80 @@ static gboolean setup_quectelqmi(struct modem_info *=
modem)
 =09return TRUE;
 }
=20
+static void setup_mbim_pci(struct device_info *info,
+=09=09=09=09const char **ctl,
+=09=09=09=09const char **net,
+=09=09=09=09const char **atcmd)
+{
+=09struct udev *udev =3D udev_new();
+=09struct udev_device *wwan_device, *sub_device;
+
+=09GDir *dir =3D NULL, *subdir =3D NULL;
+=09const gchar *filename =3D NULL, *subfile =3D NULL;
+=09gchar *path =3D NULL;
+=09gchar *wwan_path =3D NULL, *sub_path =3D NULL;
+=09const char *sub_subsystem =3D NULL;
+=09const char *type =3D NULL;
+
+=09/* Create a path to the WWAN subsystem in sysfs */
+=09path =3D g_build_path("/", udev_device_get_syspath(info->udev_device),
+=09=09=09=09=09=09=09"wwan", NULL);
+
+=09dir =3D g_dir_open(path, 0, NULL);
+=09if (!dir)
+=09=09goto cleanup;
+
+=09while ((filename =3D g_dir_read_name(dir))) {
+=09=09/* Build a path to the WWAN interface (e.g. wwan0) */
+=09=09wwan_path =3D g_build_path("/", path,
+=09=09=09=09=09=09=09filename, NULL);
+
+=09=09wwan_device =3D udev_device_new_from_syspath(udev,
+=09=09=09=09=09=09=09wwan_path);
+=09=09*net =3D g_strdup(udev_device_get_sysname(wwan_device));
+
+=09=09/* Parse all the subdirectories now */
+=09=09subdir =3D g_dir_open(wwan_path, 0, NULL);
+=09=09if (!g_file_test(wwan_path, G_FILE_TEST_IS_DIR) ||
+=09=09=09=09!subdir) {
+=09=09=09udev_device_unref(wwan_device);
+=09=09=09g_free(wwan_path);
+=09=09=09continue;
+=09=09}
+
+=09=09while ((subfile =3D g_dir_read_name(subdir))) {
+=09=09=09/* Build a path to the subsystems for the WWAN control nodes */
+=09=09=09sub_path =3D g_build_filename("/", wwan_path,
+=09=09=09=09=09=09=09=09=09subfile, NULL);
+
+=09=09=09sub_device =3D udev_device_new_from_syspath(udev,
+=09=09=09=09=09=09=09=09sub_path);
+=09=09=09sub_subsystem =3D udev_device_get_subsystem(sub_device);
+
+=09=09=09if (g_strcmp0(sub_subsystem, "wwan") =3D=3D 0) {
+=09=09=09=09type =3D udev_device_get_sysattr_value(sub_device, "type");
+
+=09=09=09=09/* Detect the subsystem of the subdirectories */
+=09=09=09=09if (g_strcmp0(type, "MBIM") =3D=3D 0)
+=09=09=09=09=09*ctl =3D g_strdup(udev_device_get_devnode(sub_device));
+=09=09=09=09else if (g_strcmp0(type, "AT") =3D=3D 0)
+=09=09=09=09=09*atcmd =3D g_strdup(udev_device_get_devnode(sub_device));
+=09=09=09}
+
+=09=09=09udev_device_unref(sub_device);
+=09=09=09g_free(sub_path);
+=09=09}
+=09=09g_dir_close(subdir);
+=09=09udev_device_unref(wwan_device);
+=09=09g_free(wwan_path);
+=09}
+
+cleanup:
+=09g_dir_close(dir);
+=09g_free(path);
+=09udev_unref(udev);
+}
+
 static gboolean setup_mbim(struct modem_info *modem)
 {
 =09const char *ctl =3D NULL, *net =3D NULL, *atcmd =3D NULL;
@@ -1206,7 +1280,8 @@ static gboolean setup_mbim(struct modem_info *modem)
 =09=09else if (g_strcmp0(subsystem, "tty") =3D=3D 0) {
 =09=09=09if (g_strcmp0(info->number, "02") =3D=3D 0)
 =09=09=09=09atcmd =3D info->devnode;
-=09=09}
+=09=09} else if (g_strcmp0(subsystem, "pci") =3D=3D 0)
+=09=09=09setup_mbim_pci(info, &ctl, &net, &atcmd);
 =09}
=20
 =09if (ctl =3D=3D NULL || net =3D=3D NULL)
--=20
2.52.0

