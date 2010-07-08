Content-Type: multipart/mixed; boundary="===============6768535510262690991=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH] huawei: recreate the GPRS atom on hup
Date: Thu, 08 Jul 2010 18:17:49 +0800
Message-ID: <1278584269-3995-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1278584269-3995-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6768535510262690991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

System is either crashed or usb_serial module reports warnings after
activate/deactivate GPRS context several times. Handle this by remove
and recreate the GPRS atom in oFono.

Tested with Huawei E1552, EM770W.
System: Ubuntu 9.10.
Kernel: 2.6.31-16-generic #53-Ubuntu SMP
---
 plugins/huawei.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index cfc693d..6cc1448 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -237,6 +237,7 @@ static void huawei_disconnect(gpointer user_data)
 	DBG("");
 =

 	ofono_gprs_context_remove(data->gc);
+	ofono_gprs_remove(data->gprs);
 =

 	g_at_chat_unref(data->modem);
 	data->modem =3D NULL;
@@ -250,6 +251,7 @@ static void huawei_disconnect(gpointer user_data)
 =

 	ofono_info("Reopened GPRS context channel");
 =

+	data->gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->pcui);
 	data->gc =3D ofono_gprs_context_create(modem, 0, "atmodem",
 							data->modem);
 =

-- =

1.6.3.3


--===============6768535510262690991==--

