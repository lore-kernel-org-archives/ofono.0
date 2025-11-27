Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D066B1E4AB
	for <ofono@lists.linux.dev>; Thu, 27 Nov 2025 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764265808; cv=none; b=to26I29r9jEJPm6k/6ZHmuD2PjpSmTSMhX4aPo6GXYOrMLsPym0j2teI+aDfEop+nsBQYAtY1TzErPJ7jwl4dGpFlR8M0jTirZJENX7QzykV39HQpAHMpDCdUYn/op5jTzooRg38X7WMqWE6ivxN9laT8iZ373dNbdc3T2aG72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764265808; c=relaxed/simple;
	bh=tWdjgfZ6PqcYuZFb+aZT2GRZslZgtHGgURZGu291XrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUHt8HaP7mAntQUGEtpNN3stLjI+jSa5X3WmwzU23Oqa2FBpNROpqOQLxA3aJvq0Ls7FosHttWagm9+lMQVU5AWSi7kDrQIl620hs9YuBQJqsXtnBwIWZ50EeRyT8fhnqFpJXOCaqI8XHpfoODP/FWba5VmXuHdSOCaiSE5DeJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=DRABvjD5; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="DRABvjD5"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=DRABvjD5B/mbb3wC3c1kw1nrA092m3zczT2FT7aFn8jvMioMpliDR88FxdywWUHe0smZRuj8oVEvu77cOBufSN9wxWuWd+vxUDTSRef9t1XzCutUSAjRX3+WHlo5ys0oeNjrLPiwAZ48ujhd+I3ZZwTa3QaLE/FHAzzUa1ebvVGPNqO1KqI2d+677s0UmnJKJrQxZ0hc1lbJQz5RoPOJyRKyHKz9VH3aEixcOLA5x0kYb4F51iytslehCkjWIQUAaIqEJqRboTPYEoqwdvpJ1pCuOOT217DZI7s8306FJWR+DPzulGHMKF0FqGoX8ffUKnNFqFBdpT4IuU26aCN69A==; s=purelymail2; d=purelymail.com; v=1; bh=tWdjgfZ6PqcYuZFb+aZT2GRZslZgtHGgURZGu291XrE=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 62202782;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 27 Nov 2025 17:50:03 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v5 02/10] plugins/udevng: Add support for PCIe MBIM modems * Parses through the sysfs tree and detects MBIM control nodes, net and   AT nodes
Date: Thu, 27 Nov 2025 22:49:36 +0500
Message-ID: <20251127174946.89981-3-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127174946.89981-1-thevancedgamer@mentallysanemainliners.org>
References: <20251127174946.89981-1-thevancedgamer@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

---
 plugins/udevng.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 18954d44..bae0be76 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1186,7 +1186,13 @@ static gboolean setup_mbim(struct modem_info *modem)
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
@@ -1206,6 +1212,56 @@ static gboolean setup_mbim(struct modem_info *modem)
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
+=09=09=09=09/* Parse all the subdirectories now */
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
2.52.0

