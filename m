Content-Type: multipart/mixed; boundary="===============7626782747102625033=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [g_isi_send RFC 0/3] g_isi_send()
Date: Mon, 30 Aug 2010 19:42:36 +0300
Message-ID: <1283186559-4548-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7626782747102625033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I've added the function g_isi_send() to the gisi client API.  It has been
modeled after g_at_chat_send(), in other words, it includes a GDestroyNotify
function.

The GDestroyNotify gets called after the sent request is complete (the
result cb returns TRUE or the request is canceled).

The latter two patches just show how to to use g_isi_send().

Now, to the evil parts:

In order to simplify the client code, the destroy notify is also called if
the request could not be sent successfully. In the same vein, if the opaque
data is NULL but destroy notify is non-NULL, the g_isi_send() just returns
NULL but does not set errno.

So, we can do something like

if (!g_isi_send(clnt, msg, len, resp_cb, isi_cb_data_new(cb, data), g_free))
	CALLBACK_WITH_FAILURE(cb, data);
else
	return;

--Pekka


--===============7626782747102625033==--

