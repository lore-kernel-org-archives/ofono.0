Content-Type: multipart/mixed; boundary="===============4972035068583130515=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [g_isi_send PATCH 3/3] isimodem/ussd: use g_isi_send()
Date: Wed, 01 Sep 2010 15:02:48 +0300
Message-ID: <AANLkTiktfzX71yBNyTMigJj6QXmFnPUGCFfkYFxnK4=e@mail.gmail.com>
In-Reply-To: <1283341668-18356-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4972035068583130515==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2010/9/1  <Pekka.Pessi@nokia.com>:
> - =C2=A0 =C2=A0 =C2=A0 return g_isi_request_vmake(client, iov, 2, SS_TIME=
OUT,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ussd_send_re=
sp_cb, data);
> + =C2=A0 =C2=A0 =C2=A0 return g_isi_send(client, iov, 2, SS_TIMEOUT,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ussd_send_resp_cb, data, notify);

Oops.

-- =

Pekka.Pessi mail at nokia.com

--===============4972035068583130515==--

