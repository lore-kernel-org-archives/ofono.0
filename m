Content-Type: multipart/mixed; boundary="===============7907265999339007858=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 2/2] Fix check data device before register the modem
Date: Thu, 06 May 2010 14:30:50 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351E658139@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1273127293-4671-2-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7907265999339007858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Zhang, Zhenhua wrote:
> To avoid the race condition that modem is registered before we
> retrieve the data device property.
> ---

The second patch is for MBM modem only. We should retrieve data device prop=
erty before register the modem. Please review it. Thanks.

Regards,
Zhenhua


--===============7907265999339007858==--

