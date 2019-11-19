Content-Type: multipart/mixed; boundary="===============7211498974543527434=="
MIME-Version: 1.0
From: Jimmy Gysens <jimmy.gysens_ext@softathome.com>
Subject: [PATCH] - oFono v1.31 stuck in loop when unplugging a USB dongle
 connected via PPP
Date: Tue, 19 Nov 2019 10:53:20 +0000
Message-ID: <20191119105320.2673.41258@new-ml01.vlan13.01.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7211498974543527434==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

After unplugging a Huawei USB dongle, the 'atoms' in oFono are removed via =
'flush_atoms'.
Every atom has a destruct function pointer, used as a - yes - destructor.

When unplugging a dongle, connected via PPP, oFono will remove the current =
GPRS context (=3D data connection).

The function calls are:

flush_atoms -> destruct -> gprs_context_remove -> at_gprs_context_remove ->=
 modem_disconnect

Because the device is physically removed, the IO channel for the AT port is=
 gone.

In 'at_gprs_context_remove', there is an attempt to resume communication ov=
er that AT port, but that
is not possible. This is detected, and 'io_disconnect' (pointer to 'modem_d=
isconnect') is called.

'modem_disconnect' has the same atom and tries to remove it again, so it ca=
lls the same destructor.

modem_disconnect -> destruct -> gprs_context_remove -> at_gprs_context_remo=
ve -> modem_disconnect

And the loop is started.

The easiest way to fix this, is to move the GPRS context removal. After a d=
isconnect, oFono tries to
re-open the AT port. If that fails (and it will in this case), we're done, =
since 'modem_disconnect' returns.

In case the AT port can be opened, for example, when setting up a new conne=
ction, the previous GPRS context
is removed.

The old GPRS context is removed via:
 - 'flush_atoms' in case the USB device is physically removed.
 - 'modem_disconnect' in case a new connection is being set up.

The loop hereby is fixed, without altering general functionality of oFono. =
This fix is limited to Huawei devices and has been tested using the followi=
ng devices:

- E3531i-2
- E3372
- E3531s-2
- E369
- E1552

The patch itself:

---
 ofono-1.31/plugins/huawei.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/ofono-1.31/plugins/huawei.c b/ofono-1.31/plugins/huawei.c
index bdf7bc3..bb87670 100644
--- a/ofono-1.31/plugins/huawei.c
+++ b/ofono-1.31/plugins/huawei.c
@@ -583,9 +583,6 @@ static void modem_disconnect(gpointer user_data)
 	g_at_chat_unref(data->modem);
 	data->modem =3D NULL;
 =

-	/* close gprs context driver */
-	ofono_gprs_context_remove(data->gc);
-
 	/* reopen modem channel */
 	data->modem =3D open_device(modem, "Modem", "Modem: ");
 =

@@ -594,6 +591,10 @@ static void modem_disconnect(gpointer user_data)
 		return;
 	}
 =

+	/* close previous gprs context driver */
+	if (data->gc)
+		ofono_gprs_context_remove(data->gc);
+
 	/* configure modem channel */
 	g_at_chat_set_disconnect_function(data->modem, modem_disconnect, modem);
 	g_at_chat_set_slave(data->modem, data->pcui);
-- =

2.17.1

A review and upstream fix would be appreciated.

Thank you.

Best regards,
Jimmy
--===============7211498974543527434==--

