Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76961D529
	for <ofono@lists.linux.dev>; Tue,  2 Apr 2024 22:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097063; cv=none; b=iysIrKfoAMQt2Guqcd3jsaNq7TN4V8m8vY9OD5b0mq4g54RgIbAkYfyYqR7xHNDQR+ux56Xe3dN7xxpBX11HyBP7o6Funanps8e9JvppyD2Y+dca3csmsduAt3uFQfiM6N7fZ46NhOYrIsAmGlE+lccIBDktRVF7UE5mVyFfuz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097063; c=relaxed/simple;
	bh=8A/vRDi5jAwzUJ1AgQLwUt184NvPYujph9PsMG+FPJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0y519UA3stAjI1al+1uLOdoEmELWUCkcblEljr2jcx4jrcrvZARfExUQbAh5czoySZ8tNX+1ZqWpbz2PgdS6w6+0lw5EUXFFKAE3M7UnoEg8qaKxBerQXtDfIiZLinJg48VmVJ+Cvyo+rWV+lDk4+L2v9JT7wCWwWvTmbsLdbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OA6ZKQa0; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OA6ZKQa0"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a470320194so3349408eaf.3
        for <ofono@lists.linux.dev>; Tue, 02 Apr 2024 15:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712097060; x=1712701860; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODeDIhWwvZpl8x9SSVdYHwsb69BrXgQE4y8wCTK2JIA=;
        b=OA6ZKQa0cxdrkgBeboliLXinO5rKFySITC+YIiu/2a+E7sryIR0kx7ctLNSoAVkUKH
         E//iFSf0KI3xUeKF206VlBCcN1LdfzJhxdRyBIJh39jtoReoLh5pnbvL5EVlu8lQRjis
         v2+IAgg9ypTBJBLIwy9m/InayOB6lFO+GPYOoovG3zO/U6ybr0IURliqi6VlWGF8LyZP
         bb1GMXfRkf+YOrRh00Ic2QgDMw+ncoNe98l5BU4R8T/HQv5dk7kf9QyvcJuCod9IcQf7
         fHTmWHMJ2rQAHf5BIVAec5I3SfT356UnFcTfGC5ULfcBKOBkWHPpf7daOskO7qq50o1I
         c6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712097060; x=1712701860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODeDIhWwvZpl8x9SSVdYHwsb69BrXgQE4y8wCTK2JIA=;
        b=du36kjql+lmRtCxReftlRadMabKYN0r6RDx0uAp07taLq7mKXewbTUc4k+Ca/ITTH4
         E0acwNd1zx2nbSP1cOMVChgA586M4aBDm9x0xxXBDJvUWY9AgVkUlcBCdOvhqsTBDK+R
         gkBnjyaPRvu0x2sW94XIlUMphf8Z/GKkBjO9mRl0mc+5yZQUKOMVVQMkBUMqBTqUrLwb
         d6/O3kNMAtLzry9MV1cCYQRhOEu2lfKmXXV7MNIcN+kz+HaunbfzKYy9t1d96nTqXzBB
         6cMx7iB38mI69r3Y1U4NzhDtRwdovVWr2oAw4KcWyCWbWXkg6Ujqr842iHvc9MZ43wQ3
         MVbg==
X-Gm-Message-State: AOJu0YxU0tJr0yxzWtZMLMFh9Mc9OYQwyPyHk5ngn8qZT+jI2U7a4nnS
	na4NNirXnyKDFRd03P5zKcF0XLoYNbAkE6IPzowB+S5Gf9TVcXVTigYX3mMY
X-Google-Smtp-Source: AGHT+IGisd8cP5o+P2Vpy7y5TxO5frHhKmGfnQ2NyP2KmEE3TFAfBJg/fCcfNFRbYyFcFPmr1HoIdg==
X-Received: by 2002:a05:6820:210d:b0:5a1:bb9d:56a7 with SMTP id cd13-20020a056820210d00b005a1bb9d56a7mr14013828oob.8.1712097060694;
        Tue, 02 Apr 2024 15:31:00 -0700 (PDT)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id eo8-20020a0568200f0800b005a58b8e4b1csm2956204oob.7.2024.04.02.15.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 15:31:00 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: ofono@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 06/13] data: Remove RESELLER settings from AT&T
Date: Tue,  2 Apr 2024 17:30:31 -0500
Message-ID: <20240402223054.2819526-6-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240402223054.2819526-1-denkenz@gmail.com>
References: <20240402223054.2819526-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This seems to be yet another MVNO, remove it for now.
---
 data/provision.json | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/data/provision.json b/data/provision.json
index 80abd78e6507..cef6e34e1ae3 100644
--- a/data/provision.json
+++ b/data/provision.json
@@ -14181,16 +14181,6 @@
         "mmsc": "http://mmsc.mobile.att.net",
         "mmsproxy": "proxy.mobile.att.net:80"
       },
-      {
-        "name": "RESELLER",
-        "apn": "RESELLER",
-        "type": [
-          "internet",
-          "mms"
-        ],
-        "mmsc": "http://mmsc.mobile.att.net",
-        "mmsproxy": "proxy.mobile.att.net:80"
-      },
       {
         "name": "AT&T M2M",
         "apn": "m2m005246.attz",
-- 
2.43.0

