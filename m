Content-Type: multipart/mixed; boundary="===============1129472561284430097=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [n900-v5 2/5] isimodem: remove the modem driver parts
Date: Thu, 16 Sep 2010 17:56:16 +0300
Message-ID: <1284648979-19046-3-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1284648979-19046-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1129472561284430097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <ppessi@hamsa.research.nokia.com>

The isimodem driver is now part of isigen (just like atmodem and atgen).
---
 drivers/isimodem/isimodem.c |  401 ---------------------------------------=
----
 1 files changed, 0 insertions(+), 401 deletions(-)

diff --git a/drivers/isimodem/isimodem.c b/drivers/isimodem/isimodem.c
index e7cac50..10d681e 100644
--- a/drivers/isimodem/isimodem.c
+++ b/drivers/isimodem/isimodem.c
@@ -29,408 +29,11 @@
 #include <string.h>
 #include <glib.h>
 =

-#include <gisi/netlink.h>
-#include <gisi/client.h>
-
 #define OFONO_API_SUBJECT_TO_CHANGE
 #include <ofono/plugin.h>
 #include <ofono/log.h>
-#include <ofono/modem.h>
-#include <ofono/devinfo.h>
-#include <ofono/phonebook.h>
-#include <ofono/netreg.h>
-#include <ofono/voicecall.h>
-#include <ofono/sms.h>
-#include <ofono/cbs.h>
-#include <ofono/sim.h>
-#include <ofono/ussd.h>
-#include <ofono/ssn.h>
-#include <ofono/call-forwarding.h>
-#include <ofono/call-settings.h>
-#include <ofono/call-barring.h>
-#include <ofono/call-meter.h>
-#include <ofono/radio-settings.h>
-#include <ofono/gprs.h>
-#include <ofono/gprs-context.h>
 =

 #include "isimodem.h"
-#include "isiutil.h"
-#include "mtc.h"
-#include "debug.h"
-
-struct isi_data {
-	struct ofono_modem *modem;
-	char const *ifname;
-	GIsiModem *idx;
-	GIsiClient *client;
-	GPhonetNetlink *link;
-	GPhonetLinkState linkstate;
-	unsigned interval;
-	int reported;
-	ofono_bool_t online;
-	struct isi_cb_data *online_cbd;
-};
-
-static void report_powered(struct isi_data *isi, ofono_bool_t powered)
-{
-	if (powered !=3D isi->reported)
-		ofono_modem_set_powered(isi->modem, isi->reported =3D powered);
-}
-
-static void report_online(struct isi_data *isi, ofono_bool_t online)
-{
-	struct isi_cb_data *cbd =3D isi->online_cbd;
-	ofono_modem_online_cb_t cb =3D cbd->cb;
-
-	isi->online_cbd =3D NULL;
-
-	if (isi->online =3D=3D online)
-		CALLBACK_WITH_SUCCESS(cb, cbd->data);
-	else
-		CALLBACK_WITH_FAILURE(cb, cbd->data);
-
-	g_free(cbd);
-}
-
-static void set_power_by_mtc_state(struct isi_data *isi, int mtc_state)
-{
-	if (isi->online_cbd)
-		report_online(isi, mtc_state =3D=3D MTC_NORMAL);
-
-	switch (mtc_state) {
-	case MTC_STATE_NONE:
-	case MTC_POWER_OFF:
-	case MTC_CHARGING:
-	case MTC_SELFTEST_FAIL:
-		report_powered(isi, 0);
-		break;
-
-	case MTC_RF_INACTIVE:
-	case MTC_NORMAL:
-	default:
-		report_powered(isi, 1);
-	}
-}
-
-static void mtc_state_ind_cb(GIsiClient *client,
-				const void *restrict data, size_t len,
-				uint16_t object, void *opaque)
-{
-	const unsigned char *msg =3D data;
-	struct isi_data *isi =3D opaque;
-
-	if (!msg) {
-		DBG("ISI client error: %d", g_isi_client_error(client));
-		return;
-	}
-
-	if (len < 3 || msg[0] !=3D MTC_STATE_INFO_IND)
-		return;
-
-	if (msg[2] =3D=3D MTC_START) {
-		DBG("target modem state: %s (0x%02X)",
-			mtc_modem_state_name(msg[1]), msg[1]);
-	} else if (msg[2] =3D=3D MTC_READY) {
-		DBG("current modem state: %s (0x%02X)",
-			mtc_modem_state_name(msg[1]), msg[1]);
-		set_power_by_mtc_state(isi, msg[1]);
-	}
-}
-
-static gboolean mtc_poll_query_cb(GIsiClient *client,
-					const void *restrict data, size_t len,
-					uint16_t object, void *opaque)
-{
-	const unsigned char *msg =3D data;
-	struct isi_data *isi =3D opaque;
-
-	if (!msg) {
-		const unsigned char req[] =3D {
-			MTC_STATE_QUERY_REQ, 0x00, 0x00
-		};
-
-		if (isi->linkstate !=3D PN_LINK_UP)
-			return TRUE;
-
-		isi->interval *=3D 2;
-		if (isi->interval >=3D 20)
-			isi->interval =3D 20;
-
-		g_isi_request_make(client, req, sizeof(req),
-					isi->interval,
-					mtc_poll_query_cb, opaque);
-
-		return TRUE;
-	}
-
-	if (len < 3 || msg[0] !=3D MTC_STATE_QUERY_RESP)
-		return FALSE;
-
-	g_isi_subscribe(client, MTC_STATE_INFO_IND, mtc_state_ind_cb, opaque);
-
-	DBG("current modem state: %s (0x%02X)",
-		mtc_modem_state_name(msg[1]), msg[1]);
-	DBG("target modem state: %s (0x%02X)",
-		mtc_modem_state_name(msg[2]), msg[2]);
-
-	if (msg[1] =3D=3D msg[2])
-		set_power_by_mtc_state(isi, msg[1]);
-
-	return TRUE;
-}
-
-static gboolean mtc_query_cb(GIsiClient *client,
-				const void *restrict data, size_t len,
-				uint16_t object, void *opaque)
-{
-	const unsigned char *msg =3D data;
-	struct isi_data *isi =3D opaque;
-
-	if (!msg) {
-		DBG("ISI client error: %d", g_isi_client_error(client));
-		return TRUE;
-	}
-
-	if (len < 3 || msg[0] !=3D MTC_STATE_QUERY_RESP)
-		return FALSE;
-
-	DBG("current modem state: %s (0x%02X)",
-		mtc_modem_state_name(msg[1]), msg[1]);
-	DBG("target modem state: %s (0x%02X)",
-		mtc_modem_state_name(msg[2]), msg[2]);
-
-	if (msg[1] =3D=3D msg[2])
-		set_power_by_mtc_state(isi, msg[1]);
-
-	return TRUE;
-}
-
-static void reachable_cb(GIsiClient *client, gboolean alive, uint16_t obje=
ct,
-				void *opaque)
-{
-	struct isi_data *isi =3D opaque;
-
-	const unsigned char msg[] =3D {
-		MTC_STATE_QUERY_REQ,
-		0x00, 0x00 /* Filler */
-	};
-
-	if (!alive) {
-		DBG("MTC client: %s", strerror(-g_isi_client_error(client)));
-
-		if (isi->linkstate =3D=3D PN_LINK_UP)
-			g_isi_request_make(client, msg, sizeof(msg),
-						isi->interval =3D MTC_TIMEOUT,
-						mtc_poll_query_cb, opaque);
-		return;
-	}
-
-	DBG("%s (v.%03d.%03d) reachable",
-		pn_resource_name(g_isi_client_resource(client)),
-		g_isi_version_major(client),
-		g_isi_version_minor(client));
-
-	g_isi_subscribe(client, MTC_STATE_INFO_IND, mtc_state_ind_cb, opaque);
-	g_isi_request_make(client, msg, sizeof(msg), MTC_TIMEOUT,
-				mtc_query_cb, opaque);
-}
-
-static void phonet_status_cb(GIsiModem *idx,
-				GPhonetLinkState st,
-				char const *ifname,
-				void *data)
-{
-	struct ofono_modem *modem =3D data;
-	struct isi_data *isi =3D ofono_modem_get_data(modem);
-
-	DBG("Link %s (%u) is %s",
-		isi->ifname, g_isi_modem_index(isi->idx),
-		st =3D=3D PN_LINK_REMOVED ? "removed" :
-		st =3D=3D PN_LINK_DOWN ? "down" : "up");
-
-	isi->linkstate =3D st;
-
-	if (st =3D=3D PN_LINK_UP)
-		g_isi_verify(isi->client, reachable_cb, isi);
-	else if (st =3D=3D PN_LINK_DOWN)
-		set_power_by_mtc_state(isi, MTC_STATE_NONE);
-	else if (st =3D=3D PN_LINK_REMOVED)
-		ofono_modem_remove(modem);
-}
-
-static int isi_modem_probe(struct ofono_modem *modem)
-{
-	struct isi_data *isi;
-	char const *ifname =3D ofono_modem_get_string(modem, "Interface");
-	GIsiModem *idx;
-	GPhonetNetlink *link;
-
-	if (ifname =3D=3D NULL)
-		return -EINVAL;
-
-	DBG("(%p) with %s", modem, ifname);
-
-	idx =3D g_isi_modem_by_name(ifname);
-	if (idx =3D=3D NULL) {
-		DBG("Interface=3D%s: %s", ifname, strerror(errno));
-		return -errno;
-	}
-
-	if (g_pn_netlink_by_modem(idx)) {
-		DBG("%s: %s", ifname, strerror(EBUSY));
-		return -EBUSY;
-	}
-
-	link =3D g_pn_netlink_start(idx, phonet_status_cb, modem);
-	if (!link) {
-		DBG("%s: %s", ifname, strerror(errno));
-		return -errno;
-	}
-
-	isi =3D g_new0(struct isi_data, 1);
-	if (isi =3D=3D NULL)
-		return -ENOMEM;
-
-	ofono_modem_set_data(isi->modem =3D modem, isi);
-
-	isi->idx =3D idx;
-	isi->ifname =3D ifname;
-	isi->link =3D link;
-	isi->client =3D g_isi_client_create(isi->idx, PN_MTC);
-	isi->reported =3D -1;
-
-	return 0;
-}
-
-static void isi_modem_remove(struct ofono_modem *modem)
-{
-	struct isi_data *isi =3D ofono_modem_get_data(modem);
-
-	if (!isi)
-		return;
-
-	ofono_modem_set_data(modem, NULL);
-	g_isi_client_destroy(isi->client);
-	g_pn_netlink_stop(isi->link);
-	g_free(isi);
-}
-
-static gboolean mtc_state_cb(GIsiClient *client,
-				const void *restrict data, size_t len,
-				uint16_t object, void *opaque)
-{
-	struct isi_cb_data *cbd =3D opaque;
-	struct ofono_modem *modem =3D cbd->user;
-	ofono_modem_online_cb_t cb =3D cbd->cb;
-	struct isi_data *isi =3D ofono_modem_get_data(modem);
-	const unsigned char *msg =3D data;
-
-	if (!msg) {
-		DBG("ISI client error: %d", g_isi_client_error(client));
-		goto err;
-	}
-
-	if (len < 3 || msg[0] !=3D MTC_STATE_RESP)
-		return FALSE;
-
-	DBG("cause: %s (0x%02X)", mtc_isi_cause_name(msg[1]), msg[1]);
-
-	if (msg[1] =3D=3D MTC_OK) {
-		isi->online_cbd =3D cbd;
-		return TRUE;
-	}
-
-err:
-	if (msg && msg[1] =3D=3D MTC_ALREADY_ACTIVE)
-		CALLBACK_WITH_SUCCESS(cb, cbd->data);
-	else
-		CALLBACK_WITH_FAILURE(cb, cbd->data);
-
-	g_free(cbd);
-	return TRUE;
-}
-
-static void isi_modem_online(struct ofono_modem *modem, ofono_bool_t onlin=
e,
-				ofono_modem_online_cb_t cb, void *data)
-{
-	struct isi_data *isi =3D ofono_modem_get_data(modem);
-	const unsigned char req[] =3D {
-		MTC_STATE_REQ, online ? MTC_NORMAL : MTC_RF_INACTIVE, 0x00
-	};
-	struct isi_cb_data *cbd =3D isi_cb_data_new(modem, cb, data);
-
-	DBG("(%p) with %s", modem, isi->ifname);
-
-	if (!cbd)
-		goto error;
-
-	isi->online =3D online;
-
-	if (g_isi_request_make(isi->client, req, sizeof(req), MTC_TIMEOUT,
-				mtc_state_cb, cbd))
-		return;
-
-error:
-	g_free(cbd);
-	CALLBACK_WITH_FAILURE(cb, data);
-}
-
-static void isi_modem_pre_sim(struct ofono_modem *modem)
-{
-	struct isi_data *isi =3D ofono_modem_get_data(modem);
-
-	DBG("(%p) with %s", modem, isi->ifname);
-
-	ofono_sim_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_devinfo_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_voicecall_create(isi->modem, 0, "isimodem", isi->idx);
-}
-
-static void isi_modem_post_sim(struct ofono_modem *modem)
-{
-	struct isi_data *isi =3D ofono_modem_get_data(modem);
-
-	DBG("(%p) with %s", modem, isi->ifname);
-
-	ofono_phonebook_create(isi->modem, 0, "isimodem", isi->idx);
-}
-
-static void isi_modem_post_online(struct ofono_modem *modem)
-{
-	struct isi_data *isi =3D ofono_modem_get_data(modem);
-	struct ofono_gprs *gprs;
-	struct ofono_gprs_context *gc;
-
-	DBG("(%p) with %s", modem, isi->ifname);
-
-	ofono_netreg_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_sms_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_cbs_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_ssn_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_ussd_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_call_forwarding_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_call_settings_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_call_barring_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_call_meter_create(isi->modem, 0, "isimodem", isi->idx);
-	ofono_radio_settings_create(isi->modem, 0, "isimodem", isi->idx);
-	gprs =3D ofono_gprs_create(isi->modem, 0, "isimodem", isi->idx);
-	gc =3D ofono_gprs_context_create(isi->modem, 0, "isimodem", isi->idx);
-
-	if (gprs && gc)
-		ofono_gprs_add_context(gprs, gc);
-	else
-		DBG("Failed to add context");
-}
-
-static struct ofono_modem_driver driver =3D {
-	.name =3D "isimodem",
-	.probe =3D isi_modem_probe,
-	.remove =3D isi_modem_remove,
-	.set_online =3D isi_modem_online,
-	.pre_sim =3D isi_modem_pre_sim,
-	.post_sim =3D isi_modem_post_sim,
-	.post_online =3D isi_modem_post_online,
-};
 =

 static int isimodem_init(void)
 {
@@ -451,15 +54,11 @@ static int isimodem_init(void)
 	isi_gprs_init();
 	isi_gprs_context_init();
 =

-	ofono_modem_driver_register(&driver);
-
 	return 0;
 }
 =

 static void isimodem_exit(void)
 {
-	ofono_modem_driver_unregister(&driver);
-
 	isi_devinfo_exit();
 	isi_phonebook_exit();
 	isi_netreg_exit();
-- =

1.7.0.4


--===============1129472561284430097==--

