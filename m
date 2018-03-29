Content-Type: multipart/mixed; boundary="===============5837706082471544461=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 00/12] QMI cleanups
Date: Thu, 29 Mar 2018 15:57:49 +0200
Message-ID: <20180329135801.5981-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5837706082471544461==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here is a submission of patches that are extracted from yesterday's RFC
series.  These patches are hopefully reasonably uncontroversial
as they constitute just cleanups.  That said, they should still be taken
in the context of yesterday's series:  this series is the foundation for
the share service changes I want to make.

Jonas Bonn (12):
  qmi: remove unused fields of service_send_data
  qmi: remove headroom parameter from req_alloc
  qmi: unify common request header setup
  qmi: request_alloc has no meaningful failure path
  qmi: push request_submit into request_alloc
  qmi: rename request_alloc to request_submit
  qmi: figure out request id without accessing header
  qmi: return request TID for __request_submit
  qmi: assume version_list is up to date
  qmi: absorb service_create_discover into service_create
  qmi: make version_list private
  qmi: use standard endian macros

 drivers/qmimodem/qmi.c | 331 ++++++++++++++++++++++-----------------------=
----
 drivers/qmimodem/qmi.h |  14 +--
 plugins/gobi.c         |  68 ++++------
 3 files changed, 180 insertions(+), 233 deletions(-)

-- =

2.15.1


--===============5837706082471544461==--

