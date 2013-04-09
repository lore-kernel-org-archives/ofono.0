Content-Type: multipart/mixed; boundary="===============8270650005882218177=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/6] include: Make HFP 1.6 codecs definition public
Date: Tue, 09 Apr 2013 14:36:32 -0500
Message-ID: <51646DC0.20408@gmail.com>
In-Reply-To: <1365460863-14645-4-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8270650005882218177==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 04/08/2013 05:41 PM, Vinicius Costa Gomes wrote:
> As there is some knowledge about the codecs in both the core
> (handsfree-audio) and the hfpmodem driver, this information should
> be available from a single location.
> ---
>   include/types.h       | 6 ++++++
>   src/handsfree-audio.c | 6 ------
>   2 files changed, 6 insertions(+), 6 deletions(-)

I moved HFP related defines to to src/hfp.h instead.

Regards,
-Denis


--===============8270650005882218177==--

