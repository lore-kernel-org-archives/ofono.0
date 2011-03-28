Content-Type: multipart/mixed; boundary="===============7372244267518795865=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 07/12] gatchat: implementation for +CPOS send
Date: Mon, 28 Mar 2011 18:00:42 -0500
Message-ID: <4D91131A.6030900@gmail.com>
In-Reply-To: <1300974396-15801-8-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7372244267518795865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jarko,

On 03/24/2011 08:46 AM, Jarko Poutiainen wrote:
> ---
>  gatchat/gatchat.c |   37 +++++++++++++++++++++++++++++++++----
>  1 files changed, 33 insertions(+), 4 deletions(-)
> =


I dropped this patch (along with 08) and implemented my own versions.
Please review the implementation and let me know if you can see any
problems.

While GAtChat can handle the short prompting now (at least in my
testing), I'm still hating the extra hoops we had to jump through to
make this happen.  I'd still prefer using 27.005 style prompts, as there
are still cases (e.g. echo enabled) where the current implementation
might not work.

Regards,
-Denis

--===============7372244267518795865==--

