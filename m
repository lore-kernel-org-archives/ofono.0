Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C911B393C
	for <ofono@lists.linux.dev>; Fri,  2 May 2025 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212653; cv=none; b=ZW5+v6XTlMihR54knYzBmH7FXJncXq7VrZ2r2op6vxW4I41XjDxlJSKbmYui/bBYdcqAY1uyu9WNu7jOG7hcnF6nm7T8m4UqDA0UepkjXIt/cxfPr3Eo0/NX4K716pYpADQXpu0fctXEDqG9KkpbvuKadoYwqkoGePwNdq2TvWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212653; c=relaxed/simple;
	bh=QLyNyfRsq9ccfidBoZunEypOuknoV53eGMj0RdEeZ94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgiL20M3lDii0C/Md2g2X2ruHvSdyBQYOEypf9FEe6t6BYr2QgxqWoGceCX/yVqjgezckgFJ35yWYX4WkW+kpnPzw+gxi9t4Ww1rxy+vXbGyZYG1kw0Oxm3uNft4dJQd8ZEO6dkUFPf7TGMWgFmd9WmR3AfpX4/5R8u7gORJO8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=cVozjlcJ; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="cVozjlcJ"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=cVozjlcJQQe/W9oZJJdIJqnsz4EUK7PT58EU3/oKZewO7InztleFC3Bip282C93tH4Wla/9xHpFUBhDls2PB2T2Xgjz/YnZPMLDCrGxL/smmaj+m3EC31Hbezr6/4I9l8B/5wzrpbdRAwr6agTHI5J0eCzXzmWl4uONPqYeSE3XUz1jPORW9z4IxZbZoqlosD4ZINY7zL3sxXZfOfu0Kl6f3uFoV53RzpkpAfCJeSwfJcSqX6sTQ965P9/7TmsjIvS4smCZ6XVC0RI5Y9AnnhgT/y/KiDha00BSJqABaAoopI4snvYKNYW35NxVDYuqrOV90RuPC8WAmcClA6/nhtA==; s=purelymail2; d=purelymail.com; v=1; bh=QLyNyfRsq9ccfidBoZunEypOuknoV53eGMj0RdEeZ94=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1492705212;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 02 May 2025 19:03:50 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v3 1/5] plugins/udevng: Add support for PCIe MBIM modems Parses through the sysfs tree and detects MBIM control nodes, net and AT nodes
Date: Sat,  3 May 2025 00:03:14 +0500
Message-ID: <20250502190318.41366-2-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502190318.41366-1-thevancedgamer@mentallysanemainliners.org>
References: <20250502190318.41366-1-thevancedgamer@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

From: Muhammad <thevancedgamer@mentallysanemainliners.org>

---
 plugins/udevng.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index b8df66de..09c916db 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1176,7 +1176,13 @@ static gboolean setup_mbim(struct modem_info *modem)
 {
 =09const char *ctl =3D NULL, *net =3D NULL, *atcmd =3D NULL;
 =09GSList *list;
+=09const char *sub_subsystem =3D NULL, *type =3D NULL;
+=09char path[512], wwan_path[1024], sub_path[2048];
 =09char descriptors[PATH_MAX];
+=09struct udev *new_udev;
+=09struct udev_device *wwan_device, *sub_device;
+=09struct dirent *dir =3D NULL, *subdir =3D NULL;
+=09DIR *d =3D NULL, *sd =3D NULL;
=20
 =09DBG("%s [%s:%s]", modem->syspath, modem->vendor, modem->model);
=20
@@ -1196,6 +1202,56 @@ static gboolean setup_mbim(struct modem_info *modem)
 =09=09else if (g_strcmp0(subsystem, "tty") =3D=3D 0) {
 =09=09=09if (g_strcmp0(info->number, "02") =3D=3D 0)
 =09=09=09=09atcmd =3D info->devnode;
+=09=09} else if (g_strcmp0(subsystem, "pci") =3D=3D 0) {
+=09=09=09sprintf(path, "%s/wwan", udev_device_get_syspath(info->udev_devic=
e));
+
+=09=09=09d =3D opendir(path);
+=09=09=09if (!d)
+=09=09=09=09return FALSE;
+
+=09=09=09new_udev =3D udev_new();
+
+=09=09=09while ((dir =3D readdir(d))) {
+=09=09=09=09if (g_strcmp0(dir->d_name, ".") =3D=3D 0 ||
+=09=09=09=09=09g_strcmp0(dir->d_name, "..") =3D=3D 0)
+=09=09=09=09=09continue;
+
+=09=09=09=09sprintf(wwan_path, "%s/%s", path, dir->d_name);
+
+=09=09=09=09wwan_device =3D udev_device_new_from_syspath(new_udev,
+=09=09=09=09=09=09=09=09=09wwan_path);
+=09=09=09=09net =3D udev_device_get_sysname(wwan_device);
+
+=09=09=09=09// Parse all the subdirectories now
+=09=09=09=09sd =3D opendir(wwan_path);
+=09=09=09=09while ((subdir =3D readdir(sd))) {
+=09=09=09=09=09if (subdir->d_type !=3D DT_DIR)
+=09=09=09=09=09=09continue;
+
+=09=09=09=09=09if (g_strcmp0(subdir->d_name, ".") =3D=3D 0 ||
+=09=09=09=09=09=09g_strcmp0(subdir->d_name, "..") =3D=3D 0)
+=09=09=09=09=09=09continue;
+
+=09=09=09=09=09sprintf(sub_path, "%s/%s", wwan_path, subdir->d_name);
+
+=09=09=09=09=09sub_device =3D udev_device_new_from_syspath(new_udev,
+=09=09=09=09=09=09=09=09=09=09sub_path);
+=09=09=09=09=09sub_subsystem =3D udev_device_get_subsystem(sub_device);
+
+=09=09=09=09=09if (g_strcmp0(sub_subsystem, "wwan") =3D=3D 0) {
+=09=09=09=09=09=09type =3D udev_device_get_sysattr_value(sub_device, "type=
");
+
+=09=09=09=09=09=09if (g_strcmp0(type, "MBIM") =3D=3D 0)
+=09=09=09=09=09=09=09ctl =3D udev_device_get_devnode(sub_device);
+=09=09=09=09=09=09else if (g_strcmp0(type, "AT") =3D=3D 0)
+=09=09=09=09=09=09=09atcmd =3D udev_device_get_devnode(sub_device);
+=09=09=09=09=09}
+=09=09=09=09}
+=09=09=09=09closedir(sd);
+=09=09=09=09break;
+=09=09=09}
+=09=09=09closedir(d);
+=09=09=09udev_unref(new_udev);
 =09=09}
 =09}
=20
--=20
2.49.0

