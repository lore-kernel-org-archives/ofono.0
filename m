Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218C71547E7
	for <ofono@lists.linux.dev>; Sun,  4 May 2025 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746386428; cv=none; b=S6ixNLqrzL1yqbwVNQEsHyZmg76LQhFb8mkAJwBbxiHOU3V9Blpu0i/zgOmyASvL0IMctV0QMCd51u2JjfdN5EfoXX2EksI5Ky+nQGwLLgs818tGjW6R7esJqaUv4M088co7d6SrgU3WyqQRs+eQt0gA7CxEwa28oPSZ2CrlHH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746386428; c=relaxed/simple;
	bh=AZaiN3egv7Bzd2H4HksrEUphPjCuR5Wkq8IFC6ISEpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhlguQALM3/285PpvXq2jAlKS39HbNNx9a3t6VJfkCY8/LD9WUhjl9+ckPZji2CenLkbkgMq3Keb9B8M9MO/xYiQk/IYc6YJe894fEqack1eSsW9YpehoXD4m4vb1YNsLmCyUT+pCJuVFLeA91uv8jwGCszeIZArBo+8aWER4YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=MRWJa87z; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="MRWJa87z"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=MRWJa87z2AulnSSGGfSAwAte13FkjXo5jDH2U70aAPuD6qOn0gP/3QqOGZk0LaTd0PqKdmzeUmEIhOwBZnb+B+eN9LvYoJKmvRNM122yxT5SGwJh11PRsl0oVEWFAnuUrP6xE7HfXB12q0Q+zCuYxVwKawvad4yQ8JHa/WdgIrhZD2HpkTAxupQb71zgowojhTdr+4wtXGgAn1sF1z+/vmdnt4zedLIDKrggXBS6qDNBDOZUXjuMcruVxeWBtejfnSYRjTXYAU7QMeXQ13XiY9lNPIX75EIgDCQjh/SNX1QsG1cZtSx3ftV9R5io6ZOD7u70VTZUND3os0hgREu87A==; s=purelymail2; d=purelymail.com; v=1; bh=AZaiN3egv7Bzd2H4HksrEUphPjCuR5Wkq8IFC6ISEpw=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1694754991;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 04 May 2025 19:20:17 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v4 1/6] plugins/udevng: Add support for PCIe MBIM modems * Parses through the sysfs tree and detects MBIM control nodes, net and   AT nodes
Date: Mon,  5 May 2025 00:19:26 +0500
Message-ID: <20250504191931.7078-2-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250504191931.7078-1-thevancedgamer@mentallysanemainliners.org>
References: <20250504191931.7078-1-thevancedgamer@mentallysanemainliners.org>
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

