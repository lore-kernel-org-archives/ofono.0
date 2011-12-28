Content-Type: multipart/mixed; boundary="===============2537129402701551927=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 0/2] phonesim: Indicate CSP, short-SPN in CPHS info.
Date: Wed, 28 Dec 2011 15:18:59 +0200
Message-ID: <1325078341-30592-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2537129402701551927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Please find the changes in order to indicate the presense of EFcphs_csp, EF=
cphs_spns in EFcphs_info.

Regards,
Oleg

Oleg Zhurakivskyy (2):
  simfilesystem: Indicate EFcphs_csp
  simfilesystem: Indicate EFcphs_spns

 src/default.xml |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

-- =

1.7.5.4


--===============2537129402701551927==--

