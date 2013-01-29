Content-Type: multipart/mixed; boundary="===============8591124497213453258=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v0 1/4] hfp_hf_bluez5: Rename 'Address' modem property to
 'Remote'
Date: Tue, 29 Jan 2013 17:38:37 -0300
Message-ID: <1359491920-15963-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1359491920-15963-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8591124497213453258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

As we will need to also keep track of the Local address, we rename the
modem property to Remote, to keep names more consistent.
---
 plugins/hfp_hf_bluez5.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index aba62e2..c4a3f32 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -185,7 +185,7 @@ static struct ofono_modem *modem_register(const char *d=
evice,
 	if (modem =3D=3D NULL)
 		return NULL;
 =

-	ofono_modem_set_string(modem, "Address", device_address);
+	ofono_modem_set_string(modem, "Remote", device_address);
 =

 	ofono_modem_set_name(modem, alias);
 	ofono_modem_register(modem);
@@ -243,7 +243,7 @@ static int hfp_disable(struct ofono_modem *modem)
 static void hfp_pre_sim(struct ofono_modem *modem)
 {
 	struct hfp *hfp =3D ofono_modem_get_data(modem);
-	char *address =3D (char *) ofono_modem_get_string(modem, "Address");
+	char *address =3D (char *) ofono_modem_get_string(modem, "Remote");
 =

 	DBG("%p", modem);
 =

-- =

1.7.11.7


--===============8591124497213453258==--

