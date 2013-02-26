Content-Type: multipart/mixed; boundary="===============2168735468413797785=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH v1 0/9] handsfree-audio: Audio Card registration
Date: Tue, 26 Feb 2013 19:08:46 -0300
Message-ID: <CAKT1EBcNyke9e5YiJEc+9XjdohxbqSosG0abSgoatFi-zv-NDg@mail.gmail.com>
In-Reply-To: <1361886653-30873-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2168735468413797785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi:

On Tue, Feb 26, 2013 at 10:50 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> This patch series adds the initial Handsfree Audio Card hierarchy
> implementation.
>
> Not implemented in this series:
> * SCO audio connection
> * LocalAddress property
>
> Changes from v0-v1:
> * Changed Audio Card object path: it is now using sequential name "device=
%d"
> * Replaced atom modem tracking by handsfree_audio_create and handsfree_au=
dio_remove functions
>
> Claudio Takahasi (9):
>   handsfree-audio: Add creating Audio Card
>   handsfree-audio: Add removing Audio Card
>   handsfree-audio: Add emitting CardAdded
>   handsfree-audio: Add emitting CardRemoved
>   handsfree-audio: Remove Audio Card when HFP is removed
>   handsfree-audio: Remove Audio Card for local initiated disconnection
>   handsfree-audio: Add Audio Card GetProperties
>   handsfree-audio: Add Audio Cards hash table
>   handsfree-audio: Add Audio Manager GetCards
>
>  include/handsfree-audio.h |   2 +
>  plugins/hfp_hf_bluez5.c   |  22 ++++++
>  src/handsfree-audio.c     | 195 ++++++++++++++++++++++++++++++++++++++++=
+++++-
>  3 files changed, 217 insertions(+), 2 deletions(-)
>
> --
> 1.7.11.7
>

Ignore this patch series. Denis pushed his own version.

Claudio.

--===============2168735468413797785==--

