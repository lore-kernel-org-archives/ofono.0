Content-Type: multipart/mixed; boundary="===============7822488888362988483=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] Add ofono_modem_reset()
Date: Thu, 02 Dec 2010 13:45:39 -0600
Message-ID: <4CF7F763.4040206@gmail.com>
In-Reply-To: <1290711740-27886-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7822488888362988483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On 11/25/2010 01:02 PM, Gustavo F. Padovan wrote:
> Some modems can screw up everything and then we will need to do a silent
> reset of the modem. This patch take the modem back to the OFFLINE state.
> ---
>  include/modem.h |    2 ++
>  src/modem.c     |   15 +++++++++++++++
>  2 files changed, 17 insertions(+), 0 deletions(-)

Two patches please.  One for the include change, one for the implementation.

Otherwise looks good.

Regards,
-Denis

--===============7822488888362988483==--

