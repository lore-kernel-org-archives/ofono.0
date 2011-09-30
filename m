Content-Type: multipart/mixed; boundary="===============2107835812673833360=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv8 3/6] plugins: mobile-broadband-provider-info parser changes
Date: Fri, 30 Sep 2011 16:31:11 +0300
Message-ID: <1317389474-16566-4-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1317389474-16566-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2107835812673833360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/mbpi.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/plugins/mbpi.h b/plugins/mbpi.h
index fc9f738..bb6bfdc 100644
--- a/plugins/mbpi.h
+++ b/plugins/mbpi.h
@@ -19,7 +19,9 @@
  *
  */
 =

-void mbpi_provision_data_free(struct ofono_gprs_provision_data *data);
+const char *mbpi_ap_type(enum ofono_gprs_context_type type);
+
+void mbpi_ap_free(struct ofono_gprs_provision_data *ap);
 =

 GSList *mbpi_lookup(const char *mcc, const char *mnc,
 			gboolean allow_duplicates, GError **error);
-- =

1.7.4.1


--===============2107835812673833360==--

