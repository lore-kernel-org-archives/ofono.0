Content-Type: multipart/mixed; boundary="===============7545116427891578819=="
MIME-Version: 1.0
From: JongSeok Won <wjs890204@gmail.com>
Subject: [PATCHv2 2/3] rilmodem: support cell type LTE for netmon
Date: Fri, 31 Jul 2020 11:20:52 +0900
Message-ID: <20200731022052.18948-1-wjs890204@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7545116427891578819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/rilmodem/netmon.c | 51 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/rilmodem/netmon.c b/drivers/rilmodem/netmon.c
index 547ebccc..9f3a1191 100644
--- a/drivers/rilmodem/netmon.c
+++ b/drivers/rilmodem/netmon.c
@@ -109,6 +109,9 @@ static int process_cellinfo_list(struct ril_msg *messag=
e,
 	int mcc, mnc;
 	int lac, cid, psc;
 	int rssi, ber;
+	int ci, pci, tac;
+	int rsrp, rsrq, rssnr;
+	int cqi, tadv;
 	char s_mcc[OFONO_MAX_MCC_LENGTH + 1];
 	char s_mnc[OFONO_MAX_MNC_LENGTH + 1];
 	int i, j;
@@ -216,6 +219,54 @@ static int process_cellinfo_list(struct ril_msg *messa=
ge,
 				OFONO_NETMON_INFO_BER, ber,
 				OFONO_NETMON_INFO_INVALID);
 =

+	} else if (cell_type =3D=3D NETMON_RIL_CELLINFO_TYPE_LTE) {
+		mcc =3D parcel_r_int32(&rilp);
+		mnc =3D parcel_r_int32(&rilp);
+		ci =3D  parcel_r_int32(&rilp);
+		pci =3D parcel_r_int32(&rilp);
+		tac =3D parcel_r_int32(&rilp);
+		rssi =3D parcel_r_int32(&rilp);
+		rsrp =3D parcel_r_int32(&rilp);
+		rsrq =3D parcel_r_int32(&rilp);
+		rssnr =3D parcel_r_int32(&rilp);
+		cqi =3D parcel_r_int32(&rilp);
+		tadv =3D parcel_r_int32(&rilp);
+
+		if (mcc >=3D 0 && mcc <=3D 999)
+		snprintf(s_mcc, sizeof(s_mcc), "%03d", mcc);
+		else
+		strcpy(s_mcc, "");
+
+		if (mnc >=3D 0 && mnc <=3D 999)
+		snprintf(s_mnc, sizeof(s_mnc), "%03d", mnc);
+		else
+		strcpy(s_mnc, "");
+
+		ci =3D (ci >=3D 0 && ci <=3D 268435455) ? ci : -1;
+		pci =3D (pci >=3D 0 && pci <=3D 503) ? pci : -1;
+		tac =3D (tac >=3D 0 && tac <=3D 65535) ? tac : -1;
+		rssi =3D (rssi >=3D 0 && rssi <=3D 31) ? rssi : -1;
+		rsrp =3D (rsrp >=3D 44 && rsrp <=3D 140) ? -rsrp : -1;
+		rsrq =3D (rsrq >=3D 3 && rsrq <=3D 20) ? -rsrq : -1;
+		rssnr =3D (rssnr >=3D -200 && rssnr <=3D 300) ? rssnr : -1;
+		cqi =3D (cqi >=3D 0 && cqi <=3D 15) ? cqi : -1;
+		tadv =3D (tadv >=3D0 && tadv <=3D 63) ? tadv : -1;
+
+		ofono_netmon_serving_cell_notify(netmon,
+				OFONO_NETMON_CELL_TYPE_LTE,
+				OFONO_NETMON_INFO_MCC, s_mcc,
+				OFONO_NETMON_INFO_MNC, s_mnc,
+				OFONO_NETMON_INFO_CI, ci,
+				OFONO_NETMON_INFO_PCI, pci,
+				OFONO_NETMON_INFO_TAC, tac,
+				OFONO_NETMON_INFO_RSSI, rssi,
+				OFONO_NETMON_INFO_RSRP, rsrp,
+				OFONO_NETMON_INFO_RSRQ, rsrq,
+				OFONO_NETMON_INFO_SNR, rssnr,
+				OFONO_NETMON_INFO_CQI, cqi,
+				OFONO_NETMON_INFO_TIMING_ADVANCE, tadv,
+				OFONO_NETMON_INFO_INVALID);
+
 	}
 =

 	return OFONO_ERROR_TYPE_NO_ERROR;
-- =

2.17.1

--===============7545116427891578819==--

