Content-Type: multipart/mixed; boundary="===============8367133164561695988=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2 v2] handsfree-audio: add type for our audio cards
Date: Mon, 05 Oct 2015 11:47:00 -0500
Message-ID: <5612A984.3090304@gmail.com>
In-Reply-To: <1444044790-17392-1-git-send-email-simon.fels@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8367133164561695988==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On 10/05/2015 06:33 AM, Simon Fels wrote:
> When registering audio cards for the handsfree and gateway roles we
> need a way for our users to differentiate between both to decide which
> of them they start using for their purpose.
> ---
>   doc/handsfree-audio-api.txt |  4 ++++
>   include/handsfree-audio.h   | 10 ++++++++--
>   plugins/hfp_hf_bluez5.c     |  4 +++-
>   src/handsfree-audio.c       | 24 ++++++++++++++++++++++--
>   4 files changed, 37 insertions(+), 5 deletions(-)
>

Applied, thanks.

Regards,
-Denis


--===============8367133164561695988==--

