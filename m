Content-Type: multipart/mixed; boundary="===============5534186778434898622=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 1/4] simutil: Add EFcsp file and service group IDs
Date: Wed, 26 Jan 2011 11:19:26 +0200
Message-ID: <1296033569-26774-2-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1296033569-26774-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5534186778434898622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/simutil.h |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/src/simutil.h b/src/simutil.h
index 463540b..a5a683b 100644
--- a/src/simutil.h
+++ b/src/simutil.h
@@ -37,6 +37,7 @@ enum sim_fileid {
 	SIM_EFIMSI_FILEID =3D			0x6F07,
 	SIM_EF_CPHS_MWIS_FILEID =3D		0x6F11,
 	SIM_EF_CPHS_CFF_FILEID =3D		0x6F13,
+	SIM_EF_CPHS_CSP_FILEID =3D		0x6F15,
 	SIM_EF_CPHS_INFORMATION_FILEID =3D	0x6F16,
 	SIM_EF_CPHS_MBDN_FILEID =3D		0x6F17,
 	SIM_EFUST_FILEID =3D			0x6F38,
@@ -238,6 +239,21 @@ enum sim_sst_service {
 	SIM_SST_SERVICE_PROVIDER_DISPLAY_INFO =3D		55
 };
 =

+/* CPHS 4.2, Section B4.7 CSP Service Group Codes */
+enum sim_csp_entry {
+	SIM_CSP_ENTRY_CALL_OFFERING =3D		0x01,
+	SIM_CSP_ENTRY_CALL_RESTRICTION =3D	0x02,
+	SIM_CSP_ENTRY_OTHER_SUPP_SERVICES =3D	0x03,
+	SIM_CSP_ENTRY_CALL_COMPLETION =3D		0x04,
+	SIM_CSP_ENTRY_TELESERVICES =3D		0x05,
+	SIM_CSP_ENTRY_CPHS_TELESERVICES =3D	0x06,
+	SIM_CSP_ENTRY_CPHS_FEATURES =3D		0x07,
+	SIM_CSP_ENTRY_NUMBER_IDENTIFICATION =3D	0x08,
+	SIM_CSP_ENTRY_PHASE_2GPLUS_SERVICES =3D	0x09,
+	SIM_CSP_ENTRY_VALUE_ADDED_SERVICES =3D	0xC0,
+	SIM_CSP_ENTRY_INFORMATION_NUMBERS =3D	0xD5,
+};
+
 enum ber_tlv_data_type {
 	BER_TLV_DATA_TYPE_UNIVERSAL =3D		0,
 	BER_TLV_DATA_TYPE_APPLICATION =3D		1,
-- =

1.7.1


--===============5534186778434898622==--

