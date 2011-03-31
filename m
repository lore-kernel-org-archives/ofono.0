Content-Type: multipart/mixed; boundary="===============3439469030197891058=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC PATCH 3/9] modem: add ofono_modem_get_emergency_mode api
Date: Thu, 31 Mar 2011 09:18:26 -0700
Message-ID: <1301588312-6932-4-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1301588312-6932-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3439469030197891058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/modem.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index 26468e8..2b49770 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -86,6 +86,7 @@ struct ofono_modem {
 	void			*driver_data;
 	char			*driver_type;
 	char			*name;
+	guint			emergency;
 };
 =

 struct ofono_devinfo {
@@ -2040,3 +2041,8 @@ void __ofono_modem_foreach(ofono_modem_foreach_func f=
unc, void *userdata)
 		func(modem, userdata);
 	}
 }
+
+ofono_bool_t ofono_modem_get_emergency_mode(struct ofono_modem *modem)
+{
+	return modem->emergency !=3D 0;
+}
-- =

1.7.0.4


--===============3439469030197891058==--

