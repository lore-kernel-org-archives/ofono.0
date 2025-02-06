Received: from mail5.g24.pair.com (mail5.g24.pair.com [66.39.139.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20AE1096F
	for <ofono@lists.linux.dev>; Thu,  6 Feb 2025 00:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.39.139.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738802479; cv=none; b=rgmOd7ZHO9/xDfxVyizzB0QPzFuU9oL0atk3AKmcseSwSKULP+m0FOjZjEL5FH+IvngfLINFhV+zVUZpbDoNpgM84hK2Ws8H+ztgV2OLKHyWuNx/W3N7irZso4kd0xYhERlUBgpJHbXbIueE3EbB2J4MhlHQQ5TBUA+HrtuEplA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738802479; c=relaxed/simple;
	bh=lYWTuH7SPgN/1tMvUpW6mvgvWI065/8GjjNT7XD0mw4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=c5SZ73XOtW5znsNs9o+C8rojkv5j3bj3p/EVkYUI6aFNmCPfr0FeEa6Jnj5jRilPxiEbrBIRYmCmFtbGQYGHM/YOpdmGI1m8TVkfSVY5834w8D3XCKbKBL+m7IouI/ouqQl46nE93X5dmWPmvI7QMZHcW/Z29iJZ7y1QtM5ABU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com; spf=pass smtp.mailfrom=nuovations.com; dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b=gQuBTgD8; arc=none smtp.client-ip=66.39.139.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuovations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuovations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuovations.com header.i=@nuovations.com header.b="gQuBTgD8"
Received: from mail5.g24.pair.com (localhost [127.0.0.1])
	by mail5.g24.pair.com (Postfix) with ESMTP id 84E6816499F
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 19:34:48 -0500 (EST)
Received: from localhost.localdomain (c-24-6-12-99.hsd1.ca.comcast.net [24.6.12.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail5.g24.pair.com (Postfix) with ESMTPSA id 335B2125168
	for <ofono@lists.linux.dev>; Wed,  5 Feb 2025 19:34:48 -0500 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: ofono@lists.linux.dev
Subject: [PATCH 0/5] Correct Provisioning Database Tags Matching Behavior
Date: Wed,  5 Feb 2025 16:34:41 -0800
Message-ID: <cover.1738800116.git.gerickson@nuovations.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuovations.com; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=pair-202401062137; bh=gzBW2xLAzaPelaQ7GeIYaedR+N4W5bNeola5dOI0bG4=; b=gQuBTgD8eN/MBQ9ZcpqLzBDyhg909mRl3BulWKLLzSzI7AGS8hDrX+mBbp4BuDqYa67hFMzf94D3Hj+3FTpouDX4tCFIiylAHR6xkrFxG/gzPcePTHrNBxY1jURZMLUmYyuNE3Aaj5hit0Ou6cYVhD+ynge81sxcgMTVhGNARKIzLAWz1lbMGcMcL4quODXEX64rsxfq1050E4bgGsoWsFvtTBFpVZ5PAtUsX8i2av0gT5GR/nAXd0QYHIS0xIpMajoA+QWD0KdZ9vfpxer/O3cTaBNIR6YLAYwBMSMTsJJA6DuuO1jiwGjzh/FAzDU9JuqfPnjpkJGTR3RJ7pDiog==
X-Scanned-By: mailmunge 3.10 on 66.39.139.36

At least in North America / United States, there exist Cellular MVNOs
(particularly in the IoT / M2M veritical) that neither use mobile
virtual network operator (MVNO) service provider names (SPNs) nor use
unique home network identifiers (HNIs) (that is, mobile country code
(MCC) + mobile network code (MNC) pairs). Instead, they simply use the
HNI of the parent operator.

In addition, those MVNOs typically have two or three APN schemes:

    1. A "public" APN that is broadly used by one or more MVNOs for
       the parent operator that issues PUBLIC IP addresses and does
       NOT route through the MVNOs or parent operator data center
       infrastructure.

    2. A "private" APN that may or may NOT be broadly used by one
       or more MVNOs for the parent operator that issues PRIVATE IP
       addresses and does route through the MVNOs or parent operator
       data center infrastructure.

    3. A "private" APN that is used only by the MVNO that issues
       static or dynamic PRIVATE IP addresses, does route through the
       MVNO data center infrastructure and, from there, via a VPN to
       the customer services infrastructure.

       These are sufficiently MVNO-specific where they do not or
       should not play a role in a generic provisioning database.

Consequently, to effectively distinguish or steer a given device to
(1) or (2), a 'TagsFilter' must be used. However, as presently
implemented, a tag in 'TagsFilter' not only returns APNs matching the
tag(s) but also untagged APNs.

Assuming an APN of both (1) and (2) above, used by the Verizon KORE
Wireless MVNO, prior to this proposed change, the behavior was/is:

No tag specified:

    # ./lookup-apn 311 480
    Opening database in default location
    Searching for info for network: 311480, spn: <None>

    Name: 4G LTE Contract
    APN: vzwims
    Type: 28
    Proto: 2
    Tags: (null)

    Name: 4G LTE Contract (Public)
    APN: vzwinternet
    Type: 1
    Proto: 2
    Tags: kore-m2m-public

    Name: 4G LTE Contract (Private)
    APN: wyleslte.gw7.vzwentp
    Type: 1
    Proto: 2
    Tags: kore-m2m-private

    Name: 4G LTE Contract
    APN: vzwapp
    Type: 4
    Proto: 2
    Tags: (null)

As expected.

One specific tag specified:

    # ./lookup-apn -t "kore-m2m-public" 311 480
    Opening database in default location
    Searching for info for network: 311480, spn: <None>

    Name: 4G LTE Contract
    APN: vzwims
    Type: 28
    Proto: 2
    Tags: (null)

    Name: 4G LTE Contract (Public)
    APN: vzwinternet
    Type: 1
    Proto: 2
    Tags: kore-m2m-public

    Name: 4G LTE Contract
    APN: vzwapp
    Type: 4
    Proto: 2
    Tags: (null)

Surprise! Both 'vzwapp' and 'vzwims' are returned which were not
expected or desired.

Another specific tag specified:

    # ./lookup-apn -t "kore-m2m-private" 311 480
    Opening database in default location
    Searching for info for network: 311480, spn: <None>

    Name: 4G LTE Contract
    APN: vzwims
    Type: 28
    Proto: 2
    Tags: (null)

    Name: 4G LTE Contract (Private)
    APN: wyleslte.gw7.vzwentp
    Type: 1
    Proto: 2
    Tags: kore-m2m-private

    Name: 4G LTE Contract
    APN: vzwapp
    Type: 4
    Proto: 2
    Tags: (null)

Surprise! Both 'vzwapp' and 'vzwims' are returned which were not
expected or desired.

Two specific tags specified:

    # ./lookup-apn -t "kore-m2m-public,kore-m2m-private" 311 480
    Opening database in default location
    Searching for info for network: 311480, spn: <None>

    Name: 4G LTE Contract
    APN: vzwims
    Type: 28
    Proto: 2
    Tags: (null)

    Name: 4G LTE Contract (Public)
    APN: vzwinternet
    Type: 1
    Proto: 2
    Tags: kore-m2m-public

    Name: 4G LTE Contract (Private)
    APN: wyleslte.gw7.vzwentp
    Type: 1
    Proto: 2
    Tags: kore-m2m-private

    Name: 4G LTE Contract
    APN: vzwapp
    Type: 4
    Proto: 2
    Tags: (null)

Surprise! Both 'vzwapp' and 'vzwims' are returned which were not
expected or desired.

With this change, specifying 'TagsFilter' now follows the rule of
least astonishment and matches expectations, returning only those APNs
which match a tag in 'TagsFilter', period.

One specific tag:

    # ./lookup-apn -t "kore-m2m-public" 311 480
    Opening database in default location
    Searching for info for network: 311480, spn: <None>
    Name: 4G LTE Contract (Public)
    APN: vzwinternet
    Type: 1
    Proto: 2
    Tags: kore-m2m-public

As desired / expected.

Another specific tag:

    # ./lookup-apn -t "kore-m2m-private" 311 480
    Opening database in default location
    Searching for info for network: 311480, spn: <None>
    Name: 4G LTE Contract (Private)
    APN: wyleslte.gw7.vzwentp
    Type: 1
    Proto: 2
    Tags: kore-m2m-private

As desired / expected.

Two specific tags:

    # ./lookup-apn -t "kore-m2m-private,kore-m2m-public" 311 480
    Opening database in default location
    Searching for info for network: 311480, spn: <None>
    Name: 4G LTE Contract (Public)
    APN: vzwinternet
    Type: 1
    Proto: 2
    Tags: kore-m2m-public

    Name: 4G LTE Contract (Private)
    APN: wyleslte.gw7.vzwentp
    Type: 1
    Proto: 2
    Tags: kore-m2m-private

As desired / expected.

No tags:

    # ./lookup-apn 311 480
    Opening database in default location
    Searching for info for network: 311480, spn: <None>
    Name: 4G LTE Contract
    APN: vzwims
    Type: 28
    Proto: 2
    Tags: (null)

    Name: 4G LTE Contract (Public)
    APN: vzwinternet
    Type: 1
    Proto: 2
    Tags: kore-m2m-public

    Name: 4G LTE Contract (Private)
    APN: wyleslte.gw7.vzwentp
    Type: 1
    Proto: 2
    Tags: kore-m2m-private

    Name: 4G LTE Contract
    APN: vzwapp
    Type: 4
    Proto: 2
    Tags: (null)

As desired / expected.

Grant Erickson (5):
  provisiondb: Const-qualify '__get_string'.
  provisiondb: Const-qualify '__get_contexts'.
  provisiondb: Correct the precondition return conditions of
    'tags_match'.
  provisiondb: Document 'tags_match'.
  provisiondb: Document '__get_contexts'.

 src/provisiondb.c | 64 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 3 deletions(-)

-- 
2.45.0

