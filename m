Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB752AF1D
	for <ofono@lists.linux.dev>; Fri, 26 Dec 2025 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766758456; cv=none; b=VOZmoS4/MZBIQmjs+blJEUqiDlDla893vLddZZUBZRIxsJNwPFQsZNCcaGrGYpYvAara1BkX5U2il6zz/7JMSm1JO6fGMiiHgN8GDOoYGuPksomcMRJUOj+HupFeDsR2jNWoEFz/K/VfLiTMSU6yt0KsizC5eU6BTf/lsI0btPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766758456; c=relaxed/simple;
	bh=GORmS9J4BHIkjXMyhdxqklx5fDJPC1oly6gidYlcIeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LSmIZyYOtTrfXV/1NRshfAbWbJJVIOw2mw6B7btO1O/zCMCu17kN1I8bEmVMCFd/Q96O08B0+ZiVCxm6ZVzMUMDxPhu7RZUsrfVSPuiU5hSRtq11SFkWG/ZrlA/z6VbTi9oAbhFj7KBYkaiMf+QaKB7CjfVyZn0XGBC2T4S9/Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=O0hQdDUt; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="O0hQdDUt"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=O0hQdDUtfPTWLezcQS8WK5FUtmcCZxRnYiCXBiC5IMfYJFpw4sRnvZv4b/bdwq9dN9Gof0i1ALIec4lrYf8m9xFIVoofgpPdOnJA/sHVwJd7Q+nTV6eL7+YKKu3xgL70cQBY0nXcxsOygKDTpbtPd+BSts7+1jrDdMKGx7tSEBGX8xeuy9cRrXBNwtQsVGe0jUC9QdOdTcVzMiJxcFgMYYOIdUUoHiGv4OB1hFNLhUWuYq/gF5vYCkvNTE2wTz+LhE0mEe0tWMyDTsPcQUDqCMeaNyNYn/ehoU7Id5BME5+A6ijh4Xhrg12DXnbRdDRIzIBEfyWz6l0hicbVrwJM3g==; s=purelymail3; d=purelymail.com; v=1; bh=GORmS9J4BHIkjXMyhdxqklx5fDJPC1oly6gidYlcIeY=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2072196880;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 26 Dec 2025 14:14:11 +0000 (UTC)
From: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
To: ofono@lists.linux.dev
Cc: Muhammad Asif <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v9 02/10] plugins/udevng: Add support for PCIe MBIM modems
Date: Fri, 26 Dec 2025 19:13:02 +0500
Message-ID: <20251226141310.41856-3-thevancedgamer@mentallysanemainliners.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251226141310.41856-1-thevancedgamer@mentallysanemainliners.org>
References: <20251226141310.41856-1-thevancedgamer@mentallysanemainliners.org>
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
 plugins/udevng.c | 118 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 114 insertions(+), 4 deletions(-)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 18954d44..1ce02525 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1182,6 +1182,110 @@ static gboolean setup_quectelqmi(struct modem_info =
*modem)
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
+=09/* Create a path to the WWAN subsystem with the sysfs path of the
+=09 * modem itself. e.g.: /devices/pci0000:00/0000:00:1c.0/0000:08:00.0
+=09 */
+=09path =3D g_build_path("/", udev_device_get_syspath(info->udev_device),
+=09=09=09=09=09=09=09"wwan", NULL);
+
+=09dir =3D g_dir_open(path, 0, NULL);
+=09if (!dir)
+=09=09goto cleanup;
+
+=09while ((filename =3D g_dir_read_name(dir))) {
+=09=09/* Build a path to the WWAN interface (e.g. .../wwan0).
+=09=09 * TODO: We currently assume only one WWAN interface per device.
+=09=09 * This will most likely break with multi-executor modems, but I hav=
e
+=09=09 * yet to see any of them available on the market.
+=09=09 */
+=09=09wwan_path =3D g_build_path("/", path,
+=09=09=09=09=09filename, NULL);
+
+=09=09/* Check if the WWAN interface even exists. */
+=09=09if (!g_file_test(wwan_path, G_FILE_TEST_IS_DIR)) {
+=09=09=09g_free((void *)wwan_path);
+=09=09=09continue;
+=09=09}
+
+=09=09subdir =3D g_dir_open(wwan_path, 0, NULL);
+=09=09if (!subdir) {
+=09=09=09g_free((void *)wwan_path);
+=09=09=09continue;
+=09=09}
+
+=09=09wwan_device =3D udev_device_new_from_syspath(udev,
+=09=09=09=09=09=09=09wwan_path);
+
+=09=09/* Only copy the WWAN interface name once */
+=09=09if (!*net)
+=09=09=09*net =3D g_strdup(udev_device_get_sysname(wwan_device));
+
+=09=09/* The WWAN directory will now have subdirectories, for each
+=09=09 * associated control node (e.g. wwan0mbim0, wwan0at0). Open
+=09=09 * each of the subdirectories to figure out their type.
+=09=09 */
+=09=09while ((subfile =3D g_dir_read_name(subdir))) {
+=09=09=09/* Build a path to the directory for each of the WWAN
+=09=09=09 * control nodes that we found earlier. (e.g. /wwan0/wwan0mbim0).
+=09=09=09 * Check if the subdirectory belongs to the WWAN subsystem,
+=09=09=09 * and if so, check its type (MBIM or AT).
+=09=09=09 */
+=09=09=09sub_path =3D g_build_filename("/", wwan_path,
+=09=09=09=09=09=09=09subfile, NULL);
+
+=09=09=09/* We only want the subdirectories for the control nodes. */
+=09=09=09if (!g_file_test(sub_path, G_FILE_TEST_IS_DIR)) {
+=09=09=09=09g_free((void *)sub_path);
+=09=09=09=09continue;
+=09=09=09}
+
+=09=09=09sub_device =3D udev_device_new_from_syspath(udev,
+=09=09=09=09=09=09=09=09sub_path);
+=09=09=09sub_subsystem =3D udev_device_get_subsystem(sub_device);
+
+=09=09=09/* We can only have one MBIM and AT node in each WWAN interface,
+=09=09=09 * so set them without checking if they're already set.
+=09=09=09 */
+=09=09=09if (g_strcmp0(sub_subsystem, "wwan") =3D=3D 0) {
+=09=09=09=09type =3D udev_device_get_sysattr_value(sub_device, "type");
+
+=09=09=09=09/* Detect the type of the WWAN control node */
+=09=09=09=09if (g_strcmp0(type, "MBIM") =3D=3D 0)
+=09=09=09=09=09*ctl =3D g_strdup(udev_device_get_devnode(sub_device));
+=09=09=09=09else if (g_strcmp0(type, "AT") =3D=3D 0)
+=09=09=09=09=09*atcmd =3D g_strdup(udev_device_get_devnode(sub_device));
+=09=09=09}
+
+=09=09=09udev_device_unref(sub_device);
+=09=09=09g_free((void *)sub_path);
+=09=09}
+=09=09g_dir_close(subdir);
+=09=09udev_device_unref(wwan_device);
+=09=09g_free((void *)wwan_path);
+=09}
+
+cleanup:
+=09if (dir)
+=09=09g_dir_close(dir);
+=09g_free((void *)path);
+=09udev_unref(udev);
+}
+
 static gboolean setup_mbim(struct modem_info *modem)
 {
 =09const char *ctl =3D NULL, *net =3D NULL, *atcmd =3D NULL;
@@ -1200,13 +1304,14 @@ static gboolean setup_mbim(struct modem_info *modem=
)
 =09=09=09=09=09=09info->sysattr, subsystem);
=20
 =09=09if (g_strcmp0(subsystem, "usbmisc") =3D=3D 0) /* cdc-wdm */
-=09=09=09ctl =3D info->devnode;
+=09=09=09ctl =3D g_strdup(info->devnode);
 =09=09else if (g_strcmp0(subsystem, "net") =3D=3D 0) /* wwan */
-=09=09=09net =3D get_ifname(info);
+=09=09=09net =3D g_strdup(get_ifname(info));
 =09=09else if (g_strcmp0(subsystem, "tty") =3D=3D 0) {
 =09=09=09if (g_strcmp0(info->number, "02") =3D=3D 0)
-=09=09=09=09atcmd =3D info->devnode;
-=09=09}
+=09=09=09=09atcmd =3D g_strdup(info->devnode);
+=09=09} else if (g_strcmp0(subsystem, "pci") =3D=3D 0)
+=09=09=09setup_mbim_pci(info, &ctl, &net, &atcmd);
 =09}
=20
 =09if (ctl =3D=3D NULL || net =3D=3D NULL)
@@ -1220,6 +1325,11 @@ static gboolean setup_mbim(struct modem_info *modem)
 =09ofono_modem_set_string(modem->modem, "NetworkInterface", net);
 =09ofono_modem_set_string(modem->modem, "DescriptorFile", descriptors);
=20
+=09/* Free up all of the strings */
+=09g_free((void *)ctl);
+=09g_free((void *)net);
+=09g_free((void *)atcmd);
+
 =09return TRUE;
 }
=20
--=20
2.52.0

