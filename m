Content-Type: multipart/mixed; boundary="===============7811759341867101593=="
MIME-Version: 1.0
From: Jupiter <jupiter.hce@gmail.com>
Subject: [PATCH v3 0/4] SARA R4 patches  
Date: Mon, 22 Feb 2021 20:08:55 +1100
Message-ID: <20210222090859.2883-1-jupiter.hce@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7811759341867101593==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: jupiter <jupiter.hce@gmail.com>

Hi Jonas,

Is any reason you need to add ofono_modem_set_string(modem->modem, "Quirk",=
 "SARAR4"); to static gboolean setup_sim7x00 rather than directly in static=
 gboolean setup_ubloxqmi(struct modem_info *modem) ?

Your patch:

--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1366,6 +1366,11 @@ static gboolean setup_sim7x00(struct modem_info
*modem)
                ofono_modem_set_string(modem->modem, "Audio", audio);
        }
  +     if ((g_strcmp0(modem->vendor, "0xffff") =3D=3D 0) &&
+               (g_strcmp0(modem->model, "0xffff") =3D=3D 0)) {
+               ofono_modem_set_string(modem->modem, "Quirk", "SARAR4");
+       }
+


My patch:
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1194,6 +1194,45 @@ static gboolean setup_ublox(struct modem_info *modem)
    return TRUE;
 }

+static gboolean setup_ubloxqmi(struct modem_info *modem) {
..........
+   ofono_modem_set_string(modem->modem, "Device", qmi);
+   ofono_modem_set_string(modem->modem, "NetworkInterface", net);
+   ofono_modem_set_string(modem->modem, "Quirk", "SARAR4");
+   ofono_modem_set_driver(modem->modem, "gobi");
+
+   return TRUE;
+}

Thanks.

- jupiter


jupiter (4):
  Change 1: SARA R4 QMI support
  Change 2: Add SARA R4 vendor ID
  Change 3: Check SARA R4 vendor ID, need to make it conditional on the
    actions being attach and detach
  Change 4: Add SARA R4 vendor and enable vendor in gprs create

 drivers/atmodem/vendor.h |  1 +
 drivers/qmimodem/gprs.c  | 15 +++++++++++++++
 plugins/gobi.c           | 11 ++++++++++-
 plugins/udevng.c         | 41 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 1 deletion(-)

-- =

2.17.1

--===============7811759341867101593==--

