Content-Type: multipart/mixed; boundary="===============7905509988363200595=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH] Fix g_isi_client_destroy segfault
Date: Thu, 09 Jul 2009 16:19:04 +0300
Message-ID: <c5cc993081a7f32bf742b8f48eee2851@localhost>
In-Reply-To: <4A55E49C.6020006@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7905509988363200595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 09 Jul 2009 15:37:48 +0300, Marko Saukko <marko.saukko@gmail.com>
wrote:
> If null pointer is given to g_isi_client_destroy it segfaults. Currently
> this is happening when signal 15 is sent to ofonod.

I pushed a patch to isimodem.c that should fix this, as well as another
problem related to the current lack of support for multiple parallel ISI
modems in Phonet.

Thanks for reporting.

Cheers,
Aki

--===============7905509988363200595==--

