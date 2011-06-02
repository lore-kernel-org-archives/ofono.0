Content-Type: multipart/mixed; boundary="===============5164856148894134539=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4] reopen once if open device failed
Date: Thu, 02 Jun 2011 16:04:23 -0500
Message-ID: <4DE7FAD7.5020108@gmail.com>
In-Reply-To: <1307091610-23058-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5164856148894134539==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 06/03/2011 04:00 AM, Caiwen Zhang wrote:
> Sometimes when open the data device, it may fail. If open the data device=
 failed,
> retry once one second later.
> =

> ---
>  plugins/huawei.c |   36 +++++++++++++++++++++++++++++++++++-
>  1 files changed, 35 insertions(+), 1 deletions(-)
> =


Patch has been applied with a slightly modified commit message.

Regards,
-Denis

--===============5164856148894134539==--

