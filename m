Content-Type: multipart/mixed; boundary="===============8288612638353977547=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH] isimodem: fix call_create_resp handling
Date: Tue, 12 Apr 2011 20:41:50 +0300
Message-ID: <BANLkTimWEYtTdf-NxXafuZKszYeytufD5g@mail.gmail.com>
In-Reply-To: <1302618809-26929-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8288612638353977547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

2011/4/12  <Pekka.Pessi@nokia.com>:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
>
> In case of call creation failure modem may return a valid call id in
> order to send CALL_SERVICE_DENIED_IND which we do not handle.
>
> Fixes MeeGo bug#15855.
> ---
> =C2=A0drivers/isimodem/voicecall.c | =C2=A0 39 ++++++++++++++++++++++++++=
+++++++------
> =C2=A01 files changed, 33 insertions(+), 6 deletions(-)

Patch has been pushed. Thanks!

Cheers,
Aki

--===============8288612638353977547==--

