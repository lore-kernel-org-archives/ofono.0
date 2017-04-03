Content-Type: multipart/mixed; boundary="===============2408283873445181428=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 2/3] qmi: fix bad lookup and double free
Date: Mon, 03 Apr 2017 14:27:33 +0200
Message-ID: <20170403122734.12638-2-jonas@southpole.se>
In-Reply-To: <20170403122734.12638-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2408283873445181428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This function was never removing discovery instances because it was looking
them up in the wrong list.  This led to some strangeness with the discovery
callbacks being invoked after the "failure" timeout of 5 seconds and
consequent failures with everything getting out of sync.

With this patch we fix the lookup to use the correct queue.  There's also
a double-free in the function that was never being hit before because the
lookups never succeeded; fix that as well.

With this, service discovery and creation work as expected when testing with
an EC21.
---
 drivers/qmimodem/qmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index e113b85..a0d79e1 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -901,7 +901,7 @@ static void __qmi_device_discovery_complete(struct qmi_=
device *device,
 	GList *list;
 	struct discovery *d;
 =

-	list =3D g_queue_find_custom(device->req_queue,
+	list =3D g_queue_find_custom(device->discovery_queue,
 				discover_data, __discovery_compare);
 	if (!list)
 		return;
@@ -909,7 +909,6 @@ static void __qmi_device_discovery_complete(struct qmi_=
device *device,
 	d =3D list->data;
 	g_queue_delete_link(device->discovery_queue, list);
 =

-	d->destroy(d->discover_data);
 	__discovery_free(d, NULL);
 }
 =

-- =

2.9.3


--===============2408283873445181428==--

