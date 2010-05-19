Content-Type: multipart/mixed; boundary="===============7464490510261153203=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: atmodem: gprs context deactivate crashes ofonod
Date: Wed, 19 May 2010 19:40:34 +0300
Message-ID: <87eih77sl9.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7464490510261153203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello again,

I have been testing ofono with my Huawei E1552 usb stick, which is using
atmodem and PPP. I noticed that whenever I call test/deactivate-context
ofono either crashes or busyloops here in at_gprs_deactivate_primary():

	if (g_at_chat_send(gcd->chat, buf, none_prefix,
				at_cgact_down_cb, cbd, g_free) > 0)
		return;

Further investigation revealed that gcd->chat is already unreferenced in
setup_ppp():

	g_at_chat_unref(gcd->chat);

So there's a conflict here. How to handle this properly? Calling
g_at_ppp_shutdown() is most likely not enough, because nobody is not
creating gcd->chat again which is needed during subsequent activate
call.

Comments?

-- =

Kalle Valo

--===============7464490510261153203==--

