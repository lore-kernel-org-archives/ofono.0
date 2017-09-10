Content-Type: multipart/mixed; boundary="===============3356957172743602238=="
MIME-Version: 1.0
From: Clayton Craft <clayton@craftyguy.net>
Subject: Re: [PATCH 1/1] isimodem: Use correct callback for pin status
Date: Sun, 10 Sep 2017 11:41:04 -0700
Message-ID: <20170910184104.GC3@computer.craftyguy.net>
In-Reply-To: <3aff6e05-ef53-a36d-360a-45b06ea94918@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3356957172743602238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
Ah, ok, I think see what you mean. Sorry for the misunderstanding, and thank
you for your patience. I have now implemented a proper query method
based on the 2010 patch you referenced. I don't have a PIN set on my
SIM, but it seems to allow the 'enabling' to proceed successfully and
based on my understanding of what the 2010 patch is doing, allow for
signaling if a SIM is locked as well.

-Clayton

 drivers/isimodem/sim.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/isimodem/sim.c b/drivers/isimodem/sim.c
index 4379a159..0aa4b03a 100644
--- a/drivers/isimodem/sim.c
+++ b/drivers/isimodem/sim.c
@@ -646,8 +646,31 @@ error:
 /* ISI callback: PIN state (enabled/disabled) query */
 static void sec_code_state_resp_cb(const GIsiMessage *msg, void *opaque)
 {
-	check_sec_response(msg, opaque, SEC_CODE_STATE_OK_RESP,
-				SEC_CODE_STATE_FAIL_RESP);
+	struct isi_cb_data *cbd =3D opaque;
+	ofono_query_facility_lock_cb_t cb =3D cbd->cb;
+	int locked;
+	uint8_t state;
+	uint8_t status;
+
+	if (!g_isi_msg_data_get_byte(msg, 0, &state) ||
+			!g_isi_msg_data_get_byte(msg, 1, &status))
+		goto error;
+
+	if (state !=3D SEC_CODE_STATE_OK_RESP)
+		goto error;
+
+	if (status =3D=3D SEC_CODE_ENABLE)
+		locked =3D 1;
+	else if (status =3D=3D SEC_CODE_DISABLE)
+		locked =3D 0;
+	else
+		goto error;
+
+	CALLBACK_WITH_SUCCESS(cb, locked, cbd->data);
+	return;
+
+error:
+	CALLBACK_WITH_FAILURE(cb, -1, cbd->date);
 }
 =

 static void isi_query_locked(struct ofono_sim *sim,



On Sun, Sep 10, 2017 at 12:47:16PM -0500, Denis Kenzior wrote:
>Hi Clayton,
>
>On 09/10/2017 11:41 AM, Clayton Craft wrote:
>>This fixes the segfault I experienced on enabling the modem by using
>>the correct callback for pin status response.
>>
>>
>>drivers/isimodem/sim.c | 6 +++---
>>1 file changed, 3 insertions(+), 3 deletions(-)
>>
>>diff --git a/drivers/isimodem/sim.c b/drivers/isimodem/sim.c
>>index 4379a159..cea50972 100644
>>--- a/drivers/isimodem/sim.c
>>+++ b/drivers/isimodem/sim.c
>>@@ -450,7 +450,7 @@ static void check_sec_response(const GIsiMessage =

>>*msg, void *opaque,
>>                     uint8_t success, uint8_t failure)
>>{
>>     struct isi_cb_data *cbd =3D opaque;
>>-    ofono_sim_lock_unlock_cb_t cb =3D cbd->cb;
>>+    ofono_query_facility_lock_cb_t cb =3D cbd->cb;
>>     struct ofono_sim *sim =3D cbd->user;
>>     uint8_t id;
>>     uint8_t cause;
>>@@ -465,7 +465,7 @@ static void check_sec_response(const GIsiMessage =

>>*msg, void *opaque,
>>     if (id =3D=3D success) {
>>         DBG("%s", sec_message_id_name(id));
>>         sim_set_passwd_state(sim, OFONO_SIM_PASSWORD_NONE);
>>-        CALLBACK_WITH_SUCCESS(cb, cbd->data);
>>+        CALLBACK_WITH_SUCCESS(cb, OFONO_SIM_PASSWORD_NONE, sim);
>
>check_sec_response is used when entering / enabling / disabling a PIN. =

>So you might be hacking around your particular issue, but breaking =

>others.
>
>The real fix is to implement a proper callback for isi_query_locked. =

>The previously submitted (2010 or so?) driver code might give you =

>hints on what the actual callback should look like.
>
>>         return;
>>     }
>>
>
>Regards,
>-Denis


--===============3356957172743602238==--

