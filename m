Content-Type: multipart/mixed; boundary="===============3602454739695307879=="
MIME-Version: 1.0
From: Clayton Craft <clayton@craftyguy.net>
Subject: [PATCH 1/1] isimodem: Use correct callback for pin status
Date: Sun, 10 Sep 2017 09:41:28 -0700
Message-ID: <20170910164128.GA3@computer.craftyguy.net>
In-Reply-To: <20170909203404.GG3@computer.craftyguy.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3602454739695307879==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This fixes the segfault I experienced on enabling the modem by using
the correct callback for pin status response.


 drivers/isimodem/sim.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/isimodem/sim.c b/drivers/isimodem/sim.c
index 4379a159..cea50972 100644
--- a/drivers/isimodem/sim.c
+++ b/drivers/isimodem/sim.c
@@ -450,7 +450,7 @@ static void check_sec_response(const GIsiMessage *msg, =
void *opaque,
 					uint8_t success, uint8_t failure)
 {
 	struct isi_cb_data *cbd =3D opaque;
-	ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
+	ofono_query_facility_lock_cb_t cb =3D cbd->cb;
 	struct ofono_sim *sim =3D cbd->user;
 	uint8_t id;
 	uint8_t cause;
@@ -465,7 +465,7 @@ static void check_sec_response(const GIsiMessage *msg, =
void *opaque,
 	if (id =3D=3D success) {
 		DBG("%s", sec_message_id_name(id));
 		sim_set_passwd_state(sim, OFONO_SIM_PASSWORD_NONE);
-		CALLBACK_WITH_SUCCESS(cb, cbd->data);
+		CALLBACK_WITH_SUCCESS(cb, OFONO_SIM_PASSWORD_NONE, sim);
 		return;
 	}

@@ -478,7 +478,7 @@ static void check_sec_response(const GIsiMessage *msg, =
void *opaque,
 		DBG("Error msg: %s", sec_message_id_name(id));

 failure:
-	CALLBACK_WITH_FAILURE(cb, cbd->data);
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->data);
 }

 static void sec_code_verify_resp(const GIsiMessage *msg, void *opaque)


--===============3602454739695307879==--

