Content-Type: multipart/mixed; boundary="===============6147379764907955226=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [gisi-notify-fix PATCHv2 1/2] gisi: simplify pending management
Date: Tue, 18 Jan 2011 23:37:46 +0200
Message-ID: <AANLkTinDENxNkojU_3vkUBv7=ye_xqaUtHswQ=jFzDCp@mail.gmail.com>
In-Reply-To: <1295386029-32624-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6147379764907955226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

2011/1/18  <Pekka.Pessi@nokia.com>:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
>
> Client or server mark their pending objects with
> the function g_isi_pending_set_owner().
>
> When client or server get destroyed or reset the pending objects are
> removed with the function g_isi_remove_pending_by_owner(). As a client
> or server always uses only a particular resource, all the pending
> objects are conveniently stored into a single list.
> ---
> =C2=A0gisi/client.c | =C2=A0199 ++++++++++-------------------------------=
----------------
> =C2=A0gisi/modem.c =C2=A0| =C2=A0 63 ++++++++++++++++++
> =C2=A0gisi/modem.h =C2=A0| =C2=A0 =C2=A05 +-
> =C2=A0gisi/server.c | =C2=A0 73 ++-------------------
> =C2=A04 files changed, 107 insertions(+), 233 deletions(-)

Pushed, thanks!

Cheers,
Aki

--===============6147379764907955226==--

