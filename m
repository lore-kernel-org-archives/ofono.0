Content-Type: multipart/mixed; boundary="===============8160040375143988722=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] handsfree-audio: Fix replying to an empty D-Bus message
Date: Fri, 03 May 2013 11:32:05 -0500
Message-ID: <5183E685.8020203@gmail.com>
In-Reply-To: <1367542036-19595-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8160040375143988722==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 05/02/2013 07:47 PM, Vinicius Costa Gomes wrote:
> In the case that ofono_handsfree_card_connect_sco() is called outside the
> context of a .Connect() call, there's no message we need to reply.  This
> happens, for example, when the HFP AG plugin initiates a SCO connection w=
hen
> it receives an AT+BCC command from the HF.
> ---
>   src/handsfree-audio.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>

Patch has been applied, thanks.

Regards,
-Denis


--===============8160040375143988722==--

