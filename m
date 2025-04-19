Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF98647
	for <ofono@lists.linux.dev>; Sat, 19 Apr 2025 13:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745068965; cv=none; b=h1AkGZgxPugvjTQFdsETHlEqt67UDJMPfiyT/XTu7q15g4xpEjQDydv/8m9YC+CRlbUjhylPMwz07ORueXS9xRnDRi0npOOPYL6vqEpmoT4ZHztKVSIg7g1FS7BcFt/xpYxLz9YllHo1rYUq9NY0WcZlWptn1slX6Kayh+xHP+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745068965; c=relaxed/simple;
	bh=M7a+uG01/mlaWaesnkfetWd7Aa5hkRuikVnzZJEFjlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWY/5O2TrkjvCgX/XrlNNC1OiBfpn1FBC5Ob2hz16EKUffhWjs+4HYN8d3GsdXbXRlVe5+THfLR5qrW8E80LL4UAbpDg37ir2S8cc+y9ir99isSOj6pd8damD/UtodZD20O4aV9Lu6/a4MbefGe3YfFeqpzHENxggBGs3ohSxwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=LT6APxh1; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="LT6APxh1"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=LT6APxh1DYwQu4Nmvr9+szZZJrA4W2/M37IAyPd1JwmyrRe1UuqaHY8rXdNmHZLTO+DjOvFvFeDSbuEZV8n4jPQcDJhdqdqrNNBen9cuiafRqXfxyKYQAS3OIAS9VqlNSKKZdKOXWZbWVe0dkOIzosv2bbB3Mixfv0UcktqMxA9Wv2+v+8Sz8Vka/NCmbPu88MjbGPF1pM7Zc1ZQF6k5hcWfYupLb9fhYggdWFqCDnr35evWktKqAj0ZO5+dklrdYmH0z+rPzMwwUBvtH2bO2MVzQfjWWVhwhicOfUYgR55g3DasDkSKQ9IWr+8FZocQ3Rh+4S4lw1nDqAI8sLMG7g==; s=purelymail3; d=purelymail.com; v=1; bh=M7a+uG01/mlaWaesnkfetWd7Aa5hkRuikVnzZJEFjlw=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1433134003;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 19 Apr 2025 13:22:28 +0000 (UTC)
From: Muhammad <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v1 1/4] plugins/udevng: Add support for PCIe MBIM modems * Parses through the sysfs tree and detects MBIM control nodes, net and   AT nodes
Date: Sat, 19 Apr 2025 18:22:12 +0500
Message-ID: <20250419132215.28887-2-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250419132215.28887-1-thevancedgamer@mentallysanemainliners.org>
References: <20250419132215.28887-1-thevancedgamer@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

Signed-off-by: Muhammad <thevancedgamer@mentallysanemainliners.org>
---
 plugins/udevng.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index b8df66de..1ba1a3a9 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1196,6 +1196,59 @@ static gboolean setup_mbim(struct modem_info *modem)
 =09=09else if (g_strcmp0(subsystem, "tty") =3D=3D 0) {
 =09=09=09if (g_strcmp0(info->number, "02") =3D=3D 0)
 =09=09=09=09atcmd =3D info->devnode;
+=09=09} else if (g_strcmp0(subsystem, "pci") =3D=3D 0) {
+=09=09=09char path[512];
+=09=09=09sprintf(path, "%s/wwan", udev_device_get_syspath(info->udev_devic=
e));
+
+=09=09=09DIR *d =3D opendir(path);
+=09=09=09struct dirent *dir;
+=09=09=09if (d) {
+=09=09=09=09struct udev *new_udev =3D udev_new();
+=09=09=09=09udev_ref(new_udev);
+
+=09=09=09=09while ((dir =3D readdir(d))) {
+=09=09=09=09=09if (g_strcmp0(dir->d_name, ".") =3D=3D 0 ||
+=09=09=09=09=09=09g_strcmp0(dir->d_name, "..") =3D=3D 0)
+=09=09=09=09=09=09continue;
+
+=09=09=09=09=09char wwan_path[1024];
+=09=09=09=09=09sprintf(wwan_path, "%s/%s", path, dir->d_name);
+
+=09=09=09=09=09struct udev_device *wwan_device =3D udev_device_new_from_sy=
spath(new_udev, wwan_path);
+=09=09=09=09=09net =3D udev_device_get_sysname(wwan_device);
+
+=09=09=09=09=09// Parse all the subdirectories now
+=09=09=09=09=09DIR *sd =3D opendir(wwan_path);
+=09=09=09=09=09struct dirent *subdir;
+=09=09=09=09=09while ((subdir =3D readdir(sd))) {
+=09=09=09=09=09=09if (subdir->d_type !=3D DT_DIR)
+=09=09=09=09=09=09=09continue;
+
+=09=09=09=09=09=09if (g_strcmp0(subdir->d_name, ".") =3D=3D 0 ||
+=09=09=09=09=09=09=09g_strcmp0(subdir->d_name, "..") =3D=3D 0)
+=09=09=09=09=09=09=09continue;
+
+=09=09=09=09=09=09char sub_path[2048];
+=09=09=09=09=09=09sprintf(sub_path, "%s/%s", wwan_path, subdir->d_name);
+
+=09=09=09=09=09=09struct udev_device *sub_device =3D udev_device_new_from_=
syspath(new_udev, sub_path);
+=09=09=09=09=09=09const char *sub_subsystem =3D udev_device_get_subsystem(=
sub_device);
+
+=09=09=09=09=09=09if (g_strcmp0(sub_subsystem, "wwan") =3D=3D 0) {
+=09=09=09=09=09=09=09const char *type =3D udev_device_get_sysattr_value(su=
b_device, "type");
+
+=09=09=09=09=09=09=09if (g_strcmp0(type, "MBIM") =3D=3D 0)
+=09=09=09=09=09=09=09=09ctl =3D udev_device_get_devnode(sub_device);
+=09=09=09=09=09=09=09else if (g_strcmp0(type, "AT") =3D=3D 0)
+=09=09=09=09=09=09=09=09atcmd =3D udev_device_get_devnode(sub_device);
+=09=09=09=09=09=09}
+=09=09=09=09=09}
+=09=09=09=09=09closedir(sd);
+=09=09=09=09=09break;
+=09=09=09=09}
+=09=09=09=09closedir(d);
+=09=09=09=09udev_unref(new_udev);
+=09=09=09}
 =09=09}
 =09}
=20
--=20
2.49.0

