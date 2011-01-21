Content-Type: multipart/mixed; boundary="===============4642280644518429576=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH] isimodem: fix sending DTMF
Date: Fri, 21 Jan 2011 15:20:51 +0200
Message-ID: <AANLkTi=HNS6F84BJSqSnMt5+W=hQog=DENmXMJ-ZWjEb@mail.gmail.com>
In-Reply-To: <1295532781-22585-1-git-send-email-kai.vehmanen@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4642280644518429576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kai,

2011/1/20 Kai Vehmanen <kai.vehmanen@nokia.com>:
> isi_call_dtmf_send_resp() handles the success case incorrectly, and
> thus all send_tones attempts fail with bogus error codes.
> ---
> =C2=A0drivers/isimodem/voicecall.c | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)

Patch has been pushed, thanks!

Cheers,
Aki

--===============4642280644518429576==--

