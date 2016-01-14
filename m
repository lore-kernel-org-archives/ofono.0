Content-Type: multipart/mixed; boundary="===============3561420149703561612=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Huawei 3131 with idVendor=12d1, idProduct=14fe
Date: Thu, 14 Jan 2016 09:32:32 -0600
Message-ID: <5697BF90.8020806@gmail.com>
In-Reply-To: <CADnUhn1YRsmCn99A1aRYHwWM3uJQTY6hnrx4XmD3uEMwHXybpw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3561420149703561612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matti,


..drivers/huaweimodem/gprs-context.c:huawei_gprs_activate_primary() cid 1
ofonod: Modem: > AT+CGDCONT=3D1,"IP","internet"\r
ofonod: Modem: < \r\nOK\r\n
..drivers/huaweimodem/gprs-context.c:at_cgdcont_cb() ok 1
ofonod: Modem: > AT^NDISDUP=3D1,1\r
ofonod: Modem: < \r\nOK\r\n

----> Activating NDIS interface seems to be okay

..drivers/huaweimodem/gprs-context.c:at_ndisdup_up_cb() ok 1
ofonod: Modem: > AT^DHCP?\r
ofonod: Modem: < \r\nOK\r\n

----> This is where we fail.  For some reason the firmware returns an =

empty result with an 'OK' here.  This is something the gprs-context =

driver isn't expecting.  See drivers/huaweimodem/gprs-context.c =

dhcp_query_cb():

         if (g_at_result_iter_next(&iter, "^DHCP:") =3D=3D FALSE)
                 return;

Can you try activating the polling logic in this case as well.  E.g. by =

changing that chunk to read:

if (g_at_result_iter_next(&iter, "^DHCP:") =3D=3D FALSE) {
	gcd->dhcp_source =3D g_timeout_add_seconds(1, dhcp_poll, gc);
	return;
}

Regards,
-Denis

--===============3561420149703561612==--

