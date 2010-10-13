Content-Type: multipart/mixed; boundary="===============8409808198464781670=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] sim: implement GetIcon
Date: Wed, 13 Oct 2010 08:44:16 -0500
Message-ID: <4CB5B7B0.2080902@gmail.com>
In-Reply-To: <1286231602-18692-3-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8409808198464781670==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

On 10/04/2010 05:33 PM, Kristen Carlson Accardi wrote:
> ---
>  src/sim.c |  187 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 187 insertions(+), 0 deletions(-)
> =


I applied this patch but refactored it afterwards to avoid a potential
memory leak.  Can you please check that I haven't broken anything?

Thanks,
-Denis

--===============8409808198464781670==--

