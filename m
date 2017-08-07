Content-Type: multipart/mixed; boundary="===============3671022901245791684=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/5] voicecall.h: declare struct ofono_modem
Date: Mon, 07 Aug 2017 12:34:26 -0500
Message-ID: <ecc41f12-8fc5-8609-29b1-9e3d98395ffd@gmail.com>
In-Reply-To: <20170725132624.32293-4-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3671022901245791684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 07/25/2017 08:26 AM, Alexander Couzens wrote:
> Fix a warning when only voicecall.h is included:
> 'struct ofono_modem declared' inside parameter list will not be visible
> outside of this definition or declaration struct ofono_voicecall
> *ofono_voicecall_create(struct ofono_modem *modem,...
> ---
>  include/voicecall.h | 1 +
>  1 file changed, 1 insertion(+)
>

Applied, thanks.

Regards,
-Denis


--===============3671022901245791684==--

