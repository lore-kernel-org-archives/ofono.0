Content-Type: multipart/mixed; boundary="===============8797239686565579221=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/2] Fix update driver attached status by CGREG notify
Date: Tue, 11 May 2010 09:04:29 +0800
Message-ID: <1273539869-23803-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1273539869-23803-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8797239686565579221==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This fix is for Meego bug #389. Dell 5530 modem reports 'ERROR' when
'AT+CGATT=3D0'. In the error case, we need to wait until the context
deactivation returns and then check netreg status. If status is zero,
we update driver_attached to FALSE.
---
 src/gprs.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/src/gprs.c b/src/gprs.c
index dfb6d16..8e065d2 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -1325,6 +1325,14 @@ void ofono_gprs_status_notify(struct ofono_gprs *gpr=
s, int status)
 	if (gprs->driver_attached =3D=3D FALSE)
 		return;
 =

+	/* Dell 5530 reports 'ERROR' when we try to detach by 'AT+CGATT=3D0'
+	 * immediately after deactivating the context. So we wait until
+	 * the context deactivation returns and then set driver_attached to
+	 * FALSE when the netreg status is not registered & not searching
+	 */
+	if (status =3D=3D NETWORK_REGISTRATION_STATUS_NOT_REGISTERED)
+		gprs->driver_attached =3D FALSE;
+
 	gprs->status =3D status;
 	gprs_attached_update(gprs);
 }
-- =

1.6.3.3


--===============8797239686565579221==--

