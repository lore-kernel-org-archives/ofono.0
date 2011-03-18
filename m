Content-Type: multipart/mixed; boundary="===============0777651413331618752=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/9] bluetooth: add functions for sco connection
Date: Fri, 18 Mar 2011 15:27:39 -0500
Message-ID: <4D83C03B.4060703@gmail.com>
In-Reply-To: <1300388148-925-2-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0777651413331618752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 03/17/2011 01:55 PM, Fr=C3=A9d=C3=A9ric Dalleau wrote:
> ---
>  plugins/bluetooth.c |  122 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  plugins/bluetooth.h |    7 +++
>  2 files changed, 129 insertions(+), 0 deletions(-)
> =


So before you run too far with this I suggest you speak to Marcel and
Johan on whether handling SCO audio inside oFono is a good idea.
Personally I'd rather see this piece remain inside BlueZ, but I'm no
longer an expert in this area.

Regards,
-Denis

--===============0777651413331618752==--

