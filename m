Content-Type: multipart/mixed; boundary="===============8702163339667173908=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 03/12] stk: Add parser for send ussd commands
Date: Wed, 16 Jun 2010 17:44:56 -0500
Message-ID: <201006161744.56868.denkenz@gmail.com>
In-Reply-To: <1276422202-16240-3-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8702163339667173908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> +char *ussd_decode(int dcs, int len, const unsigned char *data);
> =


Please put this function in smsutil.c/h, no need to start a brand new file =
for =

this.  It is highly related to sms / cbs anyway.

Regards,
-Denis

--===============8702163339667173908==--

