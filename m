Content-Type: multipart/mixed; boundary="===============2207910191897187732=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 7/7] hfp_hf_bluez5: Handle org.bluez.Profile1.Release()
Date: Thu, 12 Sep 2013 13:21:50 -0500
Message-ID: <5232063E.3080804@gmail.com>
In-Reply-To: <1378858186-683-7-git-send-email-vcgomes@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2207910191897187732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 09/10/2013 07:09 PM, Vinicius Costa Gomes wrote:
> There's nothing we can do in this case, so we only reply with a
> success.
> ---
>   plugins/hfp_hf_bluez5.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>

Since BlueZ now marks this method as noreply, I fixed it to be the same =

in commit f2103a7ada1a4f5bfb7fee8e5d0ff261718ca759.

Regards,
-Denis


--===============2207910191897187732==--

