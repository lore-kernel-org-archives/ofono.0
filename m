Content-Type: multipart/mixed; boundary="===============1331063769975277188=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 2/6] stemodem: add default case
Date: Tue, 26 Oct 2010 18:31:49 +0300
Message-ID: <1288107113-2740-3-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1288107113-2740-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1331063769975277188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/stemodem/radio-settings.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/stemodem/radio-settings.c b/drivers/stemodem/radio-set=
tings.c
index 5b16ec0..a345975 100644
--- a/drivers/stemodem/radio-settings.c
+++ b/drivers/stemodem/radio-settings.c
@@ -90,7 +90,7 @@ static gboolean ofono_mode_to_ste_mode(enum ofono_radio_a=
ccess_mode mode,
 	case OFONO_RADIO_ACCESS_MODE_UMTS:
 		*stemode =3D STE_RADIO_WCDMA_ONLY;
 		return TRUE;
-	case OFONO_RADIO_ACCESS_MODE_LTE:
+	default:
 		break;
 	}
 =

-- =

1.7.0.4


--===============1331063769975277188==--

