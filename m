Content-Type: multipart/mixed; boundary="===============2618916292742454433=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 1/1] qmimodem: fix sim file reading on MC7304
Date: Fri, 17 Feb 2017 16:06:12 +0100
Message-ID: <20170217150612.24137-2-c.ronco@kerlink.fr>
In-Reply-To: <20170217150612.24137-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2618916292742454433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Command read_file_info on MC7304 always fails.
Using qmicli or AT command, I am able to read file info.
Qmicli command is:
qmicli -d /dev/cdc-wdm0 --uim-get-file-attributes=3D0x3f00,0x7fff,0x6fad
[(null)] Successfully got file '/dev/cdc-wdm0' attributes from the UIM:
Card result:
        SW1: '0x90'
        SW2: '0x00'
File attributes:
        File size: 4
        File ID: 28589
        File type: transparent
        Record size: 0
        Record count: 0
        Read security attributes: (always) (null)
        Write security attributes: (single) adm
        Increase security attributes: (always) (null)
        Deactivate security attributes: (single) adm
        Activate security attributes: (single) adm
        Raw:    62:17:82:02:41:21:83:02:6F:AD:8A:01:05:8B:...

After a check of parameters sent by qmimodem driver and qmicli,
the only difference is on parameter "Session Information".
Session type sent by qmimodem driver is 'Card on slot 1'.
Session type sent by qmicli command is 'primary-gw-provisioning'.
Changing session type in qmimodem driver fixed problem (on this modem).

Comparing with what is done by qmili command
---
 drivers/qmimodem/sim.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/qmimodem/sim.c b/drivers/qmimodem/sim.c
index 602e5296..8d400288 100644
--- a/drivers/qmimodem/sim.c
+++ b/drivers/qmimodem/sim.c
@@ -168,7 +168,7 @@ static void qmi_read_attributes(struct ofono_sim *sim, =
int fileid,
 {
 	struct sim_data *data =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, user_data);
-	unsigned char aid_data[2] =3D { 0x06, 0x00 };
+	unsigned char aid_data[2] =3D { 0x00, 0x00 };
 	unsigned char fileid_data[9];
 	int fileid_len;
 	struct qmi_param *param;
@@ -233,7 +233,7 @@ static void qmi_read_transparent(struct ofono_sim *sim,
 {
 	struct sim_data *data =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, user_data);
-	unsigned char aid_data[2] =3D { 0x06, 0x00 };
+	unsigned char aid_data[2] =3D { 0x00, 0x00 };
 	unsigned char read_data[4];
 	unsigned char fileid_data[9];
 	int fileid_len;
@@ -279,7 +279,7 @@ static void qmi_read_record(struct ofono_sim *sim,
 {
 	struct sim_data *data =3D ofono_sim_get_data(sim);
 	struct cb_data *cbd =3D cb_data_new(cb, user_data);
-	unsigned char aid_data[2] =3D { 0x06, 0x00 };
+	unsigned char aid_data[2] =3D { 0x00, 0x00 };
 	unsigned char read_data[4];
 	unsigned char fileid_data[9];
 	int fileid_len;
-- =

2.11.0


--===============2618916292742454433==--

