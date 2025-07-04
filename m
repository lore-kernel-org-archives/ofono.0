Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F28298CA4
	for <ofono@lists.linux.dev>; Fri,  4 Jul 2025 12:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751631809; cv=none; b=F6ZJYjlRpMs4l7OzNCwAXJHKlKuIYLfAruDaKJ0Kbq6JW1gtYWZddOG39zXMulklq5t2E8oAn51qLwT0nBSrfn03XZWAvk5srsyemw9rBBzAU2hoDy38PxKpa2TP6qj2nJs3dHi1VYBvc7wCd1zNzVVzTF2KpzZu4Tpae46XwKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751631809; c=relaxed/simple;
	bh=cDji5qPWZz/FHEFG9N6NgANzOVE9x8On7mlPFkNK9Gg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=L7J0dDNzvMLTIQnyPf/QI4u9xJE64xj6/3tj0bCAh/80S799XTgEhOKbcERgdAyviUQbXbReMLdSOATzgsDqNo19W2c0LIk5p2+o12NJkU7tKbsovsCsyw42poznDk4QIXCp16ADycgJSujBA7Hl77CwMW4+bD1oCSiiRbjcmFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=A73M3TCi; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="A73M3TCi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1751631796; x=1751890996;
	bh=PyabDcJrwWLabOS8rs4jND0YILZ8W7A8zW2C1TSd3IE=;
	h=From:Subject:Date:Message-Id:To:From:To:Cc:Date:Subject:Reply-To:
	 Feedback-ID:Message-ID:BIMI-Selector;
	b=A73M3TCiT405pn55Bt4jTrNAkZeD1GeEnqu6eUipcZJTVF09HQWBJ8P+J0foPMyB9
	 oap8ho9yBH5Y4S/Eao4BB6yBt3qI5ZBzWmfcZOm8aGoAoVixAB5k6S7tzOD9GpHmY7
	 +X/pTJyZbPeJJEoN1KaTO6fuFGrE/R4+AY3t4UV/ZJxss8jyoj0Hlw6Hs00Cq8BMyH
	 5pVvdi5whFwndi9BGt4sG/Va0i3s9PVK+208QYrNHzQyUQeh839eOQph0op5MhTkEp
	 lLmyxXByLPSOLhiFsmQoVkvVwuqlzALLzBub7EHRuzjXY0PUSaD83Sow1nDWnKVuPz
	 9mieUhuvMGgZg==
X-Pm-Submission-Id: 4bYXpq6vzzzP2
From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v3 0/3] Clear forbidden operator list via SimManager
Date: Fri, 04 Jul 2025 14:23:12 +0200
Message-Id: <20250704-fplmn-v3-0-dbba340d6cfa@geanix.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALDHZ2gC/1WMyw6CMBQFf4V0bU0f0oIr/8O4uC0XaCKFtKbBE
 P7dgprock7OzEIiBoeRnIuFBEwuutFnkIeC2B58h9Q1mYlgomRKKNpO98FTY41EgMoAnEj+TgF
 bN++d6y1z7+JjDM89m/i2vgua8U8hccpoo1usbc24KfWlQ/BuPtpxIFsiiV9NfjWRNYVGSVmCN
 pX909Z1fQHByur70gAAAA==
X-Change-ID: 20250626-fplmn-bcb3eaa8baa4
To: denkenz@gmail.com, ofono@lists.linux.dev
X-Mailer: b4 0.14.2

IoT providers allow for enabling and disabling of operators.
If the modem have detected an forbiddel operator it will block
connections to that network.
This will allow controlling software to clear that list.
(Our IoT provider recommends to clear the list everytime we power off
the modem).

Clear:
$ busctl call org.ofono /sim76xx_0 org.ofono.SimManager
ClearForbiddenNetworkOperators

---
Changes in v3:
- Add check for the FPLMN list length, and clear the whole list.
- Check if write_file_transparent() is implemented.
- Remove unused variables.
- Link to v2: https://lore.kernel.org/r/20250703-fplmn-v2-0-6eb6335a7b8c@geanix.com

Changes in v2:
- Created new method in SimManager called ClearForbiddenNetworkOperators
- Scrapped previous Get and SetProperty options. It's to complicated to
  read the list, so rely on NetworkRegistration GetOperators showing the
  "forbidden" status.
- Link to v1: https://lore.kernel.org/r/20250701-fplmn-v1-0-d7fe9c901b57@geanix.com

---
Sean Nyekjaer (3):
      simutil: Add forbidden operator list fileid
      sim: Create new dbus method to clear the forbidden network operator list
      doc: sim-api document ClearForbiddenNetworkOperators

 doc/sim-api.txt |  8 ++++++
 src/sim.c       | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/simutil.c   |  1 +
 src/simutil.h   |  1 +
 4 files changed, 89 insertions(+)
---
base-commit: 8d892785e47bde9a0912a05725405bb60c140f87
change-id: 20250626-fplmn-bcb3eaa8baa4

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>

