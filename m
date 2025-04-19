Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601F128691
	for <ofono@lists.linux.dev>; Sat, 19 Apr 2025 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745068958; cv=none; b=MwTsP5KpbArVfXAVHSlG1Fx27OpHtkuqSTVMoUvRo9ZwXBA+1LC788UnsD1m77jeblIlRTIWYq1fNX5Fy+9xlmEEUGaG9WyFbzoxnGP/RiwvnngAx1kj2KJFVwIQyKzjv52ZiPbOHmEu+CTwn1NiWW5DNkpZcgOSwoghfu895A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745068958; c=relaxed/simple;
	bh=wS1zDMzVMi5VfDVMJbrAkn3zcmFohJezPCk5wBXZ1m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTnTb2tVdCuROKYpDtWGk33QgnL0gAdDLaE3jQz3ZBz/j+33r+SDyHeIN5AUwS95agJosxibtZceA52L7DkD+CV3gM9DqNwEATidOUzfW8oHcayYiHU1Epd78/2qe82FAMmdUUZUSTibXi8uuRc8xluwc1oyQ1NYcbhfb5tQMWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=SBVrLKsH; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="SBVrLKsH"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=SBVrLKsHkLN6loABknRa00s6UQ0Kc/T42yuV8FHahqDWkQoIhMLdEgBYYfhwxmyL+xFj3/KdZprIGYNgTxTcLX044MclZS4qXRVnh8xXGLrMI0bjwBG7wHT3JdKNXjgC6XmUe4dxr/0897zitM7xv8pugeurVpZVa3U9GQmhCXghIe3xq4MRqQl1doiXwCYXtmgt6QrfepBHBm82/fP+ofno78Gb5NG7Qr9Jh4R1XtGSxyY6GhE01/5F5g9517YT31ypPu5PMsRn5vuaiFy/u3AHFozx7UVpO8hBIBR+0My+O/5vZkscw76tjXuJKhfuQpy+aM+EvyMWyGCUrIA2Lw==; s=purelymail3; d=purelymail.com; v=1; bh=wS1zDMzVMi5VfDVMJbrAkn3zcmFohJezPCk5wBXZ1m0=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 68221:10037:null:purelymail
X-Pm-Original-To: ofono@lists.linux.dev
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1433134003;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 19 Apr 2025 13:22:33 +0000 (UTC)
From: Muhammad <thevancedgamer@mentallysanemainliners.org>
To: ofono <ofono@lists.linux.dev>
Cc: Muhammad <thevancedgamer@mentallysanemainliners.org>
Subject: [PATCH v1 3/4] mbim: fetch MBIM version on init
Date: Sat, 19 Apr 2025 18:22:14 +0500
Message-ID: <20250419132215.28887-4-thevancedgamer@mentallysanemainliners.org>
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

---
 plugins/mbim.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/mbim.c b/plugins/mbim.c
index e1d33f47..3a1942da 100644
--- a/plugins/mbim.c
+++ b/plugins/mbim.c
@@ -287,6 +287,8 @@ static int mbim_enable(struct ofono_modem *modem)
 =09=09=09=09=09mbim_device_closed, modem, NULL);
 =09mbim_device_set_debug(md->device, mbim_debug, "MBIM:", NULL);
=20
+=09mbim_device_get_version(md->device);
+
 =09return -EINPROGRESS;
 }
=20
--=20
2.49.0

