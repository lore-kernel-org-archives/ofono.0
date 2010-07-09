Content-Type: multipart/mixed; boundary="===============0632271747236000740=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH 1/3] Make fetch command function as external
Date: Fri, 09 Jul 2010 23:09:25 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4731F09AF71@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1278687128-8983-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0632271747236000740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

>-----Original Message-----
>From: Yang Gu [mailto:gyagp0(a)gmail.com]
>Sent: Friday, July 09, 2010 10:52 PM
>To: ofono(a)ofono.org
>Cc: Gu, Yang
>Subject: [PATCH 1/3] Make fetch command function as external
>+
>+void at_sim_fetch_command(GAtChat *chat, struct ofono_stk *stk, int lengt=
h)
>+{
>+	char buf[64];
>+	struct cb_data *cbd =3D cb_data_new(chat, stk);
>+
>+	snprintf(buf, sizeof(buf), "AT+CSIM=3D10,A0120000%02hhX", length);
>+	g_at_chat_send(chat, buf, csim_prefix, csim_fetch_cb, cbd, g_free);

Both chat and stk need to be passed to callback function, so I use cb_data =
here. Any comment?



Regards,
-Yang

--===============0632271747236000740==--

