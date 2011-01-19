Content-Type: multipart/mixed; boundary="===============0011362871856473185=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] huawei: do not query sim state on pre_sim
Date: Wed, 19 Jan 2011 12:34:41 -0200
Message-ID: <1295447681-8193-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0011362871856473185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sim state is already known after modem is enabled and there's no need to
query it again. Before this patch, query_sim_state() was called upon
huawei_enable() and huawei_pre_sim(). Both functions might call
notify_sim_state() with a valid state. Hence we could eventually end up
sending AT+CFUN=3D5 command twice.
---

Hi Marcel,

I think this is the right approach for this problem. Before this patch I had
the following log when enabling a huawei modem with not pins locked:

ofonod[7217]: oFono version 0.38
ofonod[7217]: plugins/huawei.c:huawei_probe() 0x1580610
ofonod[7217]: plugins/huawei.c:huawei_enable() 0x1580610
ofonod[7217]: plugins/huawei.c:open_device() Modem /dev/ttyUSB0
ofonod[7217]: plugins/huawei.c:open_device() Pcui /dev/ttyUSB1
ofonod[7217]: plugins/huawei.c:query_sim_state() =

ofonod[7217]: PCUI: > ATE0 +CMEE=3D1\r
ofonod[7217]: PCUI: < ATE0 +CMEE=3D1\r
ofonod[7217]: PCUI: < \r\nOK\r\n
ofonod[7217]: PCUI: > AT+CFUN=3D1\r
ofonod[7217]: PCUI: < \r\nOK\r\n
ofonod[7217]: plugins/huawei.c:cfun_enable() =

ofonod[7217]: PCUI: > AT^SYSINFO\r
ofonod[7217]: PCUI: < \r\n^SYSINFO:2,1,0,5,3,0,4\r\n\r\nOK\r\n
ofonod[7217]: plugins/huawei.c:sysinfo_cb() =

ofonod[7217]: plugins/huawei.c:notify_sim_state() 3
ofonod[7217]: plugins/huawei.c:huawei_pre_sim() 0x1580610
ofonod[7217]: plugins/huawei.c:query_sim_state() =

ofonod[7217]: PCUI: > AT^U2DIAG?\r
ofonod[7217]: PCUI: < \r\nERROR\r\n
ofonod[7217]: PCUI: > AT^GETPORTMODE\r
ofonod[7217]: PCUI: < \r\nCOMMAND NOT SUPPORT\r\n
ofonod[7217]: PCUI: > AT^USSDMODE=3D?\r
ofonod[7217]: PCUI: < \r\nCOMMAND NOT SUPPORT\r\n
ofonod[7217]: PCUI: > AT^CVOICE=3D?\r
ofonod[7217]: PCUI: < \r\nCOMMAND NOT SUPPORT\r\n
ofonod[7217]: PCUI: > AT^SYSINFO\r
ofonod[7217]: PCUI: < \r\n^SYSINFO:2,1,0,5,3,0,4\r\n\r\nOK\r\n
ofonod[7217]: plugins/huawei.c:sysinfo_cb() =

ofonod[7217]: plugins/huawei.c:notify_sim_state() 3
ofonod[7217]: PCUI: > AT+CFUN=3D5\r
ofonod[7217]: PCUI: < \r\nOK\r\n
ofonod[7217]: PCUI: > AT+CGMI\r
ofonod[7217]: PCUI: < \r\nhuawei\r\n\r\nOK\r\n
ofonod[7217]: PCUI: > AT+CFUN=3D5\r
ofonod[7217]: PCUI: < \r\nOK\r\n
<...>


The second call to query_sim_state() triggered a call to query_sim_state()
that called to notify_sim_state() with state =3D=3D 3 again.



 plugins/huawei.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index b4b7436..09a7a3e 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -621,9 +621,6 @@ static void huawei_pre_sim(struct ofono_modem *modem)
 	ofono_devinfo_create(modem, 0, "atmodem", data->pcui);
 	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_HUAWEI,
 					"atmodem", data->pcui);
-
-	data->sim_poll_count =3D 0;
-	query_sim_state(modem);
 }
 =

 static void huawei_post_sim(struct ofono_modem *modem)
-- =

1.7.3.5


--===============0011362871856473185==--

