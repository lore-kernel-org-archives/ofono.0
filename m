Content-Type: multipart/mixed; boundary="===============4330095816141092301=="
MIME-Version: 1.0
From: martin.xu@intel.com
Subject: [PATCH 0/2] fix ACCM handle issue for Huawei EM770W modem
Date: Mon, 10 Jan 2011 18:40:15 +0800
Message-ID: <1294656017-825-1-git-send-email-martin.xu@intel.com>
In-Reply-To: <martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4330095816141092301==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Martin Xu <martin.xu@intel.com>

  [PATCH 1/2] PPP: Fix Trasmit ACCM and Receive ACCM setting error
  according to RFC 1662 section 7.2, looks like oFono has set receive
  and transmit ACCM wrongly.
  normally the two ACCM are both set as 0x00000000, and the issue will
  not be found. Once the they are different, oFono will run to error.

  [PATCH 2/2] Inform Huawei modem using ACCM 0xffffffff to trasmit package.=
    =

  Using my Huawei modem (EM770W) if set ACCM as 0x00000000, the RXJ- =

  event will happend, and PPP link down, when IP package is transmited
  for a while. If I set ACCM as 0xffffffff, the RXJ- event never happen,
  and the modem can work quite stable.
  I tested the modem at China Unicom networks.
  Not sure whether the issue is specific to specific modem. If it is the ca=
se,
  ofono may let user to set the ACCM to specific modem.

 gatchat/ppp_lcp.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

-- =

1.7.2.2


--===============4330095816141092301==--

